# 모범답안 — 05c Tempo에서 분산 트레이스 검증

> **먼저 답하고 나서 열 것.** [[05c-verifying-distributed-traces-in-tempo]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 전파 실패의 증상이 미묘한 이유

**둘 다 "트레이스가 뜬다."**

| 상태 | **Tempo에 보이는 것** |
|---|---|
| **전파 성공** | 트레이스 **1개**, 안에 HTTP + Kafka + 알림 span |
| **전파 실패** | 트레이스 **2개**, **각자 그럴듯하게 보인다** |

> **개수를 세거나 span 계층을 봐야 구분된다.**

**"트레이스가 뜨면 전파가 성공한 것이다"는 오해다**(§5) — **실패해도 트레이스는 뜬다. 두 개로 나뉠 뿐이다.**

**이것이 이 장 전체가 반복하는 "조용한 실패"의 마지막 사례**다 — [[03c-verifying-logs-in-grafana]]의 로그 파이프라인, [[03b-instrumenting-the-application-for-logging]]의 `ObservabilityConfig` 누락. **어느 것도 오류를 내지 않는다.**

**그래서 확인 절차가 필요하다** — 이 절이 그 절차다.

---

## Q2. 검색 결과 한 줄의 다섯 항목

| 항목 | 값 | **뜻 / 출처** |
|---|---|---|
| **Trace ID** | `d5e9dbd74a3498b7c…` | **이 요청의 식별자** |
| Start time | `2026-04-23 15:52:44` | 언제 시작했나 |
| **Service** | `employee-service` | **[[03b-instrumenting-the-application-for-logging]]의 `service.name`이 [[05a-setting-up-grafana-tempo]]의 `resource` 프로세서를 거쳐 온 것** |
| Operation | `http post/employees` | **루트 span의 이름** |
| **Duration** | **`4.69s`** | **전체가 얼마나 걸렸나** |

> **로그·메트릭·트레이스가 같은 이름을 쓴다는 사실이 여기서도 확인된다.**

**`Service` 항목이 [[05a-setting-up-grafana-tempo]]의 Q7(세 파이프라인이 `resource` 프로세서를 공유)의 결과**다.

**4.69초는 이 애플리케이션의 정상 응답 시간에 비하면 이상하게 길다.** **어디서 쓰였는지는 이 목록으로는 알 수 없다 — 트레이스를 열어야 한다** → Q4.

---

## Q3. `create employee` span 이름의 출처

**[[05b-enabling-trace-export-and-kafka-propagation]]의 `.contextualName("create employee")`다.**

```java
Observation.createNotStarted("employee.create", observationRegistry)
           .contextualName("create employee")     // ← 이 값이 span 이름
```

**`createNotStarted`의 첫 인자(`employee.create`)와 다르다** — 앞은 **관측의 기술적 이름**(메트릭 이름 등에 쓰인다), **`contextualName`은 사람이 읽기 좋은 이름**으로 **트레이싱 백엔드의 span 이름**이 된다.

**[[05b-enabling-trace-export-and-kafka-propagation]]의 Q4가 이것을 예고했다** — **자동 계측만으로는 도메인 언어가 없고**, 그래서 **비즈니스 span을 얹었다.** 그 결과가 이 화면에 나타난다.

**다른 span들의 출처도 갈린다**:
```
http post /employees          ← 자동 계측 (Spring MVC)
create employee               ← 우리가 얹은 비즈니스 span
employee-events send/process  ← 자동 계측 (Kafka observation)
process employee notification ← 우리가 얹은 비즈니스 span
```

---

## Q4. 4.69초 중 범인을 찾는 과정

```text
http post /employees (4.69s)              ← 100%
  └ create employee (1.17s)
      └ employee-events send (1.02s)
          └ employee-events process (0.32s)
              └ process employee notification (2.18s)   ← 약 46%
```

**막대 길이를 보면 답이 즉시 나온다** — **`process employee notification` (2.18초)이 전체의 약 46%.**

> **"이 예에서 `process employee notification` span이 트레이스 지속 시간의 가장 큰 몫을 차지하며, 지연의 주된 기여자다."**

**다른 신호와 비교하면 이 절의 가치가 드러난다**:
| 신호 | **이 결론까지의 거리** |
|---|---|
| 메트릭 | **"평균이 올랐다"까지. 어느 구간인지 모른다** |
| 로그 | **시각 차를 손으로 계산해야 한다** |
| **트레이스** | **막대 길이를 눈으로 본다** |

**주의 — 계층을 따라 내려가야 한다**(§5): **"가장 긴 span이 항상 범인이다"는 오해**다. **그 span이 자식들의 합이라면 진짜 범인은 자식 중에 있다.** **잎(leaf)까지 내려가야** 한다. 여기서는 `process employee notification`이 **잎**이므로 범인이 맞다.

**§6의 한계**: **waterfall만으로는 원인을 모른다** — **"여기가 느리다"까지**이고 **"왜"는 로그에 있다.** [[06-correlating-logs-metrics-and-traces]]가 그 이동을 만든다.

---

## Q5. `send`와 `process`가 한 트레이스에 있는 것이 증거인 이유

**두 span이 다른 스레드에서, 다른 시각에 실행됐는데 같은 traceId를 갖기 때문이다.**

```
employee-events send (생산자 · 스레드 A)
        │ 메시지 헤더에 trace ID
        ▼
    Kafka 토픽
        │ 헤더에서 trace ID 복원
        ▼
employee-events process (소비자 · 스레드 B) → process employee notification
```

> **[[05-tracing-with-opentelemetry-and-tempo]]에서 말한 전파 경계를 실제로 넘은 것이다.**

**책의 표현**: **"이 뷰는 트레이스 컨텍스트가 Kafka를 가로질러 보존되어, 생산자와 소비자 span이 하나의 end-to-end 트레이스를 이룬다는 것을 확인해 준다. 동기·비동기 단계를 모두 포함한 전체 워크플로를 하나의 연산으로 분석할 수 있다."**

**Q1의 "전파 실패 시 트레이스가 2개"라는 증상이, 이 화면에서 span 5개가 한 트레이스에 있음으로 반증된다.**

**그리고 이것이 [[04b-adding-custom-business-metrics-with-micrometer]]가 지적한 "비동기 부분이 안 보이는" 문제의 최종 해결**이다 — 메트릭으로는 **별도 카운터**를 뒀고, 트레이스로는 **같은 트레이스에 담았다.**

> **원문 표기 문제 세 가지**: (1) **Trace ID가 Figure 13.9 설명과 13.10 설명에서 다르게 인쇄**됐고, 후자에는 **16진수가 아닌 `w`·`s`가 섞여** 있다. (2) **Span Filters는 "4 spans"라 하지만 패널에는 루트 포함 5개 행**이 있다. (3) **본문 나열이 넷인데 화면에는 루트 `http post /employees`가 더 있다.**

---

## Q6. span 시간을 단순 합산하면 안 되는 이유

**부모가 자식을 포함하고, 일부는 병렬일 수 있기 때문이다.**

```
단순 합산:  4.69 + 1.17 + 1.02 + 0.32 + 2.18 = 9.38s   ← 실제의 두 배
실제:       4.69s (루트가 나머지를 포함)
```

> **"span 시간을 다 더하면 총 시간이 된다" — 되지 않는다.**

**[[05b-enabling-trace-export-and-kafka-propagation]]의 비유가 깨진 지점과 같은 사실**이다 — **"공정과 부품이 같은 시간을 두 번 센다"는 오해.**

**읽는 법**: **계층을 따라 내려가며 "부모 시간 중 이 자식이 몇 %인가"**를 본다. **형제 span들의 합이 부모보다 작으면** 그 차이가 **부모 자신의 작업 시간**이거나 **계측되지 않은 구간**이다.

**병렬도 고려해야 한다** — 형제 span들이 **동시에 실행**됐다면 **합이 부모를 넘을 수도** 있다. **막대의 가로 위치**가 그것을 보여 준다.

---

## Q7. 가장 긴 span이 범인이 아닐 수 있는 경우

**그 span이 자식들의 합일 때다.**

```
느린 span (3s)
  └ 자식 A (0.1s)
  └ 자식 B (2.8s)   ← 진짜 범인
```

**부모 span은 "그 구간 전체"를 재므로**, 자식이 오래 걸리면 **부모도 자동으로 길어진다.** 부모 자신이 한 일은 0.1초일 수 있다.

> **잎(leaf)까지 내려가야 한다.**

**판별 요령**: **부모 시간 − 자식들 시간 = 부모 자신의 작업 시간.** 그 값이 크면 부모가 범인, 작으면 자식이 범인이다.

**이 예에서는**: `http post /employees` 4.69초가 가장 길지만 **범인이 아니다** — 그 안의 `process employee notification` 2.18초가 잎이고 최대 기여자다.

**§6의 다른 경계**: **샘플링이 낮으면 그 요청이 없다** — **여기서는 `1.0`이라 전부 있지만 운영에서는 다르다.** 그리고 **Search는 시간 범위와 조건에 의존한다** — **오래된 트레이스는 [[05a-setting-up-grafana-tempo]]의 24시간 보존 기간이 지나면 사라진다.**

**"Search로만 트레이스를 찾을 수 있다"는 오해도 함께**(§5) — **trace ID를 알면 TraceQL로 직접 조회할 수 있고, 그것이 [[06-correlating-logs-metrics-and-traces]]에서 로그로부터 넘어오는 방식이다.**

---

## Q8. 막대그래프 비유가 깨지는 지점

**비유**: waterfall은 **"공정별 소요 시간 막대그래프"** — **어느 공정이 병목인지 길이로 보인다.**

**깨지는 지점**: **막대가 중첩된다는 점을 담지 못한다.**

> **부모 span의 막대 안에 자식 막대들이 들어 있어서, 단순 막대그래프처럼 길이를 합산하면 총합이 실제보다 훨씬 커진다. 읽을 때는 계층을 따라 내려가며 봐야 한다.**

```
막대그래프:  막대들이 나란히. 합이 전체
waterfall:   막대들이 중첩. 부모 안에 자식 (Q6·Q7)
```

**Q6과 Q7이 이 성질의 두 결과**다 — **합산 금지**와 **잎까지 내려가기**.

**비유가 맞는 부분은 남는다** — **길이로 병목이 보인다**(Q4). 깨지는 것은 **막대들의 관계**다.

**정확한 비유로 고치면**: 막대그래프보다 **프로젝트 간트 차트**에 가깝다 — **상위 작업 아래 하위 작업이 들어가고, 시작 시각이 가로 위치로 표현되며, 일부는 병렬**이다.

---

## 재출제 문항

1. Tempo에 트레이스가 잘 뜬다. 전파가 됐다고 말할 수 있는가?
2. 검색 결과의 `Service` 값이 어디서 왔는지 추적해 보라.
3. span 이름이 `EmployeeService.createEmployee` 같은 기술 이름이다. 무엇이 빠졌는가?
4. 트레이스가 5초인데 어느 구간인지 모른다. 어떤 순서로 좁히는가?
5. 생산자와 소비자 span이 서로 다른 트레이스에 있다. 무엇을 확인하는가?
6. span 시간을 다 더했더니 총 시간의 두 배다. 버그인가?
7. 3초짜리 span을 찾았다. 바로 그것을 고치면 되는가?
8. waterfall이 간트 차트에 가깝다는 것이 무슨 뜻인가?

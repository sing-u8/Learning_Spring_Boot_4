# 모범답안 — 06 로그·메트릭·트레이스 상관관계

> **먼저 답하고 나서 열 것.** [[06-correlating-logs-metrics-and-traces]]의 `## 8. 스스로 확인` 아홉 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **9문항 모두 답이 충분**했다.

---

## Q1. "관련돼 있다"와 "상관돼 있다"

> **"텔레메트리는 이미 관련돼(related) 있다. 그러나 사용자 관점에서는 아직 완전히 상관돼(correlated) 있지 않다."**

**차이는 조사 6단계에 있다**:
| 단계 | **지금 해야 하는 일** |
|---|---|
| 1 | Loki Explore에서 오류 로그를 찾는다 |
| 2 | **로그 JSON에서 `traceId` 값을 눈으로 찾아 복사한다** |
| 3 | **데이터 소스를 Tempo로 바꾼다** |
| 4 | **복사한 ID를 붙여넣는다** |
| 5 | waterfall에서 느린 span을 찾는다 |
| 6 | **메트릭을 보려면 Prometheus로 또 바꾸고 질의를 손으로 쓴다** |

> **데이터는 다 있다. 그런데 사람이 접착제 노릇을 한다.**

**상관관계**: **서로 다른 신호를 같은 요청으로 이어 붙여 한 흐름으로 오갈 수 있게 만드는 것.**

**즉 "관련"은 데이터의 성질이고 "상관"은 도구의 성질**이다. traceId는 이미 로그에 있지만, **그것을 클릭 한 번으로 만들어 주는 것은 Grafana 설정**이다.

---

## Q2. 애플리케이션 코드를 고치지 않아도 되는 이유

> **"애플리케이션이 이미 필요한 데이터를 내보내고 있으므로 애플리케이션 로직 변경은 필요 없다."**

**바꿀 것은 `grafana-datasources.yml` 하나뿐이다.**

**앞 절들이 준비해 둔 것**:
| 준비 | 어느 절 |
|---|---|
| **로그가 JSON이고 그 안에 traceId** | [[03b-instrumenting-the-application-for-logging]] (`logging.structured.format`, `captureMdcAttributes`) |
| **`service.name`이 세 신호에 일관되게** | [[03b-instrumenting-the-application-for-logging]] + [[05a-setting-up-grafana-tempo]]의 `resource` 프로세서 공유 |
| **메트릭 태그(`role`, `outcome`)** | [[04b-adding-custom-business-metrics-with-micrometer]] |
| **Kafka를 넘는 trace 전파** | [[05b-enabling-trace-export-and-kafka-propagation]] |

> **앞의 세 절이 재료를 다 준비해 뒀기 때문에 가능한 일이다.**

**[[02-designing-an-observability-architecture]]의 "하나의 관측에서 세 신호가 파생된다"가 최종적으로 값을 내는 지점**이다 — **같은 순간에서 나왔으므로 같은 ID를 공유하고, 그래서 이어 붙일 수 있다.**

---

## Q3. `uid`가 새로 필요해진 이유

**한 데이터 소스가 다른 데이터 소스를 가리켜야 하기 때문이다.**

> **Loki 설정 안에서 "여기서 Tempo로 가라"고 쓰려면 Tempo를 부를 이름이 있어야 한다. 이름(`name`)은 사람이 바꿀 수 있으니 안정적인 식별자가 따로 필요하다.**

```yaml
- name: Loki       / uid: loki
- name: Prometheus / uid: prometheus
- name: Tempo      / uid: tempo
```

> **앞의 세 절에서는 각 데이터 소스가 독립적이라 `uid`가 없어도 됐다. 서로를 참조하기 시작하는 순간 필요해진다.**

**세 방향의 이동**:
| 방향 | **설정** | **어디에** |
|---|---|---|
| Log → Trace | **`derivedFields`** | Loki |
| Trace → Log | **`tracesToLogsV2`** | Tempo |
| Trace → Metric | **`tracesToMetrics`** | Tempo |
| Metric → Trace | **`exemplar`** | Prometheus |

---

## Q4. `matcherRegex`가 잡는 필드

**`attributes` 안의 camelCase `traceId`다.**

```json
{"body":"...","traceid":"5c356ba4...","spanid":"...",
 "attributes":{"spanId":"...","traceId":"5c356ba4..."}, ...}
       ↑ 최상위는 소문자 traceid      ↑ attributes 안은 camelCase traceId
```

**정규식**: `'"traceId":"([A-Fa-f0-9]+)"'` — **대문자 `I`를 찾으므로 `attributes` 안의 것을 잡는다.**

> **만약 최상위 소문자 키만 있었다면 이 설정은 조용히 실패했을 것이다.**

**"정규식이 최상위 `traceid`를 잡는다"는 오해다**(§5) — **대소문자가 다르다.**

**정규식 기반 추출의 취약함이 여기 드러난다** — **로그 형식이 조금만 바뀌어도 링크가 사라진다**(§6).

**동작 조건**: **로그가 JSON이고 그 안에 traceId가 있어야 한다.** [[03b-instrumenting-the-application-for-logging]]의 두 설정이 **여기서 회수된다.**

**화면에서 확인되는 것 셋**: **`Fields` 영역**(승격한 라벨들), **`Links` 영역**(`TraceID` + **View Trace** 버튼 — `derivedFields`의 산물), **로그 본문의 두 표기**.

---

## Q5. `tracesToLogsV2`의 `tags` 매핑이 필요한 이유

**두 시스템의 이름 규칙이 다르기 때문이다.**

```yaml
tags:
  - key: service.name      ← Tempo(span)의 속성 이름
    value: service_name    ← Loki 라벨 이름
```

**[[03c-verifying-logs-in-grafana]]의 Q3에서 본 변환**이다 — **OpenTelemetry의 점 표기가 Loki에서는 밑줄**이 된다.

**매핑이 없으면**: Tempo가 `service.name`으로 Loki에 질의하는데 **Loki에는 그런 라벨이 없어** 빈 결과가 나온다.

**§6의 경고**: **`tags` 매핑이 틀리면 빈 결과가 나온다.** **`service_name`인지 `exported_job`인지는 각 백엔드의 실제 라벨을 봐야 안다** → Q7.

**`customQuery: true` + `query`도 함께**: **기본 질의로는 traceId 필터가 안 되므로** 직접 쓴 LogQL을 쓴다.
```text
{${__tags}}                      ← 라벨 선택자 (service_name으로 좁힌다)
| json                           ← 본문을 JSON으로 파싱
| traceId="${__trace.traceId}"   ← 파싱된 필드로 필터
```
**[[03c-verifying-logs-in-grafana]]에서 배운 LogQL 구조 그대로**다 — **먼저 라벨로 좁히고 그다음 본문**.

---

## Q6. 시간 창을 앞뒤 2분씩 넓히는 이유

**① 시계 오차. ② 배칭 지연.**

> **`spanStartTimeShift: -2m` / `spanEndTimeShift: 2m`이 시간 창을 앞뒤로 2분씩 넓혀 시계 오차와 배칭 지연을 흡수한다.**

**배칭 지연이 구체적이다** — [[03a-setting-up-the-logging-infrastructure]]의 **`batch` 프로세서**가 로그를 모아서 보내므로, **로그의 도착 시각이 span의 시각보다 늦다.** 창을 span 구간에 딱 맞추면 **그 로그가 밖으로 밀려난다.**

**시계 오차**: 애플리케이션·Collector·Loki가 **다른 컨테이너**이고, 컨테이너마다 시계가 미세하게 다를 수 있다.

**"시간 창을 넓히는 건 대충 한 것이다"는 오해다**(§5) — **실무적 조치다. 좁히면 경계의 로그를 놓친다.**

**대가**: 넓히면 **관계없는 로그가 섞일 수 있다.** 다만 **traceId 필터가 함께 걸리므로** 실질적 문제가 적다 — **시간 창은 범위를 좁히는 1차 필터**이고 **정확한 선별은 traceId가 한다.**

---

## Q7. `tracesToMetrics`의 `tags`가 `exported_job`인 근거

**[[04c-verifying-metrics-in-prometheus-and-grafana]]의 질의 결과 화면이다.**

```text
employee_created_count_total{exported_job="employee-service", job="otel-collector", ...}
                             └──────┬──────┘
                    서비스 이름이 여기로 밀려났다
```

> **`job`이 스크레이프 작업 이름에 밀려 서비스 이름이 `exported_job`으로 간 결과다. 그 화면을 봐 두지 않았다면 이 값을 알 수 없다.**

**즉 설정 파일만 읽어서는 알 수 없는 값**이다 — **실제 데이터를 본 경험이 설정에 반영**돼 있다.

**Q5의 `service_name`과 대비하면 요점이 분명하다** — **같은 `service.name`이 Loki에서는 `service_name`, Prometheus에서는 `exported_job`**이다. **백엔드마다 이름이 다르므로 매핑을 따로 적어야** 한다.

**`queries`가 목록인 것도 이 기능의 성격을 정한다** — **질의를 미리 이름 붙여 등록해 둔다.** **조사하는 사람이 PromQL을 쓸 필요가 없어진다.**

**세 질의가 [[04b-adding-custom-business-metrics-with-micrometer]]의 메트릭 셋과 정확히 대응**한다:
| 이름 | 메트릭 | 태그 |
|---|---|---|
| Employee creations | `employee_created_count_total` | `role` |
| Employee creation latency | `employee_create_time_milliseconds_*` | — |
| Notification outcomes | `employee_notification_count_total` | `outcome` |

**§6의 한계**: **미리 정한 질의뿐이다.** **예상 밖의 각도로 보려면 결국 손으로 쓴다.**

---

## Q8. `clamp_min(..., 1)`이 막는 문제

**분모가 0이 되는 것을 막는다.**

```promql
sum(rate(..._sum[5m])) / clamp_min(sum(rate(..._count[5m])), 1)
                         └──────────────┬──────────────┘
                     0 이면 1 로 올린다 → 나눗셈이 깨지지 않는다
```

> **그 구간에 요청이 없으면 `_count`의 rate가 0이 되어 나눗셈이 깨지기 때문이다.**

**[[04c-verifying-metrics-in-prometheus-and-grafana]]의 Q7과 같은 상황**이다 — **트래픽이 없으면 rate가 0**이 된다. 거기서는 **실패율이 0%로 보이는 문제**였고, 여기서는 **나눗셈이 깨지는 문제**다.

**`increase(...[5m])`도 함께 알아 둘 것**: **`rate`와 사촌**이며 **`rate`가 초당 증가율이라면 `increase`는 구간 전체의 증가량**이다. **"지난 5분간 몇 건"에는 이쪽이 읽기 쉽다.**

---

## Q9. 상호 참조 색인 비유가 깨지는 지점

**비유**: 상관관계 설정은 **"도서관의 상호 참조 색인"** — **각 책에 "관련 항목은 몇 권 몇 쪽" 하는 표시를 붙여 두는 일.**

**깨지는 지점**: **참조가 값에 의해 계산된다는 점을 담지 못한다.**

> **색인은 사람이 미리 적어 두지만, 여기서는 traceId라는 런타임 값으로 링크가 그때그때 만들어진다. 그래서 새 요청이 들어와도 설정을 고칠 필요가 없고, 반대로 그 값이 로그에 없으면 링크 자체가 생기지 않는다.**

```
색인:  사람이 항목마다 적는다 → 항목이 늘면 색인도 늘려야 한다
상관:  정규식이 값을 추출한다 → 요청이 무한히 늘어도 설정은 그대로
                                단, 값이 없으면 링크도 없다 (Q4)
```

**"설정 한 번에 무한한 링크"**가 이 방식의 힘이고, **"값이 없으면 조용히 사라짐"**이 그 대가다.

**비유가 맞는 부분은 남는다** — **다른 자료로 건너가는 경로를 만든다**(Q1). 깨지는 것은 **링크 생성 방식**이다.

**최종 결과**: 조사 6단계가 4단계로 줄고, **2·3·4단계(복사·전환·붙여넣기)가 "View Trace를 누른다" 하나**로, **6단계(질의 작성)가 "메뉴에서 고른다"**로 바뀐다.

> **"이는 컨텍스트 전환을 줄이고 증상에서 근본 원인까지의 경로를 짧게 만든다."** — **"로그로 시작해 트레이스를 열고 관련 메트릭을 살펴볼 수 있다. 이것이 시스템 동작에 대한 명확하고 완전한 시야를 준다."**

**§6의 나머지 경계**: **exemplar는 별도 준비가 필요하다** — **`exemplarTraceIdDestinations`를 적어도 메트릭에 exemplar가 실제로 붙어 있어야 동작한다.**

---

## 재출제 문항

1. traceId가 로그에 이미 있다. 그런데 왜 상관관계 설정이 필요한가?
2. 상관관계를 켜려고 애플리케이션 코드를 열었다. 무엇이 잘못됐는가?
3. 데이터 소스 이름을 `Loki`에서 `로키`로 바꿨다. 무엇이 깨지는가?
4. 로그 형식을 바꿨더니 View Trace 버튼이 사라졌다. 어디를 보는가?
5. Trace → Log가 빈 결과를 낸다. `tags` 매핑에서 무엇을 확인하는가?
6. 시간 창을 span 구간에 딱 맞췄다. 어떤 로그를 놓치는가?
7. 같은 `service.name`이 백엔드마다 다른 이름이다. 어떻게 알아내는가?
8. 트래픽이 없는 구간에서 평균 질의가 깨진다. 어떻게 막는가?
9. 요청이 하루 백만 건이다. 상관관계 설정을 몇 번 고쳐야 하는가?

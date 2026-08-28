# 모범답안 — 04c Prometheus·Grafana에서 메트릭 검증

> **먼저 답하고 나서 열 것.** [[04c-verifying-metrics-in-prometheus-and-grafana]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. `employee.created.count`가 Prometheus에서 되는 이름

```text
Micrometer:  employee.created.count
Prometheus:  employee_created_count_total
```

**이유**: **이름 규칙이 다르다.** **Micrometer는 점으로 계층을 표현하고 Prometheus는 밑줄을 쓴다.** 게다가 **카운터에는 `_total` 접미사가 붙는다.**

> **"코드에 적은 이름으로 검색하면 된다" — 점이 밑줄이 되고 카운터에는 `_total`이, 타이머에는 `_sum`/`_count`와 단위가 붙는다.**

**Timer는 더 복잡하다**: `employee.create.time` → **`employee_create_time_milliseconds_sum`과 `..._count`** — **`_milliseconds`가 이름에 들어간 것은 Micrometer가 단위를 이름에 넣어 내보내기 때문**이다.

**[[03c-verifying-logs-in-grafana]]의 `service.name` → `service_name`과 같은 종류의 변환**이다 — **각 백엔드가 자기 이름 규칙을 갖는다.**

**실무 요령**: **추측하지 말고 Prometheus의 자동완성으로 실제 이름을 찾는다.**

---

## Q2. 질의 결과 한 줄의 라벨 다섯

```text
employee_created_count_total{exported_job="employee-service", instance="otel-collector:9464",
                             job="otel-collector", role="ENGINEER"}   15
```

| 부분 | **어디서 왔나** |
|---|---|
| `employee_created_count_total` | **코드의 `employee.created.count` + Prometheus 이름 규칙** |
| **`role="ENGINEER"`** | **`.tag("role", role)`** — [[04b-adding-custom-business-metrics-with-micrometer]] |
| `exported_job="employee-service"` | **`resource` 프로세서의 `service.name`** |
| `job="otel-collector"` | **`prometheus.yml`의 `job_name`** |
| `instance="otel-collector:9464"` | **스크레이프 대상 주소** |
| `15` | 지금까지 15명 생성 |

**한 줄에 이 절의 결론이 다 들어 있다** — **코드·Collector 설정·Prometheus 설정이 각각 라벨 하나씩을 기여**한다.

**핵심은 메트릭 태그가 Prometheus 라벨이 됐다는 것**이다:
> **`role="ENGINEER"` 라벨은 메트릭 태그가 질의 가능한 차원이 되어, 전역 합계로만 세는 대신 비즈니스 속성으로 필터·분석할 수 있음을 보여 준다.**

---

## Q3. `exported_job`이라는 이름이 생긴 이유

**`job`을 스크레이프 작업 이름이 이미 차지했기 때문이다.**

> **`job`은 이미 스크레이프 작업 이름(`otel-collector`)이 차지했으므로, 애플리케이션이 붙인 서비스 이름은 `exported_` 접두사가 붙어 밀려났다.**

```
prometheus.yml 의 job_name: otel-collector  →  job="otel-collector"
애플리케이션의 service.name: employee-service →  exported_job="employee-service"
                                                 ↑ 충돌을 피해 접두사가 붙었다
```

**"`job` 라벨이 서비스 이름이다"는 오해다**(§5) — **이 구성에서 `job`은 스크레이프 작업 이름이고, 서비스 이름은 `exported_job`으로 밀려나 있다.**

**이 이름이 [[06-correlating-logs-metrics-and-traces]]의 `tracesToMetrics` 설정에 `value: exported_job`으로 그대로 등장한다** — **이름 충돌의 결과가 상관관계 설정까지 이어진다.**

**설정을 읽을 때의 교훈**: **라벨 이름은 여러 층이 기여하므로 충돌이 일어날 수 있고**, Prometheus는 **이름을 바꿔서 보존**한다. **화면에서 실제 이름을 확인하는 것이 유일하게 확실한 방법**이다.

---

## Q4. Timer가 시계열 두 개인 이유와 평균 구하기

| 시계열 | **담는 것** |
|---|---|
| `..._sum` | **모든 실행의 소요 시간 합계** |
| `..._count` | **실행 횟수** |

> **"Timer 하나가 시계열 하나다" — 둘이다. 합계와 횟수가 따로 저장되고, 평균은 계산해서 얻는다.**

**평균 = 두 시계열의 나눗셈**:
```promql
rate(employee_create_time_milliseconds_sum[1m]) / rate(employee_create_time_milliseconds_count[1m])
```

**왜 이렇게 저장하나**: **합계와 횟수만 있으면 어떤 구간의 평균이든 계산할 수 있다.** 평균을 미리 계산해 저장하면 **구간을 나중에 바꿀 수 없다**(평균의 평균은 평균이 아니다).

**`rate`를 씌우는 이유** → Q5.

**비유의 깨짐이 이것이다** — 여권 표기 비유는 **이름이 하나에서 둘로 늘어난다는 점을 담지 못한다.** **Timer는 저쪽에서 `_sum`과 `_count` 두 항목이 되므로 대응이 1:1이 아니라 1:다이며, 원래 값을 되찾으려면 계산이 필요하다.**

---

## Q5. `rate`를 씌우는 것과 안 씌우는 것

```
sum / count               = 프로세스 시작 이후 전체 평균
                            → 어제의 느린 요청이 오늘의 평균에 계속 섞인다
rate(sum[1m]) / rate(count[1m]) = 지난 1분 동안의 평균
                            → 지금 상태를 반영한다
```

> **Counter 계열 시계열은 프로세스가 시작한 뒤로 계속 누적되기만 한다. 그대로 나누면 전 기간 평균이 나오고, 최근의 변화가 묻힌다.**

**`rate`**: **시계열의 초당 증가율을 계산하는 함수.**

**"평균은 `sum / count`면 된다"는 오해다**(§5) — **그러면 프로세스 시작 이후 전 기간 평균**이다.

**구체적 함정**: 어제 장애로 평균이 5초였고 오늘은 40ms라면, **누적 평균은 여전히 나빠 보인다.** 그리고 **오래 돌수록 최근 변화에 둔감**해진다 — 프로세스가 한 달 돌았으면 오늘의 급증이 거의 안 보인다.

**§6의 경계**: **`rate`의 구간이 짧으면 노이즈가 크고, 길면 변화를 늦게 본다.** **`[1m]`은 로컬 예제용이다.**

**다섯 질의가 각각 다른 종류의 질문에 답한다** — 원시 조회 두 개, **라벨로 그룹핑** 두 개(`sum by (role)`, `sum by (outcome)`), **rate 기반 평균** 하나.

---

## Q6. `Notification Outcomes`의 네 항목

**[[04b-adding-custom-business-metrics-with-micrometer]]의 `outcome` 태그 네 값과 1:1로 대응한다.**

```
duplicate 8 · failed 8 · received 23 · sent 7
     ↑          ↑          ↑           ↑
  중복 걸름   발송 실패   Kafka 수신   발송 성공
```

> **코드에 적은 문자열이 대시보드 항목 이름이 됐다.**

**이것이 Q6의 태그 설계(메트릭 하나 + 태그로 구분)가 값을 내는 지점**이다 — **`sum by (outcome)` 하나로 네 항목이 나온다.** 메트릭을 넷으로 나눴다면 **패널마다 다른 질의**를 넣어야 했다.

**숫자를 읽으면 시스템 상태가 보인다**: **received 23 = duplicate 8 + failed 8 + sent 7.** **중복이 3분의 1**이고 **실패가 3분의 1** — [[04b-adding-custom-business-metrics-with-micrometer]]의 `Math.random() < 0.5` 시뮬레이션이 만든 결과다.

**이 화면이 이 절의 목적을 완성한다** — **동기 구간(생성)과 비동기 구간(알림)의 상태가 한 화면에 있다.** [[04b-adding-custom-business-metrics-with-micrometer]]의 **"비동기 부분에는 자기 메트릭이 필요하다"**가 **시각적으로 확인**된다.

---

## Q7. 실패율 0%와 failed 8이 동시에 참인 이유

**재는 것이 다르다.**

| 패널 | **재는 것** |
|---|---|
| `Notification Failure Rate` **0%** | **`rate` 기반 — "지금 이 순간의 실패 속도"** (마지막 요청 이후 시간이 지나 0이 됐다) |
| `Notification Outcomes` **failed 8** | **누적 카운트** |

> **모순이 아니라 재는 것이 다르다. 책은 이 차이를 설명하지 않지만, 대시보드를 읽을 때 순간값과 누적값을 구분해야 한다는 교훈이 여기 있다.**

**"실패율 0%면 실패가 없다"는 오해다**(§5) — **순간 rate가 0일 뿐 누적 실패는 8건이다.**

**Q5와 같은 구분이 대시보드 읽기에도 적용된다** — **`rate`가 붙은 패널은 "지금", 안 붙은 패널은 "그동안"**이다.

**실무적 함정**: **알림(alert)을 `rate` 기준으로 걸면 트래픽이 없을 때 조용해진다.** 그것이 옳을 때도 있지만(요청이 없으면 실패도 없다), **"요청 자체가 0인 이상 상황"**은 별도로 감시해야 한다 — [[04b-adding-custom-business-metrics-with-micrometer]]의 Q1 표 마지막 줄.

---

## Q8. 여권 표기 비유가 깨지는 지점

**비유**: 메트릭 이름 변환은 **"여권의 로마자 표기"** — **원래 이름과 대응하지만 규칙에 따라 모양이 바뀌고, 그 규칙을 모르면 같은 사람인 줄 모른다.**

**깨지는 지점**: **이름이 하나에서 둘로 늘어난다는 점을 담지 못한다.**

> **Timer는 저쪽에서 `_sum`과 `_count` 두 항목이 되므로, 대응이 1:1이 아니라 1:다이며 원래 값을 되찾으려면 계산이 필요하다.**

```
여권:   홍길동 → HONG GILDONG          (1:1, 되돌릴 수 있다)
Timer:  employee.create.time → _sum + _count  (1:2, 나눠야 원래 개념이 나온다)
```

**Counter도 완전한 1:1은 아니다** — `_total` 접미사가 붙는다. **다만 값은 그대로**이므로 Timer보다 단순하다.

**비유가 맞는 부분은 남는다** — **규칙을 알아야 같은 것인 줄 안다**(Q1). 깨지는 것은 **대응의 개수**다.

**§6의 나머지 경계**: **대시보드는 이미 아는 질문만 답한다** — **예상 못 한 문제에는 Explore로 즉석 질의**를 던진다([[01-three-pillars-of-observability]]의 모니터링/관측 가능성 구분이 도구 층에서 반복된다). 그리고 **메트릭으로는 "그 요청"을 찾을 수 없다** — **실패율이 올랐다는 것까지가 한계**이고 **어느 요청이었는지는 [[05-tracing-with-opentelemetry-and-tempo]]의 몫**이다.

---

## 재출제 문항

1. `employee.notification.count`를 Prometheus에서 찾으려면 무엇으로 검색하는가?
2. 질의 결과에 라벨이 다섯 개다. 각각 어느 파일에서 왔는가?
3. `job` 라벨이 서비스 이름이 아니다. 그러면 무엇인가?
4. Timer의 평균을 미리 계산해 저장하면 무엇을 잃는가?
5. 프로세스가 한 달 돌았다. `sum/count`가 오늘의 급증을 보여 주는가?
6. 알림 결과 패널이 한 질의로 네 항목을 낸다. 코드의 어떤 설계 덕분인가?
7. 실패율 0%인데 실패가 8건이다. 어느 쪽이 "지금"인가?
8. Counter와 Timer 중 이름 대응이 1:1에 가까운 것은?

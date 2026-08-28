# 모범답안 — 03c Grafana에서 로그 검증

> **먼저 답하고 나서 열 것.** [[03c-verifying-logs-in-grafana]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 설정이 틀렸을 때 "아무것도 안 보임"으로 나타나는 이유

**파이프라인의 각 단계가 "보내기"이지 "확인받기"가 아니기 때문이다.**

| 어긋날 수 있는 곳 | **증상** |
|---|---|
| OTLP 엔드포인트 포트 오타 | **조용히 실패** |
| `ObservabilityConfig` 누락 | **조용히 실패** |
| Collector의 exporter 설정 오류 | **조용히 실패** |
| `loki.resource.labels` 누락 | **로그는 오는데 질의로 못 찾는다** |

> **어느 한 곳만 틀려도 로그는 Loki에 도착하지 않는다. 그리고 대부분의 경우 오류가 나지 않는다 — 그냥 아무것도 안 보인다.**

**애플리케이션은 로그를 남기는 것이 본업이 아니므로**, 로그 전송이 실패해도 **본업을 계속한다.** 그것이 올바른 설계이면서 동시에 **진단을 어렵게** 만든다.

**규모도 문제다**: **컨테이너 셋, 의존성 다섯, YAML 두 개, XML 하나, 자바 클래스 하나.** 후보가 많다.

> **그래서 끝에서 확인하는 절차가 필요하다.**

**"로그가 안 보이면 애플리케이션이 로그를 안 남긴 것이다"는 오해다**(§5) — **일곱 정거장 중 어디서든 끊길 수 있다.** **콘솔에는 보이는데 Grafana에 없다면 3번 이후가 문제다.**

---

## Q2. `{service_name="employee-service"}`가 성립하기까지의 네 단계

```
1. application.yml: service.name: employee-service
2. OTLP 로 리소스 속성 전달
3. Collector resource 프로세서: loki.resource.labels 에 service.name 포함
4. Loki 라벨 service_name 색인됨
   → {service_name="employee-service"} 질의 성립
```

> **리소스 속성으로 선언한 값이 라벨 승격을 거쳐 색인 라벨이 됐기 때문에 이 질의가 동작한다. 승격하지 않았다면 로그는 저장돼 있어도 이 방식으로는 고를 수 없다.**

**즉 이 짧은 질의 한 줄이 [[03a-setting-up-the-logging-infrastructure]]와 [[03b-instrumenting-the-application-for-logging]]의 설정을 통째로 검증한다.** 질의가 되면 **네 단계가 전부 정상**이다.

**그래서 이 절이 "검증"인 것이다** — 설정을 하나씩 확인하는 대신 **끝에서 한 번 확인**한다.

---

## Q3. `service.name`이 `service_name`이 된 이유

**Loki의 라벨 이름 규칙 때문이다.**

> **OpenTelemetry의 속성 이름과 Loki의 라벨 이름이 표기 규칙이 달라 변환된다.**

```
OpenTelemetry:  service.name          (점 표기)
Loki 라벨:      service_name          (밑줄 표기)
```

**실무적 함의**: **설정에 적은 이름 그대로 질의하면 안 된다.** `{service.name="..."}`는 동작하지 않는다.

**같은 변환이 다른 속성에도 적용된다** — `deployment.environment` → `deployment_environment`.

**어디서 확인하나** → Q4의 `Common labels` 줄. **추측하지 말고 화면에서 실제 라벨 이름을 본다.**

---

## Q4. `Common labels` 줄에서 확인할 수 있는 것

```text
deployment_environment=local   exporter=OTLP   job=employee-service   service_name=employee-service
```

> **`deployment_environment`와 `service_name`이 바로 우리가 `loki.resource.labels`에 적어 승격시킨 둘이다. 설정이 실제로 먹었다는 직접 증거다.**

**`exporter=OTLP`와 `job`은 Loki 익스포터가 자동으로 붙인 것이다.**

**세 가지를 한 줄로 확인한다**:
1. **승격이 됐다** — 우리가 지정한 둘이 라벨로 보인다
2. **이름이 어떻게 변환됐는지**(Q3) — 점이 밑줄로
3. **자동으로 붙은 라벨이 무엇인지** — 우리가 안 넣은 것도 있다

**화면에서 확인되는 나머지 둘**:
- **로그 본문이 JSON이다** — **구조화 로깅의 결과.** `severity`로 필터하고 `instrumentation_scope.name`으로 어느 클래스인지 안다
- **여러 컴포넌트의 로그가 한 화면에 있다** — `NotificationService`, `KafkaMessageListenerContainer`, `ClassicKafkaConsumer`가 섞여 있다. **애플리케이션 코드와 프레임워크 로그가 같은 파이프라인으로 나온다**

> **원문 불일치**: **화면의 `instrumentation_scope`에는 `com.springbootlearning4`로 찍혀 있는데 설정은 `com.learningspringboot4`**다.

---

## Q5. `resources` 안에 `service.version`이 있는데 라벨에는 없는 이유

**승격하지 않았기 때문이다.**

> **`resources` 안에는 `service.version`처럼 승격하지 않은 리소스 속성이 들어 있다 — 라벨은 아니지만 본문에는 남는다.**

```
application.yml 의 resource-attributes 셋:
  service.name             → loki.resource.labels 에 포함 → 라벨 ✅
  deployment.environment   → loki.resource.labels 에 포함 → 라벨 ✅
  service.version          → 미포함                       → 본문에만 ❌
```

**의미**: **승격은 색인 여부를 정하는 것이지 데이터의 유무를 정하는 것이 아니다.**

**그래서 두 가지를 할 수 있다**:
- **라벨로 질의한다** — 싸다, 스트림을 고른다
- **본문에서 읽는다** — `service.version`이 필요하면 로그를 열어 본다

**[[03a-setting-up-the-logging-infrastructure]]의 Q5(라벨을 두 개만 고른 판단)가 여기서 확인된다** — **버전은 값의 가짓수가 늘어날 수 있고 질의로 범위를 좁히는 데 잘 안 쓰이므로** 라벨로 안 올렸다.

---

## Q6. 라벨 필터와 라인 필터의 비용 차이

| 질의 | **방식** | **비용** |
|---|---|---|
| 라벨 추가 (`level="ERROR"`) | **색인 조회 — 해당 스트림만 읽는다** | **싸다** |
| 본문 검색 (`\|= "employee"`) | **스트림을 좁힌 뒤 본문을 스캔** | **스캔 범위에 비례** |

**차이의 근원**: **[[03-structured-logging-with-loki-and-grafana]]의 "Loki는 라벨만 색인한다"**는 성질. **라벨은 색인이 있고 본문은 없다.**

**LogQL 문법이 이 두 단계를 그대로 반영한다** — **중괄호 안은 라벨 선택자, 그 뒤의 `|=`·`!=`·`|~` 등은 라인 필터.**

> **먼저 라벨로 최대한 좁히고, 그다음에 본문을 훑는다. 라벨 선택자 없이 본문만 검색하는 질의는 사실상 전체 스캔이 되어 느리다.**

**"`|=`도 색인을 쓴다"는 오해다**(§5) — **쓰지 않는다.**

**실무 요령**: **시간 범위와 라벨로 최대한 좁힌 뒤 라인 필터를 건다.** 순서를 반대로 생각하면(먼저 본문 검색) 느리다.

**책의 결론**: **"이것으로 검색 가능한 로깅 시스템을 갖게 됐다."** [[03-structured-logging-with-loki-and-grafana]] 처음의 **"세 대에 접속해 `grep`하던" 상황이 질의 한 줄로** 바뀌었다.

---

## Q7. 이 시점에 traceId가 없는 것이 정상인 이유

**[[03b-instrumenting-the-application-for-logging]]에서 `management.tracing.enabled: false`로 껐기 때문이다.**

> **"traceId가 안 보이는 건 설정이 틀린 것이다" — 이 시점에서는 정상이다.**

**[[03-structured-logging-with-loki-and-grafana]]의 세 문제 중 하나가 아직 미해결**이라는 뜻이다:
| 문제 | 이 시점 |
|---|---|
| 흩어져 있다 | **해결** — Loki에 모였다 |
| 문장이다 | **해결** — JSON 필드 |
| **같은 요청인지 모른다** | **미해결** — traceId 없음 |

**§6의 경계**: **이 검증은 로그 신호 하나만 본다.** **메트릭과 트레이스는 아직 꺼져 있어 이 화면에 나타나지 않는다.**

**채워지는 시점**: [[05b-enabling-trace-export-and-kafka-propagation]] 이후. **`logback-spring.xml`의 `captureMdcAttributes`가 미리 적혀 있으므로 설정을 다시 고칠 필요는 없다.**

---

## Q8. 도서관 비유가 깨지는 지점

**비유**: LogQL의 두 단계는 **"도서관에서 책 찾기"** — **먼저 서가 번호(라벨)로 구역을 좁히고, 그 구역의 책들을 넘겨 본다(라인 필터).**

**깨지는 지점**: **서가 번호를 누가 정했는가를 흐린다.**

> **여기서는 [[03a-setting-up-the-logging-infrastructure]]에서 우리가 직접 골랐고, 고르지 않은 속성으로는 구역을 좁힐 수 없다. 도서관과 달리 분류 체계 자체가 설정의 산물이다.**

```
도서관:  분류 체계가 이미 있다 → 어떤 책이든 어딘가에 분류돼 있다
Loki:    우리가 라벨을 고른다 → 안 고른 속성으로는 구역을 못 좁힌다 (Q5)
```

**실무적 귀결**: **나중에 필요해질 질의를 미리 예상해 라벨을 골라야** 한다. 그런데 [[01-three-pillars-of-observability]]가 말했듯 **"문제는 예측 가능하지 않다."** 그 긴장이 라벨 설계의 어려움이다.

**타협점**: **범위를 좁히는 데 쓰는 소수의 저카디널리티 속성만 라벨로**, **나머지는 본문에 남겨 라인 필터로** 찾는다. Q5·Q6가 그 구조다.

**비유가 맞는 부분은 남는다** — **두 단계로 좁힌다**는 핵심. 깨지는 것은 **분류 체계의 출처**다.

**§6의 나머지 경계**: **`docker compose up -d`만으로는 준비 완료가 보장되지 않는다** — **Loki가 뜨는 데 몇 초 걸리므로 그 사이 전송이 실패할 수 있다.** 그리고 **Explore는 조사용이지 상시 감시용이 아니다** — **반복해서 볼 질의는 대시보드로** 만든다([[04c-verifying-metrics-in-prometheus-and-grafana]]).

---

## 재출제 문항

1. 애플리케이션은 정상인데 Grafana가 비어 있다. 왜 오류가 안 났는가?
2. 질의 한 줄이 검증해 주는 설정 단계가 몇 개인가?
3. `{service.name="employee-service"}`로 질의했는데 결과가 없다. 왜인가?
4. 실제 라벨 이름을 추측하지 않고 확인하려면 어디를 보는가?
5. `service.version`으로 스트림을 좁히려 한다. 가능한가?
6. `{} |= "error"`처럼 라벨 없이 검색했다. 무슨 일이 생기는가?
7. 로그에 traceId가 없다. 지금 고쳐야 하는가?
8. 새 질의가 필요해졌는데 그 속성이 라벨이 아니다. 어떻게 하는가?

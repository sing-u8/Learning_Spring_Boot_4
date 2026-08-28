# 모범답안 — 03b 로깅을 위한 애플리케이션 계측

> **먼저 답하고 나서 열 것.** [[03b-instrumenting-the-application-for-logging]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. "계측한다"의 정의

**계측 = 애플리케이션이 텔레메트리를 생산하도록 코드나 설정을 더하는 일.**

> **코드가 하던 일은 그대로 두고, 그 일에 대해 말하게 만든다.**

**동작을 바꾸지 않는다는 근거**: 이 절이 하는 일은 **로거를 추가하고, 출력 대상을 바꾸고, 메타데이터를 붙이는 것**이다. **`createEmployee`가 하는 일 자체는 한 줄도 안 바뀐다.**

**출발 상태의 두 문제**:
| 문제 | 구체적으로 |
|---|---|
| **어디로도 안 나간다** | **콘솔에만 찍힌다. 프로세스가 죽으면 사라진다** |
| **형태가 문장이다** | `System.out.println("Skipping duplicate event...")` — **필드가 없다** |

**비유의 깨짐도 여기 있다** — **"기계에 센서를 붙이는 것"**이지만 **센서를 붙이는 데 드는 비용을 가볍게 보이게 한다.** **로그 한 줄마다 문자열 포맷·직렬화·네트워크 전송이 일어나고, 레벨과 샘플링으로 그 양을 조절하는 것이 이 장 내내 반복되는 주제다.**

---

## Q2. 다섯 번째 의존성만 손으로 넣는 이유

**① Initializr에 없다. ② alpha 릴리스로 배포된다.**

```xml
<artifactId>opentelemetry-logback-appender-1.0</artifactId>
<version>2.26.1-alpha</version>
```

**하는 일**: **로그 appender** — **SLF4J와 Logback으로 쓴 로그를 OpenTelemetry 로그 레코드로 바꿔 OTLP로 내보낸다.**

**나머지 넷**:
| 아티팩트 | 하는 일 |
|---|---|
| `spring-boot-starter-actuator` | **헬스 체크·메트릭·관측 자동 설정의 토대**이고 **트레이싱 지원이 통합되는 자리** |
| `spring-boot-starter-opentelemetry` | **Spring 팀이 밝힌 공식적인 방법.** Micrometer 기반 관측 모델과 OTLP 내보내기 |
| `*-actuator-test` / `*-opentelemetry-test` | 테스트에서 검증 |

**test 스타터가 둘이나 있다는 사실이 [[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/01-junit-6-and-focused-test-starters|Ch5]]의 집중형 test starter 전략과 이어진다.**

---

## Q3. alpha 의존성 지침이 "최신을 쓰라"와 반대인 이유

**API가 릴리스마다 바뀔 수 있기 때문이다.**

> **버전 `2.26.1-alpha`를 정확히 고정하고, 의존성 자동 갱신 도구가 손대지 못하게 설정하라.**

**alpha 릴리스**: **API가 아직 바뀔 수 있는 초기 배포판.**

**위험이 구체적이다**: **자동 업그레이드가 도는 프로젝트에서 이 한 줄이 조용히 올라가면 로그 파이프라인이 통째로 멈출 수 있다.**

**그리고 [[03c-verifying-logs-in-grafana]]의 성질과 겹치면 최악이다** — **파이프라인이 끊겨도 오류가 안 난다.** **버전이 올라가 appender가 동작하지 않아도 애플리케이션은 정상 기동**하고, **Grafana만 비어 간다.**

**§6의 경계**: **alpha appender에 운영을 걸기는 이르다.**

---

## Q4. 트레이싱과 메트릭을 일부러 꺼 두는 것

```yaml
management.tracing.enabled: false
management.otlp.metrics.export.enabled: false
```

> **세 신호를 한꺼번에 켜면 무엇이 어디서 나오는지 구분이 안 된다.**

**순서**: **로그만 켜서 파이프라인을 확인**([[03c-verifying-logs-in-grafana]]) → **메트릭**([[04a-setting-up-prometheus-for-metrics]]) → **트레이스**([[05b-enabling-trace-export-and-kafka-propagation]]).

**교육적 이유 외에 진단상의 이유도 있다** — **한 번에 하나씩 켜면 문제가 생겼을 때 방금 켠 것이 원인**이다. 셋을 한꺼번에 켜면 **일곱 정거장 × 세 신호**의 조합에서 원인을 찾아야 한다.

**"트레이싱을 껐으니 나중에 설정을 다시 고쳐야 한다"는 오해다**(§5) — **`logback-spring.xml`의 `captureMdcAttributes`는 미리 적어 두었다.** **트레이싱을 켜면 값이 자동으로 채워진다.** **미리 적어 두는 것이 나중에 고치지 않아도 되는 방법이다.**

---

## Q5. `service.name`이 `${spring.application.name}`을 참조하는 것

**이름이 어긋나 상관관계가 끊기는 사고를 막는다.**

> **이름을 두 군데 적으면 언젠가 어긋나고, 그러면 로그의 서비스 이름과 메트릭의 서비스 이름이 달라져 상관관계가 끊긴다.**

```
spring.application.name: employee-service
        ↓ 참조
service.name: ${spring.application.name}
        ↓
모든 신호에서 같은 이름
```

**[[02-designing-an-observability-architecture]]의 "하나의 관측에서 세 신호"와 같은 원칙이 설정 층에도 적용된 것**이다 — **한 번 선언하고 파생시킨다.**

**어긋나면 어떻게 드러나나**: **조용히.** 로그도 메트릭도 정상적으로 쌓이는데 **Grafana에서 두 신호를 같은 서비스로 묶지 못한다.** [[06-correlating-logs-metrics-and-traces]]가 안 된다.

**나머지 설정들**:
| 설정 | 왜 |
|---|---|
| `endpoints.web.exposure.include: health,info` | **필요한 것만 노출** |
| `opentelemetry.resource-attributes` (3개) | **Collector가 라벨로 승격할 재료** |
| `logging.structured.format.console: logstash` | **콘솔을 구조화 로깅으로** |

**logstash 포맷은 선택지 중 하나다** — **`ecs`(Elastic Common Schema)와 `gelf`(Graylog)도 있고, 수집·분석 플랫폼에 맞춰 고른다.**

---

## Q6. `ObservabilityConfig`가 필요한 이유

**Logback이 Spring보다 먼저 뜨기 때문이다.**

```
1. Logback 이 먼저 초기화된다 (XML 을 읽고 OTEL appender 생성)
2. 이 시점에는 Spring 컨텍스트가 없다 → OpenTelemetry 빈이 아직 없다
3. Spring 컨텍스트 기동 → OpenTelemetry 빈 생성
4. ApplicationRunner 실행 → OpenTelemetryAppender.install(openTelemetry)
5. 이제 appender 가 인스턴스를 갖는다
```

> **로깅은 Spring 자신의 기동 과정에서도 필요하기 때문이다. 그래서 XML만으로는 Spring이 만든 빈을 appender에 넣을 수 없고, 컨텍스트가 준비된 뒤 `ApplicationRunner`로 뒤늦게 꽂아 준다.**

**`logback-spring.xml`은 appender를 선언했지만, 그 appender가 실제로 쓸 OpenTelemetry 인스턴스는 아직 연결되지 않았다.**

**"`ObservabilityConfig`는 없어도 된다"는 오해다**(§5) — **없으면 OTEL appender가 인스턴스를 못 받아 조용히 아무것도 내보내지 않는다.**

**Q3·Q4와 같은 계열의 함정이다** — **조용한 실패**가 이 절 전체의 주제다. [[03c-verifying-logs-in-grafana]]가 존재하는 이유이기도 하다.

---

## Q7. `System.out.println`과 `log.info`의 차이

| | `System.out.println` | **`log.info`** |
|---|---|---|
| **파이프라인** | **아예 실리지 않는다** | Logback → OTEL → Collector → Loki |
| **레벨 필터** | 없다 | **적용된다** |
| **구조화** | 없다 | **필드로 나뉜다** |
| **traceId** | 없다 | **MDC에서 자동으로 실린다** |
| 출처 정보 | 없다 | **클래스 이름이 `instrumentation_scope`로** |

> **"`System.out.println`도 어차피 콘솔에 찍히니 같다" — Logback을 거치지 않으므로 파이프라인에 아예 실리지 않는다.**

**`{}` 플레이스홀더를 쓰는 이유** — 책은 **"효율적이고 더 깔끔한 구조화 레코드를 만든다"**고 요약하고, 구체적으로 둘이다:
1. **레벨이 꺼져 있으면 문자열 연결과 포맷팅이 생략된다**
2. **메시지 템플릿과 값이 분리된 채 기록된다** — **구조화 로깅에서 이 분리가 유지되면 "같은 종류의 로그"를 값과 무관하게 묶을 수 있다**

**레벨 선택 원칙**: **정상 사건은 `log.info()`, 경고 상황은 `log.warn()`, 오류는 `log.error()`.**

> **원문 불일치 두 가지**: (1) **모든 `System.out`을 SLF4J로 바꿨다고 하지만 [[04b-adding-custom-business-metrics-with-micrometer]]의 `NotificationService` 중복 이벤트 분기에는 `System.out.println`이 그대로 남아 있다.** (2) **설정은 패키지를 `com.learningspringboot4`로 적지만 [[03c-verifying-logs-in-grafana]]의 화면에는 `com.springbootlearning4`로 찍혀 있다** — **`logging.level` 필터가 실제 패키지와 맞지 않는다.**

---

## Q8. 센서 비유가 깨지는 지점

**비유**: 계측은 **"기계에 센서를 붙이는 것"** — **기계가 하던 일은 그대로고 상태를 말하게 될 뿐이다.**

**깨지는 지점**: **센서를 붙이는 데 드는 비용을 가볍게 보이게 한다.**

> **실제로는 로그 한 줄마다 문자열 포맷·직렬화·네트워크 전송이 일어나고, 레벨과 샘플링으로 그 양을 조절하는 것이 이 장 내내 반복되는 주제다.**

```
물리 센서:  전력만 쓰고 기계 동작에 영향 없음
계측:       CPU · 메모리 · 네트워크 · 저장소를 쓴다
            로그를 너무 많이 남기면 애플리케이션이 느려진다
```

**§6의 관련 경계**: **콘솔과 OTLP로 이중 출력하면 비용이 두 배다.** **로컬에서는 유용하지만 운영에서는 한쪽만 남기는 경우가 많다.**

**[[01-three-pillars-of-observability]]의 §6과 같은 이야기다** — **세 신호 모두 비용이 있다.**

**비유가 맞는 부분은 남는다** — **동작을 바꾸지 않고 상태를 노출한다**(Q1). 깨지는 것은 **부담의 크기**다.

**Logback의 두 출구도 함께**: `CONSOLE`(**로컬 개발에서 눈으로 본다. 파이프라인이 안 될 때도 여기는 보인다**)과 `OTEL`(Collector → Loki). **[[03a-setting-up-the-logging-infrastructure]]의 `exporters: [loki, debug]`와 같은 패턴**이다.

---

## 재출제 문항

1. 계측을 했더니 `createEmployee`의 반환값이 달라졌다. 정상인가?
2. 자동 의존성 갱신이 alpha appender 버전을 올렸다. 어떻게 알아채는가?
3. 세 신호를 한꺼번에 켜고 아무것도 안 보인다. 후보가 몇 개인가?
4. `service.name`을 따로 적었다가 오타를 냈다. 어떻게 드러나는가?
5. `ObservabilityConfig`를 지웠다. 어떤 오류가 나는가?
6. `System.out.println`으로 남긴 로그를 Grafana에서 찾을 수 있는가?
7. `log.debug("x " + expensive())`와 `log.debug("x {}", expensive())`의 차이는?
8. 로그를 열 배로 늘렸다. 센서 비유가 어디서 깨지는가?

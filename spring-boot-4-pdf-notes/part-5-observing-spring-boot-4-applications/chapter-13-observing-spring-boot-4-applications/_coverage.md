# Chapter 13 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 13 *Observability with Spring Boot 4*, 책 pp. 347–397 / PDF pp. 372–422. PDF를 `pdftotext -layout -f 372 -l 422`로 새로 추출해 2,082줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

상위 절 6개 아래에 **실제 하위 제목 9개**가 있다. 책에 인쇄된 하위 제목을 그대로 분할선으로 삼아 15개 노트로 나눴고, 하위 제목을 새로 만들어 쪼갠 곳은 없다.

**기존 초안 6개의 파일 이름은 하나도 바꾸지 않았다.** Ch11·Ch12·Ch14가 `06-correlating-logs-metrics-and-traces`를 직접 참조하고 있고, `02-designing-an-observability-architecture`도 Ch7이 가리킨다. 새로 만든 9개는 하위 제목에 대응하는 접미사 노트다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-three-pillars-of-observability]] | Understanding the three pillars of observability | 348–350 | 373–375 |
| [[02-designing-an-observability-architecture]] | Observability architecture with Spring Boot 4 | 350–352 | 375–377 |
| [[03-structured-logging-with-loki-and-grafana]] | Structuring logging with Logback, Loki, and Grafana | 352–353 | 377–378 |
| [[03a-setting-up-the-logging-infrastructure]] | └ Setting up the logging infrastructure with Docker Compose | 353–356 | 378–381 |
| [[03b-instrumenting-the-application-for-logging]] | └ Instrumenting the Spring Boot application for logging | 357–363 | 382–388 |
| [[03c-verifying-logs-in-grafana]] | └ Running the logging stack and verifying logs in Grafana | 364–365 | 389–390 |
| [[04-metrics-with-micrometer-prometheus-and-grafana]] | Collecting and visualizing metrics with Prometheus and Grafana | 365–366 | 390–391 |
| [[04a-setting-up-prometheus-for-metrics]] | └ Setting up Prometheus for metrics collection | 367–370 | 392–395 |
| [[04b-adding-custom-business-metrics-with-micrometer]] | └ Adding custom business metrics with Micrometer | 370–375 | 395–400 |
| [[04c-verifying-metrics-in-prometheus-and-grafana]] | └ Verifying metrics in Prometheus and Grafana | 375–378 | 400–403 |
| [[05-tracing-with-opentelemetry-and-tempo]] | Tracing propagation with Grafana Tempo | 378–380 | 403–405 |
| [[05a-setting-up-grafana-tempo]] | └ Setting up Grafana Tempo for distributed tracing | 380–383 | 405–408 |
| [[05b-enabling-trace-export-and-kafka-propagation]] | └ Enabling trace export and Kafka context propagation | 383–387 | 408–412 |
| [[05c-verifying-distributed-traces-in-tempo]] | └ Verifying distributed traces in Grafana Tempo | 387–389 | 412–414 |
| [[06-correlating-logs-metrics-and-traces]] | Correlating logs, metrics, and traces | 390–397 | 415–422 |

`03`·`04`·`05`의 파일 이름은 원문 제목과 어순이 다르지만(예: 원문 *Tracing propagation with Grafana Tempo* vs `05-tracing-with-opentelemetry-and-tempo`) 다루는 범위가 같고, 기존 이름을 바꾸면 대상 Chapter 밖 파일을 고쳐야 해서 유지했다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 347 | 372 | 장 도입: 배포 후에 생기는 다른 종류의 문제 — **증상이 원인에서 멀리 떨어져 나타난다**, 느린 쿼리·다운스트림 장애·컨슈머 실패·다른 컴포넌트의 설정 문제, 왜 Loki·Prometheus·Tempo·Grafana인가, 다룰 6개 주제 | [[_map]] | 반영 |
| 348 | 373 | Note: 이 장의 소스는 저장소 `ch13` 폴더 | [[03a-setting-up-the-logging-infrastructure]] | 반영 |
| 348 | 373 | 모니터링(CPU·메모리·가동시간 같은 고정 신호)의 한계, 문제는 예측 가능하지 않다 | [[01-three-pillars-of-observability]] | 반영 |
| 348 | 373 | 관측 가능성의 정의 — **외부 출력으로 내부 상태를 이해하는 능력**, 텔레메트리 수집·분석 | [[01-three-pillars-of-observability]] | 반영 |
| 348 | 373 | Figure 13.1 세 기둥 다이어그램 | [[01-three-pillars-of-observability]] | 반영 (Mermaid 재현) |
| 349 | 374 | 로그·메트릭·트레이스 각각의 정의와 쓰임, 셋이 상호 보완적인 이유 | [[01-three-pillars-of-observability]] | 반영 |
| 349 | 374 | Note: 지속적 프로파일링(continuous profiling)은 네 번째 축이 될 수 있다, Grafana Pyroscope, 전용 백엔드와 에이전트가 필요해 선택적 확장으로 다룬다 | [[01-three-pillars-of-observability]] | 반영 |
| 350 | 375 | 50밀리초 요청 하나로 본 세 신호의 역할 분담, "추측에서 이해로" | [[01-three-pillars-of-observability]] | 반영 |
| 350 | 375 | 아키텍처는 캡처·전송·시각화 컴포넌트로 구성, **Micrometer와 Observation API라는 단일 진실 원천** | [[02-designing-an-observability-architecture]] | 반영 |
| 350 | 375 | OpenTelemetry가 표준화, OTLP로 내보내고, Collector가 처리, Prometheus·Loki·Tempo·Grafana가 저장·시각화 | [[02-designing-an-observability-architecture]] | 반영 |
| 351 | 376 | Figure 13.2 end-to-end 흐름과 7단계 설명 | [[02-designing-an-observability-architecture]] | 반영 (Mermaid 재현) |
| 352 | 377 | 애플리케이션은 비즈니스 로직에 집중하고 계측 계층과 파이프라인이 나머지를 맡는다, **백엔드로부터 독립적이 된다** | [[02-designing-an-observability-architecture]] | 반영 |
| 352 | 377 | Note: Collector는 선택이지만 강력히 권장 — 배칭·필터링·강화·라우팅의 중앙 계층, 앱과 백엔드를 분리 | [[02-designing-an-observability-architecture]] | 반영 |
| 352 | 377 | Figure 13.3 중앙화된 로그 흐름과 7단계 설명(Logback의 JSON 포맷·MDC·traceId·spanId 포함) | [[03-structured-logging-with-loki-and-grafana]] | 반영 (Mermaid 재현) |
| 353–355 | 378–380 | `docker-compose.yml`에 loki·otel-collector·grafana 추가와 서비스별 3개 설명(포트 3100·4317/4318·3000, 볼륨 마운트, `depends_on`) | [[03a-setting-up-the-logging-infrastructure]] | 반영 |
| 355–356 | 380–381 | `otel-collector-config.yml` 전체와 receivers·processors·exporters·pipelines 4개 설명(`loki.resource.labels`로 라벨 승격, batch, debug exporter) | [[03a-setting-up-the-logging-infrastructure]] | 반영 |
| 356 | 381 | `grafana-datasources.yml`의 Loki 데이터소스, proxy 접근 모드, 기본 데이터소스 지정 | [[03a-setting-up-the-logging-infrastructure]] | 반영 |
| 357 | 382 | Note: "계측한다(instrumenting)"의 뜻 — 텔레메트리를 생산하도록 코드·설정을 더하는 것 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 357 | 382 | Chapter 12의 Employee 애플리케이션 재사용, 프로젝트 좌표 5개 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 357–358 | 382–383 | Initializr 의존성 2개(Actuator, OpenTelemetry) → pom.xml 4개 의존성과 각각의 역할 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 358–359 | 383–384 | `opentelemetry-logback-appender-1.0` 2.26.1-alpha를 수동 추가, **alpha라서 버전을 고정하고 자동 업그레이드를 막으라**는 지시 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 359–360 | 384–385 | `application.yml` 전체와 항목별 9개 설명(`tracing.enabled: false`로 로그에 집중, resource-attributes, OTLP 로그 엔드포인트, `logging.structured.format.console: logstash`와 ecs·gelf 대안) | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 361–362 | 386–387 | `logback-spring.xml` 전체와 CONSOLE·OTEL 두 출력, 항목별 4개 설명(`captureMdcAttributes`로 traceId·spanId 포착) | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 362 | 387 | 아직 트레이싱을 켜지 않아 traceId·spanId가 안 보일 수 있다, 켜면 자동 상관관계 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 362 | 387 | `ObservabilityConfig`의 `ApplicationRunner`와 `OpenTelemetryAppender.install(openTelemetry)`, 항목별 2개 설명 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 362–363 | 387–388 | `EmployeeController`에서 `System.out`을 SLF4J로 교체, `LoggerFactory.getLogger`와 파라미터 플레이스홀더의 이점 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 363 | 388 | Note: `EmployeeService`·`NotificationService`·`NotificationDeadLetterListener`도 같은 방식으로 교체, `log.info`/`warn`/`error` 구분 | [[03b-instrumenting-the-application-for-logging]] | 반영 |
| 364 | 389 | `docker compose up -d` → `./mvnw spring-boot:run` → `curl -X POST /employees` | [[03c-verifying-logs-in-grafana]] | 반영 |
| 364 | 389 | Grafana 확인 4단계, `{service_name="employee-service"}` 질의, 레벨 필터와 `\|=` 문자열 검색 | [[03c-verifying-logs-in-grafana]] | 반영 |
| 365 | 390 | Figure 13.4 Grafana에 표시된 구조화 로그 | [[03c-verifying-logs-in-grafana]] | 반영 (이미지 추출) |
| 365 | 390 | "로그는 무슨 일이 있었는지, 메트릭은 얼마나 자주·얼마나 오래·정상인지를 말한다" | [[04-metrics-with-micrometer-prometheus-and-grafana]] | 반영 |
| 366 | 391 | Figure 13.5 메트릭 흐름과 7단계 설명 | [[04-metrics-with-micrometer-prometheus-and-grafana]] | 반영 (Mermaid 재현) |
| 367 | 392 | Loki는 로그용이고 메트릭에는 **시계열 데이터베이스**가 필요하다, Prometheus가 Collector를 스크레이프한다 | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 367 | 392 | `docker-compose.yml`에 prometheus 추가(포트 9090, 볼륨, `depends_on: otel-collector`) | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 367–368 | 392–393 | `prometheus.yml`과 항목별 6개 설명(`scrape_interval: 5s`, `targets: ["otel-collector:9464"]`) | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 368–369 | 393–394 | `otel-collector-config.yml`에 prometheus exporter와 metrics 파이프라인 추가, 항목별 6개 설명 | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 369 | 394 | `grafana-datasources.yml`에 Prometheus 데이터소스 추가, 항목별 8개 설명 | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 370 | 395 | `application.yml`에서 OTLP 메트릭 export 활성화, 항목별 4개 설명(`step: 5s`) | [[04a-setting-up-prometheus-for-metrics]] | 반영 |
| 370–371 | 395–396 | 인프라 메트릭 vs **비즈니스 메트릭**, 이 앱에서 추적할 세 가지 질문 | [[04b-adding-custom-business-metrics-with-micrometer]] | 반영 |
| 371–372 | 396–397 | `EmployeeService`의 `Timer.builder("employee.create.time")` + `counter("employee.created.count")`, 항목별 9개 설명(`.tag("role", role)`, `roleForMetrics`의 UNKNOWN 기본값) | [[04b-adding-custom-business-metrics-with-micrometer]] | 반영 |
| 373 | 398 | 워크플로가 저장으로 끝나지 않는다 — Kafka 이벤트 발행 후 알림 흐름이 **비동기로 이어진다**, 그래서 별도 메트릭이 필요하다 | [[04b-adding-custom-business-metrics-with-micrometer]] | 반영 |
| 373–374 | 398–399 | `NotificationService` 전체와 `employee.notification.count`의 `outcome` 태그 4종(received·duplicate·failed·sent), 항목별 9개 설명 | [[04b-adding-custom-business-metrics-with-micrometer]] | 반영 |
| 375 | 400 | `docker compose down && up -d` → 앱 실행 → curl 여러 번 | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 |
| 376 | 401 | Figure 13.6 Prometheus의 `employee_created_count_total`, **메트릭 태그가 질의 가능한 차원이 된다**는 설명 | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 (이미지 추출) |
| 376 | 401 | 유용한 PromQL 질의 5개(`sum by (role)`, rate 기반 평균 지연) | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 |
| 377 | 402 | 대시보드 import 6단계, Figure 13.7 커스텀 비즈니스 메트릭 대시보드 | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 (이미지 추출) |
| 378 | 403 | 대시보드가 묶어 보여 주는 6개 패널, 동기·비동기 동작의 통합 뷰 | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 |
| 378 | 403 | Note: 대시보드 JSON 구조 설명은 이 책의 범위 밖 | [[04c-verifying-metrics-in-prometheus-and-grafana]] | 반영 |
| 378 | 403 | 트레이스가 답하는 다른 질문 — **요청 하나가 시스템을 어떻게 지나가는가** | [[05-tracing-with-opentelemetry-and-tempo]] | 반영 |
| 379–380 | 404–405 | Figure 13.8 분산 트레이스 흐름과 7단계 설명, trace ID와 span의 관계, **Kafka 토픽이 전파 경계** | [[05-tracing-with-opentelemetry-and-tempo]] | 반영 (Mermaid 재현) |
| 380 | 405 | `docker-compose.yml`에 tempo 추가(포트 3200, 볼륨) | [[05a-setting-up-grafana-tempo]] | 반영 |
| 380–382 | 405–407 | `tempo.yml` 전체와 항목별 9개 설명(distributor·ingester·compactor·storage·overrides, 24h 보존, WAL) | [[05a-setting-up-grafana-tempo]] | 반영 |
| 382–383 | 407–408 | `otel-collector-config.yml`에 `otlp/tempo` exporter와 traces 파이프라인, 항목별 5개 설명(`tls.insecure: true`) | [[05a-setting-up-grafana-tempo]] | 반영 |
| 383 | 408 | `grafana-datasources.yml`에 Tempo 데이터소스, 항목별 5개 설명 | [[05a-setting-up-grafana-tempo]] | 반영 |
| 383–384 | 408–409 | `application.yml`의 Kafka observation 2개 + tracing export + sampling probability + OTLP 트레이스 엔드포인트, 항목별 5개 설명(운영에서는 낮은 샘플링) | [[05b-enabling-trace-export-and-kafka-propagation]] | 반영 |
| 385 | 410 | 기술적 span만으로는 부족하다 — **비즈니스 span**으로 강화한다 | [[05b-enabling-trace-export-and-kafka-propagation]] | 반영 |
| 385–387 | 410–412 | `EmployeeService`의 `Observation.createNotStarted("employee.create", ...)`, 항목별 5개 설명(`contextualName`, `lowCardinalityKeyValue`, `observe`가 Timer를 감싼다는 변화) | [[05b-enabling-trace-export-and-kafka-propagation]] | 반영 |
| 386 | 411 | Note: 저·고 카디널리티 속성의 정의와 판단 기준, "기본은 낮은 카디널리티" | [[05b-enabling-trace-export-and-kafka-propagation]] | 반영 |
| 387 | 412 | `NotificationService`의 Kafka 컨슈머와 DLT 리스너에도 같은 방식 적용 | [[05b-enabling-trace-export-and-kafka-propagation]] | 반영 |
| 387–388 | 412–413 | 재실행 → curl → Grafana Explore에서 Tempo Search 4단계, Figure 13.9 트레이스 목록(trace ID·시작 시각·operation·4.69초) | [[05c-verifying-distributed-traces-in-tempo]] | 반영 (Figure 13.9 미추출) |
| 389 | 414 | Figure 13.10 특정 Trace ID의 waterfall, span 4개 계층, **process employee notification이 지연의 주범** | [[05c-verifying-distributed-traces-in-tempo]] | 반영 (이미지 추출) |
| 389 | 414 | Kafka를 가로질러 트레이스 컨텍스트가 보존됨을 확인, 동기·비동기를 한 연산으로 분석 | [[05c-verifying-distributed-traces-in-tempo]] | 반영 |
| 390 | 415 | 세 신호는 이미 **관련돼(related) 있지만 상관돼(correlated) 있지 않다**, 수동으로 trace ID를 복사하고 뷰를 옮겨 다녀야 한다 | [[06-correlating-logs-metrics-and-traces]] | 반영 |
| 390 | 415 | 애플리케이션 로직 변경은 **필요 없다** — Grafana 설정만으로 해결한다 | [[06-correlating-logs-metrics-and-traces]] | 반영 |
| 390–392 | 415–417 | `grafana-datasources.yml` 전체(Loki `derivedFields`, Prometheus `exemplarTraceIdDestinations`, Tempo `tracesToLogsV2`·`tracesToMetrics`) | [[06-correlating-logs-metrics-and-traces]] | 반영 |
| 392 | 417 | 세 가지 이동 경로 설명 — Log→Trace, Trace→Log, Trace→Metric | [[06-correlating-logs-metrics-and-traces]] | 반영 |
| 392–393 | 417–418 | 재실행과 로그→트레이스 이동 6단계, Figure 13.11의 View Trace 링크 | [[06-correlating-logs-metrics-and-traces]] | 반영 (이미지 추출) |
| 394 | 419 | Figure 13.12 이동한 트레이스 뷰, Figure 13.13 span의 링크 아이콘 메뉴 | [[06-correlating-logs-metrics-and-traces]] | 반영 (13.13만 추출) |
| 395 | 420 | 메뉴에서 갈 수 있는 4곳(메트릭 3 + Related logs), Figure 13.14 자동 생성된 Prometheus 질의 | [[06-correlating-logs-metrics-and-traces]] | 반영 (Figure 13.14 미추출) |
| 396 | 421 | Figure 13.15 traceId로 필터된 Loki 로그, 질의를 손으로 만들 필요가 없다 | [[06-correlating-logs-metrics-and-traces]] | 반영 (Figure 13.15 미추출) |
| 396 | 421 | 로그에서 시작해 트레이스를 열고 메트릭을 본다는 최종 워크플로 | [[06-correlating-logs-metrics-and-traces]] | 반영 |
| 397 | 422 | Summary: 세 신호 → 구조화 로그 → 메트릭 → 분산 트레이싱 → 상관관계, 다음 장 예고 | [[_map]] | 반영 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 |
|---:|---|---:|---|
| 1 | `docker-compose.yml` — loki · otel-collector · grafana | 353–354 | [[03a-setting-up-the-logging-infrastructure]] |
| 2 | `otel-collector-config.yml` — logs 파이프라인 | 355 | [[03a-setting-up-the-logging-infrastructure]] |
| 3 | `grafana-datasources.yml` — Loki | 356 | [[03a-setting-up-the-logging-infrastructure]] |
| 4 | pom.xml — actuator · opentelemetry · 두 test 스타터 | 357–358 | [[03b-instrumenting-the-application-for-logging]] |
| 5 | pom.xml — `opentelemetry-logback-appender-1.0` 2.26.1-alpha | 358–359 | [[03b-instrumenting-the-application-for-logging]] |
| 6 | `application.yml` — 로깅용 전체 설정 | 359–360 | [[03b-instrumenting-the-application-for-logging]] |
| 7 | `logback-spring.xml` — CONSOLE + OTEL appender | 361 | [[03b-instrumenting-the-application-for-logging]] |
| 8 | `ObservabilityConfig` — `OpenTelemetryAppender.install` | 362 | [[03b-instrumenting-the-application-for-logging]] |
| 9 | `EmployeeController` — SLF4J 로깅 | 362–363 | [[03b-instrumenting-the-application-for-logging]] |
| 10 | `docker compose up -d` · `./mvnw spring-boot:run` · `curl POST /employees` | 364 | [[03c-verifying-logs-in-grafana]] |
| 11 | LogQL 질의 3종 | 364 | [[03c-verifying-logs-in-grafana]] |
| 12 | `docker-compose.yml` — prometheus | 367 | [[04a-setting-up-prometheus-for-metrics]] |
| 13 | `prometheus.yml` — scrape 설정 | 367–368 | [[04a-setting-up-prometheus-for-metrics]] |
| 14 | `otel-collector-config.yml` — metrics 파이프라인 | 368 | [[04a-setting-up-prometheus-for-metrics]] |
| 15 | `grafana-datasources.yml` — Prometheus | 369 | [[04a-setting-up-prometheus-for-metrics]] |
| 16 | `application.yml` — OTLP 메트릭 export | 370 | [[04a-setting-up-prometheus-for-metrics]] |
| 17 | `EmployeeService` — Timer + Counter | 371–372 | [[04b-adding-custom-business-metrics-with-micrometer]] |
| 18 | `NotificationService` — outcome 태그 카운터 | 373–374 | [[04b-adding-custom-business-metrics-with-micrometer]] |
| 19 | 검증 명령 3종 | 375 | [[04c-verifying-metrics-in-prometheus-and-grafana]] |
| 20 | PromQL 질의 5종 | 376 | [[04c-verifying-metrics-in-prometheus-and-grafana]] |
| 21 | `docker-compose.yml` — tempo | 380 | [[05a-setting-up-grafana-tempo]] |
| 22 | `tempo.yml` 전체 | 380–381 | [[05a-setting-up-grafana-tempo]] |
| 23 | `otel-collector-config.yml` — traces 파이프라인 | 382 | [[05a-setting-up-grafana-tempo]] |
| 24 | `grafana-datasources.yml` — Tempo | 383 | [[05a-setting-up-grafana-tempo]] |
| 25 | `application.yml` — Kafka observation + tracing export + sampling | 383–384 | [[05b-enabling-trace-export-and-kafka-propagation]] |
| 26 | `EmployeeService` — `Observation.createNotStarted` | 385 | [[05b-enabling-trace-export-and-kafka-propagation]] |
| 27 | 검증 명령 3종 | 387 | [[05c-verifying-distributed-traces-in-tempo]] |
| 28 | `grafana-datasources.yml` — 상관관계 전체 설정 | 390–392 | [[06-correlating-logs-metrics-and-traces]] |
| 29 | 검증 명령 3종 | 392–393 | [[06-correlating-logs-metrics-and-traces]] |

## 3. Tip / Note 블록 → 노트 매핑

| # | 종류 | 요지 | 책 쪽 | 노트 |
|---:|---|---|---:|---|
| 1 | Note | 이 장의 소스는 `ch13` 폴더 | 348 | [[03a-setting-up-the-logging-infrastructure]] |
| 2 | Note | 네 번째 축이 될 수 있는 지속적 프로파일링(Pyroscope), 선택적 확장으로 다룬다 | 349 | [[01-three-pillars-of-observability]] |
| 3 | Note | OpenTelemetry Collector는 선택이지만 강력히 권장 | 352 | [[02-designing-an-observability-architecture]] |
| 4 | Note | "계측한다"의 정의 | 357 | [[03b-instrumenting-the-application-for-logging]] |
| 5 | Note | 다른 서비스 클래스들도 `System.out` → SLF4J로 교체 | 363 | [[03b-instrumenting-the-application-for-logging]] |
| 6 | Note | 대시보드 JSON 구조는 이 책의 범위 밖 | 378 | [[04c-verifying-metrics-in-prometheus-and-grafana]] |
| 7 | Note | 저·고 카디널리티 속성의 정의와 사용 기준 | 386 | [[05b-enabling-trace-export-and-kafka-propagation]] |

## 4. Figure 처리 판단

`pdfimages -f 372 -l 422 -list` 결과 raster 15개(Figure 13.1–13.15) + QR 2개를 확인하고, UI 후보를 전부 PNG로 뽑아 육안 대조한 뒤 **6개만** `_assets/`에 남겼다.

| Figure | 책 쪽 / PDF 쪽 | 판단 | 근거 |
|---|---:|---|---|
| 13.1 세 기둥 | 348 / 373 | 미추출 · Mermaid 재현 | 개념 관계도다 |
| 13.2 end-to-end 흐름 | 351 / 376 | 미추출 · Mermaid 재현 | 개념 관계도다 |
| 13.3 로그 흐름 | 352 / 377 | 미추출 · Mermaid 재현 | 개념 관계도다 |
| 13.4 Grafana Loki 로그 | 365 / 390 | **추출** | 구조화 로그의 실제 모양과 함께 **`Common labels: deployment_environment=local exporter=OTLP job=employee-service service_name=employee-service`**가 찍혀 있어, Collector의 `resource` 프로세서가 `loki.resource.labels`로 승격한 속성이 Loki 라벨이 됐음을 증명한다 |
| 13.5 메트릭 흐름 | 366 / 391 | 미추출 · Mermaid 재현 | 개념 관계도다 |
| 13.6 Prometheus 질의 | 376 / 401 | **추출** | `employee_created_count_total{exported_job="employee-service", instance="otel-collector:9464", job="otel-collector", role="ENGINEER"} 15` — **`.tag("role", role)`가 질의 가능한 라벨이 됐다**는 주장의 직접 증거이고, `exported_job` 라벨이 6절 `tracesToMetrics` 설정의 `value: exported_job`과 이어진다 |
| 13.7 Grafana 대시보드 | 377 / 402 | **추출** | 커스텀 Timer·Counter가 6개 패널로 어떻게 보이는지 보여 준다. `Notification Outcomes`의 duplicate 8 · failed 8 · received 23 · sent 7이 `outcome` 태그 4종과 1:1로 대응한다 |
| 13.8 분산 트레이스 흐름 | 379 / 404 | 미추출 · Mermaid 재현 | 개념 관계도다 |
| 13.9 Tempo 검색 결과 | 388 / 413 | 미추출 | 트레이스 목록 그리드이고, 그 안의 정보(trace ID·시각·operation·4.69초)를 Figure 13.10이 전부 포함한 채 더 보여 준다 |
| 13.10 Tempo waterfall | 389 / 414 | **추출** | 이 절의 결론 그 자체다. `http post /employees (4.69s)` 아래 `create employee (1.17s)` → `employee-events send (1.02s)` → `employee-events process (0.32s)` → `process employee notification (2.18s)`가 계층으로 놓이고, 마지막 span이 전체의 절반 가까이를 차지하는 것이 막대 길이로 보인다 |
| 13.11 View Trace 링크 | 393 / 418 | **추출** | 상관관계의 진입점. 로그 항목을 펼치면 **Fields**(service_name·job·level 등)와 **Links: TraceID … [View Trace]**가 나타난다. 로그 본문에 최상위 `"traceid"`(소문자)와 `attributes` 안의 `"traceId"`(camelCase)가 **둘 다** 있어, `derivedFields`의 정규식 `'"traceId":"([A-Fa-f0-9]+)"'`이 어느 쪽을 잡는지 눈으로 확인된다 |
| 13.12 이동한 트레이스 뷰 | 394 / 419 | 미추출 | Figure 13.10과 같은 종류의 waterfall이다 |
| 13.13 span 링크 메뉴 | 394 / 419 | **추출** | `tracesToMetrics`에 적은 세 질의(Employee creation latency · Employee creations · Notification outcomes)와 `tracesToLogsV2`의 Related logs가 **설정한 이름 그대로** 메뉴에 뜬다. 설정과 화면이 1:1로 맞는 것을 보여 주는 유일한 자료 |
| 13.14 Prometheus로 이동 | 395 / 420 | 미추출 | Figure 13.13이 보여 주는 이동의 **도착지**이고, 본문 서술로 충분하다 |
| 13.15 Loki로 이동 | 396 / 421 | 미추출 | 같은 이유. 또 Figure 13.11이 같은 Loki Explore 화면을 이미 보여 준다 |

## 5. 원문의 오류·불일치 (노트에 명시)

| # | 위치 | 내용 |
|---:|---|---|
| 1 | 책 p.357 vs Figure 13.4·13.11 | 프로젝트 패키지를 `com.learningspringboot4`로 지정하고 `logging.level.com.learningspringboot4: info`까지 적지만, 두 화면의 로그에는 `instrumentation_scope: {"name":"com.springbootlearning4.NotificationService"}`처럼 **`com.springbootlearning4`**로 찍혀 있다. 설정한 로그 레벨 필터가 실제 패키지와 맞지 않는다 |
| 2 | 책 p.374 | `NotificationService`의 중복 이벤트 분기에 **`System.out.println`이 그대로 남아 있다.** 바로 앞 Note(p.363)가 모든 `System.out`을 SLF4J로 바꿨다고 말하는 것과 어긋난다 |
| 3 | 책 p.374 vs p.375 | 항목 설명은 `recordNotificationMetric("received")`와 `("duplicate")`를 호출한다고 하지만, 인쇄된 코드에는 그 두 호출이 없다. `failed`와 `sent`만 있다 |
| 4 | 책 p.354 | `docker-compose.yml`의 grafana 볼륨 경로가 `/etc/grafana/provisioning//datasources/datasources.yml`로 **슬래시가 중복**돼 있고, 마지막 `depends_on:` 아래 항목이 잘려 있다 |
| 5 | 책 p.368 | Prometheus exporter를 `otel-collector:9464`에서 스크레이프하도록 설정하지만, 이 포트를 `docker-compose.yml`의 otel-collector 서비스에 노출하는 변경은 제시되지 않는다(같은 Docker 네트워크 안이라 동작하지만, 4317·4318과 달리 호스트에서는 볼 수 없다) |
| 6 | 책 pp. 388–389 | 예시 Trace ID가 `d5e9dbd74a3498b7c…`(13.9)와 `d5e9dbd74a3498b7w1c2s3`(13.10)로 다르게 인쇄되고, 후자에는 16진수가 아닌 `w`·`s`가 섞여 있다. 실제 화면의 값은 `d5e9dbd74a3498b7w1c2s3a`다 |
| 7 | 책 p.389 | Figure 13.10의 Span Filters 영역이 "4 spans"라고 표시하지만 Service & Operation 패널에는 루트를 포함해 5개 행이 있다 |
| 8 | 책 p.377 vs Figure 13.7 | 대시보드의 `Notification Failure Rate`가 **0%**로 표시되는데 같은 화면의 `Notification Outcomes`에는 `failed 8`이 있다. 순간 rate와 누적 count의 차이에서 오는 것이며 본문은 이 차이를 설명하지 않는다 |
| 9 | 책 p.352 | Figure 13.2 설명 7번이 "The observability backends **receives**"로 주어-동사 수가 맞지 않는다. 6번 설명의 "forward them"(p.366)도 같은 종류의 오기다 |

## 공식 문서 대조 검증 (2026-08-29)

> 최초 검증(§5)은 **책이 틀렸나**를 봤다(9건, 대부분 본문↔화면 불일치). 이 절은 **노트가 책을 넘어 주장한 것**과 **가르친 코드가 내세운 동기를 실제로 달성하는지**를 대조한 기록이다.

| 대조한 문서 | URL |
|---|---|
| Micrometer Reference — Timers | `https://docs.micrometer.io/micrometer/reference/concepts/timers.html` |

### 찾아 보강한 것 1건

| # | 위치 | 문제 | 보강 |
|---|---|---|---|
| 1 | `04b` §6 | **장의 동기와 가르친 코드가 어긋난다.** `01`·`04`가 *"메트릭이 **p99가 어제보다 3배**라고 알린다"*를 출발 장면으로 쓰는데, `04b`가 만드는 것은 기본 `Timer`이고 `04c`가 가르치는 질의는 `rate(_sum)/rate(_count)` — **평균 지연**이다 | Micrometer 문서 인용(*"모든 `Timer` 구현은 최소한 총 시간과 이벤트 수를 보고한다"*)과 함께, 백분위수를 실제로 얻는 두 방식과 **인스턴스 여럿일 때의 결정적 차이**를 추가 |

**왜 중요한가.** 평균은 p99가 드러내려는 것을 정확히 가린다 — 100건 중 99건이 10ms, 1건이 3초여도 평균은 40ms다. 관측을 붙인 이유가 "느린 소수를 찾는 것"인데 평균만 보면 그 소수가 녹아 사라진다.

**추가한 핵심 구분.**

| 방식 | 인스턴스 여럿일 때 |
|---|---|
| `.publishPercentiles(0.99)` | **합산 불가** — 인스턴스별 p99를 평균 내는 것은 의미 없는 수다 |
| `.publishPercentileHistogram()` | **합산 가능** — Prometheus `histogram_quantile()`로 전체 p99를 구한다 |

스케일 아웃은 흔한 조치이므로 처음부터 후자를 쓰는 편이 안전하다는 판단과, 그 대가(버킷마다 시계열 → 카디널리티 증가)도 함께 적었다.

### 정정 0건으로 확인한 것

| 확인한 것 | 결과 |
|---|---|
| `step`과 `scrape_interval`을 맞추는 이유 | `04a` §2가 어긋날 때의 두 경우(중간값 소실 / 중복 저장)를 정확히 구분한다 |
| 샘플링의 함정 | `05b` §2.2가 *"10%만 기록하면 문제가 된 그 요청이 기록되지 않았을 확률이 90%"*까지 짚고 규칙 기반 샘플링을 언급한다 |
| 고 카디널리티 경고 | `04`·`04b`·`05b` 세 노트에 걸쳐 일관되게 경고하고, 직원 ID를 태그로 넣는 구체적 반례까지 든다 |
| "익스포터는 보내지 않고 포트를 연다" | `04a` §5의 지적이 정확하다. 이름과 동작이 어긋나는 사례 |
| 트레이스가 메트릭을 대체하지 못하는 이유 | `05` §5가 "샘플링되므로 전체 통계를 대신하지 못한다"로 옳게 적는다 |

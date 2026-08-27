# Observability with Spring Boot 4 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## observability
시스템의 외부 출력 데이터를 바탕으로 시스템 내부의 상태를 완벽하게 이해하고 진단할 수 있는 능력
- 처음 나온 곳: [[01-understanding-the-three-pillars-of-observability]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## continuous-profiling
운영 환경에서 코드 레벨의 CPU, 메모리 성능 데이터를 지속적으로 수집하여 소스 코드의 병목을 찾아내는 기법
- 처음 나온 곳: [[01-understanding-the-three-pillars-of-observability]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## opentelemetry
벤더(Vendor) 종속성을 없애기 위해 텔레메트리 데이터(로그, 메트릭, 트레이스)의 수집과 전송 표준을 통일한 CNCF의 오픈소스 프로젝트
- 처음 나온 곳: [[02-observability-architecture-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## opentelemetry-collector
애플리케이션으로부터 텔레메트리 데이터를 받아 필터링, 배치 처리, 속성 강화를 수행한 후 적절한 백엔드로 라우팅하는 독립적인 파이프라인 컴포넌트
- 처음 나온 곳: [[02-observability-architecture-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## otlp
오픈텔레메트리 프로젝트에서 규정한, 텔레메트리 데이터를 gRPC나 HTTP를 통해 효율적으로 전송하는 범용 프로토콜
- 처음 나온 곳: [[02-observability-architecture-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## structured-logging
사람이 읽는 텍스트 문장이 아닌, 기계(시스템)가 빠르게 검색하고 분석할 수 있도록 JSON 같은 key-value 구조로 로그를 남기는 방식
- 처음 나온 곳: [[03-structuring-logging-with-logback-loki-and-grafana]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mdc
Mapped Diagnostic Context. 현재 실행 중인 스레드에 찰싹 달라붙어 요청자의 ID나 Trace ID 등을 로깅 프레임워크에 넘겨주는 스레드 로컬(ThreadLocal) 저장소
- 처음 나온 곳: [[03-structuring-logging-with-logback-loki-and-grafana]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## slf4j
Simple Logging Facade for Java. 직접 로그를 찍는 구현체가 아니라, Logback이나 Log4j 같은 구현체를 언제든 갈아끼울 수 있게 해주는 자바의 표준 로깅 인터페이스
- 처음 나온 곳: [[03-structuring-logging-with-logback-loki-and-grafana]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## micrometer
스프링 생태계의 메트릭 수집 파사드(Facade)로, 프로메테우스, 데이터독 등 다양한 모니터링 시스템의 규격을 추상화한 라이브러리
- 처음 나온 곳: [[04-collecting-and-visualizing-metrics]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## prometheus
시계열 데이터(Time-Series Data)를 다차원 라벨 기반으로 저장하고 강력한 쿼리 언어(PromQL)를 제공하는 오픈소스 메트릭 서버
- 처음 나온 곳: [[04-collecting-and-visualizing-metrics]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## meter-registry
타이머(Timer), 카운터(Counter), 게이지(Gauge) 등 마이크로미터의 다양한 계측 도구들을 생성하고 관리하는 중앙 저장소 인터페이스
- 처음 나온 곳: [[04-collecting-and-visualizing-metrics]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## observation-api
메트릭 수집 코드와 트레이싱 추적 코드를 분리하지 않고 한 번의 래핑(Wrapping)으로 둘 다 달성하게 해주는 스프링 부트의 통합 계측 API
- 처음 나온 곳: [[05-tracing-propagation-with-grafana-tempo]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## trace-and-span
트레이스는 전체 사용자 요청의 시작부터 끝까지를 아우르는 나무(Tree)이고, 스팬은 그 나무를 구성하는 각각의 가지(단위 작업)를 의미한다
- 처음 나온 곳: [[05-tracing-propagation-with-grafana-tempo]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## high-low-cardinality
카디널리티(Cardinality)는 데이터 값의 다양성을 의미하며, 이메일 주소처럼 값이 다양한 데이터(High)는 시계열 DB를 마비시키므로 태그로 사용해서는 안 된다
- 처음 나온 곳: [[05-tracing-propagation-with-grafana-tempo]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## correlation
독립적으로 수집된 로그, 메트릭, 트레이스 데이터를 traceId나 시스템 태그 같은 공통 속성을 이용해 서로 연결하여 통합된 맥락(Context)을 제공하는 기술
- 처음 나온 곳: [[06-correlating-logs-metrics-and-traces]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## derived-fields
그라파나에서 텍스트 로그 내부에 숨어있는 특정 값(Trace ID 등)을 정규식으로 추출하여, 다른 데이터소스로 이동할 수 있는 클릭 가능한 하이퍼링크 필드를 동적으로 생성하는 기능
- 처음 나온 곳: [[06-correlating-logs-metrics-and-traces]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

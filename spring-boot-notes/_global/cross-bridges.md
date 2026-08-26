# 크로스 브리지 (Cross Bridges)

> 서로 다른 카테고리 간의 핵심 연결 고리.

## 01-core ↔ 02-web
- [[01-core/01-spring-boot-architecture-and-context]] ↔ [[02-web/01-spring-mvc-architecture-and-controllers]]
  - DispatcherServlet이 Spring IoC ApplicationContext 내부의 Controller 및 ViewResolver 빈들을 검색하여 라우팅 체계를 구축함.
- [[01-core/02-autoconfiguration-and-conditionals]] ↔ [[02-web/03-json-rest-api-jackson3]]
  - `JacksonAutoConfiguration`이 `@ConditionalOnClass(ObjectMapper.class)` 조건에 의해 동작하여 최신 Jackson 3 직렬화 엔진을 자동 구성함.

## 02-web ↔ 03-data
- [[02-web/03-json-rest-api-jackson3]] ↔ [[03-data/01-spring-data-jpa-repositories]]
  - 컨트롤러 계층에서는 불변 Record DTO를 JSON으로 직렬화/역직렬화하고, 서비스 계층에서 JPA Entity로 변환하여 영속화함으로써 계층 간 완벽한 책임 분리를 달성함.
- [[02-web/01-spring-mvc-architecture-and-controllers]] ↔ [[03-data/03-derived-queries-and-pagination]]
  - MVC 컨트롤러에서 주입받은 `Pageable` 파라미터가 JpaRepository 파생 쿼리로 전달되어 정렬 및 페이징이 일괄 적용된 `Page<T>`로 변환됨.

## 02-web ↔ 04-security
- [[02-web/01-spring-mvc-architecture-and-controllers]] ↔ [[04-security/01-spring-security-architecture-filterchain]]
  - `SecurityFilterChain`이 서블릿 컨테이너의 최전방에서 모든 요청을 검문한 뒤 인가된 요청만 `DispatcherServlet`으로 넘김.
- [[02-web/02-server-side-templates-thymeleaf]] ↔ [[04-security/04-csrf-protection-and-session]]
  - Thymeleaf 폼 렌더링 엔진이 스프링 시큐리티의 `_csrf` 히든 토큰을 HTML 폼에 자동 삽입하여 CSRF 공격을 방어함.

## 03-data ↔ 05-async-reactive
- [[03-data/01-spring-data-jpa-repositories]] ↔ [[05-async-reactive/01-virtual-threads-loom-concurrency]]
  - 블로킹 JPA 데이터베이스 접근 시 Java 25 가상 스레드가 캐리어 스레드를 자동 양보(Unmount)하여 동기식 코드 그대로 고성능 처리량을 달성함.
- [[03-data/05-r2dbc-reactive-data-access]] ↔ [[05-async-reactive/03-spring-webflux-controllers-streaming]]
  - R2DBC 리포지토리가 반환하는 `Flux<T>` 스트림이 WebFlux 컨트롤러를 통해 Server-Sent Events(SSE)로 클라이언트에 실시간 논블로킹 스트리밍됨.

## 05-async-reactive ↔ 06-ops-native
- [[05-async-reactive/05-event-driven-architecture-kafka-basics]] ↔ [[06-ops-native/08-distributed-tracing-tempo-correlation]]
  - 카프카 레코드 헤더를 통해 W3C `traceparent` 컨텍스트가 전파되어, HTTP 동기 호출과 비동기 카프카 컨슈머 전 구간이 Grafana Tempo에서 단일 `traceId`로 분산 추적됨.
- [[05-async-reactive/01-virtual-threads-loom-concurrency]] ↔ [[06-ops-native/03-graalvm-native-image-and-runtime-hints]]
  - 가상 스레드와 GraalVM AOT 네이티브 이미지가 결합되어 서브세컨드 기동 속도와 수백만 개 동시 연결을 동시에 달성함.

## 06-ops-native ↔ 07-ai
- [[06-ops-native/05-observability-three-pillars-architecture]] ↔ [[07-ai/01-spring-ai-architecture-and-chatclient]]
  - Spring AI의 `ChatClient`가 방출하는 LLM 추론 토큰 수, 소요 시간, 프롬프트 메타데이터가 OpenTelemetry 표준 OTLP를 통해 프로메테우스와 템포로 자동 계측됨.
- [[06-ops-native/02-docker-compose-production-scaling]] ↔ [[07-ai/04-rag-architecture-and-vector-stores]]
  - Docker Compose를 통해 `pgvector` 확장이 활성화된 PostgreSQL 컨테이너를 구동하고 Spring AI VectorStore와 즉시 연동함.

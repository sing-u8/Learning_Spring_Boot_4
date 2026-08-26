# Learning Spring Boot 4 학습 노트 저장소 (Deep-Tutor Vault)

> **교재**: *Learning Spring Boot 4: Simplify the development of production-grade applications using Java and Spring (4th Edition)*  
> **저자**: Wanderson Xesquevixos, Ranga Rao Karanam, Magnus Larsson, Greg L. Turnquist  
> **기술 스택**: Spring Boot 4.1.x, Java 25, Spring AI 1.x, Testcontainers 2.x, JUnit 6, OpenTelemetry, OCI Buildpacks  
> **총 개념 노트**: **8개 카테고리 / 51개 개념 노트 (전수 100% 검증 완료)**

---

## 📚 카테고리별 개념 맵 및 구성

```
spring-boot-notes/
├── 01-core/ (6개 노트)
│   └── 스프링 부트 아키텍처, IoC/DI, 자동 구성, 스타터, 외부화 설정, BeanRegistrar, 마이그레이션
├── 02-web/ (6개 노트)
│   └── Spring MVC, Thymeleaf, Jackson 3, 네이티브 API 버저닝, @HttpExchange, React 통합
├── 03-data/ (5개 노트)
│   └── Spring Data JPA, Hibernate 7 SQM, 파생 쿼리/페이징, Query By Example, R2DBC
├── 04-security/ (6개 노트)
│   └── SecurityFilterChain, UserDetailsService, 메서드 보안, CSRF, OAuth 2.1 / OIDC, SSL Bundles
├── 05-async-reactive/ (8개 노트)
│   └── 가상 스레드, Reactive Streams, WebFlux SSE, HATEOAS, Kafka EDA, DLT/멱등성, 구조화된 동시성, Thymeleaf DataDriver
├── 06-ops-native/ (8개 노트)
│   └── Uber JAR/Buildpacks, Docker Compose, GraalVM Native Image, Java 25 AOT Cache, 관측성 3대 기둥, Loki, Prometheus, Tempo
├── 07-ai/ (8개 노트)
│   └── Spring AI, ChatClient, 프롬프트 템플릿, Tool Calling, RAG/VectorStore, MCP, 가드레일, 대화 메모리, LLM 평가
├── 08-testing/ (6개 노트)
│   └── JUnit 6 도메인 단위 테스트, @WebMvcTest & @MockitoBean, @DataJpaTest, Testcontainers 2.x & @ServiceConnection, Spring Security Test, RestTestClient
└── _global/
    └── 설정(config.md), 세션 로그, 교차 연결 맵
```

---

## 🎯 전체 51개 개념 노트 색인

### 01-core (6)
1. `01-spring-boot-architecture-and-context.md` — 스프링 부트 아키텍처와 IoC 컨테이너
2. `02-autoconfiguration-and-conditionals.md` — 모듈형 자동 구성과 @Conditional 조건부 등록
3. `03-starters-and-dependency-management.md` — 스타터 POM과 전이 의존성 관리
4. `04-configuration-properties-and-profiles.md` — ConfigurationProperties 타입 안전 바인딩과 프로파일
5. `05-bean-registration-and-null-safety.md` — BeanRegistrar 함수형 등록과 JSpecify Null-Safety
6. `06-spring-boot-4-migration-and-breaking-changes.md` — Spring Boot 4 마이그레이션과 파괴적 변경사항

### 02-web (6)
1. `01-spring-mvc-architecture-and-controllers.md` — Spring MVC 요청-응답 생명주기와 웹 컨트롤러
2. `02-server-side-templates-thymeleaf.md` — 서버 사이드 템플릿 엔진 Thymeleaf와 폼 데이터 바인딩
3. `03-json-rest-api-jackson3.md` — Jackson 3 기반 RESTful JSON API 설계와 엔드포인트
4. `04-native-api-versioning.md` — Spring Boot 4 네이티브 API 버저닝 (URI, 헤더, 쿼리 파라미터)
5. `05-declarative-http-interfaces.md` — 선언적 HTTP 서비스 인터페이스 (@HttpExchange 프록시 클라이언트)
6. `06-frontend-integration-react.md` — React 프론트엔드 연동과 프로덕션 단일 JAR 패키징 파이프라인

### 03-data (5)
1. `01-spring-data-jpa-repositories.md` — Spring Data JPA 리포지토리 추상화와 도메인 계층 분리
2. `02-hibernate-7-and-persistence-module.md` — Hibernate 7 SQM 엔진과 Spring Boot Persistence 모듈
3. `03-derived-queries-and-pagination.md` — 파생 쿼리 메서드와 Pageable/Slice 페이징 최적화
4. `04-query-by-example-and-custom-jpa.md` — Query By Example 동적 검색과 커스텀 JPA 리포지토리 구현
5. `05-r2dbc-reactive-data-access.md` — R2DBC 비동기 논블로킹 데이터 액세스와 반응형 리포지토리

### 04-security (6)
1. `01-spring-security-architecture-filterchain.md` — Spring Security 7 아키텍처와 SecurityFilterChain 파이프라인
2. `02-authentication-user-details-service.md` — 사용자 인증과 UserDetailsService 및 PasswordEncoder 해싱
3. `03-authorization-and-method-security.md` — URL 인가 규칙과 @PreAuthorize 메서드 수준 보안 (SpEL)
4. `04-csrf-protection-and-session.md` — CSRF 공격 방어 메커니즘과 세션 고정 보호 정책
5. `05-oauth2-oidc-social-login.md` — OAuth 2.1 & OpenID Connect 기반 소셜 로그인 및 토큰 인증
6. `06-ssl-bundles-and-data-protection.md` — SSL Bundles 중앙화 인증서 관리와 전송 계층 보안 (TLS/HTTPS)

### 05-async-reactive (8)
1. `01-virtual-threads-loom-concurrency.md` — Java 25 가상 스레드 (Project Loom)와 Spring Boot 동시성 모델
2. `02-reactive-streams-reactor-core.md` — Reactive Streams 표준 명세와 Project Reactor (Mono & Flux) 핵심
3. `03-spring-webflux-controllers-streaming.md` — Spring WebFlux 컨트롤러와 Server-Sent Events (SSE) 실시간 스트리밍
4. `04-reactive-hypermedia-hateoas.md` — Spring HATEOAS 기반 반응형 하이퍼미디어 API 구축
5. `05-event-driven-architecture-kafka-basics.md` — 이벤트 기반 아키텍처(EDA)와 Apache Kafka 기초
6. `06-kafka-reliability-retries-dlq-idempotency.md` — Kafka 신뢰성 패턴: 논블로킹 재시도, DLT 격리, 멱등성 소비자
7. `07-structured-concurrency-and-task-decorator.md` — 구조화된 동시성(StructuredTaskScope)과 TaskDecorator 컨텍스트 전파
8. `08-reactive-thymeleaf-and-r2dbc-template.md` — Thymeleaf 리액티브 데이터 드라이버와 R2DBC 템플릿

### 06-ops-native (8)
1. `01-uber-jar-and-buildpacks-container.md` — 실행 가능한 Uber JAR 구조와 Cloud Native Buildpacks OCI 이미지
2. `02-docker-compose-production-scaling.md` — Docker Compose 멀티 인스턴스 스케일링과 공유 데이터베이스 구성
3. `03-graalvm-native-image-and-runtime-hints.md` — GraalVM 네이티브 이미지 AOT 컴파일과 RuntimeHints 등록
4. `04-java25-aot-cache-and-runtime-comparison.md` — Java 25 AOT Cache 트레이닝 실행과 런타임 기술별 성능 비교
5. `05-observability-three-pillars-architecture.md` — 옵저버빌리티 3대 기둥과 OpenTelemetry 표준 아키텍처
6. `06-structured-logging-loki-grafana.md` — Logback 구조화된 JSON 로깅과 Grafana Loki 수집 파이프라인
7. `07-metrics-micrometer-prometheus.md` — Micrometer 벤더 중립 메트릭 수집과 Prometheus / Grafana 연동
8. `08-distributed-tracing-tempo-correlation.md` — OpenTelemetry 기반 Grafana Tempo 분산 추적과 3대 신호 교차 상관분석

### 07-ai (8)
1. `01-spring-ai-architecture-and-chatclient.md` — Spring AI 아키텍처와 ChatClient Fluent API 빌더
2. `02-prompt-engineering-and-templates.md` — 프롬프트 템플릿 엔지니어링과 BeanOutputConverter 구조화 DTO 매핑
3. `03-tool-calling-and-function-callbacks.md` — @Tool 기반 Tool Calling과 자바 메서드 자율 실행 에이전트 루프
4. `04-rag-architecture-and-vector-stores.md` — RAG (검색 증강 생성) 아키텍처와 PGVector 기반 의미론적 검색 파이프라인
5. `05-model-context-protocol-mcp.md` — Model Context Protocol (MCP) 표준 아키텍처와 엔터프라이즈 도구 연동
6. `06-ai-security-and-responsible-guardrails.md` — AI 보안: 프롬프트 인젝션 방어, PII 마스킹 및 다층 가드레일 체인
7. `07-conversation-memory-chat-memory.md` — 대화 메모리(ChatMemory)와 MessageChatMemoryAdvisor 세션 상태 관리
8. `08-llm-evaluation-and-cost-optimization.md` — LLM 응답 품질 평가(LLM-as-a-Judge)와 프롬프트 캐싱 비용 최적화

### 08-testing (6)
1. `01-junit6-and-domain-unit-testing.md` — JUnit 6와 도메인 객체 순수 단위 테스트
2. `02-web-mvc-test-mockmvc-mockito-bean.md` — @WebMvcTest와 MockMvc 및 @MockitoBean 웹 슬라이스 테스트
3. `03-data-jpa-test-and-embedded-db.md` — @DataJpaTest와 인메모리 데이터베이스 슬라이스 테스트
4. `04-testcontainers-and-service-connection.md` — Testcontainers 2.x와 @ServiceConnection 통합 테스트
5. `05-spring-security-test-and-mock-user.md` — Spring Security Test와 @WithMockUser 보안 정책 검증
6. `06-rest-test-client-and-integration.md` — RestTestClient와 @SpringBootTest 풀스택 통합 테스트

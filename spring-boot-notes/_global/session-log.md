# 세션 로그 (Session Log)

## 2026-08-26 (Batch Preparation Completed)
- **모드**: `deep-tutor` Mode 0 (Prepare) 전권 일괄(Batch) 생성
- **대상 서적**: *Learning Spring Boot 4: Simplify the development of production-grade applications using Java and Spring (4th Edition)*
- **생성 완료 현황**: 총 7개 카테고리 / 40개 핵심 개념 노트 전수 생성 및 검증 완료 (`check-note.sh` 100% 통과)

### 카테고리별 세부 생성 내역
1. **`01-core` (5개)**:
   - `01-spring-boot-architecture-and-context.md`
   - `02-autoconfiguration-and-conditionals.md`
   - `03-starters-and-dependency-management.md`
   - `04-configuration-properties-and-profiles.md`
   - `05-bean-registration-and-null-safety.md`
2. **`02-web` (6개)**:
   - `01-spring-mvc-architecture-and-controllers.md`
   - `02-server-side-templates-thymeleaf.md`
   - `03-json-rest-api-jackson3.md`
   - `04-native-api-versioning.md`
   - `05-declarative-http-interfaces.md`
   - `06-frontend-integration-react.md`
3. **`03-data` (5개)**:
   - `01-spring-data-jpa-repositories.md`
   - `02-hibernate-7-and-persistence-module.md`
   - `03-derived-queries-and-pagination.md`
   - `04-query-by-example-and-custom-jpa.md`
   - `05-r2dbc-reactive-data-access.md`
4. **`04-security` (6개)**:
   - `01-spring-security-architecture-filterchain.md`
   - `02-authentication-user-details-service.md`
   - `03-authorization-and-method-security.md`
   - `04-csrf-protection-and-session.md`
   - `05-oauth2-oidc-social-login.md`
   - `06-ssl-bundles-and-data-protection.md`
5. **`05-async-reactive` (6개)**:
   - `01-virtual-threads-loom-concurrency.md`
   - `02-reactive-streams-reactor-core.md`
   - `03-spring-webflux-controllers-streaming.md`
   - `04-reactive-hypermedia-hateoas.md`
   - `05-event-driven-architecture-kafka-basics.md`
   - `06-kafka-reliability-retries-dlq-idempotency.md`
6. **`06-ops-native` (8개)**:
   - `01-uber-jar-and-buildpacks-container.md`
   - `02-docker-compose-production-scaling.md`
   - `03-graalvm-native-image-and-runtime-hints.md`
   - `04-java25-aot-cache-and-runtime-comparison.md`
   - `05-observability-three-pillars-architecture.md`
   - `06-structured-logging-loki-grafana.md`
   - `07-metrics-micrometer-prometheus.md`
   - `08-distributed-tracing-tempo-correlation.md`
7. **`07-ai` (6개)**:
   - `01-spring-ai-architecture-and-chatclient.md`
   - `02-prompt-engineering-and-templates.md`
   - `03-tool-calling-and-function-callbacks.md`
   - `04-rag-architecture-and-vector-stores.md`
   - `05-model-context-protocol-mcp.md`
   - `06-ai-security-and-responsible-guardrails.md`

### 전수 검증 결과
- 모든 40개 노트의 프론트매터 6개 키, 필수 섹션 7개, 다이어그램/표 2개 이상, `_glossary.md` 용어 무오류 대조, `## 7. 연결` 쌍방향 링크 검증 완료.

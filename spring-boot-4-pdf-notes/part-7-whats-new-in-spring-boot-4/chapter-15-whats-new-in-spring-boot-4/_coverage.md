# Chapter 15 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 15 *What's New in Spring Boot 4*, 책 pp. 469–492 / PDF pp. 494–517. PDF를 `pdftotext -layout -f 494 -l 517`로 새로 추출해 1,130줄 전체를 읽은 뒤, 9개 상위 영역·34개 하위 절·Note 40개를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거 — 이 Chapter만 예외

Chapter 1–3과 달리 이 Chapter는 **절 단위로 쪼개지 않고 하나의 노트로 통합했다.** 근거는 셋이다.

1. **원문의 성격이 다르다.** 이 장은 개념을 전개하는 장이 아니라 **변경 사항 카탈로그**다. 34개 하위 절 중 대부분이 5–20줄이며, 각각은 "무엇이 어떻게 바뀌었고 무엇을 고쳐야 하는가"라는 같은 형식을 반복한다.
2. **설명 가능한 개념이 하나다.** 34개 항목을 관통하는 것은 **"Boot 4가 어느 방향으로 움직였는가"**이며, 그것은 항목을 흩어 놓으면 오히려 보이지 않는다.
3. **절 단위 짝짓기는 읽는 쪽의 일이다.** 책의 Note 대부분이 "Chapter N의 어느 절에서 다룬다"는 안내인데, 그 대응은 노트를 쪼개서 만드는 것이 아니라 표 하나로 제공하는 편이 낫다(§4).

| 노트 | 범위 | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-whats-new-in-spring-boot-4]] | Chapter 15 전체 | 469–492 | 494–517 |

기존 9개 압축 초안(`01-core-framework-changes` … `09-additional-migration-changes`)은 이 노트로 통합하고 제거했다. 사용자 영역이 모두 비어 있음을 사전에 확인했다.

## 1. 본문 영역·하위 절 → 노트 매핑

전부 [[01-whats-new-in-spring-boot-4]]의 해당 소절에 반영했다. 아래는 원문 구조와 노트 소절의 대응이다.

| 책 쪽 | PDF 쪽 | 원문 영역 / 하위 절 | 노트 소절 | 상태 |
|---:|---:|---|---|---|
| 469 | 494 | 장 도입: Framework 7, Jakarta EE 11, Java 17 baseline, 책은 Java 25 사용, GraalVM 25·JVM AOT Cache, 9개 영역 목록 | 2.0 | 반영 |
| 470 | 495 | Note: Migration Guide·Release Notes 링크, `spring-boot-properties-migrator` 안내 | 2.10 | 반영 |
| 470 | 495 | **Core framework changes** (도입): Servlet 6.1, Jakarta Persistence 3.2, Bean Validation 3.1 | 2.0, 2.1 | 반영 |
| 470–471 | 495–496 | JSpecify null-safety annotations: `org.springframework.lang` → `org.jspecify.annotations`, 벤더 중립, NullAway, 컴파일 경고 증가 가능성 | 2.1 | 반영 |
| 471–472 | 496–497 | Programmatic bean registration with `BeanRegistrar`: `BeanRegistry`·`Environment`, `BeanDefinitionRegistryPostProcessor` 대비, AOT·네이티브 방향과의 정렬, 대부분 앱은 변경 불필요 | 2.1 | 반영 |
| 472–473 | 497–498 | Jackson 3 integration: `com.fasterxml.jackson` → `tools.jackson`(단 `jackson-annotations` 예외), `@JsonComponent`→`@JacksonComponent`·`@JsonMixin`→`@JacksonMixin`, 프로퍼티 경로 변경, `Jackson2ObjectMapperBuilderCustomizer`→`JsonMapperBuilderCustomizer`, Jackson 2 deprecated 지원, `spring.jackson.use-jackson2-defaults` | 2.1 | 반영 |
| 473–474 | 498–499 | Renamed and restructured starters: `starter-web`→`starter-webmvc`, `web-services`→`webservices`, `aop`→`aspectj`, 기술별 test starter, Flyway 전용 starter, classic starter 2종 | 2.1 | 반영 |
| 474 | 499 | **Web and API changes** (도입): 세 가지 테마 | 2.2 | 반영 |
| 474 | 499 | API versioning: `ApiVersionStrategy`, path/query/header/media-type 해석, `ApiVersionDeprecationHandler`, `spring.mvc.apiversion.*`·`spring.webflux.apiversion.*`, `ApiVersionResolver`·`ApiVersionParser` | 2.2 | 반영 |
| 475 | 500 | HTTP service clients: `@HttpExchange`·`@GetExchange`·`@PostExchange`, 프록시 구현, RestClient/WebClient 백엔드, 마이크로서비스 활용 | 2.2 | 반영 |
| 475–476 | 500–501 | Static resource locations: `/fonts/**` 추가, `PathRequest#toStaticResources().atCommonLocations()` 영향, WOFF/WOFF2/TTF, `StaticResourceLocation.FONTS`로 제외 | 2.2 | 반영 |
| 476 | 501 | Undertow removal: Servlet 6.1 baseline, Undertow 미지원, Tomcat·Jetty로 이전 | 2.2 | 반영 |
| 476–477 | 501–502 | **Data layer changes** (도입): 리포지토리는 대체로 그대로, import·애노테이션 프로세서·프로퍼티·저수준 커스터마이저는 검토 | 2.3 | 반영 |
| 477 | 502 | Spring Boot persistence module: `spring-boot-persistence`, `@EntityScan` 패키지 이동, `spring.dao.exceptiontranslation.enabled` → `spring.persistence.exceptiontranslation.enabled` | 2.3 | 반영 |
| 477 | 502 | Hibernate 7 and Jakarta Persistence 3.2: 프로그래밍 모델 유지, Criteria·정적 메타모델·애노테이션 프로세서 아티팩트 변경 | 2.3 | 반영 |
| 477–478 | 502–503 | Elasticsearch: 저수준 `RestClient` 자동 구성 → `Rest5Client`(Apache HttpClient 5), `RestClientBuilderCustomizer`→`Rest5ClientBuilderCustomizer`, 옛 의존성 불필요, 리포지토리는 그대로 | 2.3 | 반영 |
| 478–479 | 503–504 | MongoDB configuration changes: `spring.data.mongodb.*` → `spring.mongodb.*` 8종, management 프로퍼티 `mongo`→`mongodb` 3종, Spring Data 전용으로 남는 5종, UUID·BigDecimal 표현 기본값 제거 | 2.3 | 반영 |
| 479 | 504 | Redis Master/Replica: `spring.data.redis.masterreplica.nodes`, `MicrometerCommandLatencyRecorder` → `MicrometerTracing`, Observation API로 metric+span | 2.3 | 반영 |
| 480 | 505 | **Security changes**: Spring Security 7, `SecurityFilterChain` 명시, Spring Authorization Server가 Spring Security에 편입되어 버전 프로퍼티 제거, 검토 대상 목록 | 2.4 | 반영 |
| 480 | 505 | **Testing changes** (도입): 기술별 test starter 선언 | 2.5 | 반영 |
| 480–481 | 505–506 | Mockito bean override: `@MockBean`·`@SpyBean` 제거, `@MockitoBean`·`@MockitoSpyBean`, 패키지 위치, `@Configuration` 클래스에는 사용 불가 | 2.5 | 반영 |
| 481 | 506 | RestTestClient support: RestClient 기반 테스트 클라이언트, 서버 있는/없는 두 방식, **이 책에서 자세히 다루지 않음** | 2.5 | 반영 |
| 481–482 | 506–507 | Explicit web test Auto-Configuration: `@SpringBootTest`가 더 이상 웹 테스트 클라이언트를 자동 구성하지 않음, `@AutoConfigureMockMvc`·`@AutoConfigureTestRestTemplate`·`@AutoConfigureWebTestClient` | 2.5 | 반영 |
| 482 | 507 | Testcontainers 2.x support: artifact id 변경(`postgresql`→`testcontainers-postgresql` 등), Java 클래스 이름은 대체로 유지 | 2.5 | 반영 |
| 482 | 507 | **Messaging, batch, and retry changes** (도입) | 2.6 | 반영 |
| 482–483 | 507–508 | Spring Retry and Framework-Level retry: Framework 6 재시도 인프라로 이동, AMQP·Kafka·Integration·Batch 영향, `@Retryable` 직접 사용 시 `spring-retry` 명시 필요, `spring.kafka.retry.topic.backoff.random`→`.jitter`, `RabbitTemplateRetrySettingsCustomizer`·`RabbitListenerRetrySettingsCustomizer` | 2.6 | 반영 |
| 483 | 508 | Kafka streams customizations: `StreamBuilderFactoryBeanCustomizer` 제거 → `StreamsBuilderFactoryBeanConfigurer`, `Ordered` 기본값 0 | 2.6 | 반영 |
| 484 | 509 | Spring Batch 6: 데이터베이스 없는 in-memory `JobRepository`가 `spring-boot-starter-batch` 기본, 재시작 시 메타데이터 소실, `spring-boot-starter-batch-jdbc` + `DataSource`로 복원 | 2.6 | 반영 |
| 484 | 509 | JMS client API support: `JmsClient` 자동 구성, `JdbcClient` 계열의 fluent 스타일, `JmsTemplate` 계속 지원 | 2.6 | 반영 |
| 485 | 510 | **Observability changes** (도입): metrics/traces/logs 세 축 | 2.7 | 반영 |
| 485 | 510 | Dedicated OpenTelemetry starter: `spring-boot-starter-opentelemetry`, OTLP export, OTel SDK 자동 구성, Micrometer Observation API 통합, 로그는 로깅 시스템에 의존 | 2.7 | 반영 |
| 485–486 | 510–511 | Actuator health probes enabled by default: Kubernetes 감지와 무관하게 liveness·readiness 기본 활성, `/actuator/health/liveness`·`/readiness`, `management.endpoint.health.probes.enabled=false`로 해제 | 2.7 | 반영 |
| 486 | 511 | Multiple `TaskDecorator` beans: `CompositeTaskDecorator`, `@Order`·`Ordered`로 순서, 추적·보안 컨텍스트·MDC 전파 | 2.7 | 반영 |
| 486–487 | 511–512 | SSL health and certificate expiry: `expiringChains` 항목, `WILL_EXPIRE_SOON` 상태 폐지, 만료 임박도 `VALID`로 보고 | 2.7 | 반영 |
| 487 | 512 | **Native image and performance** (도입) | 2.8 | 반영 |
| 487 | 512 | GraalVM native image and AOT improvements: GraalVM Native Image 25 이상 요구, 빌드 시점 메타데이터 생성(reflection·resources·proxies·serialization), 수동 설정 감소하나 동적 요소는 힌트 필요 | 2.8 | 반영 |
| 487–488 | 512–513 | Java AOT cache: Java 24 도입·25 사용 가능, 학습 실행(training run) 후 캐시 재사용, 네이티브와 달리 JVM 유지, 개선 폭은 상황 의존, buildpack 지원은 Java 25 이상 | 2.8 | 반영 |
| 488 | 513 | **Additional migration changes** (도입) | 2.9 | 반영 |
| 488 | 513 | Configuration properties metadata for external types: `@ConfigurationPropertiesSource`, 모듈 분리 애플리케이션·라이브러리 작성자 대상 | 2.9 | 반영 |
| 488 | 513 | DevTools live reload disabled by default: `spring.devtools.livereload.enabled=true`로 복원, hot restart는 변화 없음 | 2.9 | 반영 |
| 489 | 514 | Spock framework integration removed: Groovy 5 미지원이 이유, 수동 의존성 관리로는 가능, JUnit 5 권장 | 2.9 | 반영 |
| 489 | 514 | Spring session property changes: `spring.session.redis`→`spring.session.data.redis`, `spring.session.mongodb`→`spring.session.data.mongodb` | 2.9 | 반영 |
| 489 | 514 | Pulsar reactive support removal: Spring Pulsar 자체의 Reactor 지원 제거에 따름 | 2.9 | 반영 |
| 490 | 515 | Embedded executable launch script support removed: Unix 전용·배포 제약이 이유, `java -jar`는 그대로, Gradle application plugin 등 대안 | 2.9 | 반영 |
| 490 | 515 | Spring Session Hazelcast support removed: Hazelcast 팀으로 주도권 이전 | 2.9 | 반영 |
| 490 | 515 | Spring Session MongoDB support removed: MongoDB 팀으로 주도권 이전 | 2.9 | 반영 |
| 491 | 516 | Jersey 4.0 and Jackson 3 incompatibilities: Jersey 4.0이 Jackson 3 미지원, `spring-boot-jackson` / deprecated `spring-boot-jackson2` | 2.9 | 반영 |
| 491 | 516 | Kotlin 2.2 or later: Java 전용 앱은 무관 | 2.9 | 반영 |
| 491 | 516 | Classic starter for migration: `spring-boot-starter-classic`·`spring-boot-starter-test-classic`, 임시 수단 | 2.9 | 반영 |
| 492 | 517 | Summary: 책 전체를 관통한 생각과 마무리 | [[_map]] | 반영 |

## 2. Note 커버리지

이 Chapter에는 Tip이 없고 **Note가 40개**다. 성격이 셋으로 갈린다.

| 성격 | 개수 | 처리 |
|---|---:|---|
| **"Chapter N의 어느 절에서 다룬다"는 교차 참조** | 15 | §4의 대응표로 통합 정리 |
| **공식 문서·Migration Guide·Release Notes 링크** | 24 | 해당 항목 서술에 출처로 병기 |
| **이 책에서 다루지 않는다는 명시** (RestTestClient) | 1 | 2.5에 그대로 반영 |

40개 모두 [[01-whats-new-in-spring-boot-4]]에 반영했다. 링크 URL은 항목마다 다시 나열하지 않고, 대표적인 세 곳(Migration Guide, Release Notes, JSpecify 사이트)만 본문에 적고 나머지는 "공식 마이그레이션 가이드의 해당 절"로 묶었다 — 24개 URL을 그대로 옮기는 것은 원문 복제에 가깝고 학습에 기여하지 않기 때문이다.

## 3. 코드·설정·좌표 커버리지

이 Chapter에는 실행 가능한 코드 리스팅이 없다. 대신 **이름·좌표·프로퍼티 키의 변경 목록**이 본문 내용의 대부분이다. 전부 노트의 대조표로 옮겼다.

| 종류 | 원문 항목 수 | 노트의 처리 |
|---|---:|---|
| Maven 좌표(starter·모듈) 변경·신설 | 16 | 2.1·2.2·2.5·2.6·2.7·2.9의 대조표 |
| 프로퍼티 키 변경·신설 | 21 | 2.1·2.3·2.5·2.7·2.9의 대조표 |
| 애노테이션·클래스 이름 변경 | 12 | 2.1·2.3·2.5·2.6의 대조표 |
| 패키지 경로 이동 | 4 | 2.1·2.3·2.5 |
| 제거된 기능 | 8 | 2.2·2.9의 "제거" 묶음 |

## 4. 책이 안내하는 "이 변화는 어느 Chapter에서" 대응표

원문 Note 15개가 각 변경을 이 책의 어느 절과 연결하는지 밝힌다. 이 표 자체가 원문의 일부이므로 그대로 옮겼다.

| Chapter 15의 항목 | 책이 지목한 곳 |
|---|---|
| JSpecify null-safety annotations | Ch. 2 · *Writing Null-Safe Applications with Spring Boot 4* |
| Renamed and restructured starters | Ch. 1 · *Adding portfolio components using Spring Boot starters* |
| API versioning | Ch. 2 · *Versioning APIs with Spring Boot 4* |
| HTTP service clients | Ch. 11 · *Using Interface-Proxy HTTP Service Clients in Spring Boot 4* |
| Spring Boot persistence module | Ch. 3 · *Adding Spring Data JPA to our project* |
| Hibernate 7 and Jakarta Persistence 3.2 | Ch. 3 · *Adding Spring Data JPA to our project* |
| Security changes | Ch. 4 · *Understanding OAuth 2.1* |
| Mockito bean override | Ch. 5 · *Testing web controllers with MockMvc* |
| RestTestClient | **이 책에서 다루지 않음** (Ch. 5는 MockMvc·Testcontainers 사용) |
| Explicit web test Auto-Configuration | Ch. 5 · *Testing web controllers with MockMvc* |
| Testcontainers 2.x | Ch. 5 · *Adding Testcontainers to the application* |
| Spring Retry / Framework retry | Ch. 12 · *Applying Reliability Patterns: Retries, DLQs, and Idempotency* |
| Kafka streams customizations | Ch. 12 · *Building Event-Driven Services with Spring Boot and Apache Kafka* |
| Dedicated OpenTelemetry starter | Ch. 13 · *Observability Architecture with Spring Boot 4* |
| Actuator health probes | Ch. 13 · *Instrumenting the Spring Boot Application for Logging* |
| Multiple TaskDecorator beans | Ch. 11 · *Integrating Virtual Threads with Spring Boot's TaskExecutor* |
| GraalVM native image / AOT | Ch. 8 · 네 개 절 (retrofitting, running, Docker, runtime hints) |
| Java AOT cache | Ch. 8 · *Using Java AOT Cache to reduce startup times* |

## 5. 이미지·도표 판단

- `pdfimages -f 494 -l 517 -list` 결과 **이 범위에는 raster 이미지가 하나도 없다.** 출력이 헤더 두 줄뿐이었다.
- 원문은 전부 산문과 불릿 목록이며 코드 리스팅도, 스크린샷도, 도표도 없다.
- **따라서 책 이미지를 추출하지 않았다.** 변경의 방향과 영역 간 파급을 밝은 배경 Mermaid와 대조표로 재구성했다.

## 6. 공식 문서 교차 확인에서 보강한 점

| 항목 | 책의 서술 | 노트의 보강 |
|---|---|---|
| `spring-boot-persistence` | 이름과 `@EntityScan` 이동, 프로퍼티 개명만 언급 | Chapter 3 작업에서 확인한 `PersistenceExceptionTranslationAutoConfiguration`의 실제 역할을 연결 |
| `spring-boot-starter-webmvc` | 이름 변경만 언급 | Chapter 2 작업에서 확인한 전이 의존성 구성(`starter-jackson`·`starter-tomcat`·`http-converter`·`webmvc`)을 연결 |
| API versioning 프로퍼티 | `spring.mvc.apiversion.*`·`spring.webflux.apiversion.*` | Chapter 3 작업에서 확인한 `supported`·`MissingApiVersionException`·`InvalidApiVersionException`을 연결 |
| Java AOT Cache | "`spring.aot.enabled`" 언급 없음 (Ch.15에서는 언급하지 않는다) | Chapter 3의 AOT repository 항목과 구분해, 두 AOT가 서로 다른 것임을 명시 |

## 7. 완료 기준

- [x] 9개 상위 영역과 34개 하위 절이 전부 노트의 소절에 매핑됨
- [x] Note 40개의 기술적 내용이 반영됨 (교차 참조 15개는 §4 대응표로 통합)
- [x] 이름·좌표·프로퍼티 변경 목록이 대조표로 전수 반영됨
- [x] PDF 내 raster 이미지 부재를 `pdfimages -list`로 실제 확인함
- [x] 절 단위로 쪼개지 않고 챕터 단위 단일 노트로 정리함

## 공식 문서 대조 검증 (2026-08-29)

이 챕터는 **Boot 4의 변경 사항 카탈로그**라 버전 민감한 단정이 밀집해 있다. 검증 가치가 높은 둘을 대조했다.

| 주장 | 위치 | 결과 |
|---|---|---|
| Actuator의 liveness·readiness **상태 프로브가 모든 애플리케이션에서 기본으로 켜진다** (Kubernetes 감지 시에만이 아니라) | `01` | **확인됨 ✅** — Boot 4.0.3 문서: *"두 HealthIndicator 빈이 **기본으로 활성화된다** — `LivenessStateHealthIndicator`와 `ReadinessStateHealthIndicator`. `management.endpoint.health.probes.enabled`로 끌 수 있다."* |
| Boot 4의 `spring-boot-starter-batch`가 **인메모리 `JobRepository`를 기본으로 쓴다** | `01` | **확인됨 ✅** — 아래 참고 |

### Batch 주장 — 상류 문서까지 추적해 확정 (2026-08-29 2차)

처음에는 Boot 문서만 보고 **확인 불가**로 남겼다. Boot 레퍼런스가 조건부로만 서술하기 때문이다(*"**SQL 데이터베이스에 작업 상세를 저장하는** 배치 애플리케이션은 `DataSource` 빈이 필요하다"*). 실수 대가가 큰 항목이라 **상류로 거슬러 올라가** 확정했다.

| 단계 | 문서 | 얻은 것 |
|---|---|---|
| 1 | Boot 4 레퍼런스 — Spring Batch | 자동 구성 가능한 저장소를 *"**In-memory**, JDBC, MongoDB"*로 나열. **인메모리가 정식 선택지**임은 확인되나 기본값은 미기재 |
| 2 | Boot 4.0 릴리스 노트 | Batch 항목은 *"Spring Batch 6.0"* 의존성 업그레이드 한 줄뿐. **상류를 가리킨다** |
| 3 | Spring Batch 6.0 릴리스 노트 | 기본값 서술 없음. **마이그레이션 가이드를 가리킨다** |
| 4 | **Spring Batch 6.0 마이그레이션 가이드** | **확정.** *"`DefaultBatchConfiguration`이 이제 **'resourceless' 배치 인프라**를 구성한다(즉 **`ResourcelessJobRepository`**와 `ResourcelessTransactionManager`)."* 이유 — *"배치 메타데이터가 필요 없는 사람들에게 **인메모리 데이터베이스에 대한 추가 의존성을 요구하지 않기 위해서**다."* JDBC 유지에는 **`@EnableJdbcJobRepository`**(또는 `JdbcDefaultBatchConfiguration`)가 필요하다 |

**판정 — 책이 옳다.** 다만 변경의 주체가 Boot가 아니라 **Spring Batch 6 자체**이며, Boot 4는 그 기본값 위에 올라탄 것이다. 노트에 그 층위와 클래스 이름(`ResourcelessJobRepository`·`ResourcelessTransactionManager`), Batch 층의 복구 방법(`@EnableJdbcJobRepository`), 확인 방법을 함께 적었다.

**방법론적 교훈.** 프레임워크의 기본값 변경은 **그 프레임워크의 문서에 없을 수 있다.** Boot는 상류 라이브러리의 결정을 그대로 물려받으므로, Boot 문서에서 안 나오면 **릴리스 노트 → 상류 릴리스 노트 → 상류 마이그레이션 가이드** 순으로 따라가야 한다. 네 단계를 거쳐야 나왔다.

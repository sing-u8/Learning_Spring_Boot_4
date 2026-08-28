# chapter-j3 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다. 근거는 `CLAUDE.md`의 「보조 소스 트랙 — part-0-jpa-foundations」에 있다.

## 1. 1차 소스

| 소스 | 접근 | 역할 |
|---|---|---|
| Hibernate ORM Query Language — From | Context7 `/hibernate/hibernate-orm` | `join fetch` 문법과 목적 |
| Hibernate ORM User Guide — Fetching | Context7 `/hibernate/hibernate-orm` | `@BatchSize`와 `IN` 절 형태 |
| Hibernate ORM Introduction — Interacting | Context7 `/hibernate/hibernate-orm` | `EntityGraph`, 지연 로딩과 N+1의 관계 |
| `SelectionQueryImpl` 소스 | Context7 `/hibernate/hibernate-orm` | **페이징 + 컬렉션 페치 시 `limit`을 빼는 실제 코드** |
| Hibernate ORM User Guide — Locking | Context7 `/hibernate/hibernate-orm` | `@Version`, `LockMode`와 `LockModeType`의 차이 |
| Hibernate ORM Introduction — Tuning | Context7 `/hibernate/hibernate-orm` | `PESSIMISTIC_WRITE`, 타임아웃, `NOWAIT`·`SKIPLOCKED` |
| Spring Framework Reference — Declarative Transaction Management | Context7 `/websites/spring_io_spring-framework_reference` | 전파 속성, **자기 호출이 가로채이지 않는다는 명시** |
| Spring Framework Reference — Understanding AOP Proxies | Context7 같음 | 자기 호출 해법 세 가지와 권장 순위 |
| Spring Boot Reference — SQL Databases | Context7 `/spring-projects/spring-boot/v4.1.0` | OSIV 기본값이 켜짐이라는 근거 |
| Hibernate ORM User Guide — JDBC · Database Access | Context7 `/hibernate/hibernate-orm` | **RESOURCE_LOCAL 은 트랜잭션이 끝나면 커넥션을 반환한다** — "OSIV 가 커넥션을 요청 끝까지 붙잡는다"는 통설의 반증 |


> **문서 루트 (2026-08-28 추가).** 이 챕터는 이전 세션이 Context7로 조회해 작성했고, **절 단위 URL이 기록되지 않았다.** 아래는 위 표의 문서 이름에 대응하는 공식 문서의 최상위 주소다. 절 이름으로 찾아 들어가면 대조할 수 있다. 내가 직접 열어 확인한 페이지가 아니므로 **절 단위 앵커는 지어내지 않았다.**
>
> | 문서 | 루트 |
> |---|---|
> | Hibernate ORM User Guide | `https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html` |
> | Hibernate ORM Query Language | `https://docs.jboss.org/hibernate/orm/current/querylanguage/html_single/Hibernate_Query_Language.html` |
> | Hibernate ORM Introduction | `https://docs.jboss.org/hibernate/orm/current/introduction/html_single/Hibernate_Introduction.html` |
> | Spring Framework Reference — Transaction Management | `https://docs.spring.io/spring-framework/reference/data-access/transaction.html` |
> | Spring Boot Reference — SQL Databases | `https://docs.spring.io/spring-boot/reference/data/sql.html` |
> | Hibernate ORM 소스 | `https://github.com/hibernate/hibernate-orm` |

## 2. 대조 읽기용 참고서

김영한 『자바 ORM 표준 JPA 프로그래밍』. **노트를 먼저 읽고 그다음 책을 펴는 순서**를 권한다. 장 번호는 판본에 따라 다를 수 있으므로 목차로 확인한다.

| 노트 | 대조할 장 | 특히 볼 것 |
|---|---|---|
| [[01-n-plus-one-when-it-happens]] | 15장 고급 주제와 성능 최적화 | N+1 문제의 발생 형태 |
| [[02-fetch-join-entitygraph-batch-size]] | 15장 | 페치 조인, 배치 사이즈 |
| [[03-transactional-propagation-and-proxy-limits]] | 12장 스프링 데이터 JPA | 스프링과 트랜잭션 |
| [[04-isolation-and-optimistic-locking]] | 16장 트랜잭션과 락, 2차 캐시 | 낙관적·비관적 락 |
| [[05-open-session-in-view]] | 13장 웹 애플리케이션과 영속성 관리 | OSIV의 동작과 대안 |

## 3. 주제 → 노트 매핑

| 주제 | 노트 | 반영 |
|---|---|---|
| N+1의 정의와 계산 | [[01-n-plus-one-when-it-happens]] | 반영 — 1절 |
| 로딩 전략이 원인이 아니라는 점 | [[01-n-plus-one-when-it-happens]] | 반영 — 1절 |
| 발생 조건 3가지 | [[01-n-plus-one-when-it-happens]] | 반영 — 2.1 |
| 중첩 연관에서 곱해지는 형태 | [[01-n-plus-one-when-it-happens]] | 반영 — 2.2 |
| 1차 캐시가 개발 환경에서 가리는 현상 | [[01-n-plus-one-when-it-happens]] | 반영 — 2.3 |
| 쿼리 카운트 검증 | [[01-n-plus-one-when-it-happens]] | 반영 — 2.4 |
| 페치 조인의 동작과 행 증가 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.1 |
| 페이징과 컬렉션 페치의 충돌 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 1절 · 2.1 (소스 근거) |
| 컬렉션 둘 이상 페치 시 카테시안 곱 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.1 |
| 엔티티 그래프와 재사용성 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.2 |
| 배치 페칭의 `IN` 절과 페이징 호환 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.3 |
| 경로마다 다른 전략을 고르는 판단 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.4 |
| DTO 직접 조회라는 네 번째 선택지 | [[02-fetch-join-entitygraph-batch-size]] | 반영 — 2.5 |
| 프록시 기반 AOP의 가로채기 지점 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.1 |
| 전파 7종 비교 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.2 |
| 잡은 예외인데 롤백되는 과정 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.3 |
| unchecked만 롤백하는 기본 규칙 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.3 |
| 자기 호출 해법 3가지와 권장 순위 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.4 |
| 참여 트랜잭션에서 `readOnly` 무시 | [[03-transactional-propagation-and-proxy-limits]] | 반영 — 2.5 |
| 격리 수준으로 덮어쓰기를 못 막는 이유 | [[04-isolation-and-optimistic-locking]] | 반영 — 1절 |
| 낙관적 락의 UPDATE 문 형태 | [[04-isolation-and-optimistic-locking]] | 반영 — 2.1 · 3절 |
| 탐지 후 선택지 3가지 | [[04-isolation-and-optimistic-locking]] | 반영 — 2.2 |
| 비관적 락 모드와 SQL 대응 | [[04-isolation-and-optimistic-locking]] | 반영 — 2.3 |
| `LockMode`와 `LockModeType`의 불일치 | [[04-isolation-and-optimistic-locking]] | 반영 — 2.3 · 5절 |
| 선택 기준과 판별 질문 | [[04-isolation-and-optimistic-locking]] | 반영 — 2.4 |
| OSIV 기본값이 켜짐이라는 사실 | [[05-open-session-in-view]] | 반영 — 1절 |
| 컨텍스트 수명과 트랜잭션 경계의 구분 | [[05-open-session-in-view]] | 반영 — 1절 · 2.1 |
| 커넥션 점유 시간과 처리량 상한 | [[05-open-session-in-view]] | 반영 — 1절 · 3절 |
| 끄면 달라지는 것 | [[05-open-session-in-view]] | 반영 — 2.2 |

## 4. CosmoRoute 실제 코드와의 대조

읽기 전용으로 확인한 사실만 적었다.

| 확인한 사실 | 위치 | 쓰인 노트 |
|---|---|---|
| `application.yaml`에 `open-in-view` 설정이 **없음** | `api/src/main/resources/application.yaml` | 05 — 출발 장면 |
| `default_batch_fetch_size` 설정이 **없음** | 같은 파일 (`hibernate` 속성은 `jdbc.time_zone`뿐) | 02 — 2.4 |
| `Material`·`Company`에 `@Version` **없음** | `catalog/internal/*.java` | 04 — 전체 |
| 스키마에 `version` 컬럼 **없음** | `V1__initial_schema.sql` | 04 — 2.5 |
| `CuratedCatalogService` 클래스 레벨 `@Transactional` | `CuratedCatalogService.java:24` | 03 — 2.5 |
| 조회 메서드에 `@Transactional(readOnly = true)` | 같은 파일 72·97행 | 03 — 2.5 |
| `Material.company`가 `fetch = LAZY` | `catalog/internal/Material.java:34` | 01 — 1절 |
| 프론트 3앱이 백엔드와 분리(Nuxt·Vue SPA) | `README.md` · `frontend/` | 05 — 2.3 |
| 응답 타입이 `CompanySummary`·`MaterialSummary` DTO | `catalog/*.java` | 02 — 2.5 · 05 — 2.3 |
| 모듈 경계를 테스트가 검증 (ADR-0008) | `ModuleStructureTest.java` | 01 — 2.4 · 05 — 2.3 |
| Testcontainers 실 PostgreSQL 사용 | `api/build.gradle.kts` | 01 — 2.4 |
| RFC 9457 Problem Details 사용 | `application.yaml` | 04 — 2.5 |
| Flyway가 스키마를 소유, `ddl-auto: validate` | `application.yaml` | 04 — 2.5 |

## 5. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "지연 로딩 때문에 N+1이 난다" | 즉시 로딩도 쿼리 수가 같다 | 01 — 1절 |
| "페치 조인으로 N+1을 해결한다" | 컬렉션이면 페이징이 깨진다 | 02 — 1절 |
| "페이징이 안 되면 에러가 난다" | 기본은 경고만 찍고 메모리에서 자른다 | 02 — 1절 |
| "`@Transactional`을 붙였으니 적용된다" | 자기 호출은 프록시를 안 거쳐 무시된다 | 03 — 1절 |
| "예외를 잡으면 롤백을 막을 수 있다" | rollback-only는 되돌릴 수 없다 | 03 — 2.3 |
| "낙관적 락이 행을 잠근다" | 아무것도 잠그지 않는다. 탐지만 한다 | 04 — 2.1 |
| "`LockModeType.WRITE`가 비관적 락" | 낙관적 모드다 | 04 — 5절 |
| "트랜잭션을 걸었으니 덮어쓰기는 없다" | `READ COMMITTED`는 이 패턴을 막지 않는다 | 04 — 1절 |
| "OSIV는 트랜잭션을 늘린다" | 컨텍스트 수명만 늘린다. 변경은 저장되지 않는다 | 05 — 1절 |
| "설정에 없으면 꺼져 있다" | 기본값이 켜짐이다 | 05 — 1절 |

## 6. 이 챕터가 만든 결정 목록

`part-0` 세 챕터가 끝나면서 첫 슬라이스에 필요한 판단이 모두 갖춰졌다. 아래는 이 챕터가 추가한 항목이다.

| 결정할 것 | 이 챕터의 결론 | 언제 |
|---|---|---|
| `default_batch_fetch_size` | **켠다.** 설정 한 줄, 매핑 무수정, 페이징과 호환 | 첫 슬라이스에서 바로 |
| `spring.jpa.open-in-view` | **`false`로 명시한다.** 서버 뷰가 없다 | 첫 슬라이스에서 바로 |
| 목록 조회의 연관 전략 | 단일 연관은 엔티티 그래프, 컬렉션은 배치 페칭 | 첫 슬라이스 |
| 상세 조회의 연관 전략 | 페이징이 없으므로 컬렉션 페치 조인 가능 | 첫 슬라이스 |
| 쿼리 카운트 검증 | 목록 API에 붙인다 | 첫 슬라이스 |
| DTO 변환 위치 | 서비스 트랜잭션 안 | 첫 슬라이스 |
| `@Version` 도입 | **보류.** 동시 수정이 실제 문제가 됐을 때 ADR과 함께 | 나중 |
| `@DynamicUpdate` | **보류.** `@Version`이 선행 조건 | 나중 |
| `fail_on_pagination_over_collection_fetch` | 검토 대상 — 경고를 예외로 승격 | 첫 슬라이스 이후 |

## 7. 아직 다루지 않은 것

| 주제 | 왜 보류인가 |
|---|---|
| 2차 캐시 | 단일 인스턴스이고 아직 읽기 부하가 문제가 아니다 |
| 벌크 연산과 컨텍스트 동기화 | 벌크 삭제·갱신 경로가 아직 없다 |
| 커넥션 풀 튜닝 (HikariCP) | 측정 없이 조정할 값이 아니다 |
| 상속 매핑 전략 | 이 도메인에 상속 계층이 없다 |
| 읽기 전용 복제본 라우팅 | 단일 DB 단계다 |

# chapter-j1 출처 커버리지

> 이 챕터는 PDF 원문이 아니라 공식 문서와 참고서를 대조해 만들었다. 그래서 Chapter 노트의 `_coverage.md`와 성격이 다르다 — 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다.
>
> 이 트랙이 왜 필요한지는 `CLAUDE.md`의 「보조 소스 트랙 — part-0-jpa-foundations」에 있다. 요약하면 *Learning Spring Boot 4* Ch. 3은 26쪽 6절이고 영속성 컨텍스트·변경 감지·엔티티 생명주기를 다루지 않는다.

## 1. 1차 소스

| 소스 | 접근 | 역할 |
|---|---|---|
| Hibernate ORM User Guide — Persistence Context | Context7 `/hibernate/hibernate-orm` | 4상태 정의, `merge` 의미, `@DynamicUpdate` |
| Hibernate ORM User Guide — Flushing | Context7 `/hibernate/hibernate-orm` | write-behind 정의, 플러시 계기, 모드별 동작 |
| Hibernate ORM User Guide — Caching | Context7 `/hibernate/hibernate-orm` | 1차 캐시가 곧 영속성 컨텍스트라는 규정 |
| Hibernate ORM Introduction — Interacting · Advanced | Context7 `/hibernate/hibernate-orm` | 쿼리 직전 플러시 예제, static UPDATE 기본 동작 |
| `StatefulPersistenceContext` 소스 | Context7 `/hibernate/hibernate-orm` | 결과 행과 1차 캐시의 동일성 조정 |
| Spring Data JPA Reference — Persisting Entities | Context7 `/spring-projects/spring-data-jpa` | `save()` 분기, `Persistable` 패턴 |
| `SimpleJpaRepository.save()` 소스 | Context7 `/spring-projects/spring-data-jpa` | `isNew ? persist : merge` 실제 구현 |


> **문서 루트 (2026-08-28 추가).** 이 챕터는 이전 세션이 Context7로 조회해 작성했고, **절 단위 URL이 기록되지 않았다.** 아래는 위 표의 문서 이름에 대응하는 공식 문서의 최상위 주소다. 절 이름으로 찾아 들어가면 대조할 수 있다. 내가 직접 열어 확인한 페이지가 아니므로 **절 단위 앵커는 지어내지 않았다.**
>
> | 문서 | 루트 |
> |---|---|
> | Hibernate ORM User Guide | `https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html` |
> | Hibernate ORM Introduction | `https://docs.jboss.org/hibernate/orm/current/introduction/html_single/Hibernate_Introduction.html` |
> | Spring Data JPA Reference | `https://docs.spring.io/spring-data/jpa/reference/` |
> | Hibernate ORM · Spring Data JPA 소스 | `https://github.com/hibernate/hibernate-orm` · `https://github.com/spring-projects/spring-data-jpa` |

## 2. 대조 읽기용 참고서

김영한 『자바 ORM 표준 JPA 프로그래밍』. **노트를 먼저 읽고 그다음 책을 펴는 순서**를 권한다. 책을 먼저 읽으면 그 설명 구조를 그대로 따라가게 되어 인출 연습에서 회수할 것이 남지 않는다. 장 번호는 판본에 따라 다를 수 있으므로 목차로 확인한다.

| 노트 | 대조할 장 | 특히 볼 것 |
|---|---|---|
| [[01-persistence-context-and-first-level-cache]] | 3장 영속성 관리 | 1차 캐시, 영속 엔티티의 동일성 보장 |
| [[02-write-behind-and-flush]] | 3장 영속성 관리 | 트랜잭션을 지원하는 쓰기 지연, 플러시 |
| [[03-dirty-checking-and-snapshots]] | 3장 영속성 관리 | 변경 감지, 스냅샷 |
| [[04-entity-lifecycle-and-detachment]] | 3장 · 12장 스프링 데이터 JPA | 준영속, `merge`의 동작, 새 엔티티 판별 |

## 3. 주제 → 노트 매핑

| 주제 | 노트 | 반영 |
|---|---|---|
| 영속성 컨텍스트의 정의와 수명 | [[01-persistence-context-and-first-level-cache]] | 반영 |
| 1차 캐시와 동일성 보장 | [[01-persistence-context-and-first-level-cache]] | 반영 |
| `find()`와 JPQL의 캐시 처리 차이 | [[01-persistence-context-and-first-level-cache]] | 반영 — 2.1 / 2.2 |
| JPQL 결과 행과 캐시 인스턴스의 조정 | [[01-persistence-context-and-first-level-cache]] | 반영 — `StatefulPersistenceContext` 근거 |
| 1차 캐시 대 2차 캐시 | [[01-persistence-context-and-first-level-cache]] | 반영 — 5절 비교표 |
| write-behind의 정의와 이유 | [[02-write-behind-and-flush]] | 반영 |
| 플러시 계기 3종 | [[02-write-behind-and-flush]] | 반영 — 2.1 |
| 플러시와 커밋의 구분 | [[02-write-behind-and-flush]] | 반영 — 2.3 비교표 |
| `FlushModeType` AUTO · COMMIT · MANUAL | [[02-write-behind-and-flush]] | 반영 — 2.4 |
| `COMMIT` 모드에서 네이티브 SQL의 예외 | [[02-write-behind-and-flush]] | 반영 — 2.4 |
| 식별자 전략이 쓰기 지연에 주는 영향 | [[02-write-behind-and-flush]] | 반영 — 2.5 |
| 더티 체킹 메커니즘 | [[03-dirty-checking-and-snapshots]] | 반영 — 2.1 |
| 스냅샷의 존재 이유와 대안 비교 | [[03-dirty-checking-and-snapshots]] | 반영 — 1절 |
| static UPDATE 기본 동작 | [[03-dirty-checking-and-snapshots]] | 반영 — 2.2 |
| `@DynamicUpdate`와 version 부재 시 위험 | [[03-dirty-checking-and-snapshots]] | 반영 — 2.2 |
| 조회 경로의 비용과 `readOnly = true` | [[03-dirty-checking-and-snapshots]] | 반영 — 2.3 / 2.4 |
| DTO 조회로 컨텍스트를 비우는 선택 | [[03-dirty-checking-and-snapshots]] | 반영 — 2.4 |
| 엔티티 4상태와 전이 | [[04-entity-lifecycle-and-detachment]] | 반영 — 2.1 |
| `merge()`의 단계별 동작과 반환값 | [[04-entity-lifecycle-and-detachment]] | 반영 — 2.2 |
| `save()`의 `isNew` 분기 | [[04-entity-lifecycle-and-detachment]] | 반영 — 1절 · 2.3 |
| 수동 할당 식별자와 `Persistable` | [[04-entity-lifecycle-and-detachment]] | 반영 — 2.3 |
| `merge()`가 null을 덮어쓰는 문제 | [[04-entity-lifecycle-and-detachment]] | 반영 — 2.4 |
| 삭제 상태와 소프트 삭제의 구분 | [[04-entity-lifecycle-and-detachment]] | 반영 — 2.5 |

## 4. CosmoRoute 실제 코드와의 대조

이 챕터의 예제는 가공한 것이 아니라 `/Users/singyupark/Documents/dev_projects/CosmoRoute`의 실제 코드에서 가져왔다. 읽기 전용으로 확인한 사실만 적었다.

| 확인한 사실 | 위치 | 쓰인 노트 |
|---|---|---|
| `CompanyRepository`가 `JpaRepository` 대신 `Repository`를 상속 | `catalog/internal/CompanyRepository.java` | 01 — JPQL 조회 예제 |
| 조회 메서드가 전부 JPQL `@Query` | 같은 파일 | 01 — 2.2 |
| `existsByNormalizedNameAndDeletedAtIsNull` 파생 쿼리 존재 | 같은 파일 | 02 — 출발 장면 |
| INV-8을 부분 유니크 인덱스와 사전 검사로 이중 강제 | `docs/domain/invariants.md` · `V1__initial_schema.sql` | 02 — 출발 장면 |
| `@GeneratedValue`가 코드베이스 어디에도 없음 | `api/src/main/java` 전수 | 02 — 2.5 · 04 — 2.3 |
| `Company.curated()`가 `UUID.randomUUID()`로 식별자 할당 | `catalog/internal/Company.java:100` | 02 — 2.5 · 04 — 2.3 |
| `company.id`에 DB 기본값 `gen_random_uuid()`도 존재 | `V1__initial_schema.sql:89` | 02 — 2.5 |
| INV-13을 `Material.publish()` 도메인 게이트로 강제 | `docs/domain/invariants.md` | 03 — 출발 장면 |
| `Company`에 `@Version` 필드 없음 | `catalog/internal/Company.java` | 03 — 2.2 경고 |
| 조회 경로에 `@Transactional(readOnly = true)` 이미 적용 | `CuratedCatalogService.java:72,97` | 03 — 2.4 |
| `return this.companies.save(company)` 형태로 반환값 사용 | `CuratedCatalogService.java:56,86` | 04 — 출발 장면 |
| `CompanySummary`·`MaterialSummary`를 모듈 공개 타입으로 분리 | `catalog/CompanySummary.java` 등 | 03 — 2.4 |
| 소프트 삭제(`deleted_at`) 사용, 물리 삭제 없음 | `V1__initial_schema.sql` | 04 — 2.5 |

## 5. 책과 공식 문서가 갈리는 지점

이번 챕터에서는 *Learning Spring Boot 4*와 직접 충돌하는 서술이 없었다. 책이 이 층을 아예 다루지 않기 때문이다. 대신 흔한 요약과 공식 동작이 갈리는 지점을 노트에 명시했다.

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "1차 캐시가 있으니 같은 조회는 쿼리가 한 번만 나간다" | `find()`에서만 참이다. JPQL은 SQL을 보내고 결과를 캐시와 조정한다 | 01 — 2.2 |
| "`save()`를 부르면 저장된다" | 컨텍스트 등록일 뿐이고 SQL은 플러시 때 나간다 | 02 — 5절 |
| "변경된 컬럼만 UPDATE된다" | Hibernate 기본은 static UPDATE로 전체 컬럼을 포함한다 | 03 — 2.2 |
| "`save()`는 `persist()`다" | `isNew()`가 거짓이면 `merge()`다 | 04 — 1절 |
| "`merge()`하면 그 객체가 영속이 된다" | 구별되는 다른 인스턴스를 반환하고 원본은 준영속으로 남는다 | 04 — 2.2 |

## 6. 아직 다루지 않은 것

다음 챕터로 넘긴 주제다. 이 챕터에서 설명하려 하면 선행 개념이 부족해진다.

| 주제 | 넘긴 곳 |
|---|---|
| 연관관계 매핑, 연관관계 주인, 연결 엔티티 | `chapter-j2-associations-and-proxies` |
| 프록시와 지연 로딩, `LazyInitializationException` | `chapter-j2-associations-and-proxies` |
| 영속성 전이와 고아 객체, DB CASCADE와의 이중 정의 | `chapter-j2-associations-and-proxies` |
| N+1, fetch join, `@EntityGraph`, batch size | `chapter-j3-performance-and-transactions` |
| `@Transactional` 전파와 프록시 AOP의 한계 | `chapter-j3-performance-and-transactions` |
| 격리 수준, 낙관적·비관적 락, `@Version` | `chapter-j3-performance-and-transactions` |
| OSIV와 트랜잭션 밖 지연 로딩 | `chapter-j3-performance-and-transactions` |

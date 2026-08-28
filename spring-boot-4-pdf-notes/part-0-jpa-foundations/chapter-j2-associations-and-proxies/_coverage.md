# chapter-j2 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. Chapter 노트의 `_coverage.md`와 달리 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다. 근거는 `CLAUDE.md`의 「보조 소스 트랙 — part-0-jpa-foundations」에 있다.

## 1. 1차 소스

| 소스 | 접근 | 역할 |
|---|---|---|
| Hibernate ORM User Guide — Domain Associations | Context7 `/hibernate/hibernate-orm` | 주인·`mappedBy`, 양방향의 이점과 한계 |
| Hibernate ORM Introduction — Entities | Context7 `/hibernate/hibernate-orm` | 단방향·양방향 매핑 예제 |
| Hibernate ORM Introduction — Advanced Mapping | Context7 `/hibernate/hibernate-orm` | `@Any` 매핑과 **참조 무결성 제약 불가**의 근거 |
| Hibernate ORM User Guide — ANY and @ManyToAny | Context7 `/hibernate/hibernate-orm` | `@AnyDiscriminatorValue` 형태 |
| Hibernate ORM Introduction — Interacting | Context7 `/hibernate/hibernate-orm` | 프록시 정의, 지연 로딩의 함정, cascade·orphanRemoval |
| Hibernate ORM User Guide — Persistence Context | Context7 `/hibernate/hibernate-orm` | `getReference`, `@OnDelete` cascade |
| `AbstractLazyInitializer` 소스 | Context7 `/hibernate/hibernate-orm` | 컨텍스트 없는 초기화가 세션을 새로 여는 동작 |


> **문서 루트 (2026-08-28 추가).** 이 챕터는 이전 세션이 Context7로 조회해 작성했고, **절 단위 URL이 기록되지 않았다.** 아래는 위 표의 문서 이름에 대응하는 공식 문서의 최상위 주소다. 절 이름으로 찾아 들어가면 대조할 수 있다. 내가 직접 열어 확인한 페이지가 아니므로 **절 단위 앵커는 지어내지 않았다.**
>
> | 문서 | 루트 |
> |---|---|
> | Hibernate ORM User Guide | `https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html` |
> | Hibernate ORM Introduction | `https://docs.jboss.org/hibernate/orm/current/introduction/html_single/Hibernate_Introduction.html` |

## 2. 대조 읽기용 참고서

김영한 『자바 ORM 표준 JPA 프로그래밍』. **노트를 먼저 읽고 그다음 책을 펴는 순서**를 권한다. 장 번호는 판본에 따라 다를 수 있으므로 목차로 확인한다.

| 노트 | 대조할 장 | 특히 볼 것 |
|---|---|---|
| [[01-association-owner-and-mappedby]] | 5장 연관관계 매핑 기초 | 연관관계 주인, `mappedBy`, 편의 메서드 |
| [[02-join-entity-instead-of-many-to-many]] | 6장 다양한 연관관계 매핑 | 다대다에서 연결 엔티티로 |
| [[03-exclusive-target-associations]] | 7장 고급 매핑 | 상속 매핑과의 대비 |
| [[04-proxies-and-lazy-loading]] | 8장 프록시와 연관관계 관리 | 프록시, 즉시·지연 로딩 |
| [[05-cascade-orphan-removal-vs-db-cascade]] | 8장 프록시와 연관관계 관리 | 영속성 전이, 고아 객체 |

## 3. 주제 → 노트 매핑

| 주제 | 노트 | 반영 |
|---|---|---|
| 참조 2개와 외래 키 1개의 불일치 | [[01-association-owner-and-mappedby]] | 반영 — 1절 |
| 연관관계 주인의 판정 근거 | [[01-association-owner-and-mappedby]] | 반영 — 1절 · 2.1 |
| `mappedBy`가 수동태라는 점 | [[01-association-owner-and-mappedby]] | 반영 — 1절 |
| 반대편 컬렉션이 SQL을 만들지 않는 이유 | [[01-association-owner-and-mappedby]] | 반영 — 2.1 |
| 편의 메서드의 두 줄이 하는 다른 일 | [[01-association-owner-and-mappedby]] | 반영 — 2.2 |
| 단방향을 기본으로 두는 판단 | [[01-association-owner-and-mappedby]] | 반영 — 2.3 |
| 양방향이 정당한 경우 | [[01-association-owner-and-mappedby]] | 반영 — 2.4 |
| `@ManyToMany`의 조인 테이블 가정 | [[02-join-entity-instead-of-many-to-many]] | 반영 — 1절 |
| 연결 엔티티 승격과 다대일 두 개 | [[02-join-entity-instead-of-many-to-many]] | 반영 — 1절 · 2.1 |
| 컬렉션을 두는 두 가지 정당한 이유 | [[02-join-entity-instead-of-many-to-many]] | 반영 — 2.2 |
| `@ManyToMany`를 일반적으로 피하는 이유 | [[02-join-entity-instead-of-many-to-many]] | 반영 — 2.3 |
| 배타적 연관을 표준 JPA가 못 다루는 이유 | [[03-exclusive-target-associations]] | 반영 — 1절 |
| 널 허용 `@ManyToOne` 두 개 | [[03-exclusive-target-associations]] | 반영 — 2.1 |
| `@Any`와 판별 컬럼, 제약 불가 | [[03-exclusive-target-associations]] | 반영 — 2.2 |
| 식별자만 매핑하는 선택지 | [[03-exclusive-target-associations]] | 반영 — 2.3 |
| 세 선택지 비교와 이 저장소의 결론 | [[03-exclusive-target-associations]] | 반영 — 2.4 |
| 읽는 쪽 분기를 엔티티에 가두기 | [[03-exclusive-target-associations]] | 반영 — 2.5 |
| 프록시의 생성과 초기화 순서 | [[04-proxies-and-lazy-loading]] | 반영 — 2.1 |
| `LazyInitializationException`의 조건 | [[04-proxies-and-lazy-loading]] | 반영 — 2.2 |
| 컨텍스트 없는 초기화가 세션을 새로 여는 동작 | [[04-proxies-and-lazy-loading]] | 반영 — 2.2 |
| fetch 기본값이 연관 종류마다 다른 점 | [[04-proxies-and-lazy-loading]] | 반영 — 2.3 |
| `getClass()`·`instanceof`가 깨지는 지점 | [[04-proxies-and-lazy-loading]] | 반영 — 2.4 |
| `getReference()`로 SELECT 아끼기 | [[04-proxies-and-lazy-loading]] | 반영 — 2.5 |
| 전이가 컨텍스트 통과 연산에만 걸리는 점 | [[05-cascade-orphan-removal-vs-db-cascade]] | 반영 — 2.1 |
| `REMOVE`와 `orphanRemoval`의 발동 조건 | [[05-cascade-orphan-removal-vs-db-cascade]] | 반영 — 2.2 |
| 소프트 삭제 설계에서의 선택 | [[05-cascade-orphan-removal-vs-db-cascade]] | 반영 — 2.3 |
| `@OnDelete`의 이득과 대가 | [[05-cascade-orphan-removal-vs-db-cascade]] | 반영 — 2.4 |

## 4. CosmoRoute 실제 코드와의 대조

읽기 전용으로 확인한 사실만 적었다.

| 확인한 사실 | 위치 | 쓰인 노트 |
|---|---|---|
| `Material.company`가 이 저장소의 **유일한** 연관관계 매핑 | `catalog/internal/Material.java:34-36` | 01 · 04 |
| 그 매핑에 `fetch = LAZY`와 `optional = false`가 명시됨 | 같은 위치 | 04 — 2.3 |
| `Company` 쪽에 역방향 컬렉션 없음 (단방향) | `catalog/internal/Company.java` 전수 | 01 — 2.3 |
| `material_substance`에 자체 PK `id` 존재 | `V1__initial_schema.sql:398` | 02 — 1절 |
| `canonical_id`(text)와 `provisional_id`(uuid) 타입이 다름 | 같은 파일 | 03 — 1절 |
| INV-9 CHECK `num_nonnulls(...) = 1` | 같은 파일 · `invariants.md` | 02 · 03 |
| INV-10 "발견/공급이 조인을 공유" | `docs/domain/invariants.md` | 02 — 1절 |
| `material_id`에 `ON DELETE CASCADE` | `V1__initial_schema.sql` | 05 — 1절 |
| 성분 쪽 외래 키가 `ON DELETE RESTRICT` | 같은 파일 | 05 — 2.3 |
| 성분은 수집 시스템 소유의 투영 (ADR-0001) | `docs/adr/0001-...md` | 03 · 05 |
| 소프트 삭제(`deleted_at`·`hidden_at`) 사용 | `V1__initial_schema.sql` | 05 — 2.3 |
| INV-8을 사전 검사 + 부분 유니크로 이중 강제 | `invariants.md` | 02 — 2.2 · 03 — 2.1 |
| `CompanyRepository`가 필터 없는 조회를 주지 않는 설계 | `catalog/internal/CompanyRepository.java` | 01 — 2.3 |
| 가시성을 읽기 시점에 계산 (ADR-0002) | `docs/adr/0002-...md` | 01 — 6절 |
| `Material.publish()`가 INV-13 도메인 게이트 | `invariants.md` | 02 — 2.2 · 03 — 2.5 |
| 실 PostgreSQL 테스트, H2 배제 | `api/build.gradle.kts` 주석 | 03 — 2.4 |

## 5. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "양방향으로 하면 양쪽에서 저장된다" | 반대편은 외래 키 판정에서 제외된다 | 01 — 2.1 |
| "부모가 주인이다" | 외래 키를 가진 쪽이 주인이다. 보통 자식이다 | 01 — 5절 |
| "다대다는 `@ManyToMany`로 매핑한다" | 조인 테이블이 순수한 두 외래 키일 때만 | 02 — 1절 |
| "`@Any`로 다형 연관을 깔끔하게 푼다" | 물리 외래 키를 걸 수 없어 공식 문서도 선호하지 않는다 | 03 — 2.2 |
| "LAZY로 하면 쿼리가 준다" | 미루는 것이지 안 읽는 것이 아니다. 접근하면 N+1 | 04 — 2.4 · 3절 |
| "`@ManyToOne`은 기본이 지연" | 기본은 **즉시**다. `@OneToMany`가 지연이다 | 04 — 2.3 |
| "DDL에 CASCADE가 있으면 JPA에도 걸어야 한다" | 다른 층이다. 벌크 삭제는 DDL만 적용된다 | 05 — 2.1 |
| "`cascade = ALL`이 편하다" | 쓰지 않는 `REMOVE`까지 켜진다 | 05 — 5절 |

## 6. 아직 다루지 않은 것

| 주제 | 넘긴 곳 |
|---|---|
| N+1의 정확한 발생 조건과 측정 | `chapter-j3-performance-and-transactions` |
| fetch join · `@EntityGraph` · batch size의 적용 조건 | `chapter-j3-performance-and-transactions` |
| `@Transactional` 전파와 프록시 AOP의 한계 | `chapter-j3-performance-and-transactions` |
| 격리 수준과 낙관적·비관적 락 | `chapter-j3-performance-and-transactions` |
| OSIV가 트랜잭션 경계를 미루는 방식 | `chapter-j3-performance-and-transactions` |
| 상속 매핑 전략 (`SINGLE_TABLE`·`JOINED`·`TABLE_PER_CLASS`) | 이 도메인에 상속 계층이 없어 보류 |
| 임베디드 타입과 값 타입 컬렉션 | 필요가 생길 때 |

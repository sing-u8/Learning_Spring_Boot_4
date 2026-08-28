# Chapter 3 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 3 *Querying for Data with Spring Boot*, 책 pp. 71–96 / PDF pp. 96–121. PDF를 `pdftotext -layout -f 96 -l 121`로 새로 추출해 1,219줄 전체를 읽은 뒤, 실제 제목·하위 제목·코드·Tip/Note를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

책의 상위 절은 6개다. 그중 두 곳이 실제 하위 제목을 갖고 있어 Chapter 1·2와 같은 기준으로 12개 노트로 나눴다.

| 원문 상위 절 | 실제 하위 제목 | 노트 |
|---|---|---|
| Adding Spring Data to an existing Spring Boot application | Using Spring Data to easily manage data / Adding Spring Data JPA to our project | `01`, `01a`, `01b` |
| DTOs, entities, and POJOs, oh my! | Entities / DTOs / POJOs | `02`, `02a`, `02b` |
| Creating repositories and declarative queries with Spring Data | — | `03` |
| Using custom finders | Sorting the results / Limiting query results | `04`, `04a`, `04b` |
| Using Query By Example to find tricky answers | — | `05` |
| Using custom JPA | — | `06` |

하위 제목이 없는 절은 쪼개지 않았다. `04`의 다중 필드 검색 상자 실습(책 pp. 84–87)은 원문에 별도 제목이 없어 `04` 안에 두었다.

| 노트 | 원문 절 | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-adding-spring-data-to-an-existing-application]] | Adding Spring Data to an existing Spring Boot application (저장소 선택) | 72–73 | 97–98 |
| [[01a-using-spring-data-to-easily-manage-data]] | Using Spring Data to easily manage data | 73–74 | 98–99 |
| [[01b-adding-spring-data-jpa-to-our-project]] | Adding Spring Data JPA to our project | 74–76 | 99–101 |
| [[02-dtos-entities-and-pojos]] | DTOs, entities, and POJOs, oh my! + DTOs | 76–79 | 101–104 |
| [[02a-entities-in-jpa]] | Entities | 77–78 | 102–103 |
| [[02b-pojos-and-the-spring-programming-model]] | POJOs | 79–80 | 104–105 |
| [[03-creating-repositories-and-declarative-queries]] | Creating repositories and declarative queries with Spring Data | 80–82 | 105–107 |
| [[04-using-custom-finders]] | Using custom finders | 82–87 | 107–112 |
| [[04a-sorting-the-results]] | Sorting the results | 87 | 112 |
| [[04b-limiting-query-results]] | Limiting query results | 87–89 | 112–114 |
| [[05-query-by-example-for-dynamic-search]] | Using Query By Example to find tricky answers | 89–93 | 114–118 |
| [[06-writing-custom-jpa-queries]] | Using custom JPA | 93–96 | 118–121 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 71 | 96 | 장 도입: Chapter 2 복습, 데이터 영속화의 필요, 다룰 6개 주제 목록 | [[_map]] | 반영 |
| 72 | 97 | 데모 압박 상황, 저장소 선택의 필요, 관계형이 Initializr 프로젝트의 약 80% | [[01-adding-spring-data-to-an-existing-application]] | 반영 |
| 72–73 | 97–98 | NoSQL 3종(Redis·MongoDB·Cassandra)의 성격, SQL의 스키마·키 제약, NoSQL의 완화와 트레이드오프, 관계형을 고르는 근거 | [[01-adding-spring-data-to-an-existing-application]] | 반영 |
| 73–74 | 98–99 | Spring Data의 접근: 저장소별 모듈 vs JDBC식 최소공통분모, template 4종, repository 추상화, QBE·Querydsl, 손으로 쓴 쿼리 | [[01a-using-spring-data-to-easily-manage-data]] | 반영 |
| 74–75 | 99–100 | Spring Data JPA와 H2 선택, Initializr EXPLORE 10단계 절차 | [[01b-adding-spring-data-jpa-to-our-project]] | 반영 |
| 75 | 100 | Maven 의존성 4개와 Boot 4의 test 지원 자동 포함·H2 세분화 서술 | [[01b-adding-spring-data-jpa-to-our-project]] | 반영 |
| 76 | 101 | `spring-boot-persistence` 모듈 이동, 기본값·프로퍼티 변경, 마이그레이션 가이드 Note | [[01b-adding-spring-data-jpa-to-our-project]] | 반영 |
| 76–77 | 101–102 | DTO·Entity·POJO 세 정의와 "도구가 강제하지 않는 패러다임"이라는 성격 | [[02-dtos-entities-and-pojos]] | 반영 |
| 77–78 | 102–103 | Entities: JPA 표준화, `@Entity` 강제, 다른 저장소의 entity, 프록시·flushing·캐싱, `VideoEntity` 코드와 4개 특징 | [[02a-entities-in-jpa]] | 반영 |
| 78 | 103 | 엔티티 모델링 참고서 Note | [[02a-entities-in-jpa]] | 반영 |
| 78–79 | 103–104 | DTOs: 웹 계층, Jackson 애노테이션, JSON 외 형식 Note, SRP, entity와 노출 필드의 차이, 두 이해관계자 | [[02-dtos-entities-and-pojos]] | 반영 |
| 79 | 104 | 단기 데모에서는 한 클래스가 둘을 겸해도 된다는 Tip | [[02-dtos-entities-and-pojos]] | 반영 |
| 79–80 | 104–105 | POJOs: Spring 이전 프레임워크의 상속 강제와 테스트 곤란, 빈+프록시로 횡단 관심사 적용, `TransactionTemplate` → `@Transactional`, POJO 논쟁 | [[02b-pojos-and-the-spring-programming-model]] | 반영 |
| 80–81 | 105–106 | "최고의 쿼리는 쓰지 않는 쿼리", repository 패턴 출처(Fowler), 도메인 말 ↔ 쿼리 말 번역, `VideoRepository` 코드 | [[03-creating-repositories-and-declarative-queries]] | 반영 |
| 81 | 106 | `Repository` marker interface와 컴포넌트 스캔 자동 등록 | [[03-creating-repositories-and-declarative-queries]] | 반영 |
| 81–82 | 106–107 | `JpaRepository` 연산 목록 4묶음, 상위 인터페이스 3종, 제네릭 `ID`/`T`/`S`, `Iterable`·`Example` | [[03-creating-repositories-and-declarative-queries]] | 반영 |
| 82 | 107 | 파생 finder `findByName`, 메서드 이름 파싱 규칙, 생성되는 SQL과 바인딩 | [[04-using-custom-finders]] | 반영 |
| 82 | 107 | SQL injection 공격과 바인딩이 막는 것 Tip | [[04-using-custom-finders]] | 반영 |
| 82–83 | 107–108 | 타입 안전성, 테이블·컬럼 이름 불필요, 방언 무관, 연산자 4묶음(And/Or/Between/LessThan…, StartingWith 계열, IgnoreCase/AllIgnoreCase, OrderBy) | [[04-using-custom-finders]] | 반영 |
| 83 | 108 | JPQL과 `%` 와일드카드, `Like`/`StartsWith`/`EndsWith`/`Containing`의 관계 Note | [[04-using-custom-finders]] | 반영 |
| 83–84 | 108–109 | 관계 탐색 `findByAddressZipCode`, 모호성과 밑줄 `findByAddress_ZipCode` | [[04-using-custom-finders]] | 반영 |
| 84 | 109 | 검색 상자 HTML form `/multi-field-search` | [[04-using-custom-finders]] | 반영 |
| 84–85 | 109–110 | `record VideoSearch`, `@PostMapping("/multi-field-search")` 컨트롤러 메서드와 4개 설명 | [[04-using-custom-finders]] | 반영 |
| 85–86 | 110–111 | 입력 조합 3가지 경우, `search(VideoSearch)` 시그니처, `StringUtils.hasText` 분기와 `findByNameContainsOrDescriptionContainsAllIgnoreCase` | [[04-using-custom-finders]] | 반영 |
| 86–87 | 111–112 | 단일 필드 분기 2개, `Collections.emptyList()`, "if 절이 좀 투박하다"는 저자의 자평 | [[04-using-custom-finders]] | 반영 |
| 87 | 112 | Sorting: 정적 `OrderBy` vs 호출자 결정 `Sort` 파라미터, fluent `Sort` API, `TypedSort` | [[04a-sorting-the-results]] | 반영 |
| 87–88 | 112–113 | Limiting: 10만 행 문제, `First`/`Top`, `FirstNNN`/`TopNNN`, `Distinct`, `Pageable` | [[04b-limiting-query-results]] | 반영 |
| 88 | 113 | 파생 `countBy`·`existsBy`·`deleteBy`와 예시 3개 | [[04b-limiting-query-results]] | 반영 |
| 88 | 113 | `EntityManager`·JPQL·SQL 변환 관계 Tip | [[04b-limiting-query-results]] | 반영 |
| 88–89 | 113–114 | 파생 finder의 근본적 한계: 기준이 작성 시점에 고정됨, 필드 추가 시 조합 폭발 | [[04b-limiting-query-results]] | 반영 |
| 89 | 114 | Query By Example의 동기: 요청마다 달라지는 기준 | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 89 | 114 | probe 생성과 `Example.of(probe)` 코드 | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 89–90 | 114–115 | `ExampleMatcher`: `matchingAll`/`matchingAny`, `withIgnoreCase`, `withStringMatcher(CONTAINING)` 3개 설명 | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 90 | 115 | `findOne(Example)`·`findAll(Example)` 사용, `QueryByExampleExecutor` 상속 Tip | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 90–91 | 115–116 | 통합 검색 상자 form `/universal-search`, `record UniversalSearch` | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 91–92 | 116–117 | `@PostMapping("/universal-search")` 컨트롤러, `search(UniversalSearch)` 서비스와 4개 설명 | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 92–93 | 117–118 | UI 한 번의 변경으로 백엔드가 따라간다는 평가, `null != null`과 `IsNull`/`IsNotNull` Tip | [[05-query-by-example-for-dynamic-search]] | 반영 |
| 93 | 118 | `@Query` JPQL, 위치 바인딩 `?1`, 메서드 이름 자유, `Sort` 적용 유지 | [[06-writing-custom-jpa-queries]] | 반영 |
| 93–94 | 118–119 | 다른 Spring Data 모듈의 `@Query`(MongoQL·CQL·N1QL), 파생 finder와 같은 동작의 `@Query` 대응 | [[06-writing-custom-jpa-queries]] | 반영 |
| 94 | 119 | 4개 테이블 JOIN `@Query`, 이름 있는 파라미터와 `@Param`, 등가 파생 finder의 길이 | [[06-writing-custom-jpa-queries]] | 반영 |
| 94 | 119 | 파생 finder와 `@Query` 사이 선택 기준 Tip (WHERE 수, 복잡한 JOIN 수) | [[06-writing-custom-jpa-queries]] | 반영 |
| 95 | 120 | `nativeQuery = true`, JSqlParser, 네이티브 SQL을 쓰는 두 가지 이유, JPQL vs SQL 숙련도 | [[06-writing-custom-jpa-queries]] | 반영 |
| 95 | 120 | AOT repository 생성과 `spring.aot.enabled` Tip | [[06-writing-custom-jpa-queries]] | 반영 |
| 96 | 121 | 네이티브 쿼리의 제약: 동적 정렬 불가, 페이징에 `countQuery` 필요, 연결·트랜잭션은 계속 관리됨 | [[06-writing-custom-jpa-queries]] | 반영 |
| 96 | 121 | Summary와 Chapter 4 예고 | [[_map]] | 반영 |

## 2. 코드·명령·설정 예제 커버리지

| # | 원문 예제 (책 쪽) | 노트 | 설명 보강 |
|---:|---|---|---|
| 1 | `spring-boot-starter-data-jpa` 의존성 (75) | [[01b-adding-spring-data-jpa-to-our-project]] | 무엇이 함께 들어오는지, Initializr가 좌표를 계산해 주는 이유 |
| 2 | `spring-boot-h2console` 의존성 (75) | [[01b-adding-spring-data-jpa-to-our-project]] | Boot 4에서 드라이버와 콘솔이 갈라진 이유, 공식 모듈 구성 확인 |
| 3 | `com.h2database:h2` `runtime` scope (75) | [[01b-adding-spring-data-jpa-to-our-project]] | `runtime` scope의 의미와 컴파일 의존을 막는 효과 |
| 4 | `spring-boot-starter-data-jpa-test` `test` scope (75) | [[01b-adding-spring-data-jpa-to-our-project]] | 공식 문서의 모듈 이름과 책 표기 차이를 명시 |
| 5 | `VideoEntity` 클래스 (77) | [[02a-entities-in-jpa]] | 애노테이션 3개, no-arg 생성자 요구의 이유, `id == null`이 INSERT를 뜻하는 이유 |
| 6 | `VideoRepository extends JpaRepository<VideoEntity, Long>` (80) | [[03-creating-repositories-and-declarative-queries]] | 제네릭 두 개의 의미, 구현체가 없는데 동작하는 경로 |
| 7 | `JpaRepository` 연산 목록 (81) | [[03-creating-repositories-and-declarative-queries]] | 4묶음으로 재분류하고 어느 상위 인터페이스에서 오는지 표기 |
| 8 | `List<VideoEntity> findByName(String name);` (82) | [[04-using-custom-finders]] | 이름 파싱 단계, 생성되는 JPQL/SQL, 파라미터 이름이 무관한 이유 |
| 9 | 연산자 목록 4묶음 (83) | [[04-using-custom-finders]] | 표로 재구성하고 각 묶음이 푸는 문제를 명시 |
| 10 | `findByAddressZipCode` / `findByAddress_ZipCode` (83–84) | [[04-using-custom-finders]] | 관계 탐색과 모호성 해소 규칙 |
| 11 | 다중 필드 검색 HTML form (84) | [[04-using-custom-finders]] | `name` 속성이 record 컴포넌트와 맞물리는 지점 |
| 12 | `record VideoSearch(String name, String description)` (84) | [[04-using-custom-finders]] | DTO로서의 역할, Chapter 2 `@ModelAttribute`와의 연결 |
| 13 | `@PostMapping("/multi-field-search")` 컨트롤러 (84–85) | [[04-using-custom-finders]] | 웹 계층 → 서비스 → repository 3단 흐름 |
| 14 | `search(VideoSearch)` 3중 분기 전체 (86–87) | [[04-using-custom-finders]] | 빈 문자열이 전체 매칭이 되는 함정, 분기 수가 늘어나는 규칙 |
| 15 | `Sort.by("name").ascending().and(...)` (87) | [[04a-sorting-the-results]] | 정렬 결정권을 누가 갖는지, 적용 순서 |
| 16 | `TypedSort<Video>` (87) | [[04a-sorting-the-results]] | 문자열 컬럼명의 위험과 타입 안전 대안 |
| 17 | 결과 제한 옵션 목록 (87–88) | [[04b-limiting-query-results]] | `First`/`Top` 계열과 `Pageable`의 차이 |
| 18 | `countByName` / `existsByDescription` / `deleteByTag` (88) | [[04b-limiting-query-results]] | SELECT가 아닌 파생 연산과 반환 타입 |
| 19 | probe + `Example.of(probe)` (89) | [[05-query-by-example-for-dynamic-search]] | probe가 "부분적으로 채운 도메인 객체"라는 성격 |
| 20 | `ExampleMatcher.matchingAll().withIgnoreCase().withStringMatcher(CONTAINING)` (90) | [[05-query-by-example-for-dynamic-search]] | 세 설정이 각각 SQL의 무엇으로 번역되는지 |
| 21 | 통합 검색 HTML form (91) | [[05-query-by-example-for-dynamic-search]] | 다중 필드 form과의 차이 |
| 22 | `record UniversalSearch(String value)` (91) | [[05-query-by-example-for-dynamic-search]] | 입력 하나로 여러 필드를 덮는 구조 |
| 23 | `@PostMapping("/universal-search")` 컨트롤러 (91) | [[05-query-by-example-for-dynamic-search]] | 다중 필드 handler와의 차이 4가지 |
| 24 | `search(UniversalSearch)` probe 조립 (92) | [[05-query-by-example-for-dynamic-search]] | `matchingAny`가 필요한 이유, if 분기가 사라진 자리 |
| 25 | `@Query("select v from VideoEntity v where v.name = ?1")` (93) | [[06-writing-custom-jpa-queries]] | 위치 바인딩, 메서드 이름이 의도를 담게 되는 변화 |
| 26 | 4-JOIN `@Query` + `@Param` (94) | [[06-writing-custom-jpa-queries]] | 이름 있는 파라미터, 등가 파생 finder 이름의 길이 비교 |
| 27 | `@Query(value=..., nativeQuery=true)` (95) | [[06-writing-custom-jpa-queries]] | JPQL과 SQL의 경계, JSqlParser의 역할, 제약 |

## 3. Tip·Note 커버리지

원문 박스는 12개다.

| # | 종류 | 책 쪽 | 내용 | 노트 |
|---:|---|---:|---|---|
| 1 | Note | 71 | 이 장의 소스는 저장소 `ch3` 폴더에 있다 | [[01-adding-spring-data-to-an-existing-application]] |
| 2 | Note | 76 | Boot 4의 `spring-boot-persistence` 모듈 이동, 기본값·프로퍼티 변경, 마이그레이션 가이드 | [[01b-adding-spring-data-jpa-to-our-project]] |
| 3 | Note | 78 | 엔티티 모델링은 이 책의 범위 밖. 참고서 안내 | [[02a-entities-in-jpa]] |
| 4 | Note | 78 | DTO는 JSON 전용이 아니다. XML 등 다른 교환 형식도 같은 필요를 갖는다 | [[02-dtos-entities-and-pojos]] |
| 5 | Tip | 79 | 단기 데모라면 한 클래스가 DTO와 entity를 겸해도 된다 | [[02-dtos-entities-and-pojos]] |
| 6 | Tip | 82 | SQL injection 공격이란 무엇이고 바인딩이 무엇을 막는가 | [[04-using-custom-finders]] |
| 7 | Note | 83 | JPQL은 컬럼이 아닌 엔티티 필드로 표현된다. `%` 와일드카드와 `Like` 계열의 관계 | [[04-using-custom-finders]] |
| 8 | Tip | 88 | Spring Data JPA가 실제로 쓰는 것은 JPQL이고 `EntityManager`가 SQL로 바꾼다 | [[04b-limiting-query-results]] |
| 9 | Tip | 90 | `JpaRepository`는 `QueryByExampleExecutor`에서 Example 연산을 상속받는다 | [[05-query-by-example-for-dynamic-search]] |
| 10 | Tip | 92–93 | 관계형 DB에서 `null`은 `null`과 같지 않다. `IsNull`/`IsNotNull` | [[05-query-by-example-for-dynamic-search]] |
| 11 | Tip | 94 | 파생 finder와 `@Query` 사이 선택 기준 | [[06-writing-custom-jpa-queries]] |
| 12 | Tip | 95 | AOT repository 생성과 `spring.aot.enabled` | [[06-writing-custom-jpa-queries]] |

## 4. 이미지·도표 판단

- `pdfimages -f 96 -l 121 -list` 결과 Chapter 3 범위의 raster 이미지는 PDF p.121의 4개뿐이며, 246×246 QR 코드와 144×33 로고(각각 smask 포함)다. 모두 Packt 혜택 안내용이라 학습 대상이 아니다.
- **따라서 이 Chapter에서는 책 이미지를 하나도 추출하지 않았다.** 본문의 시각 자료는 코드 리스팅과 Tip/Note 박스뿐이다.
- 개념 관계(저장소 선택 축, 세 객체의 계층 위치, 쿼리 작성 방식 4단계의 사다리)는 밝은 배경 Mermaid와 비교표로 재구성했다.

## 5. 공식 문서 교차 확인에서 보강한 점

PDF가 서술 순서의 1차 기준이고, Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)는 버전 민감한 동작을 확인하는 보조 근거로만 사용했다.

| 항목 | 책의 서술 | 노트의 보강 |
|---|---|---|
| `spring-boot-h2console` | 이름만 제시 | Boot 4의 실제 모듈이며 `com.h2database:h2`를 이미 api 의존성으로 갖는다는 구성을 확인. 책이 `h2`를 따로 또 넣는 이유를 경계로 설명 |
| `spring-boot-starter-data-jpa-test` | 이 이름으로 표기 | 공식 테스트 문서는 `@DataJpaTest`가 **`spring-boot-data-jpa-test` 모듈**에서 온다고 설명한다. 표기 차이를 명시하고 Initializr가 내주는 좌표를 그대로 쓰라고 안내 |
| `spring-boot-persistence` 모듈 | 이름과 "명시적·모듈화" 정도만 서술 | `PersistenceExceptionTranslationAutoConfiguration`과 `spring.persistence.exceptiontranslation.enabled` 프로퍼티라는 구체적 내용물 추가 |
| AOT repository | "`spring.aot.enabled=true`로 켠다" | 실제로는 **빌드 시점 AOT 처리**(`-Pnative` 프로파일 또는 `org.springframework.boot.aot` Gradle 플러그인)가 먼저 있어야 하고, `spring.aot.enabled`는 그렇게 만든 JAR을 **실행할 때** 주는 시스템 프로퍼티(`java -Dspring.aot.enabled=true -jar`)임을 명시 |
| 스키마 생성 | 언급 없음 | H2로 예제가 도는 것은 JPA/Hibernate의 자동 DDL 동작 덕분이며, 실제 DB에서는 이 가정이 성립하지 않는다는 경계를 추가 |

## 6. 완료 기준

- [x] 책의 모든 상위 절과 실제 하위 절이 최소 한 노트에 매핑됨
- [x] 27개 코드·설정 예제가 전부 노트에 반영되거나 의미가 보존된 형태로 재구성됨
- [x] Tip·Note 12건의 기술적 내용이 관련 노트에 반영됨
- [x] PDF 내 raster 이미지 존재 여부를 실제 검사하고 미추출 근거를 남김
- [x] 버전 민감한 동작을 Spring Boot 4.1.0 공식 문서와 교차 확인함

## 공식 문서 대조 검증 (2026-08-29)

> 이 챕터는 `part-0-jpa-foundations`(j1~j3)와 주제가 겹친다. 그 트랙은 Hibernate·Spring Data 공식 문서를 1차 소스로 쓰고 이미 전수 검증을 마쳤으므로, **두 트랙이 같은 것을 다르게 말하는 곳**을 찾는 방식으로 대조했다.

### 찾아 고친 것 1건 — 트랙 간 모순

| # | 위치 | 처음에 쓴 것 | 실제 |
|---|---|---|---|
| 1 | `02a` §2.3 | 관리 상태 엔티티를 *"영속성 계층이 **프록시로 감싸 상태를 감시**한다"*, 필드 변경 시 *"변경이 **기록된다**"* | **둘 다 틀렸다.** 관리 엔티티는 프록시가 아니라 원본 객체이고, JPA는 감시하지 않는다. 변경 감지는 **플러시 시점의 스냅숏 비교**다. 프록시는 **지연 로딩**용이다 |

**같은 저장소가 정반대를 말하고 있었다.**

| 위치 | 서술 |
|---|---|
| 이 챕터 `02a` §2.3 (수정 전) | "프록시로 감싸 상태를 감시한다" |
| `part-0-jpa-foundations` j1 `03` §2.1 | "이 시점에 JPA는 **아무것도 하지 않는다** — 엔티티는 **평범한 자바 객체**이고, 값이 바뀌었다고 **알려 줄 방법이 없기** 때문이다" |

**왜 중요한가.** 스냅숏 방식이라서 **관리 엔티티가 많을수록 플러시 비용이 는다** — 전부 순회하며 필드 단위로 비교하기 때문이다. 프록시 감시 모델을 믿으면 그 비용이 어디서 오는지 설명할 수 없다. 더티 체킹 vs 프록시는 면접 단골 구분이기도 하다.

**부수적으로 드러난 것.** §2.3은 요구 다섯 개를 일생의 각 단계에 대응시키는데, 3번을 *"프록시가 필요한 지점"*이라 적으면서 정작 §2.2의 요구 목록에는 **프록시 관련 항목이 없다.** 끊어진 참조였다. 3번을 스냅숏 복사로, 5번을 `@Id`와 연결하도록 고쳤다.

### 검증 방법에 대한 기록

이 챕터는 앞서 **grep 교차 검색만으로 "0건"이라 보고했던 곳**이다. 실제로 `§2` 본문을 읽자 위 1건이 나왔다. `프록시`라는 단어는 j2와 Ch3 양쪽에 정상적으로 등장하므로 **grep으로는 걸리지 않는다** — 문장이 무엇을 주장하는지 읽어야 보인다. 패턴 검색은 스크리닝이지 검증이 아니라는 사례로 남긴다.

### 정정 0건으로 확인한 것

| 확인한 것 | 결과 |
|---|---|
| `06` §2.6 네이티브 쿼리로 내려갈 때 꺼지는 것 | `Sort` 미적용·`countQuery` 필요·방언 의존을 정확히 구분하고, **연결·트랜잭션 관리는 유지된다**는 점까지 옳게 적는다 |
| `01b` §2.5 `spring-boot-persistence` 모듈 | 책이 이름만 말한 것을 **출처를 밝히고** 보강했다(`PersistenceExceptionTranslationAutoConfiguration`, `spring.persistence.exceptiontranslation.enabled`). 책 밖 내용을 덧붙일 때의 모범 형태 |
| `02` §6 엔티티를 그대로 JSON으로 내보낼 때 | 지연 로딩 연관 직렬화와 순환 참조 위험을 짚는다. `part-0-spring-core-internals` c3 `04`의 같은 경고와 일치 |
| `02a` §2.2 요구 다섯 개의 근거 | `protected` 무인자 생성자를 "프레임워크에는 열고 일반 코드에는 닫는 절충"으로 설명한다. 정확하다 |

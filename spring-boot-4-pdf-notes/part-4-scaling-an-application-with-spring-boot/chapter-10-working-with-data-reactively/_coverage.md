# Chapter 10 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 10 *Working with Data Reactively*, 책 pp. 281–294 / PDF pp. 306–319. PDF를 `pdftotext -layout -f 306 -l 319`로 새로 추출해 603줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

인쇄된 상위 절은 **4개**, 2단계 하위 제목은 **3개**(전부 §4 아래), 3단계는 **없다**. 이 장은 책에서 가장 짧은 축(14쪽)이고 코드 예제도 8개뿐이지만, §4가 **초기화 → API → 템플릿**이라는 세 단계를 각각 하위 제목으로 인쇄하고 있어 그 셋을 분할선으로 삼아 4 → **6개**로 늘렸다.

§4의 도입부(두 문장)는 별도 노트로 만들지 않고 첫 하위 제목과 합쳤다. "이 절에서 Spring Data R2DBC로 관계형 데이터를 리액티브하게 다룬다. **데이터베이스 초기화와 샘플 데이터 적재부터 시작한다**"가 곧 `Loading data with R2dbcEntityTemplate`의 예고이기 때문이다.

**기존 초안 4개 중 3개는 파일 이름을 유지했고, 하나만 rename했다.** `04-connecting-reactive-data-to-api-and-templates.md` → `04-loading-data-with-r2dbcentitytemplate.md`. API·템플릿 연결이 `04a`·`04b`로 분리되면서 원래 이름이 실제 내용과 어긋나게 됐기 때문이다. rename 전에 저장소 전체를 읽기 전용으로 확인해 **Ch10 밖의 inbound 링크가 0건**임을 확인했다(참조 3건은 모두 이번에 전면 재작성하는 Ch10 자신의 노트와 glossary였다). Ch9는 이 장의 `01`·`02`만 참조하며 그 이름은 유지했다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-what-reactive-data-access-requires]] | Learning what it means to fetch data reactively | 282–283 | 307–308 |
| [[02-choosing-r2dbc-and-a-reactive-data-store]] | Picking a Reactive data store | 283–285 | 308–310 |
| [[03-creating-reactive-repositories-and-r2dbc-access]] | Creating a Reactive data repository | 285–287 | 310–312 |
| [[04-loading-data-with-r2dbcentitytemplate]] | Working with R2DBC (도입) + Loading data with R2dbcEntityTemplate | 287–289 | 312–314 |
| [[04a-returning-data-reactively-to-an-api-controller]] | Returning data reactively to an API controller | 289–291 | 314–316 |
| [[04b-reactively-dealing-with-data-in-a-template]] | Reactively dealing with data in a template | 292–294 | 317–319 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 281 | 306 | 장 도입 — 앞 장에서 WebFlux 컨트롤러·Thymeleaf·JSON·HATEOAS를 만들었지만 **전부 통조림 인메모리 데이터**가 뒷받침했다. 이번 장에서 리액티브 데이터 계층을 들여 **end-to-end 리액티브**를 완성한다. 다룰 4개 주제 | [[_map]] | 반영 |
| 281 | 306 | Note: 소스는 저장소 `ch10` 폴더 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 282 | 307 | 앞 장에서 리액티브 웹 페이지의 기본은 다뤘지만 **결정적 재료가 빠졌다 — 진짜 데이터.** 진짜 데이터는 데이터베이스에서 온다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | 데이터베이스를 안 쓰는 애플리케이션은 드물고, 전 세계를 상대하는 전자상거래 시대에 관계형·key-value·document 등 선택지가 어느 때보다 넓다. 그래서 고르기가 까다롭고, **데이터베이스조차 리액티브하게 접근해야 한다**는 점 때문에 더 어렵다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | 앞 장과 같은 리액티브 전술로 접근하지 않으면 **모든 노력이 헛수고**가 된다. 핵심 반복 — **시스템의 모든 부분이 리액티브여야 한다.** 아니면 블로킹 호출이 스레드를 붙들어 처리량을 망가뜨린다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | Project Reactor는 기본 thread pool 크기를 **머신의 CPU 코어 수와 같게** 잡는다. context switching이 비싸기 때문이며, 코어보다 스레드가 많지 않으면 **스레드를 중단하고 상태를 저장하고 다른 스레드를 깨워 상태를 복원하는 일이 아예 없다** | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | 그 비싼 연산을 없앤 덕에 리액티브 앱은 **Reactor 런타임으로 돌아가 다음 작업을 집는** 더 효과적인 전술에 집중한다 — work stealing. 다만 이는 **Reactor의 `Mono`·`Flux`와 그 연산자를 쓸 때만** 가능하다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | 원격 DB에 블로킹 호출을 하면 스레드 전체가 답을 기다리며 멈춘다. **4코어 머신에서 코어 하나가 그렇게 막히면 즉시 25% 처리량 하락** | [[01-what-reactive-data-access-requires]] | 반영 |
| 282 | 307 | 그래서 MongoDB·Neo4j·Apache Cassandra·Redis 등 여러 DB가 **Reactive Streams 명세를 쓰는 대체 드라이버**를 구현하고 있다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 282–283 | 307–308 | 리액티브 드라이버란 무엇인가 — 드라이버는 연결을 열고, 질의를 파싱하고, 명령으로 바꾸고, 결과를 호출자에게 되돌린다. Reactive Streams 기반 프로그래밍의 인기가 벤더들이 리액티브 드라이버를 만들게 했다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 283 | 308 | **그런데 막힌 영역이 하나 있다 — JDBC.** Java에서 관계형 DB와 말하는 모든 툴킷·드라이버·전략이 JDBC를 지난다. jOOQ·JPA·MyBatis·QueryDSL이 **전부 밑에서 JDBC를 쓴다.** JDBC가 블로킹이므로 리액티브 시스템에서 동작하지 않는다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 283 | 308 | Note: **"JDBC 전용 thread pool을 떼어 내고 앞에 reactor 친화 프록시를 두면 안 되나?"** 요청마다 pool에 넘길 수는 있지만 **pool 한계에 부딪힐 위험**이 있다. 그 순간 다음 리액티브 호출이 스레드가 나기를 기다리며 막혀 **시스템 전체를 망가뜨린다.** 리액티브의 요점은 막지 않고 양보해 다른 일이 되게 하는 것이다. **thread pool은 불가피한 것을 미룰 뿐이고 context switching 비용까지 물린다.** 드라이버는 **DB 엔진과 말하는 지점까지** Reactive Streams를 해야 한다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 283 | 308 | 문제의 본질 — **JDBC는 드라이버가 아니라 명세**다. Java가 관계형 DB와 어떻게 말하는지를 정의하며 그 명세가 **본질적으로 블로킹**이다. 그 위에 세워진 모든 드라이버가 이 모델을 따르므로 리액티브 논블로킹 시스템과 호환되지 않는다 | [[01-what-reactive-data-access-requires]] | 반영 |
| 283 | 308 | JDBC가 Reactive Streams를 지원하도록 충분히 바뀔 수 없음을 인식하고, 리액티브로 가고 싶어 하는 Spring 사용자 커뮤니티를 위해 Spring 팀이 **2018년** 새 해법에 착수해 **R2DBC 명세**를 초안했다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 283 | 308 | R2DBC는 명세로서 **2022년 4월 1.0**에 도달했고 이 장 나머지는 이것으로 리액티브 관계형 데이터를 다룬다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 283 | 308 | 아주 단순한 것을 원하므로 **H2**를 고른다 — 인메모리·임베더블 관계형 DB. 흔히 테스트용이지만 이 장에서는 production DB의 대역으로 쓴다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 284 | 309 | H2와 함께 **Spring Data R2DBC**를 쓴다. start.spring.io에서 앞 장과 같은 Boot 버전·메타데이터에 의존성 2개(H2 Database, Spring Data R2DBC)를 고르고 EXPLORE로 pom을 본다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 284–285 | 309–310 | pom 좌표 4개와 각각의 역할 — `spring-boot-starter-data-r2dbc`·`h2`·`r2dbc-h2`·`spring-boot-starter-data-r2dbc-test`. **`h2`는 DB 자체, `r2dbc-h2`는 그 DB와 리액티브로 말하는 드라이버** | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 285 | 310 | Note: **`spring-boot-h2console`(H2 Console)은 포함하지 않는다.** 이 애플리케이션이 WebFlux + Spring Data R2DBC를 쓰기 때문이다. 추가하면 **servlet/JDBC 가정이 예제에 들어온다.** DB 확인에는 DBeaver·DataGrip 같은 외부 클라이언트를 쓴다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 285 | 310 | **R2DBC는 매우 저수준**이다. 근본적으로 **드라이버 작성자가 구현하기 쉽게** 하는 것이 목표다. JDBC의 드라이버 인터페이스 측면 일부가 애플리케이션이 소비하기 쉽도록 타협됐는데 R2DBC는 그것을 바로잡으려 했다. **결과적으로 애플리케이션이 R2DBC로 직접 말하는 것은 상당히 번거롭다** | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 285 | 310 | 그래서 툴킷 사용이 권장된다. 이 책은 Spring Data R2DBC를 쓰지만 Spring Framework의 `DatabaseClient`나 서드파티를 써도 된다 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 285 | 310 | Chapter 3에서 `JpaRepository`를 확장해 읽기 쉬운 repository를 만들었다. Spring Data R2DBC에서는 `ReactiveCrudRepository<Employee, Long>`을 확장한다 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 286 | 311 | 항목별 4개 설명 — `EmployeeRepository`(런타임에 구현이 자동 생성), **`ReactiveCrudRepository`**(Spring Data Commons 인터페이스, `save`·`findById`·`findAll`·`delete`를 **리액티브 타입으로** 반환, **R2DBC 전용이 아니라 리액티브 Spring Data 모듈이 공유**), `Employee`(도메인 타입), `Long`(기본 키 타입) | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 286 | 311 | 앞 장의 `Employee`는 `record Employee(String name, String role)`이었다. **단순 데이터 운반자일 때는 충분**했지만 Spring Data R2DBC로 DB와 상호작용하려면 조금 더 풍부한 표현이 필요하다 — 특히 **DB 기본 키에 대응하는 식별자 필드** | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 286–287 | 311–312 | 확장된 record — `@Id Long id` 추가, `id` 없이 만드는 **추가 생성자**. 항목별 3개 설명. **`@Id`는 JPA의 `jakarta.persistence.Id`가 아니라 Spring Data Commons 애노테이션**이며 R2DBC를 포함한 여러 모듈에서 쓴다 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 287 | 312 | `equals`·`hashCode`·`toString`·접근자는 record가 자동 생성해 도메인 타입을 간결하게 유지하면서도 Spring Data 매핑 인프라와 완전히 호환된다 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 287 | 312 | §4 도입 — Spring Data R2DBC로 관계형 데이터를 리액티브하게 다룬다. **데이터베이스 초기화와 샘플 데이터 적재부터 시작한다** | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 287 | 312 | 데이터를 가져오려면 먼저 DB를 채워야 한다. 실제로는 DBA나 마이그레이션 도구가 하지만, 여기서는 **애플리케이션 시작 시 자동 실행되는 Spring 컴포넌트**로 직접 초기화한다 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 287–288 | 312–313 | `Startup` 클래스의 `@Configuration` + `@Bean CommandLineRunner initDatabase(R2dbcEntityTemplate template)` 골격과 항목별 5개 설명 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 288 | 313 | Spring Data R2DBC를 쓰므로 **스키마를 직접 정의해야 한다.** 외부에 정의돼 있지 않으면 프로그래밍 방식으로 만들고 리액티브 파이프라인으로 샘플 데이터를 싣는다 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 288–289 | 313–314 | `getDatabaseClient().sql(CREATE TABLE ...).fetch().rowsUpdated().thenMany(insert...).subscribe()` 전문과 항목별 **8개** 설명 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 289 | 314 | `subscribe()` — **리액티브 스트림은 게으르므로 구독자가 붙기 전에는 어떤 연산도 실행되지 않는다** | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 289 | 314 | 이 방식은 초기화 과정 전체를 완전히 리액티브로 유지한다. 스키마 생성과 insert가 **하나의 파이프라인으로 조합**되어 각 단계가 순차 실행됨을 보장한다 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 289 | 314 | 무거운 일은 끝났다. 여기서부터는 앞 장에서 배운 것을 활용한다. `ApiController` 골격과 항목별 2개 설명 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 290 | 315 | 가장 단순한 것은 모든 `Employee`를 반환하는 것 — `Flux<Employee> employees()`가 `repository.findAll()` 하나. 항목별 3개 설명 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 290 | 315 | 앞 장은 Java `Map`이라 리액티브하게 만들려면 **손질(finagling)**이 필요했다. `EmployeeRepository`가 `ReactiveCrudRepository`를 확장하므로 **메서드 반환 타입에 리액티브 타입이 이미 구워져 있다 — 손질이 필요 없다** | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 290–291 | 315–316 | POST 메서드 — `newEmployee.flatMap(e -> { new Employee(e.name(), e.role()); return repository.save(...); })`와 항목별 5개 설명. **입력의 `id`를 의도적으로 버려** 완전히 새 항목이 만들어지게 한다 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 291 | 316 | **왜 `flatMap`인가** — 매핑은 보통 타입 변환에 쓴다. 여기서도 들어온 `Employee`를 저장된 `Employee`로 바꾸려는 것이니 `map`이면 될 것 같다. **그런데 `save()`가 돌려준 것은 `Employee`가 아니라 `Mono<Employee>`였다.** `map`했다면 `Mono<Mono<Employee>>`가 됐을 것 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 291 | 316 | Note: **무엇을 할지 모르겠거나 Reactor API가 나를 방해하는 것 같을 때, 비밀은 대개 `flatMap()`이다.** 모든 Reactor 타입이 `flatMap`을 지원하도록 심하게 오버로드돼 있어 `Flux<Flux<?>>`·`Mono<Mono<?>>`와 그 모든 조합이 `flatMap()`만 걸면 잘 풀린다. Reactor의 `then()` 연산자를 쓸 때도 마찬가지 — **`then()` 앞에 `flatMap()`을 쓰면 대개 이전 단계가 수행됨을 보장**한다 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 292 | 317 | `HomeController` 골격과 `@Controller`·생성자 주입 설명 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 292 | 317 | `Mono<Rendering> index()` — **앞 장의 `index()`와 거의 같고 강조 부분만 다르다.** `repository.findAll()`이 이미 `Flux`를 주므로 **map의 값을 `Flux`로 변환하는 과정이 사라졌다.** 나머지는 전부 동일 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 293 | 318 | 폼 기반 `Employee` bean을 처리하는 POST 메서드 — `flatMap`으로 저장하고 `map`으로 `"redirect:/"`로 변환. 항목별 3개 설명 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 293 | 318 | **앞 장과 비교해 중요한 점 — 여기서는 단계를 나눴다.** 앞 장은 들어온 `Employee`를 redirect 요청으로 그냥 map했다. **가짜 DB가 비리액티브라 명령형 호출 하나면 됐기 때문**이다. 이 장의 repository는 리액티브라 **`save()` 하나, 그 결과를 redirect로 바꾸는 것 하나로 나눠야** 한다 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 293 | 318 | 그리고 `save()`의 응답이 Reactor `Mono`에 감싸여 있어 **`flatMap`을 써야 했다.** employee를 `"redirect:/"`로 바꾸는 데는 Reactor 타입이 관여하지 않으므로 **단순 `map`이면 충분**하다 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 294 | 319 | `index.html` 템플릿은 **앞 장에서 그대로 복사**하면 된다. 같은 파일이라 여기 다시 싣지 않는다 — **변경 없음** | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 294 | 319 | Summary — 리액티브 데이터 조회의 의미, 리액티브 데이터 스토어 선택, Spring Data 활용, 리액티브 웹 컨트롤러 연결, R2DBC. **앞 장들의 배포 전술이 그대로 통하고** 이 책에서 쓴 많은 기능도 그대로 동작한다. 다음 장은 **경량 스레드 기반의 또 다른 모델** | [[_map]] | 반영 |
| 319 | 319 | 책 PDF 다운로드 QR 안내 | — | 학습 무관, 제외 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | pom 좌표 4개 (r2dbc starter·h2·r2dbc-h2·r2dbc-test) | 284 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 2 | `EmployeeRepository extends ReactiveCrudRepository<Employee, Long>` | 285 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 3 | 앞 장의 `record Employee(String name, String role)` | 286 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 4 | `@Id Long id`를 더한 확장 record + 보조 생성자 | 286 | [[03-creating-reactive-repositories-and-r2dbc-access]] | 반영 |
| 5 | `Startup` 클래스 골격 (`CommandLineRunner` + `R2dbcEntityTemplate`) | 287 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 6 | `CREATE TABLE EMPLOYEE` + 3건 insert 리액티브 파이프라인 | 288–289 | [[04-loading-data-with-r2dbcentitytemplate]] | 반영 |
| 7 | `ApiController` 골격 (생성자 주입) | 289 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 8 | `Flux<Employee> employees()` — `repository.findAll()` | 290 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 9 | `Mono<Employee> add(@RequestBody Mono<Employee>)` — `flatMap` + `save` | 290–291 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |
| 10 | `HomeController` 골격 | 292 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 11 | `Mono<Rendering> index()` — `repository.findAll().collectList()` | 292 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |
| 12 | `Mono<String> newEmployee(@ModelAttribute Mono<Employee>)` — `flatMap` → `map` | 293 | [[04b-reactively-dealing-with-data-in-a-template]] | 반영 |

## 3. Tip / Note 블록 → 노트 매핑

| # | Note 내용 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | 소스는 저장소 `ch10` 폴더 | 281 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 2 | JDBC thread pool + 리액터 프록시가 왜 안 되는가 — pool 한계·불가피한 것의 지연·context switching 비용 | 283 | [[01-what-reactive-data-access-requires]] | 반영 |
| 3 | H2 Console을 넣지 않는 이유 — servlet/JDBC 가정이 들어온다. DBeaver·DataGrip을 쓴다 | 285 | [[02-choosing-r2dbc-and-a-reactive-data-store]] | 반영 |
| 4 | 막히면 `flatMap()`이 대개 답이다. `then()` 앞의 `flatMap()`도 | 291 | [[04a-returning-data-reactively-to-an-api-controller]] | 반영 |

## 4. Figure 처리 판단

`pdfimages -f 306 -l 319 -list` 결과 이 범위의 raster는 **PDF p.319의 246×246 QR 코드와 144×33 로고(각각 smask 포함) 4개뿐**이며 전부 Packt 혜택 안내다. **따라서 책 이미지를 하나도 추출하지 않았고 `_assets/`도 만들지 않았다.** 이 장에는 학습 대상 Figure가 애초에 없다 — 본문에도 Figure 번호가 한 번도 등장하지 않는다. Ch3와 같은 상황이다.

## 5. 원문의 오류·공백 (노트에 명시)

| # | 원문 | 실제 | 노트 반영 |
|---:|---|---|---|
| 1 | p.291 POST 메서드 코드의 닫는 중괄호 앞에 **`});f`** — `f` 한 글자가 붙어 있다 | `});`. 그대로 복사하면 컴파일되지 않는다 | [[04a-returning-data-reactively-to-an-api-controller]] §5 |
| 2 | p.293 템플릿용 POST 메서드가 **`e.getName()`·`e.getRole()`**을 호출한다 | `Employee`는 **record**이므로 접근자는 `e.name()`·`e.role()`이다. 같은 장 p.290의 API용 POST는 올바르게 `e.name()`을 쓴다 — **같은 타입에 두 가지 접근자 문법이 섞여 있다** | [[04b-reactively-dealing-with-data-in-a-template]] §5 |
| 3 | p.288 `CommandLineRunner`를 `@Configuration` 클래스의 `@Bean`으로 등록한다 | 동작하지만, 이 초기화는 **`@Bean` 안에서 `subscribe()`를 직접 불러 결과를 버린다.** 예외가 나도 애플리케이션은 정상 기동하고 **테이블이 없는 채로 서비스가 뜬다.** 리액티브에서 `subscribe()`를 인자 없이 부르는 것은 오류 처리를 포기하는 것이다 | [[04-loading-data-with-r2dbcentitytemplate]] §5 |
| 4 | p.282 "4코어 중 하나가 막히면 **즉시 25% 처리량 하락**" | Ch9 p.263과 같은 계산이며 같은 이유로 **낙관적 하한**이다. 이벤트 루프에 고정 배정된 연결이 함께 멈추므로 실제 영향은 더 클 수 있다 | [[01-what-reactive-data-access-requires]] §5 |
| 5 | p.285 "R2DBC는 매우 저수준이라 직접 쓰면 번거롭다"고 하고 **툴킷을 쓰라**고 한다 | 그런데 바로 다음 절의 초기화 코드가 `template.getDatabaseClient().sql(...)`로 **결국 저수준 `DatabaseClient`를 직접 쓴다.** 스키마 정의만은 툴킷이 덮어 주지 않는 영역이라는 사실이 명시되지 않는다 | [[04-loading-data-with-r2dbcentitytemplate]] §5 |
| 6 | p.294 "`index.html`은 앞 장에서 그대로 복사하면 된다 — 변경 없음" | 맞지만, 앞 장 템플릿의 `th:field="*{name}"`은 record 접근자에 의존한다. 위 #2의 `getName()` 오류와 합치면 **어느 쪽이 맞는지 독자가 판단해야 하는 상태**로 장이 끝난다 | [[04b-reactively-dealing-with-data-in-a-template]] §5 |

## 6. 공식 문서 대조 검증 (2026-08-29)

> 이 챕터의 최초 검증(§5)은 **책이 틀렸나**를 봤다. 이 절은 그 위층 — **노트가 책을 넘어 주장한 것**과 **책의 주장이 공식 문서와 어긋나는지** — 를 대조한 기록이다.

| 대조한 문서 | URL |
|---|---|
| Reactor Core Reference — Threading and Schedulers | `https://projectreactor.io/docs/core/release/reference/coreFeatures/schedulers.html` |
| Spring Framework Reference — WebFlux Concurrency Model | `https://docs.spring.io/spring-framework/reference/web/webflux/new-framework.html` |

### 결과 — 정정 0건

- `01` §2.5의 thread-pool 프록시 반박(5단계 논증)은 공식 문서의 동시성 모델 서술과 일치한다.
- `01` §2.2의 "25%"는 **책의 계산으로 명시**돼 있고, 같은 수치를 다루는 `chapter-9`의 서술에는 낙관적 하한이라는 단서가 붙어 있다.
- `01` §2.6의 "JDBC는 드라이버가 아니라 명세다"는 과장이 아니다 — `ResultSet.next()`의 반환 계약이 근거다.
- **`chapter-9`에서 정정한 "Scheduler가 기본" 혼동이 이 챕터에는 없다**(전수 검색으로 확인).

**0건이 "검사하지 않았다"가 아니라 "대조했고 어긋난 곳을 못 찾았다"임을 구분해 적는다.**

# Chapter 3 용어집

> Chapter 3에서 사용하는 전문 용어의 정의 원본이다. 개념 노트는 첫 등장 때 `**[[용어]]**(= 한 줄 풀이)` 형태로 여기를 링크하고, 정의 자체는 이 파일에만 둔다. 앞 Chapter에서 이미 나온 말이라도 Chapter 3 노트에서 링크하려면 여기에 다시 정의가 있어야 하므로, 그런 항목은 Chapter 3 문맥에 맞춰 다시 적었다.

## Spring-Data (Spring Data)
데이터 접근 코드를 줄이기 위한 Spring 프로젝트군이다. 저장소마다 별도 모듈이 있고, 각 모듈이 그 저장소의 성격에 맞춘 template과 repository 추상화를 제공한다. 하나의 공통 API로 모든 저장소를 덮으려 하지 않는다는 점이 설계의 핵심이다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[JPA]], [[리포지토리]]

## 관계형-데이터베이스 (relational database)
데이터를 행과 열로 이루어진 표에 저장하고, 표 사이의 관계를 키로 표현하는 저장소다. 구조를 미리 정의하고 제약을 강제하는 대신 강한 트랜잭션 보장을 준다. Oracle·MySQL·PostgreSQL이 대표적이다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[NoSQL]], [[스키마]]

## NoSQL (NoSQL)
관계형 모델의 제약 일부를 완화한 저장소들을 묶어 부르는 말이다. 미리 스키마를 정하지 않아도 되거나, 레코드마다 필드가 달라도 되거나, 수평 확장과 지연 시간을 위해 일관성 수준을 조정할 수 있는 것들이 여기 속한다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[관계형-데이터베이스]], [[최종적-일관성]]

## 키-값-저장소 (key/value store)
키 하나에 값 하나를 대응시켜 저장하는 가장 단순한 저장 모델이다. 조회 경로가 짧아 매우 빠르다. Redis가 대표적이며 TTL·원자적 연산·집계용 자료구조를 함께 제공한다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[문서-저장소]], 캐시

## 문서-저장소 (document store)
JSON 같은 중첩 구조 문서를 통째로 하나의 레코드로 저장하는 모델이다. 여러 단계로 중첩된 데이터를 조인 없이 한 번에 읽을 수 있다. MongoDB가 대표적이다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[키-값-저장소]], [[스키마]]

## 최종적-일관성 (eventual consistency)
쓰기 직후에는 노드마다 값이 다를 수 있지만 시간이 지나면 모두 같은 값으로 수렴한다는 보장이다. 모든 복제본의 즉시 일치를 포기하는 대신 지연 시간과 가용성을 얻는다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[ACID]], 정족수 읽기

## ACID (Atomicity, Consistency, Isolation, Durability)
트랜잭션이 지켜야 할 네 가지 성질이다. 전부 되거나 전부 안 되고(원자성), 제약을 깨지 않고(일관성), 동시 실행이 서로를 방해하지 않으며(격리성), 완료된 것은 사라지지 않는다(지속성).
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[최종적-일관성]], [[트랜잭션]]

## 스키마 (schema)
저장할 데이터의 구조를 미리 정의해 둔 것이다. 어떤 표에 어떤 열이 있고 각 열의 타입과 제약이 무엇인지를 담는다.
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-application]]
- 섞이는 말: [[엔티티]], 마이그레이션

## 최소공통분모-API (lowest common denominator API)
여러 구현체를 하나의 인터페이스로 덮을 때, 모든 구현이 공통으로 지원하는 기능만 노출하게 되는 설계다. 이식성은 얻지만 각 구현의 고유 강점은 API 밖으로 밀려난다.
- 처음 나온 곳: [[01a-using-spring-data-to-easily-manage-data]]
- 섞이는 말: [[템플릿]], JDBC

## 템플릿 (template)
특정 저장소의 기능을 직접 다루기 위한 Spring Data의 저수준 진입점이다. `RedisTemplate`·`MongoTemplate`처럼 저장소마다 따로 있으며 공통 상위 타입을 갖지 않는다. 자원 관리 같은 공통 관심사는 비슷하게 처리하되 연산은 각 저장소에 맞춘다.
- 처음 나온 곳: [[01a-using-spring-data-to-easily-manage-data]]
- 섞이는 말: [[리포지토리]], [[최소공통분모-API]]

## Querydsl (Querydsl)
Java 코드로 타입 안전한 쿼리를 조립하게 해 주는 외부 라이브러리다. Spring Data가 통합을 제공해 도메인 타입 정보를 재사용한 쿼리 작성을 지원한다.
- 처음 나온 곳: [[01a-using-spring-data-to-easily-manage-data]]
- 섞이는 말: [[Query-By-Example]], [[JPQL]]

## JPA (Java Persistence API, Jakarta Persistence)
Java 객체와 관계형 데이터베이스 표를 대응시키는 표준 명세다. `@Entity` 같은 애노테이션과 `EntityManager` API를 정의하며, Hibernate 같은 구현체가 실제 동작을 제공한다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[Spring-Data-JPA]], [[JPQL]]

## Spring-Data-JPA (Spring Data JPA)
JPA를 대상으로 하는 Spring Data 모듈이다. JPA 위에 repository 추상화와 쿼리 파생을 얹어, 인터페이스 선언만으로 쿼리가 만들어지게 한다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[JPA]], [[Spring-Data]]

## H2 (H2 Database)
Java로 작성된 JDBC 기반 관계형 데이터베이스다. 애플리케이션과 같은 프로세스 안에서 메모리에 띄울 수 있어 프로토타이핑과 테스트에 자주 쓴다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[내장-데이터베이스]], PostgreSQL

## 내장-데이터베이스 (embedded database)
별도 서버 프로세스 없이 애플리케이션 안에서 함께 뜨는 데이터베이스다. 설치와 기동이 필요 없는 대신 프로세스가 끝나면 데이터도 사라지는 것이 보통이다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[H2]], 외부 DB 서버

## JDBC (Java Database Connectivity)
Java에서 관계형 데이터베이스에 접속해 SQL을 실행하기 위한 표준 API다. 드라이버가 각 데이터베이스에 맞는 구현을 제공한다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[JPA]], [[최소공통분모-API]]

## 의존성-scope (dependency scope)
Maven에서 어떤 의존성이 컴파일·테스트·실행 중 어느 단계에 필요한지 표시하는 값이다. `runtime`은 컴파일에는 안 보이고 실행에만 필요하다는 뜻이고, `test`는 테스트 코드에만 쓰인다는 뜻이다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[스타터]], 전이 의존성

## 스타터 (starter)
어떤 기능을 쓰기 시작하는 데 필요한 의존성 묶음을 하나의 이름으로 제공하는 Maven/Gradle 아티팩트다. 스타터 자체에는 보통 코드가 거의 없고 필요한 라이브러리들을 전이 의존성으로 끌어온다.
- 처음 나온 곳: [[01b-adding-spring-data-jpa-to-our-project]]
- 섞이는 말: [[의존성-scope]], 자동 구성

## DTO (Data Transfer Object)
데이터를 옮기는 것이 목적인 클래스다. 보통 서버와 클라이언트 사이를 오가며, 외부에 노출할 필드만 담는다. 최신 Java에서는 record로 구현하는 경우가 많다.
- 처음 나온 곳: [[02-dtos-entities-and-pojos]]
- 섞이는 말: [[엔티티]], [[POJO]]

## 엔티티 (entity)
데이터 저장소에 저장하고 저장소에서 읽어 오는 것이 목적인 클래스다. JPA에서는 영속성 계층이 관리하며 식별자와 가변 상태에 의존한다. 그래서 불변인 record는 이 역할에 맞지 않는다.
- 처음 나온 곳: [[02-dtos-entities-and-pojos]]
- 섞이는 말: [[DTO]], [[영속성-계층]]

## POJO (Plain Old Java Object)
프레임워크 클래스를 상속하지도 않고 프레임워크가 강제하는 제약을 내부에 지니지도 않은 평범한 Java 객체다. 이름 자체가 "특별할 것 없는 그냥 Java 객체"라는 뜻으로 붙었다.
- 처음 나온 곳: [[02-dtos-entities-and-pojos]]
- 섞이는 말: [[DTO]], [[횡단-관심사]]

## 단일-책임-원칙 (single-responsibility principle, SRP)
한 클래스는 한 가지 일에 집중할 때 유지·변경이 쉬워진다는 설계 원칙이다. 바꿔 말하면 한 클래스를 고쳐야 하는 이유가 하나여야 한다는 뜻이다.
- 처음 나온 곳: [[02-dtos-entities-and-pojos]]
- 섞이는 말: [[DTO]], [[엔티티]]

## 영속성-계층 (persistence layer)
데이터 저장소와의 대화를 담당하는 계층이다. JPA에서는 이 계층이 엔티티의 생명주기와 변경 추적, 저장 시점을 관리한다.
- 처음 나온 곳: [[02a-entities-in-jpa]]
- 섞이는 말: [[엔티티]], [[서비스-계층]]

## 프록시 (proxy)
어떤 타입인 척하면서 호출을 가로채 부가 동작을 수행하는 객체다. JPA는 쿼리로 돌려준 엔티티를 프록시로 감싸 상태 변경을 추적하고, Spring은 빈을 프록시로 감싸 트랜잭션 같은 횡단 관심사를 적용한다.
- 처음 나온 곳: [[02a-entities-in-jpa]]
- 섞이는 말: [[플러시]], [[횡단-관심사]]

## 플러시 (flushing)
영속성 계층이 메모리에서 추적하던 엔티티의 변경을 실제 데이터베이스 문장으로 내보내는 일이다. 개발자가 `save`를 부르지 않아도 일어날 수 있다는 점이 JPA를 처음 쓸 때 놀라운 지점이다.
- 처음 나온 곳: [[02a-entities-in-jpa]]
- 섞이는 말: [[프록시]], [[트랜잭션]]

## 기본-키 (primary key)
표에서 각 행을 유일하게 식별하는 열이다. JPA에서는 `@Id`가 붙은 필드가 이 역할을 하며, 엔티티의 동일성 판단 기준이 된다.
- 처음 나온 곳: [[02a-entities-in-jpa]]
- 섞이는 말: [[키-생성-전략]], [[도메인-타입]]

## 키-생성-전략 (generated value)
기본 키 값을 누가 어떻게 만들지에 대한 정책이다. `@GeneratedValue`는 그 책임을 JPA 제공자에게 넘겨, 데이터베이스의 시퀀스나 자동 증가 컬럼을 쓰게 한다.
- 처음 나온 곳: [[02a-entities-in-jpa]]
- 섞이는 말: [[기본-키]], [[플러시]]

## 횡단-관심사 (cross-cutting concern)
여러 클래스에 공통으로 필요하지만 그 클래스들의 본업은 아닌 기능이다. 트랜잭션, 보안, 로깅, 캐시가 대표적이며 프록시로 바깥에서 감싸 적용한다.
- 처음 나온 곳: [[02b-pojos-and-the-spring-programming-model]]
- 섞이는 말: [[프록시]], [[POJO]]

## 트랜잭션 (transaction)
여러 데이터 변경을 하나의 단위로 묶어 전부 반영하거나 전부 되돌리는 장치다. Spring에서는 `@Transactional` 하나로 이 경계를 선언한다.
- 처음 나온 곳: [[02b-pojos-and-the-spring-programming-model]]
- 섞이는 말: [[ACID]], [[횡단-관심사]]

## 애플리케이션-컨텍스트 (application context)
Spring이 빈을 만들고 연결하고 생명주기를 관리하는 컨테이너다. 빈이 이 컨테이너에 등록되어 있기 때문에 프록시로 감싸 부가 기능을 넣을 자리가 생긴다.
- 처음 나온 곳: [[02b-pojos-and-the-spring-programming-model]]
- 섞이는 말: [[프록시]], [[서비스-계층]]

## 서비스-계층 (service layer)
웹이나 저장소 같은 바깥 기술에 매이지 않고 업무 동작 자체를 담당하는 계층이다. Chapter 2에서 만든 `VideoService`가 이 자리에 있으며, 이 장에서 그 안이 인메모리 목록에서 repository 호출로 바뀐다.
- 처음 나온 곳: [[02b-pojos-and-the-spring-programming-model]]
- 섞이는 말: [[리포지토리]], [[영속성-계층]]

## 리포지토리 (repository)
한 도메인 타입에 대한 데이터 연산을 한곳에 모으는 패턴이자 그 인터페이스다. 애플리케이션은 도메인 말로 리포지토리에 요청하고, 리포지토리가 그것을 저장소의 쿼리 말로 옮긴다.
- 처음 나온 곳: [[01a-using-spring-data-to-easily-manage-data]]
- 섞이는 말: [[템플릿]], [[쿼리-파생]]

## 쿼리-파생 (query derivation)
Spring Data가 저장소 메타데이터와 메서드 이름을 읽어 쿼리를 자동으로 만들어 내는 동작이다. 개발자가 쿼리 문자열을 쓰지 않아도 되게 하는 핵심 메커니즘이다.
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries]]
- 섞이는 말: [[파생-finder]], [[리포지토리]]

## 마커-인터페이스 (marker interface)
메서드를 하나도 갖지 않고, 그 타입을 구현했다는 사실 자체만으로 의미를 전달하는 인터페이스다. Spring Data의 `Repository`가 그 예이며, 프레임워크가 "이건 리포지토리다"를 알아보는 표식이 된다.
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries]]
- 섞이는 말: [[리포지토리]], 애노테이션

## CRUD (Create, Read, Update, Delete)
데이터에 대한 네 가지 기본 연산이다. 생성·조회·수정·삭제를 묶어 부르는 말이며, 리포지토리가 기본으로 제공하는 연산 집합의 뼈대다.
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries]]
- 섞이는 말: [[리포지토리]], [[결과-집합]]

## 도메인-타입 (domain type)
리포지토리가 다루는 대상 클래스다. `JpaRepository<VideoEntity, Long>`에서 `VideoEntity`가 도메인 타입이고 `Long`이 기본 키 타입이다.
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries]]
- 섞이는 말: [[엔티티]], [[기본-키]]

## 파생-finder (custom finder, derived query method)
리포지토리 인터페이스에 이름만 선언하면 Spring Data가 그 이름을 파싱해 쿼리를 만들어 주는 메서드다. `findByNameContainsIgnoreCase`처럼 `findBy` 뒤에 필드 이름과 한정어를 붙여 표현한다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[쿼리-파생]], [[네이티브-쿼리]]

## JPQL (Jakarta Persistence Query Language)
데이터베이스의 표·컬럼이 아니라 **엔티티와 그 필드**를 대상으로 쓰는 질의 언어다. JPA 제공자가 이것을 각 데이터베이스의 SQL로 번역한다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[네이티브-쿼리]], [[데이터베이스-방언]]

## 파라미터-바인딩 (parameter binding)
사용자 입력을 쿼리 문자열에 이어 붙이지 않고, 쿼리의 자리표시자에 값으로 따로 전달하는 방식이다. 값이 문법이 아니라 데이터로 취급되므로 인젝션이 막힌다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[SQL-인젝션]], [[이름-있는-파라미터]]

## SQL-인젝션 (SQL injection)
사용자 입력에 SQL 조각을 섞어 보내 쿼리의 의미 자체를 바꿔 버리는 공격이다. 입력을 쿼리 문자열에 그대로 이어 붙일 때 생긴다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[파라미터-바인딩]], 입력 검증

## 와일드카드 (wildcard)
문자열 비교에서 "여기에는 아무 문자열이 와도 된다"를 뜻하는 기호다. SQL과 JPQL의 `LIKE`에서는 `%`가 그 역할을 하며, `StartsWith`·`Containing` 같은 한정어가 이 기호를 대신 붙여 준다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[JPQL]], [[ExampleMatcher]]

## 데이터베이스-방언 (database dialect)
같은 표준 SQL이라도 제품마다 다른 문법·함수·타입의 차이다. JPA는 방언을 흡수해 같은 JPQL이 여러 데이터베이스에서 돌게 한다.
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: [[JPQL]], [[네이티브-쿼리]]

## 정렬-기준 (Sort)
결과를 어떤 컬럼으로 어떤 방향으로 정렬할지 담은 Spring Data의 객체다. 메서드 이름에 `OrderBy`로 고정해 넣는 대신 파라미터로 받으면 정렬 결정권이 호출자에게 넘어간다.
- 처음 나온 곳: [[04a-sorting-the-results]]
- 섞이는 말: [[페이징]], [[타입-안전성]]

## 타입-안전성 (type safety)
잘못된 조합을 컴파일러가 미리 잡아 주는 성질이다. 컬럼 이름을 문자열로 쓰면 오타가 런타임까지 살아남지만, 메서드 참조나 도메인 타입으로 쓰면 컴파일 시점에 걸린다.
- 처음 나온 곳: [[04a-sorting-the-results]]
- 섞이는 말: [[정렬-기준]], [[Querydsl]]

## 페이징 (paging, Pageable)
전체 결과를 한 번에 가져오지 않고 정해진 크기의 페이지 단위로 나눠 요청하는 방식이다. `PageRequest.of(0, 20)`은 0번 페이지를 20건 크기로 달라는 뜻이다.
- 처음 나온 곳: [[04b-limiting-query-results]]
- 섞이는 말: [[정렬-기준]], [[결과-집합]]

## 결과-집합 (result set)
쿼리 하나가 돌려주는 행들의 모음이다. 이 크기를 제어하지 않으면 표의 크기가 그대로 애플리케이션 메모리 사용량이 된다.
- 처음 나온 곳: [[04b-limiting-query-results]]
- 섞이는 말: [[페이징]], [[CRUD]]

## EntityManager (EntityManager)
JPA가 정의한 영속성 진입점이다. 엔티티를 저장·조회·삭제하고 JPQL 쿼리를 만들어 실행한다. Spring Data JPA는 파생한 쿼리를 이 API에 대신 넘긴다.
- 처음 나온 곳: [[04b-limiting-query-results]]
- 섞이는 말: [[JPQL]], [[영속성-계층]]

## Query-By-Example (Query By Example, QBE)
찾고 싶은 조건을 도메인 객체에 부분적으로 채워 넣고 그 객체를 그대로 조회 조건으로 쓰는 방식이다. 조건이 요청마다 달라질 때 메서드를 새로 만들지 않아도 된다.
- 처음 나온 곳: [[05-query-by-example-for-dynamic-search]]
- 섞이는 말: [[프로브]], [[파생-finder]]

## 프로브 (probe)
Query By Example에서 조건을 담는 도메인 객체 인스턴스다. 관심 있는 필드만 값을 채우고 나머지는 `null`로 둔다. 그 `null`이 "이 필드는 조건에서 빼라"는 뜻이 된다.
- 처음 나온 곳: [[05-query-by-example-for-dynamic-search]]
- 섞이는 말: [[Query-By-Example]], [[ExampleMatcher]]

## ExampleMatcher (ExampleMatcher)
프로브의 값들을 어떻게 비교할지 정하는 정책 객체다. 모든 필드를 AND로 묶을지 OR로 묶을지, 대소문자를 무시할지, 문자열을 부분 일치로 볼지를 지정한다.
- 처음 나온 곳: [[05-query-by-example-for-dynamic-search]]
- 섞이는 말: [[프로브]], [[와일드카드]]

## 삼치-논리 (three-valued logic)
SQL의 비교 결과가 참·거짓만이 아니라 `UNKNOWN`도 될 수 있는 논리 체계다. `null = null`이 참이 아니라 `UNKNOWN`인 이유이며, 그래서 `IS NULL`이라는 별도 연산자가 필요하다.
- 처음 나온 곳: [[05-query-by-example-for-dynamic-search]]
- 섞이는 말: [[프로브]], [[JPQL]]

## 네이티브-쿼리 (native query)
JPQL이 아니라 데이터베이스가 직접 이해하는 SQL을 그대로 쓰는 쿼리다. `@Query(nativeQuery = true)`로 표시하며, 방언 독립성과 일부 Spring Data 기능을 포기하는 대가로 완전한 제어를 얻는다.
- 처음 나온 곳: [[06-writing-custom-jpa-queries]]
- 섞이는 말: [[JPQL]], [[데이터베이스-방언]]

## 위치-파라미터 (positional parameter)
쿼리 안에서 `?1`, `?2`처럼 순번으로 가리키는 바인딩 자리다. 짧지만 인자가 늘면 어느 값이 어디로 가는지 읽기 어려워진다.
- 처음 나온 곳: [[06-writing-custom-jpa-queries]]
- 섞이는 말: [[이름-있는-파라미터]], [[파라미터-바인딩]]

## 이름-있는-파라미터 (named parameter)
`:minimumViews`처럼 이름으로 가리키는 바인딩 자리다. `@Param`으로 메서드 인자와 연결하며, 인자가 많을 때 순서 착오를 없앤다.
- 처음 나온 곳: [[06-writing-custom-jpa-queries]]
- 섞이는 말: [[위치-파라미터]], [[파라미터-바인딩]]

## JSqlParser (JSqlParser)
SQL 문자열을 구문 트리로 파싱하는 Java 라이브러리다. Spring Data JPA가 네이티브 쿼리를 다룰 때 내부적으로 사용해, 페이징을 위한 count 쿼리 처리 같은 조작을 가능하게 한다.
- 처음 나온 곳: [[06-writing-custom-jpa-queries]]
- 섞이는 말: [[네이티브-쿼리]], [[JPQL]]

## AOT (Ahead-of-Time)
프로그램을 실행하기 전, 빌드 시점에 미리 처리해 두는 방식이다. Spring Data의 AOT repository는 리포지토리 구현을 실행 중이 아니라 빌드 때 생성해 시작 시간을 줄인다.
- 처음 나온 곳: [[06-writing-custom-jpa-queries]]
- 섞이는 말: [[쿼리-파생]], 네이티브 이미지

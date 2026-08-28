# Chapter 10 용어집

> *Learning Spring Boot 4*, Ch. 10 *Working with Data Reactively* (책 pp. 281–294 / PDF pp. 306–319)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## JDBC (Java Database Connectivity)

Java가 관계형 데이터베이스와 어떻게 말하는지를 정의하는 **명세**. 드라이버가 아니라 명세라는 점이 중요하다 — 그 위에 세워진 모든 드라이버가 **본질적으로 블로킹인** 이 모델을 따른다.

## R2DBC (Reactive Relational Database Connectivity)

Spring 팀이 2018년에 착수해 **2022년 4월 1.0**에 도달한 명세. JDBC를 리액티브로 고칠 수 없다는 판단에서 출발해, 관계형 DB와 **논블로킹으로** 말하는 방법을 새로 정의했다.

## 리액티브-드라이버 (reactive driver)

연결 열기, 질의 파싱, 명령 변환, 결과 반환을 **Reactive Streams 시그널로** 수행하는 DB 드라이버. MongoDB·Neo4j·Cassandra·Redis 등이 이런 드라이버를 내놓았다.

## 블로킹-호출 (blocking call)

결과가 올 때까지 스레드를 붙드는 호출. 리액티브 런타임에서는 이벤트 루프 스레드 하나를 통째로 세우므로 처리량에 직접 타격을 준다.

## 스레드-풀-프록시 (thread pool proxy)

"JDBC를 전용 thread pool에 가두고 앞에 리액터 친화 프록시를 두면 되지 않나"라는 흔한 발상. **pool 한계에 닿는 순간 다음 리액티브 호출이 막히므로** 불가피한 것을 미룰 뿐이고 context switching 비용까지 더한다.

## 작업-훔치기 (work stealing)

한 작업이 멈춰 있을 때 스레드가 런타임의 큐로 돌아가 **다른 작업을 집어 오는** 방식. Reactor의 `Mono`·`Flux`와 그 연산자를 쓸 때만 가능하다.

## 컨텍스트-스위칭 (context switching)

스레드를 중단하고 상태를 저장한 뒤 다른 스레드를 깨워 상태를 복원하는 비용. 코어보다 스레드가 많지 않으면 **애초에 일어나지 않는다.**

## Spring-Data-R2DBC (Spring Data R2DBC)

R2DBC 위에 올리는 Spring Data 툴킷. 저수준 R2DBC를 직접 쓰는 번거로움을 덜고 repository·template 추상을 준다.

## ReactiveCrudRepository (ReactiveCrudRepository)

`save`·`findById`·`findAll`·`delete` 같은 CRUD를 **리액티브 타입으로 반환**하는 Spring Data Commons 인터페이스. **R2DBC 전용이 아니라** 리액티브 Spring Data 모듈들이 공유한다.

## R2dbcEntityTemplate (R2dbcEntityTemplate)

Spring Data R2DBC의 template. 도메인 타입을 알고 있는 `insert`·`select` 같은 편의 연산과, 저수준 `DatabaseClient`로 내려가는 통로를 함께 제공한다.

## DatabaseClient (DatabaseClient)

Spring Framework R2DBC 모듈이 제공하는 저수준 client. **원시 SQL을 리액티브하게** 실행할 때 쓴다.

## H2 (H2)

인메모리이자 임베더블한 관계형 DB. 흔히 테스트용이지만 이 장에서는 production DB의 대역으로 쓴다.

## r2dbc-h2 (r2dbc-h2)

H2용 R2DBC 드라이버. `h2` 의존성이 **DB 자체**를 준다면 이쪽은 그 DB와 **리액티브로 말하는 통로**를 준다.

## H2-Console (H2 Console)

H2를 브라우저에서 들여다보는 도구. **servlet/JDBC 가정을 끌고 들어오므로** 순수 리액티브 예제에는 넣지 않는다.

## Flux (Flux)

Reactor에서 0개 이상의 값이 시간에 걸쳐 도착하는 타입.

## Mono (Mono)

Reactor에서 0개 또는 1개 값을 다루는 타입.

## flatMap (flatMap)

map한 결과가 다시 리액티브 타입일 때 그 **중첩을 한 단계로 걷어내는** 연산자. `save()`가 `Mono<Employee>`를 돌려주므로 `map`을 쓰면 `Mono<Mono<Employee>>`가 된다.

## collectList (collectList)

`Flux`의 항목을 모아 `Mono<List<T>>`로 만드는 연산자.

## thenMany (thenMany)

앞 단계가 **완료된 뒤에** 이어질 리액티브 연산을 잇는 연산자. 테이블 생성 후에만 insert가 돌게 하는 순서 보장이 여기서 나온다.

## then-연산자 (then)

앞 단계의 값은 버리고 완료 시그널만 받아 다음으로 넘어가는 연산자. 앞에 `flatMap`을 두면 이전 단계가 실제로 수행됨을 보장하기 쉬워진다.

## subscribe (subscribe)

조립된 리액티브 파이프라인을 **실제로 시작시키는** 호출. 구독자가 붙기 전에는 어떤 연산도 실행되지 않는다.

## 게으른-평가 (laziness)

정의한 순간이 아니라 구독된 순간에 실행하는 성질. 초기화 코드에 `subscribe()`가 필요한 이유다.

## Id-애노테이션 (@Id)

식별자 필드를 표시하는 **Spring Data Commons** 애노테이션. JPA의 `jakarta.persistence.Id`가 **아니며** R2DBC를 포함한 여러 Spring Data 모듈에서 함께 쓴다.

## 도메인-타입 (domain type)

repository가 관리하는 대상 타입. Spring Data가 이 타입을 보고 무엇을 저장·조회할지 정한다.

## 기본-키 (primary key)

행을 유일하게 식별하는 컬럼. 새 항목을 넣을 때는 DB가 생성하므로 애플리케이션은 `null`로 둔다.

## 스키마-초기화 (schema initialization)

테이블을 만들고 초기 데이터를 싣는 단계. Spring Data R2DBC는 JPA와 달리 **스키마를 대신 만들어 주지 않으므로** 직접 정의해야 한다.

## CommandLineRunner (CommandLineRunner)

애플리케이션 기동이 끝난 뒤 자동으로 실행되는 Spring Boot 함수형 인터페이스.

## rowsUpdated (rowsUpdated)

SQL 실행이 영향을 준 행 수를 `Mono<Integer>`로 돌려주는 연산. 값 자체보다 **완료 시그널**이 쓰인다.

## Rendering (Rendering)

렌더링할 뷰 이름과 모델 속성을 함께 담는 WebFlux 값 타입.

## Reactive-Streams-명세 (Reactive Streams)

논블로킹 배압을 갖춘 비동기 스트림 처리의 표준. 드라이버가 **DB 엔진과 말하는 지점까지** 이것을 해야 리액티브가 성립한다.

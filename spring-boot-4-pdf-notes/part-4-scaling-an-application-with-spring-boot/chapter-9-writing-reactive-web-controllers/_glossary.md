# Chapter 9 용어집

> *Learning Spring Boot 4*, Ch. 9 *Writing Reactive Web Controllers* (책 pp. 251–278 / PDF pp. 276–303)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 리액티브-스트림 (Reactive Streams)

**논블로킹 배압을 갖춘 비동기 스트림 처리**의 표준을 정하는 이니셔티브이자 명세. JVM·JavaScript 런타임과 네트워크 프로토콜을 포괄한다.

## 배압 (backpressure)

소비자가 처리할 수 있는 만큼만 데이터를 받도록 **소비자가 흐름을 통제**하는 메커니즘. 생산자가 무작정 밀지 않고, 소비자가 "몇 개 달라"고 요청해야 보낸다.

## Publisher (Publisher)

출력을 만들어 내는 쪽. 하나일 수도 무한할 수도 있다.

## Subscriber (Subscriber)

`Publisher`로부터 받는 쪽.

## Subscription (Subscription)

`Subscriber`가 `Publisher`의 내용을 소비하기 시작하는 데 필요한 세부를 담는 연결. 여기서 `request(n)`과 `cancel`이 나온다.

## Processor (Processor)

`Subscriber`이면서 동시에 `Publisher`인 컴포넌트. 중간에서 받아 변환해 다시 내보낸다.

## 시그널 (signal)

리액티브 스트림에서 데이터 처리나 동작에 따라오는 신호. 데이터가 없어도 시그널은 오간다. 그래서 **리액티브에는 근본적으로 void 메서드가 없다.**

## onSubscribe (onSubscribe)

리액티브 스트림의 **첫 시그널**. 하류 컴포넌트가 상류 이벤트를 소비할 준비가 됐다는 표시다.

## request (request)

`Subscriber`가 `Subscription`을 통해 "n개 달라"고 요구하는 호출. 배압이 실제로 작동하는 지점이다.

## onNext (onNext)

`Publisher`가 항목 하나를 내보내는 시그널. 요청받은 n을 **초과할 수 없다.**

## onComplete (onComplete)

더 보낼 것이 없음을 알리는 시그널.

## 블로킹 (blocking)

연산이 끝날 때까지 스레드가 기다리는 실행 방식. 기다리는 동안 스레드는 **놀면서도 자원을 소비**한다.

## 논블로킹 (non-blocking)

연산이 끝나기를 기다리지 않는 실행 방식. 작업을 시작하면 스레드를 놓아 다른 일을 시키고, 결과가 나오면 시그널로 처리를 잇는다.

## 스레드-per-요청 (thread per request)

들어오는 요청마다 전용 스레드를 배정하는 전통적 모델. 동시 요청 수가 곧 스레드 수가 된다.

## 컨텍스트-스위칭 (context switching)

CPU가 실행 중인 스레드를 바꿀 때 레지스터와 상태를 저장·복원하는 비용. 코어보다 스레드가 많을수록 커진다.

## Project-Reactor (Project Reactor)

Spring 팀이 만든 리액티브 스트림 구현 툴킷. **Spring 의존성이 없는 독립 툴킷**이며, Spring 포트폴리오가 core 의존성으로 집어 쓴다.

## Flux (Flux)

Reactor의 `Publisher` 구현으로 **0개 이상**의 데이터가 시간에 걸쳐 도착하는 흐름. `map`·`filter`·`flatMap` 등 풍부한 연산자를 갖는다.

## Mono (Mono)

Reactor에서 **0개 또는 1개** 값을 다루는 타입. `Flux`의 단일 항목 대응물이다.

## 어셈블리 (assembly)

`map`·`filter` 같은 연산자를 이어 쓰는 동안 각 단계가 **command object로 조립되는** 과정. **실행이 아니다.**

## 구독 (subscribe)

조립된 흐름을 실제로 시작시키는 행위. **구독하기 전에는 아무 일도 일어나지 않는다** — 웹 호출도, DB 연결도, 자원 할당도.

## 게으른-평가 (laziness)

정의한 순간이 아니라 필요해진 순간에 실행하는 성질. 리액티브 파이프라인 전체가 이 원칙으로 설계됐다.

## Scheduler (Scheduler)

Reactor가 조립된 작업을 실제로 실행할 때 쓰는 실행 자원. 단일 스레드, thread pool, `ExecutorService`, bounded elastic 등을 고를 수 있다.

## boundedElastic (boundedElastic)

블로킹 작업을 격리하기 위한 Reactor의 Scheduler. 필요에 따라 늘어나되 상한이 있다.

## 작업-훔치기 (work stealing)

한 작업이 I/O로 멈춰 있을 때 스레드가 놀지 않고 큐에서 **다른 작업을 집어 오는** 방식. 지연을 다른 일을 끝낼 기회로 바꾼다.

## 이벤트-루프 (event loop)

적은 수의 스레드가 큐에 쌓인 이벤트를 돌아가며 처리하는 실행 모델. 여기서 블로킹이 일어나면 그 루프에 묶인 모든 작업이 함께 멈춘다.

## Reactor-Netty (Reactor Netty)

Netty 위에 Project Reactor를 통합한 **완전 논블로킹 웹 서버**. WebFlux의 기본 임베디드 서버이며 대량 동시 연결을 효율적으로 다룬다.

## Spring-WebFlux (Spring WebFlux)

Spring의 리액티브 웹 프레임워크. 저수준 리액티브 시그널을 감춰 주고, MVC와 같은 애노테이션으로 논블로킹 컨트롤러를 쓰게 한다.

## RSocket (RSocket)

배압을 내장한 리액티브 통신용 전송 프로토콜. HTTP가 TCP 위에 서듯 분산 시스템 사이에 흐름 제어를 확장한다.

## RxJava (RxJava)

리액티브 스트림 명세의 또 다른 구현. 명세가 표준이므로 Reactor와 상호 운용할 수 있다.

## Flow-API (java.util.concurrent.Flow)

Java 9부터 JDK에 들어온 네 인터페이스. Reactive Streams와 **1:1 호환**으로 설계됐다.

## flatMap (flatMap)

map한 결과가 다시 컨테이너일 때 그 중첩을 **한 단계로 걷어내는** 연산자. `map` + flattening이다.

## collectList (collectList)

`Flux`의 모든 항목을 모아 `Mono<List<T>>`로 만드는 연산자. 스트림을 한 덩어리로 바꾼다.

## fromIterable (fromIterable)

Java `Iterable`을 `Flux`로 감싸는 static 헬퍼. 이미 손에 든 컬렉션을 리액티브 파이프라인에 들여올 때 쓴다.

## concatWith (concatWith)

두 `Flux`를 이어 붙이되 **앞의 것을 전부 방출한 뒤** 뒤의 것을 방출하는 연산자.

## mergeWith (mergeWith)

두 `Flux`를 합치되 **도착하는 실시간 순서대로** 방출해 교차를 허용하는 연산자.

## Rendering (Rendering)

WebFlux의 값 타입으로 **렌더링할 뷰 이름과 모델 속성을 함께** 담는다. builder로 조립하고 `build()`로 불변 인스턴스를 만든다.

## Thymeleaf (Thymeleaf)

Spring Boot와 잘 통합되고 **리액티브 지원을 갖춘** 서버 사이드 템플릿 엔진. DOM 기반 파서라 모든 태그가 닫혀 있어야 한다.

## Thymeleaf-디렉티브 (Thymeleaf directives)

`th:` 접두를 갖는 템플릿 처리 지시자. `th:each`는 반복, `th:text`는 텍스트 삽입, `th:object`는 폼 바인딩 대상, `th:field`는 개별 입력과 필드의 연결을 맡는다.

## 폼-바인딩 (form binding)

HTML 폼의 입력값을 객체의 필드에 자동으로 대응시키는 것. POST를 하려면 GET 단계에서 **빈 객체를 미리 모델에 넣어** 둬야 한다.

## ModelAttribute (@ModelAttribute)

이 메서드가 JSON 본문이 아니라 **HTML 폼**을 소비한다는 신호. `@RequestBody`와 대비된다.

## 하이퍼미디어 (hypermedia)

API가 콘텐츠와 **메타데이터를 함께** 내주어, 데이터로 무엇을 할 수 있고 관련 데이터를 어디서 찾는지 알려 주는 방식.

## Spring-HATEOAS (Spring HATEOAS)

데이터와 하이퍼링크를 결합해 주는 Spring 툴킷. `Link` 생성과 병합 연산을 갖춘다.

## HAL (Hypertext Application Language)

하이퍼미디어를 JSON으로 표현하는 형식. `_links`에 link relation과 `href`를, `_embedded`에 내포된 리소스를 담는다.

## Link (Link)

Spring HATEOAS가 하이퍼링크를 표현하는 타입. relation 이름과 URI를 갖는다.

## RepresentationModel (RepresentationModel)

데이터와 링크를 담는 하이퍼미디어 응답의 **핵심 타입**. 하이퍼미디어 endpoint는 이것 또는 그 하위 타입을 반환해야 한다.

## EntityModel (EntityModel)

`RepresentationModel`의 제네릭 확장. 업무 객체를 static 생성 메서드에 넣어 **링크와 업무 로직을 분리한 채** 감싼다.

## CollectionModel (CollectionModel)

`T` 하나가 아니라 **컬렉션**을 표현하는 `RepresentationModel` 확장.

## PagedModel (PagedModel)

`CollectionModel`을 확장해 **한 페이지 분량**의 하이퍼미디어 객체를 표현한다.

## self-링크 (self link)

거의 모든 하이퍼미디어 표현에 들어가는 "this" 링크. **문맥이 중요하다** — 컬렉션 응답 안에는 각 항목의 self와 문서 자신의 self가 함께 있다.

## 집합-루트 (aggregate root)

개별 리소스들을 모아 대표하는 컬렉션 endpoint. 각 항목이 여기로 돌아오는 링크를 갖는다.

## linkTo (linkTo)

Spring HATEOAS의 static 헬퍼로, 컨트롤러 메서드 호출에서 링크를 뽑아낸다.

## methodOn (methodOn)

링크를 만들기 위해 컨트롤러 웹 메서드를 **더미로 호출**해 정보를 모으는 static 헬퍼.

## Mono-zip (Mono.zip)

둘 이상의 `Mono`를 합쳐 **전부 완료됐을 때** 결과를 처리하는 Reactor 연산자. 최대 8개까지 직접 지원하고, 오류 전파를 미루려면 `zipDelayError`를 쓴다.

## RouterFunction (RouterFunction)

애노테이션 대신 **설정 코드에서 라우트를 선언**하는 WebFlux의 함수형 라우팅 구성 요소. 성능 이점은 없고 스타일의 차이다.

## 블로킹-API (blocking API)

JDBC·JPA·JMS·servlet처럼 블로킹 패러다임 위에 세워진 명세. 리액티브 애플리케이션에 그대로 쓰면 이벤트 루프를 붙잡는다.

## 가상-스레드 (virtual thread)

JVM이 관리하는 경량 스레드. Java 21·Boot 3.2 이후 **명령형 코드를 유지하면서** 고동시성으로 가는 다른 길을 준다.

# Chapter 9 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 9 *Writing Reactive Web Controllers*, 책 pp. 251–278 / PDF pp. 276–303. PDF를 `pdftotext -layout -f 276 -l 303`으로 새로 추출해 1,197줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

인쇄된 상위 절은 **6개**, 2단계 하위 제목은 **7개**, 3단계는 **없다**. 상위 절 6개 중 3개(`01`·`04`·`05`)가 하위 제목을 품고 있어 **인쇄된 하위 제목을 기준으로만** 쪼개 6 → **12개**로 늘렸다.

`01`의 하위 제목 3개 중 첫 번째(*Introduction to Reactive*)만은 별도 노트로 만들지 않았다. 상위 절 도입부와 이어져 **배압 하나를 설명하는 한 덩어리**이고, 기존 파일 이름 `01-reactive-programming-and-backpressure`가 이미 그 범위를 가리키기 때문이다. 나머지 둘(*Blocking vs. non-blocking execution*, *Reactive Streams details*)은 각각 "왜 적은 스레드로 되는가"와 "명세가 실제로 무엇인가"라는 독립된 질문이라 분리했다.

`04`의 하위 제목 2개(*Scaling applications with Project Reactor*, *Quick history of Java concurrent programming*)는 **인쇄 위치가 POST 절 뒤**지만 내용은 POST와 무관하다. 원문 배치를 존중해 `04a`·`04b`로 두되, `_map.md`에서는 `01` 계열과 함께 읽도록 안내한다.

**기존 초안 6개의 파일 이름은 하나도 바꾸지 않았다.** Ch10의 세 노트가 `02`·`04`·`05`를 직접 참조한다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-reactive-programming-and-backpressure]] | What is Reactive and why do we care? (+ 하위 *Introduction to Reactive*) | 252–253 | 277–278 |
| [[01a-blocking-vs-non-blocking]] | Blocking vs. non-blocking execution | 253–254 | 278–279 |
| [[01b-reactive-streams-details]] | Reactive Streams details | 254–256 | 279–281 |
| [[02-creating-a-webflux-application]] | Creating a Reactive Spring Boot application | 256–257 | 281–282 |
| [[03-serving-data-with-reactive-get]] | Serving data with a Reactive GET method | 257–259 | 282–284 |
| [[04-consuming-data-with-reactive-post]] | Consuming incoming data with a Reactive POST method | 259–261 | 284–286 |
| [[04a-scaling-with-project-reactor]] | Scaling applications with Project Reactor | 261–262 | 286–287 |
| [[04b-java-concurrency-history]] | Quick history of Java concurrent programming | 262–263 | 287–288 |
| [[05-rendering-reactive-templates]] | Serving a Reactive template | 263–264 | 288–289 |
| [[05a-creating-a-reactive-web-controller]] | Creating a Reactive web controller | 264–265 | 289–290 |
| [[05b-crafting-a-thymeleaf-template]] | Crafting a Thymeleaf template | 266–271 | 291–296 |
| [[06-building-reactive-hypermedia-apis]] | Creating hypermedia reactively | 271–278 | 296–303 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 251 | 276 | 장 도입 — 여덟 장에 걸쳐 다 만들고 컨테이너에 넣고 네이티브로도 돌렸는데, **여전히 idle time이 많고 인스턴스 수 때문에 클라우드 비용이 탄다면?** | [[_map]] | 반영 |
| 252 | 277 | Note: 소스는 저장소 `ch9` 폴더 | [[02-creating-a-webflux-application]] | 반영 |
| 252 | 277 | 수십 년간의 확장 도구 — thread pool, synchronized 블록, 그 밖의 context-switching 기법. **강력하지만 규모에서 올바로 쓰기 어려웠다** | [[01-reactive-programming-and-backpressure]] | 반영 |
| 252 | 277 | 약속은 컸고 구현은 까다로웠으며 결과는 빈약했다. 사람들은 여전히 수백~수천 인스턴스를 돌리고 월 청구서가 거대해진다 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 252 | 277 | 브라우저의 리액티브 JavaScript — **스레드가 하나뿐인 환경**이 논블로킹·이벤트 기반으로 얼마나 잘 확장되는지 보여 줬다 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 252 | 277 | Reactive Streams 공식 인용 — "**논블로킹 배압**을 갖춘 비동기 스트림 처리의 표준을 제공하려는 이니셔티브. JVM·JavaScript 런타임과 네트워크 프로토콜을 포괄한다" | [[01-reactive-programming-and-backpressure]] | 반영 |
| 252–253 | 277–278 | 리액티브 시스템의 핵심 특성 — **빠른 데이터 스트림이 목적지를 압도하면 안 된다.** 생산자가 소비자보다 빠르면 지연 증가·자원 고갈·장애 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 253 | 278 | **배압** — 무작정 밀지 않고 생산자와 소비자 사이에 조율을 넣는다. **소비자가 흐름을 통제**하며 1개·10개 식으로 명시적으로 요청한다. publish-subscribe가 **수요 주도 상호작용**으로 바뀐다 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 253 | 278 | 조율은 잘 정의된 시그널 집합으로 일어나고, 배압이 명세의 일부라 **여러 컴포넌트를 이어 붙여도 흐름 제어가 파이프라인 전체로 전파**된다 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 253 | 278 | 애플리케이션 경계를 넘어선다 — **RSocket**이 같은 원리를 네트워크에 적용한다. HTTP가 TCP 위에 서듯, RSocket은 배압 내장 리액티브 통신의 전송 계층이다 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 253 | 278 | 전통적 **블로킹 모델** — 요청마다 전용 스레드. DB 호출이나 HTTP 요청 동안 스레드는 **놀면서도 자원을 소비**한다. 동시 요청이 많으면 큰 thread pool·메모리 증가·비싼 context switching | [[01a-blocking-vs-non-blocking]] | 반영 |
| 253–254 | 278–279 | **논블로킹 모델** — 연산이 끝나기를 기다리지 않는다. DB 호출을 시작하면 **스레드를 놓아** 다른 일을 시키고, 결과가 준비되면 시그널이 방출돼 처리가 이어진다 | [[01a-blocking-vs-non-blocking]] | 반영 |
| 254 | 279 | 그래서 **적은 스레드로 많은 동시 요청**을 다룬다. 목표는 한 스레드로 더 많은 일을 동시에 하는 것이 아니라 **I/O를 기다리며 시간을 낭비하지 않는 것** | [[01a-blocking-vs-non-blocking]] | 반영 |
| 254 | 279 | 리액티브 프로그래밍은 이 위에 선다 — 논블로킹 실행 + 배압 + 비동기 데이터 스트림 | [[01a-blocking-vs-non-blocking]] | 반영 |
| 254 | 279 | Reactive Streams는 **인터페이스 4개뿐**인 매우 단순한 명세 — `Publisher`·`Subscriber`·`Subscription`·`Processor` | [[01b-reactive-streams-details]] | 반영 |
| 254 | 279 | Java 9부터 같은 넷이 JDK의 `java.util.concurrent.Flow`에도 있고 **1:1 호환**으로 설계됐다 | [[01b-reactive-streams-details]] | 반영 |
| 254 | 279 | 네 인터페이스 각각의 역할 설명 | [[01b-reactive-streams-details]] | 반영 |
| 254 | 279 | 단순하지만 **너무 단순해서**, 명세를 구현하고 구조와 지원을 더 주는 툴킷을 찾는 편이 권장된다 | [[01b-reactive-streams-details]] | 반영 |
| 254 | 279 | **시그널** — 데이터가 다뤄지거나 동작이 일어날 때마다 시그널이 따른다. 데이터 교환이 없어도 시그널은 처리된다. 그래서 **리액티브에는 근본적으로 void 메서드가 없다** | [[01b-reactive-streams-details]] | 반영 |
| 254 | 279 | 이 책은 Spring 팀의 구현인 **Project Reactor**를 쓴다. Spring 팀이 만들지만 **Reactor 자체에는 Spring 의존성이 없다** — Spring이 집어 쓰는 core 의존성이자 독립 툴킷이다 | [[01b-reactive-streams-details]] | 반영 |
| 255 | 280 | Reactive Streams를 직접 쓰지 않고 Reactor 구현을 쓴다. 출처를 알아 두면 **RxJava 3** 같은 다른 구현과 통합할 수 있다 | [[01b-reactive-streams-details]] | 반영 |
| 255 | 280 | Reactor는 Java 함수형 모델 위에 세워졌고 **람다를 많이 써 데이터 처리 파이프라인**을 정의한다. `Flux.just(...).filter(...).map(...)` 예제와 항목별 4개 설명 | [[01b-reactive-streams-details]] | 반영 |
| 255 | 280 | 이 코드는 **flow 또는 리액티브 레시피**다. 각 줄이 **assembly** 과정에서 command object로 포착된다. **assembly는 실행과 다르다** | [[01b-reactive-streams-details]] · [[04a-scaling-with-project-reactor]] | 반영 |
| 255–256 | 280–281 | **구독하기 전에는 아무 일도 없다.** 구독 후의 5단계 — `onSubscribe` → `request(n)` → `onNext` (n회 이내) → 추가 `request` 또는 `cancel` → `onComplete` | [[01b-reactive-streams-details]] | 반영 |
| 256 | 281 | 이건 **저수준 프로토콜**이다. 실무 개발자는 이 시그널을 직접 다루지 않고 Reactor·WebFlux가 추상화해 준다 | [[01b-reactive-streams-details]] | 반영 |
| 256 | 281 | start.spring.io 좌표 9개와 의존성 **단 하나** — Spring Reactive Web (Spring WebFlux) | [[02-creating-a-webflux-application]] | 반영 |
| 257 | 282 | `spring-boot-starter-webflux`가 Jackson·Reactor Core를 포함하고 **Reactor Netty를 기본 임베디드 리액티브 서버로 구성**한다. `spring-boot-starter-webflux-test`는 Boot 4의 기능별 테스트 starter | [[02-creating-a-webflux-application]] | 반영 |
| 257 | 282 | 리액티브의 근본 요구 — **끝에서 끝까지 논블로킹을 지원하는 런타임**. 웹 서버도 블로킹을 피해야 하며 그러지 않으면 이점이 사라진다 | [[02-creating-a-webflux-application]] | 반영 |
| 257 | 282 | **Reactor Netty** — Netty 위에 Reactor를 통합해 대량 동시 연결을 효율적으로 다루는 완전 논블로킹 웹 서버 | [[02-creating-a-webflux-application]] | 반영 |
| 257 | 282 | 웹 컨트롤러는 보통 데이터 아니면 HTML을 낸다. 리액티브를 이해하려면 **더 단순한 데이터 쪽**부터 | [[03-serving-data-with-reactive-get]] | 반영 |
| 257 | 282 | `Flux`는 Reactor의 `Publisher` 구현이며 풍부한 리액티브 연산자를 제공한다 | [[03-serving-data-with-reactive-get]] | 반영 |
| 258 | 283 | `ApiController`의 `Flux<Employee> employees()`와 항목별 3개 설명 | [[03-serving-data-with-reactive-get]] | 반영 |
| 258 | 283 | **`Flux`는 List와 Future를 합친 것 같지만 아니다** — List는 한꺼번에 갖지만 Flux는 아니고, 반복문으로 소비하지 않으며 `map`·`filter`·`flatMap` 같은 스트림 연산을 갖는다. Future는 `get`뿐이지만 Flux는 연산자가 풍부하다 | [[03-serving-data-with-reactive-get]] | 반영 |
| 258–259 | 283–284 | `concatWith`(a 전부 뒤에 b)와 `mergeWith`(실시간 도착 순서, 교차 허용) 예제와 설명 | [[03-serving-data-with-reactive-get]] | 반영 |
| 259 | 284 | Note: "예제에서 `just`로 미리 채운 건 Flux의 미래적 성격에 어긋나지 않나?" — 맞다. 실제로는 **리액티브 DB나 원격 서비스** 같은 데이터 소스를 연결하고, 더 정교한 API로 값이 준비되는 대로 방출한다 | [[03-serving-data-with-reactive-get]] | 반영 |
| 259 | 284 | 웹 메서드에서 `Flux`는 WebFlux에 넘겨지고, **프레임워크가 직렬화와 JSON 응답을 책임진다.** 구독·request·onNext·onComplete의 전체 생명주기도 프레임워크가 관리한다 | [[03-serving-data-with-reactive-get]] | 반영 |
| 259 | 284 | **구독 전에는 아무 일도 없다** — 웹 호출도, DB 연결도, 자원 할당도. 시스템 전체가 **게으르게** 설계됐다. 웹 메서드에서는 이 구독을 프레임워크가 자동 처리한다 | [[03-serving-data-with-reactive-get]] | 반영 |
| 259–260 | 284–285 | `@PostMapping`의 `Mono<Employee> add(@RequestBody Mono<Employee>)`와 항목별 4개 설명 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 260 | 285 | Note: WebFlux는 **`RouterFunction`·`HandlerFunction` 기반 함수형 라우팅**도 지원한다. 애노테이션 방식의 대안이며 **성능 이점은 없고** 스타일·명시성·조합의 차이다. 이 책은 명료성을 위해 애노테이션 방식을 계속 쓴다 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 261 | 286 | 들어오는 데이터가 `Mono`에 감싸여 오고, `map`으로 내용에 접근한다. 여기서는 변환 없이 `DATABASE`에 저장하고 그대로 반환 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 261 | 286 | Note: **`map`은 1:1**이다. 10개짜리 Flux를 map하면 새 Flux도 10개. 문자열 하나를 글자 리스트로 map하면 **리스트의 리스트**가 된다. 그 중첩을 걷어내는 것이 **flattening**이고 `flatMap`은 그걸 한 단계로 한다 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 261 | 286 | Reactor가 뒤에서 하는 **첫 번째 일** — 각 단계가 즉시 수행되지 않는다. `map`·`filter`를 쓸 때마다 **assembly**가 일어난다. 실행이 아니다 | [[04a-scaling-with-project-reactor]] | 반영 |
| 261 | 286 | 각 연산은 필요한 세부를 담은 **작은 command object**를 조립한다. `DATABASE`에 저장하고 값을 반환하는 문장 전체가 람다 안에 있고, **컨트롤러가 호출될 때 그 람다가 같이 실행돼야 할 이유가 없다** | [[04a-scaling-with-project-reactor]] | 반영 |
| 261 | 286 | Reactor가 command object를 모아 **내부 작업 큐**에 쌓고 내장 **`Scheduler`**에 실행을 위임한다. 단일 스레드·thread pool·`ExecutorService`·정교한 bounded elastic 등 여러 Scheduler가 있다 | [[04a-scaling-with-project-reactor]] | 반영 |
| 262 | 287 | Scheduler가 자원이 나는 대로 backlog를 처리한다. 모든 단계가 게으르고 논블로킹이라 **I/O 지연 때 현재 스레드가 붙들리지 않고** 큐에서 다른 작업을 집는다 — **work stealing**. 지연이 다른 일을 끝낼 기회로 바뀐다 | [[04a-scaling-with-project-reactor]] | 반영 |
| 262 | 287 | 그래서 **블로킹 작업은 리액티브 event-loop 스레드에서 돌면 안 된다.** 불가피하면 `boundedElastic` 같은 적절한 Scheduler로 격리한다 | [[04a-scaling-with-project-reactor]] | 반영 |
| 262 | 287 | Mark Paluch 인용 — "리액티브 프로그래밍은 **자원 가용성에 반응하는 것**에 기반한다" | [[04a-scaling-with-project-reactor]] | 반영 |
| 262 | 287 | Reactor의 **두 번째 일** — 200 스레드짜리 거대 pool 대신 **코어당 스레드 하나**를 쓰는 Scheduler가 기본이다. context switching을 줄이고 I/O 바운드에서 CPU를 더 잘 쓴다 | [[04a-scaling-with-project-reactor]] | 반영 |
| 262 | 287 | 초창기 Java 동시성 — 거대 thread pool을 만들었지만 **코어보다 스레드가 많으면 context switching이 비싸다**는 것을 배웠다 | [[04b-java-concurrency-history]] | 반영 |
| 262 | 287 | Java 코어에 **깨지기 쉬운 API**가 많다. `synchronized`·lock·semaphore가 있었지만 **효과적이면서 올바르게** 하기가 정말 어렵다 | [[04b-java-concurrency-history]] | 반영 |
| 262 | 287 | 흔한 세 결말 — A) 올바르지만 처리량은 그대로, B) 처리량은 늘지만 deadlock, C) deadlock도 생기고 처리량도 그대로. 게다가 **비직관적인 재작성**을 요구한다 | [[04b-java-concurrency-history]] | 반영 |
| 262–263 | 287–288 | 코어당 스레드 하나 + 게으른 논블로킹 + work stealing이 훨씬 효율적일 수 있다. Reactor 코딩도 배워야 할 스타일이 있지만 **Java 8 Stream과 같은 방향**이라 초창기 동시성만큼 큰 요구는 아니다 | [[04b-java-concurrency-history]] | 반영 |
| 263 | 288 | 그래서 **애플리케이션의 모든 부분이 이 방식으로 작성돼야** 한다. 4코어에 Reactor 스레드 4개인데 하나가 블로킹에 걸리면 **전체 처리량의 25%가 날아간다** | [[04b-java-concurrency-history]] | 반영 |
| 263 | 288 | **JDBC·JPA·JMS·servlet**의 블로킹 API가 리액티브에 심각한 문제인 이유. 전부 블로킹 패러다임 위에 세워졌고 다음 장에서 더 다룬다 | [[04b-java-concurrency-history]] | 반영 |
| 263 | 288 | 지금까지 직렬화된 JSON을 냈지만 **대부분의 웹사이트는 HTML을 렌더링**해야 한다 → 템플릿 | [[05-rendering-reactive-templates]] | 반영 |
| 263 | 288 | 리액티브 얘기를 하고 있으니 **블로킹하지 않는 템플릿 엔진**을 고르는 것이 이치에 맞다 → **Thymeleaf** | [[05-rendering-reactive-templates]] | 반영 |
| 263–264 | 288–289 | 새 프로젝트를 만들지 않고 같은 메타데이터에 의존성 두 개(Spring Reactive Web, Thymeleaf)를 골라 **EXPLORE**로 pom을 보고 복사한다. 추가되는 것은 `spring-boot-starter-thymeleaf`와 `spring-boot-starter-webflux-test` | [[05-rendering-reactive-templates]] | 반영 |
| 264 | 289 | `HomeController`의 `Mono<Rendering> index()`와 항목별 **7개** 설명 (`@Controller`·`@GetMapping`·`Mono<Rendering>`·`Flux.fromIterable()`·`DATABASE.values()`·`collectList()`·`map()`·`build()`) | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 265 | 290 | 끝의 `map()`은 **Mono 안의 타입을 변환**한다. `List<Employee>`를 `Rendering`으로 바꾸되 계속 Mono 안에 둔다. 원래 `Mono<List<Employee>>`를 풀어 새 `Mono<Rendering>`을 만든다 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 265 | 290 | Note: **컨테이너 안의 것을 map하고 계속 컨테이너 안에 두는 것**이 함수형의 기본이다. 새 Mono를 직접 만들 걱정을 하지 않아도 되고, 리액티브 컨테이너 안에만 있으면 프레임워크가 알맞은 때에 풀어 렌더링한다 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 265 | 290 | 실제 데이터 소스가 아니라 Java `Map`이다. Java 리스트를 `fromIterable`로 Flux로 감쌌다가 `collectList`로 도로 빼는 것이 이상해 보이는 이유 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 265 | 290 | 그래도 이것이 **`Iterable`을 건네받는 실제 상황**의 올바른 처리다 — Flux로 감싸고, 변환·필터를 거쳐, WebFlux 핸들러에 넘겨 Thymeleaf로 렌더링한다 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 266 | 291 | `src/main/resources/templates/index.html` 전문과 항목별 3개 설명(`xmlns:th`·`th:each`·`th:text`) | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 266 | 291 | **모든 HTML 태그가 닫혀 있어야 한다.** Thymeleaf의 DOM 기반 파서 때문이며, `<IMG>`처럼 닫는 태그가 없는 것도 `</IMG>`나 `<IMG/>`로 닫아야 한다 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 267 | 292 | Figure 9.1 — 렌더링된 페이지 | [[05b-crafting-a-thymeleaf-template]] | 반영 (Figure 미추출) |
| 267 | 292 | POST를 하려면 GET 단계에서 **빈 객체를 먼저 제공**해야 한다 → `index`에 `modelAttribute("newEmployee", new Employee("", ""))` 추가 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 268 | 293 | `<form th:action th:object method="post">`와 `th:field="*{name}"`·`*{role}` 전문, 항목별 4개 설명. 나머지는 표준 HTML5이고 설명한 부분이 **WebFlux 폼 처리에 필요한 접착제** | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 268–269 | 293–294 | `HomeController`의 `Mono<String> newEmployee(@ModelAttribute Mono<Employee>)`와 항목별 4개 설명. `@ModelAttribute`는 **JSON 본문이 아니라 HTML 폼**을 소비한다는 신호 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 269 | 294 | 이 메서드 전체가 **들어온 데이터에서 시작해 나가는 동작으로 변환**되는 Reactor flow다. 명령형이 중간 변수를 만지작거리는 것과 대비된다 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 269 | 294 | Figure 9.2 — 새 직원 입력 화면 | [[05b-crafting-a-thymeleaf-template]] | 반영 (Figure 미추출) |
| 270 | 295 | Figure 9.3 — Submit 후 홈으로 redirect된 화면 | [[05b-crafting-a-thymeleaf-template]] | 반영 (Figure 미추출) |
| 270 | 295 | Note: **"Spring WebFlux는 그만한 값을 하나?"** — MVC가 여전히 유효하고 더 단순하다. **I/O 바운드 고동시성**(스트리밍·API 게이트웨이·수천 동시 연결)에서 스레드 사용이 극적으로 줄고 자원 효율이 오른다. Java 21·Boot 3.2 이후 **가상 스레드**가 명령형 MVC를 유지하며 고동시성으로 가는 다른 길을 준다. **WebFlux가 본질적으로 낫다는 게 아니라 특정 아키텍처 시나리오에 낫다** | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 271 | 296 | Thymeleaf를 더 파고들 수 있지만 이 책은 Spring Boot에 집중한다 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 271 | 296 | 앞서 만든 API에는 **controls가 없었다**. **하이퍼미디어**는 API가 내주는 콘텐츠와 메타데이터를 함께 가리키며, 데이터로 무엇을 할 수 있고 관련 데이터를 어떻게 찾는지 알려 준다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 271 | 296 | 웹 페이지에서 매일 보는 것 — 다른 페이지로 가는 링크, 스타일시트 링크, 변경을 일으키는 링크. Amazon에서 주문할 때 **우리가 링크를 제공하지 않는다.** JSON 하이퍼미디어는 같은 개념을 API에 적용한 것 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 271 | 296 | Note: start.spring.io에서 Spring HATEOAS를 고르면 `spring-boot-starter-hateoas`가 들어가는데 **이건 Spring MVC 전용이라 WebFlux 앱에 쓰면 안 된다.** servlet 기반 스택을 끌어와 Reactor Netty와 충돌한다. Spring HATEOAS 자체는 WebFlux를 지원하지만 **Boot starter가 의도적으로 MVC에 정렬**돼 있어, 리액티브에서는 `spring-hateoas`를 직접 넣는다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 272 | 297 | `spring-hateoas` 의존성(버전 불필요)과 `HypermediaController`의 `@RestController`·`@EnableHypermediaSupport(type = HAL)` | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 272 | 297 | Boot starter를 썼다면 HAL이 자동 활성화됐겠지만, **수동으로 꽂았으니 직접 활성화**해야 한다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 272 | 297 | Note: `@EnableHypermediaSupport`는 **한 번만** 쓰면 된다. 여기서는 간결함을 위해 하이퍼미디어 컨트롤러에 붙였지만 실제로는 `@SpringBootApplication` 클래스에 두는 편이 나을 수 있다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 272–274 | 297–299 | 단일 항목 endpoint `Mono<EntityModel<Employee>> employee(@PathVariable String key)` 전문과 항목별 **8개** 설명(`linkTo`·`methodOn`·`withSelfRel`·`withRel`·`toMono`·`Mono.zip`·`links.map`) | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 274 | 299 | `Mono.zip()`은 2개 이상의 Mono를 합쳐 **전부 완료됐을 때** 결과를 처리한다. 가장 흔한 형태는 둘이고, 더 큰 집합에는 combinator `Function`을 받는 변형이 있어 **최대 8개까지** 직접 지원한다. 오류 전파 전에 여러 연산을 끝내려면 `Mono.zipDelayError()` | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 274 | 299 | Spring HATEOAS가 하는 일 — 데이터와 하이퍼링크를 결합한다. 링크는 `Link` 타입으로 표현되고 툴킷이 `Link` 생성·병합 연산을 갖춘다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 274 | 299 | 하이퍼미디어 응답은 **`RepresentationModel` 또는 그 하위 타입**으로 감싸야 한다. 4가지 — `RepresentationModel`·`EntityModel<T>`·`CollectionModel<T>`·`PagedModel<T>` | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 274–275 | 299–300 | **단일 항목과 컬렉션은 서로 다른 링크 집합**을 가질 수 있다. 풍부한 컬렉션은 `CollectionModel<EntityModel<T>>`로 표현한다 — 컬렉션 전체는 집합 루트 링크를, 각 항목은 자기 단일 리소스 링크와 집합 루트로 돌아가는 링크를 갖는다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 275 | 300 | 집합 루트 endpoint `Mono<CollectionModel<EntityModel<Employee>>> employees()` 전문과 차이점 4개 설명(`flatMap`으로 selfLink 위를 지나 `DATABASE.keySet()` 순회, `employee(key)` 재사용, `collectList`, `CollectionModel.of`) | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 275–276 | 300–301 | 앞 메서드보다 복잡한 것이 맞다. 그래도 **웹 컨트롤러 메서드를 하이퍼미디어 렌더링에 직접 물리면** 이후 조정이 자동으로 반영된다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 276–277 | 301–302 | `curl -v localhost:8080/hypermedia/employees`를 `jq`에 파이프한 출력 전문 — `_embedded.employeeList` 3건, 각 항목의 `self`·`employees` 링크, 컬렉션의 `self` 링크 | [[06-building-reactive-hypermedia-apis]] | 반영 (요약 인용) |
| 277 | 302 | `_link`는 HAL의 하이퍼미디어 링크 형식으로 link relation과 href를 담는다. **컬렉션의 self는 맨 아래**, 각 Employee는 자기 self와 집합 루트로 가는 employees 링크를 갖는다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 277 | 302 | Note: 거의 모든 표현에 **self 링크**가 있다. "this"의 개념이며 **문맥이 중요하다** — 위 HAL 출력에는 self가 셋인데 **마지막 것만 이 문서의 self**이고 나머지는 개별 레코드의 canonical link다. 링크는 본질적으로 불투명하므로 그것으로 레코드에 이동할 수 있다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 277–278 | 302–303 | **하이퍼미디어의 진짜 목적** — 장식용 링크가 아니라 **서버가 리소스의 현재 상태에 따라 가능한 동작을 클라이언트에게 안내**하는 것. `takePTO`·`fileExpenseReport`·`contactManager` 예. 휴가를 다 쓴 직원에게 `takePTO`는 유효하지 않다 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 278 | 303 | 업무 규칙에 따라 링크가 나타나거나 사라지면 클라이언트는 **하드코딩하거나 추론할 필요가 없다.** 얻는 것 4가지 — 런타임 주도 워크플로, 책임 분리, 안전한 API 진화, 문맥 인식 UI | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 278 | 303 | Summary — Reactor로 리액티브 앱, JSON을 내고 받는 리액티브 웹 메서드, Thymeleaf로 HTML 생성과 폼 소비, Spring HATEOAS로 하이퍼미디어 API. **같은 Spring Web 애노테이션을 그대로 재사용**했다. 다음 장은 실제 데이터 | [[_map]] | 반영 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | Reactive Streams 공식 인용문 | 252 | [[01-reactive-programming-and-backpressure]] | 반영 |
| 2 | 네 인터페이스 목록 (`Publisher`·`Subscriber`·`Subscription`·`Processor`) | 254 | [[01b-reactive-streams-details]] | 반영 |
| 3 | `Flux.just(...).filter(...).map(...)` 예제 | 255 | [[01b-reactive-streams-details]] | 반영 |
| 4 | 구독 5단계 시퀀스 | 255–256 | [[01b-reactive-streams-details]] | 반영 |
| 5 | Initializr 좌표 9개 + 의존성 1개 | 256 | [[02-creating-a-webflux-application]] | 반영 |
| 6 | pom 좌표 2개와 각각의 역할 | 257 | [[02-creating-a-webflux-application]] | 반영 |
| 7 | `ApiController.employees()` — `Flux<Employee>` | 258 | [[03-serving-data-with-reactive-get]] | 반영 |
| 8 | `concatWith` · `mergeWith` 예제 | 258 | [[03-serving-data-with-reactive-get]] | 반영 |
| 9 | `ApiController.add()` — `Mono<Employee>` + `@RequestBody` | 259–260 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 10 | Thymeleaf 의존성 2개 (EXPLORE 복사) | 264 | [[05-rendering-reactive-templates]] | 반영 |
| 11 | `HomeController.index()` — `Mono<Rendering>` | 264 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 12 | `index.html` 템플릿 전문 | 266 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 13 | `index()`에 `newEmployee` 모델 속성 추가 | 267 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 14 | `<form th:action th:object th:field>` | 268 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 15 | `HomeController.newEmployee()` — `@ModelAttribute` + `redirect:/` | 268 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 16 | `spring-hateoas` 의존성 | 272 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 17 | `HypermediaController` 골격 + `@EnableHypermediaSupport(type = HAL)` | 272 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 18 | 단일 항목 `employee(String key)` — `linkTo`·`methodOn`·`Mono.zip` | 272–273 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 19 | 집합 루트 `employees()` — `flatMap`·`collectList`·`CollectionModel.of` | 275 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 20 | `curl` + HAL JSON 출력 전문 | 276–277 | [[06-building-reactive-hypermedia-apis]] | 반영 (요약) |

## 3. Tip / Note 블록 → 노트 매핑

| # | Note 내용 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | 소스는 저장소 `ch9` 폴더 | 252 | [[02-creating-a-webflux-application]] | 반영 |
| 2 | `just`로 미리 채운 Flux는 실제와 다르다 — 실제로는 리액티브 DB·원격 서비스를 연결 | 259 | [[03-serving-data-with-reactive-get]] | 반영 |
| 3 | `RouterFunction`·`HandlerFunction` 함수형 라우팅 — 성능 이점 없음, 스타일의 차이 | 260 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 4 | `map`은 1:1, 중첩을 걷어내는 것이 flattening, `flatMap`은 한 단계로 | 261 | [[04-consuming-data-with-reactive-post]] | 반영 |
| 5 | 컨테이너 안에서 map하고 계속 안에 두는 함수형 기본 | 265 | [[05a-creating-a-reactive-web-controller]] | 반영 |
| 6 | "Spring WebFlux는 그만한 값을 하나?" — MVC도 유효, 가상 스레드라는 다른 길 | 270 | [[05b-crafting-a-thymeleaf-template]] | 반영 |
| 7 | `spring-boot-starter-hateoas`는 MVC 전용, WebFlux에는 `spring-hateoas` 직접 | 271 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 8 | `@EnableHypermediaSupport`는 한 번만, 실제로는 메인 클래스에 | 272 | [[06-building-reactive-hypermedia-apis]] | 반영 |
| 9 | self 링크의 문맥 — HAL 출력의 self 셋 중 마지막만 이 문서의 self | 277 | [[06-building-reactive-hypermedia-apis]] | 반영 |

## 4. Figure 처리 판단

`pdfimages -f 276 -l 303 -list`로 raster **3개**(PDF pp. 292·294·295)를 확인하고 전부 PNG로 추출해 **육안 확인**한 뒤, **한 장도 `_assets/`에 넣지 않았다.**

| Figure | 책 쪽 | 내용 (육안 확인) | 판단 |
|---|---:|---|---|
| 9.1 | 267 | 브라우저 창 — 제목 `Employees`, 불릿 3개(Frodo Baggins/ring bearer, Samwise Gamgee/gardener, Bilbo Baggins/burglar). CSS 없는 기본 HTML | **미추출**. 데이터도 마크업도 본문에 전문이 실려 있고, **화면 어디에도 리액티브에 관한 정보가 없다.** 같은 화면이 Spring MVC로도 똑같이 나온다 |
| 9.2 | 269 | 같은 화면 + 라벨 없는 텍스트 입력 두 칸에 `Gandalf`·`wizard`를 입력하고 Submit 버튼 | **미추출**. `th:field` 두 개와 submit이 만든 결과이며 템플릿 코드가 그대로 설명한다 |
| 9.3 | 270 | Submit 후 홈으로 redirect — 불릿 4개(Gandalf/wizard 추가), 입력 칸은 비워짐 | **미추출**. 9.2 → 9.3의 대비가 보여 주는 POST-redirect-GET 왕복은 [[05b-crafting-a-thymeleaf-template]]의 Mermaid sequence로 재현했다. 브라우저 크롬과 북마크 바가 화면의 절반을 차지해 정보 밀도도 낮다 |

Ch11 Figure 11.1과 같은 판단이다 — **스타일 없는 HTML 화면이고 그 장의 주제에 대한 정보가 담겨 있지 않다.**

## 5. 원문의 오류·공백 (노트에 명시)

| # | 원문 | 실제 | 노트 반영 |
|---:|---|---|---|
| 1 | p.275 집합 루트 설명에 **`InIn this case,`** — 오타 | `In this case,` | [[06-building-reactive-hypermedia-apis]] §5 |
| 2 | p.272 `@EnableHypermediaSupport(type = HAL)`을 그대로 제시 | `HAL`은 `HypermediaType.HAL`의 static import를 전제한다. 책이 import 목록을 보이지 않아 그대로 붙여 넣으면 컴파일되지 않는다 | [[06-building-reactive-hypermedia-apis]] §5 |
| 3 | p.268 POST 핸들러가 `Mono<String>`에 `"redirect:/"` 문자열을 담는다 | 동작하지만, **WebFlux에는 `Rendering.redirectTo(String)`이라는 타입 있는 대안**이 있다(`spring-webflux` 7.0.9 확인). 같은 장에서 `Rendering`을 이미 쓰고 있는데 redirect만 문자열 규약으로 돌아간다 | [[05b-crafting-a-thymeleaf-template]] §5 |
| 4 | p.261 "Reactor가 두 가지를 한다"로 시작하는 절이 **POST 절 뒤에** 배치됐다 | `Scaling applications with Project Reactor`와 `Quick history of Java concurrent programming`은 내용상 §1(리액티브란 무엇인가)의 연장이다. POST 예제와 아무 관련이 없어 읽는 순서가 끊긴다 | [[_map]] 축 1에 읽기 순서 안내 |
| 5 | p.263 "4코어에 Reactor 스레드 4개인데 하나가 블로킹되면 **전체 처리량의 25%**가 날아간다" | 산술적으로는 맞지만 **낙관적 하한**이다. 블로킹이 event loop을 잡으면 그 스레드에 배정된 모든 연결이 함께 멈추므로, 실제 영향은 요청 분배에 따라 25%를 크게 넘을 수 있다 | [[04b-java-concurrency-history]] §5 |
| 6 | p.254 "Reactive Streams는 인터페이스 4개뿐인 매우 단순한 명세" | 인터페이스는 넷이 맞지만 명세의 본체는 **TCK와 규칙 문서**다. `request(n)`의 누적 의미, 취소 후 시그널 금지 같은 규칙이 구현의 실제 난이도를 만든다 | [[01b-reactive-streams-details]] §5 |
| 7 | p.270 Note가 가상 스레드를 "다른 길"로 언급하고 끝난다 | 이 책 자신의 Chapter 11이 그 길을 다룬다. 두 선택지의 **결정 기준**은 어느 쪽에서도 정면으로 비교되지 않는다 | [[05b-crafting-a-thymeleaf-template]] §6 |

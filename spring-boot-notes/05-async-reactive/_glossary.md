# 05-async-reactive 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 가상-스레드 (virtual thread)
JVM(Project Loom)이 자체적으로 관리하는 초경량 스레드로, OS 플랫폼 스레드에 1:1로 매핑되지 않고 M:N으로 다중화되어 수백만 개를 동시에 생성할 수 있는 Java 21/25의 동시성 기술.
- 처음 나온 곳: [[01-virtual-threads-loom-concurrency]]
- 섞이는 말: [[플랫폼-스레드]]

## 플랫폼-스레드 (platform thread)
운영체제(OS)의 커널 스레드에 1:1로 직접 매핑되어 생성 비용과 컨텍스트 스위칭 비용이 크고 메모리 점유율(스택 ~1MB)이 높은 전통적인 자바 스레드.
- 처음 나온 곳: [[01-virtual-threads-loom-concurrency]]
- 섞이는 말: [[가상-스레드]]

## 리액티브-스트림즈 (reactive streams)
비동기 논블로킹 방식으로 데이터 스트림을 처리하고 소비자의 처리 속도에 맞춰 데이터 흐름량을 제어(백프레셔)하기 위한 표준 인터페이스 명세 (Project Reactor의 `Mono`, `Flux`).
- 처음 나온 곳: [[02-reactive-streams-reactor-core]]
- 섞이는 말: [[백프레셔]], [[웹플럭스]]

## 백프레셔 (backpressure)
데이터 생산자(Producer)의 발행 속도가 데이터 소비자(Consumer)의 처리 속도보다 빠를 때, 소비자가 감당할 수 있는 만큼만 데이터를 요청하여 메모리 고갈(OOM)을 방지하는 흐름 제어 메커니즘.
- 처음 나온 곳: [[02-reactive-streams-reactor-core]]
- 섞이는 말: [[리액티브-스트림즈]]

## 웹플럭스 (webflux)
Netty 등 논블로킹 I/O 웹 서버를 기반으로 적은 수의 스레드로 대규모 동시 연결과 실시간 스트리밍을 처리하는 Spring의 리액티브 웹 프레임워크 (`spring-boot-starter-webflux`).
- 처음 나온 곳: [[03-spring-webflux-controllers-streaming]]
- 섞이는 말: [[리액티브-스트림즈]]

## 하이퍼미디어 (hypermedia)
클라이언트가 서버의 리소스 응답을 받았을 때, 다음에 수행 가능한 관련 액션과 상태 전이 URL 링크(HATEOAS)를 데이터와 함께 동봉하여 전달하는 RESTful 웹 서비스 설계 원칙.
- 처음 나온 곳: [[04-reactive-hypermedia-hateoas]]
- 섞이는 말: [[웹플럭스]]

## 이벤트-기반-아키텍처 (event driven architecture)
서비스들이 서로를 직접 동기 호출하지 않고, 도메인 상태 변경 사건(Event)을 브로커에 발행하고 구독함으로써 결합도를 극도로 낮추는 분산 시스템 아키텍처 (EDA).
- 처음 나온 곳: [[05-event-driven-architecture-kafka-basics]]
- 섞이는 말: [[아파치-카프카]]

## 아파치-카프카 (apache kafka)
대규모 분산 환경에서 실시간 이벤트 스트림을 파티션 단위로 안전하게 영속화하고 고성능으로 발행/구독할 수 있게 해주는 분산 이벤트 스트리밍 플랫폼.
- 처음 나온 곳: [[05-event-driven-architecture-kafka-basics]]
- 섞이는 말: [[이벤트-기반-아키텍처]], [[데드-레터-토픽]]

## 데드-레터-토픽 (dead letter topic)
최대 재시도 횟수를 초과하여 정상 처리에 실패한 불량 메시지(Poison Pill)를 별도로 격리 수집하여 전체 컨슈머 파이프라인의 중단을 막고 사후 분석을 가능하게 하는 카프카 토픽 (DLT).
- 처음 나온 곳: [[06-kafka-reliability-retries-dlq-idempotency]]
- 섞이는 말: [[아파치-카프카]], [[멱등-소비자]]

## 멱등-소비자 (idempotent consumer)
분산 네트워크 재전송으로 인해 동일한 이벤트 메시지가 2회 이상 중복 수신되더라도, 고유 메시지 식별자(Message Key) 검증을 통해 시스템 상태를 단 1회만 정확히 반영하는 신뢰성 패턴.
- 처음 나온 곳: [[06-kafka-reliability-retries-dlq-idempotency]]
- 섞이는 말: [[아파치-카프카]], [[데드-레터-토픽]]

## 구조화된-동시성 (structured concurrency)
동시에 실행되는 여러 비동기 하위 작업들을 단일 코드 블록의 명확한 생명주기 스코프로 묶어, 에러 발생 시 미완료 작업을 자동으로 취소(Short-circuit)하고 스레드 누수를 방지하는 Java 25의 동시성 프로그래밍 패러다임 (`StructuredTaskScope`).
- 처음 나온 곳: [[07-structured-concurrency-and-task-decorator]]
- 섞이는 말: [[가상-스레드]], [[태스크-데코레이터]]

## 태스크-데코레이터 (task decorator)
비동기 스레드 풀이나 가상 스레드로 작업이 위임될 때, 호출 스레드의 컨텍스트(MDC 로깅 ID, SecurityContext, 트레이스 ID)를 복제하여 실행 스레드로 안전하게 전파해 주는 스프링 부트의 확장 인터페이스 (`TaskDecorator`).
- 처음 나온 곳: [[07-structured-concurrency-and-task-decorator]]
- 섞이는 말: [[가상-스레드]], [[구조화된-동시성]]

## 리액티브-데이터-드라이버 (reactive data driver)
Thymeleaf 등 서버사이드 템플릿 엔진에서 대용량 리액티브 `Flux` 스트림을 메모리에 한꺼번에 적재하지 않고, 버퍼 청크 단위로 클라이언트 브라우저에 실시간 스트리밍 렌더링하도록 돕는 컨텍스트 변수 어댑터 (`IReactiveDataDriverContextVariable`).
- 처음 나온 곳: [[08-reactive-thymeleaf-and-r2dbc-template]]
- 섞이는 말: [[웹플럭스]], [[리액티브-스트림즈]]

## 리액티브-데이터-템플릿 (reactive data template)
R2DBC 리포지토리 인터페이스 대신, 유려한 Fluent API와 프로그래밍 방식으로 조건부 비동기 데이터 쿼리 및 매핑을 수행하는 고수준 템플릿 컴포넌트 (`R2dbcEntityTemplate`, `DatabaseClient`).
- 처음 나온 곳: [[08-reactive-thymeleaf-and-r2dbc-template]]
- 섞이는 말: [[웹플럭스]]

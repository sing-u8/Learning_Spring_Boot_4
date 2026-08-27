# Writing Reactive Web Controllers 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## reactive-streams
비동기 스트림 처리와 논블로킹 백프레셔를 표준화하기 위한 JVM 및 JavaScript 런타임 대상의 명세
- 처음 나온 곳: [[01-what-is-reactive]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## backpressure
생산자의 데이터 발행 속도가 소비자의 처리 속도를 압도하지 못하도록, 소비자가 처리 가능한 데이터 양을 역으로 제어하는 메커니즘
- 처음 나온 곳: [[01-what-is-reactive]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## project-reactor
스프링 팀에서 만든 Reactive Streams의 강력한 구현체로, Flux와 Mono를 제공하는 리액티브 툴킷
- 처음 나온 곳: [[01-what-is-reactive]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## webflux
스프링 프레임워크 5.0부터 도입된, 서블릿 스택을 탈피하여 Reactive Streams 기반으로 완전히 새로 짜여진 논블로킹 웹 프레임워크
- 처음 나온 곳: [[02-reactive-spring-boot]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## reactor-netty
Netty의 이벤트 기반 고성능 네트워킹 성능과 Project Reactor의 백프레셔 메커니즘을 결합한 비동기 서버 엔진
- 처음 나온 곳: [[02-reactive-spring-boot]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## assembly
리액티브 연산자(map, filter 등)를 체이닝하여 데이터가 흘러갈 경로와 수행할 작업 명세(레시피)를 선언적으로 구성하는 단계
- 처음 나온 곳: [[03-scaling-with-reactor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## lazy-execution
작성된 코드가 그 즉시 실행되는 것이 아니라, 최종적으로 누군가(Subscriber)가 데이터를 요구(Subscribe)할 때 비로소 실행되는 특성
- 처음 나온 곳: [[03-scaling-with-reactor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## work-stealing
스레드가 특정 I/O 작업의 완료를 멍하니 기다리지 않고, 큐에 쌓인 다른 유효한 작업을 가져와 빈틈없이 처리하는 기법
- 처음 나온 곳: [[03-scaling-with-reactor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## scheduler
Project Reactor 내에서 작업 큐를 관리하고 스레드에 작업을 할당하여 비동기 실행을 관장하는 엔진 (예: boundedElastic, parallel)
- 처음 나온 곳: [[03-scaling-with-reactor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## rendering-builder
WebFlux 환경에서 렌더링할 뷰의 이름과 모델 속성들을 유연하게 결합하여 불변 객체인 Rendering 인스턴스를 만들어주는 스프링의 빌더 클래스
- 처음 나온 곳: [[04-reactive-templates-with-thymeleaf]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## hateoas
클라이언트가 서버로부터 받은 응답(상태)에 포함된 동적 하이퍼미디어 링크만을 바탕으로 다음 상태(애플리케이션 상태 전이)로 이동하게 하는 REST 아키텍처 성숙도의 최고 단계
- 처음 나온 곳: [[05-creating-hypermedia-reactively]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## hal
Hypertext Application Language의 약자로 JSON 형식 내에서 하이퍼링크 리소스(_links)와 임베디드 리소스(_embedded)를 일관된 규격으로 표현하기 위한 표준 스펙
- 처음 나온 곳: [[05-creating-hypermedia-reactively]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

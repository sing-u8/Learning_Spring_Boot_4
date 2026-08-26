# 05-async-reactive 개념 맵

```
01-virtual-threads-loom-concurrency (Java 25 가상 스레드 동시성)
  │
  ├──▶ 07-structured-concurrency-and-task-decorator (구조화된 동시성과 TaskDecorator)
  │
  ├──▶ 02-reactive-streams-reactor-core (Reactive Streams 표준 & Reactor Mono/Flux)
  │      │
  │      ├──▶ 03-spring-webflux-controllers-streaming (WebFlux 실시간 SSE 스트리밍)
  │      │      │
  │      │      └──▶ 08-reactive-thymeleaf-and-r2dbc-template (Thymeleaf DataDriver & R2DBC 템플릿)
  │      │
  │      └──▶ 04-reactive-hypermedia-hateoas (반응형 HATEOAS 하이퍼미디어)
  │
  └──▶ 05-event-driven-architecture-kafka-basics (이벤트 기반 아키텍처와 Apache Kafka)
         │
         └──▶ 06-kafka-reliability-retries-dlq-idempotency (카프카 재시도, DLT, 멱등 소비자)
```

## 핵심 개념 목록
- [[01-virtual-threads-loom-concurrency]] — Java 25 가상 스레드와 Spring Boot 동시성 모델
- [[02-reactive-streams-reactor-core]] — Reactive Streams 표준과 Project Reactor 핵심 원리
- [[03-spring-webflux-controllers-streaming]] — Spring WebFlux 컨트롤러와 실시간 스트리밍
- [[04-reactive-hypermedia-hateoas]] — Spring HATEOAS 기반 반응형 하이퍼미디어 구축
- [[05-event-driven-architecture-kafka-basics]] — 이벤트 기반 아키텍처와 Apache Kafka 기초
- [[06-kafka-reliability-retries-dlq-idempotency]] — Kafka 신뢰성 패턴과 재시도, DLT 및 멱등성
- [[07-structured-concurrency-and-task-decorator]] — 구조화된 동시성과 TaskDecorator 컨텍스트 전파
- [[08-reactive-thymeleaf-and-r2dbc-template]] — Thymeleaf 리액티브 데이터 드라이버와 R2DBC 템플릿

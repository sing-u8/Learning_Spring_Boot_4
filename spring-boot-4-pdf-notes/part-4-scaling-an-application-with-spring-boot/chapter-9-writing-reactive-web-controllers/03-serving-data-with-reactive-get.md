---
category: spring-webflux
concept: reactive-get-flux
title: "Reactive GET으로 데이터 제공"
source: "Learning Spring Boot 4, Ch. 9, pp. 257-259 (PDF pp. 282-284)"
terms: [Flux, lazy publisher, concatWith, mergeWith, serialization, subscription]
status: seed
---

# Reactive GET으로 데이터 제공

## 한눈에 보기

WebFlux `@RestController`는 `Flux<Employee>`를 반환할 수 있다. Framework가 HTTP client를 downstream Subscriber로 연결해 subscribe·demand·JSON serialization을 수행한다. `concatWith`는 source 순서를 보존하고 `mergeWith`는 도착 순서대로 interleave한다.

## 1. 왜 이게 필요한가

Data가 DB나 remote service에서 시간차로 도착할 때 모두 모일 때까지 thread와 memory를 붙잡지 않고 준비된 element부터 downstream에 전달할 수 있다. 반환 type 자체가 “미래에 여러 값이 올 수 있다”는 contract를 나타낸다.

## 2. 어떻게 동작하는가

Controller method가 Flux recipe를 반환하면 아직 실행되지 않았다. WebFlux가 response writing을 시작하며 subscribe하고 network capacity에 맞춰 demand를 흘린다. `map`, `filter`, `flatMap`은 data signal을 변환하고 terminal completion/error가 HTTP response lifecycle을 끝낸다.

`Flux.just` hardcoded example은 API 모양을 보여주지만 실제 scalability evidence는 아니다. Real source가 reactive DB/client여야 하며 response media type과 codec에 따라 element를 streaming할지 buffer할 수도 있다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    G[GET /api/employees] --> C[Controller Flux]
    C --> S[WebFlux subscribes]
    S --> D[demand]
    D --> E[Employee onNext]
    E --> J[JSON encoding]
    J --> H[HTTP response]
```

## 4. 이 노트에 나온 용어

- **Flux**: Reactor의 0..N asynchronous sequence.
- **lazy publisher**: subscribe/demand가 오기 전 실제 work를 시작하지 않는 Publisher.
- **concat/merge**: source 순서를 이어 붙이는 결합과 arrival time으로 interleave하는 결합.

## 7. 연결

- [[01-reactive-programming-and-backpressure]] — Flux가 구현하는 기본 contract다.
- [[04-consuming-data-with-reactive-post]] — request body도 Mono로 받아 pipeline을 잇는다.
- [[chapter-10-working-with-data-reactively/03-creating-reactive-repositories-and-r2dbc-access|R2DBC access]] — hardcoded source를 실제 reactive DB publisher로 바꾼다.

## 8. 스스로 확인

- 전체 1차 정리 후: `concatWith`와 `mergeWith`의 결과 순서 차이를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



# Chapter 9 지도 — Reactive Web Controllers

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    R[01 Reactive Streams] --> W[02 WebFlux runtime]
    W --> G[03 GET Flux]
    W --> P[04 POST Mono]
    G --> T[05 Reactive template]
    P --> T
    G --> H[06 Hypermedia]
```

## 동시성 모델 축

| 모델 | 기다림 처리 | Programming style |
|---|---|---|
| MVC platform threads | thread가 block | imperative |
| MVC virtual threads | 값싼 virtual thread가 block | imperative |
| WebFlux | event loop가 I/O signal로 재개 | Publisher pipeline |

## 완전한 chain 원칙

Web server만 reactive여서는 부족하다. Controller → client → database가 모두 non-blocking이고 backpressure를 전달해야 event-loop 확장성이 유지된다.


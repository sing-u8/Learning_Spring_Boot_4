# Chapter 10 지도 — Working with Data Reactively

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    E[01 End-to-end 요구] --> R[02 R2DBC 선택]
    R --> P[03 Repository·Template]
    P --> W[04 API·Template 연결]
    W --> H[완전한 reactive HTTP↔DB chain]
```

## JPA와 R2DBC 축

| 관점 | JPA/JDBC | Spring Data R2DBC |
|---|---|---|
| I/O | blocking | non-blocking Publisher |
| Entity state | persistence context·dirty checking | explicit mapped operation |
| CRUD return | entity/list | Mono/Flux |
| 적합한 web model | MVC/virtual threads | WebFlux |


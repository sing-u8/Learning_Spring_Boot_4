# Chapter 8 지도 — Going Native

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    W[01 Cold-start 동기] --> C[02 Closed world]
    C --> B[03 Local native build]
    C --> H[05 Runtime hints]
    H --> B
    B --> I[04 Native image container]
    W --> A[06 JVM AOT Cache]
    A --> X[07 JVM/Native/CRaC 비교]
    I --> X
```

## 선택 축

| 우선순위 | 후보 |
|---|---|
| 최대 runtime 유연성·낮은 build 복잡도 | Standard JVM |
| JVM 호환성 유지 + startup 개선 | Java AOT Cache |
| 작은 footprint + 빠른 cold start | GraalVM Native Image |
| 초기화된 JVM의 매우 빠른 복원 | CRaC |

실제 선택은 startup뿐 아니라 throughput, memory, build time, library compatibility, 운영 platform을 함께 benchmark한다.


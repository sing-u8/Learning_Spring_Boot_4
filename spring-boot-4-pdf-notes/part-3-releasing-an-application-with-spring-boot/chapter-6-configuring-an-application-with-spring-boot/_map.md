# Chapter 6 지도 — Configuring an Application

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    T[01 타입 있는 설정] --> P[02 Profile]
    P --> Y[03 YAML·metadata]
    P --> E[04 환경 변수]
    Y --> O[05 우선순위]
    E --> O
    O --> R[동일 artifact, 환경별 behavior]
```

## 역할 축

| 관심사 | 도구 | 핵심 |
|---|---|---|
| 설정 소비 | `@ConfigurationProperties` | type-safe contract |
| 환경 변형 | profiles | baseline 위에 차이 layering |
| 표현 형식 | Properties/YAML | 같은 Environment model |
| 배포 주입 | env/external files | immutable artifact 유지 |
| 충돌 해결 | precedence | 최종 값의 origin 추적 |


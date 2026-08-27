# Chapter 5 지도 — Testing with Spring Boot

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    J[01 도구] --> D[02 Domain unit]
    J --> W[03 MVC slice]
    D --> M[04 Service mock]
    M --> E[05 Embedded DB]
    E --> A[06 Testcontainers 추가]
    A --> P[07 PostgreSQL container]
    W --> S[08 Security matrix]
```

## 현실성 ↔ 속도 축

| 범위 | 속도 | 실제성과 주요 목적 |
|---|---|---|
| Domain unit | 매우 빠름 | 순수 object 규칙 |
| Service + mocks | 빠름 | 분기와 collaborator protocol |
| MVC/Data slice | 중간 | framework mapping·query |
| Testcontainers | 느림 | 실제 DB product behavior |

## 위험 축

빠른 테스트를 많이 두고, mock이 숨기는 통합 위험은 slice와 container test로 선택적으로 덮는다. 보안은 허용과 거부 경로를 모두 검증한다.


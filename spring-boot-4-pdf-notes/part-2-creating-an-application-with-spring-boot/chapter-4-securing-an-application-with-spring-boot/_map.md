# Chapter 4 지도 — Securing an Application

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart TD
    F[01 Filter chain] --> U[02 사용자 source]
    U --> D[03 DB 사용자]
    D --> R[04 경로·동사 인가]
    R --> C[05 CSRF]
    R --> M[06 method ownership]
    F --> O[07 OAuth/OIDC]
    O --> G[08 Google·YouTube]
    G --> T[09 TLS]
    D --> H[10 password hashing]
```

## 보호 대상 축

| 대상 | 주된 위협 | 방어 경계 |
|---|---|---|
| 요청자 identity | credential 위조 | 인증 filter·UserDetails/OIDC |
| URL·행동 | 과도한 권한 | request authorization |
| 브라우저 상태 변경 | CSRF | token 검증 |
| 개별 데이터 | 타 사용자 자원 접근 | method security·ownership |
| 이동 데이터 | 도청·변조 | TLS·certificate |
| 저장 password | DB 유출 | BCrypt hash |

## 핵심 원칙

인증, URL 인가, 객체 인가, 전송 보호, 저장 보호는 겹치는 층이다. 한 층이 다른 층을 대체하지 않는다.


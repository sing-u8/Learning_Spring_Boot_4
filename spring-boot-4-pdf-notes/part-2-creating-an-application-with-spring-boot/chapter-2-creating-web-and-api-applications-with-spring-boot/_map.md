# Chapter 2 지도 — Web and API Applications

## 기능 성장 흐름

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    I[01 Initializr] --> C[02 MVC Controller]
    C --> T[04 Mustache]
    T --> A[05 JSON API]
    A --> N[06 Node 통합]
    N --> R[07 React]
    A --> V[08 API 버전]
    V --> H[09 HTTP Client]
    A --> J[10 JSpecify]
    X[03 기존 프로젝트 확장] --> T
```

## 표현 경계 축

| 소비자 | 진입 애노테이션 | 표현 | 핵심 노트 |
|---|---|---|---|
| 브라우저 페이지 | `@Controller` | Mustache HTML | [[04-leveraging-templates-to-create-content]] |
| 기계·SPA | `@RestController` | Jackson JSON | [[05-creating-json-based-apis]] |
| 원격 Java 코드 | `@HttpExchange` | 타입 있는 HTTP client | [[09-calling-versioned-apis-with-http-service-clients]] |

## 변경 위험 축

`화면 상태 복잡성 → React`, `공개 계약 변화 → API versioning`, `값의 부재 → JSpecify`로 서로 다른 위험을 다룬다.

## 다음 Chapter로

현재 `VideoService`는 메모리 목록만 가진다. Chapter 3은 이를 엔티티와 Spring Data 저장소로 교체한다.


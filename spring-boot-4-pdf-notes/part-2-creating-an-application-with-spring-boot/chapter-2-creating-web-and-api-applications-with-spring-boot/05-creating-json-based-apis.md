---
category: spring-mvc
concept: json-rest-controller
title: "JSON 기반 API 만들기"
source: "Learning Spring Boot 4, Ch. 2, pp. 43-48 (PDF pp. 68-73)"
terms: [REST controller, Jackson, serialization, deserialization, request body, HTTP semantics]
status: seed
---

# JSON 기반 API 만들기

## 한눈에 보기

`@RestController`는 반환값을 뷰 이름이 아니라 HTTP 응답 본문으로 해석한다. Spring Web이 제공한 Jackson은 `List<Video>`를 JSON 배열로 직렬화하고, `@RequestBody Video`는 들어온 JSON을 Java 객체로 역직렬화한다.

## 1. 왜 이게 필요한가

하나의 백엔드는 사람용 서버 렌더링 화면뿐 아니라 모바일 앱, JavaScript 프런트엔드, 외부 시스템을 위한 기계 판독 인터페이스도 제공해야 한다. 서비스 계층을 공유하고 표현 방식만 나누면 도메인 동작의 중복을 줄일 수 있다.

## 2. 어떻게 동작하는가

1. `@RestController`도 컴포넌트 스캔으로 Bean과 MVC 컨트롤러가 된다.
2. `GET /api/videos`는 서비스의 목록을 반환하고 메시지 변환기가 JSON으로 직렬화한다.
3. `POST /api/videos`의 `Content-Type: application/json` 요청 본문을 `@RequestBody`가 Jackson에 넘긴다.
4. Jackson이 JSON 필드를 `Video`에 매핑하고 서비스가 새 항목을 만든다.
5. 반환 객체가 다시 JSON 응답으로 직렬화된다.

HTTP 동사의 의도도 계약의 일부다. GET은 서버 상태를 바꾸지 않는 safe·idempotent 조회, POST는 보통 생성, PUT은 전체 교체 성격의 idempotent 변경, DELETE는 제거를 표현한다. 이 속성은 프레임워크가 자동으로 보장하는 것이 아니라 서버 구현이 지켜야 한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    J[JSON 요청] --> D[Jackson 역직렬화]
    D --> C[@RestController]
    C --> S[VideoService]
    S --> O[Java 객체]
    O --> E[Jackson 직렬화]
    E --> R[JSON 응답]
```

## 4. 이 노트에 나온 용어

- **serialization**: 메모리의 객체를 JSON 같은 전송 표현으로 바꾸는 과정.
- **deserialization**: 전송 표현을 타입 있는 객체로 복원하는 과정.
- **request body**: HTTP 요청의 데이터 본문.
- **idempotent**: 같은 요청을 반복해도 한 번 수행한 것과 최종 상태가 같은 성질.

## 7. 연결

- [[04-leveraging-templates-to-create-content]] — HTML과 JSON이 동일 서비스 데이터를 공유한다.
- [[07-bundling-javascript-and-building-a-react-app]] — React가 이 API를 `fetch`로 소비한다.
- [[08-versioning-apis-with-spring-boot-4]] — 공개된 JSON 계약의 변경을 관리한다.

## 8. 스스로 확인

- 전체 1차 정리 후: `@Controller`와 `@RestController`에서 같은 문자열 반환값이 어떻게 달라지는지 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



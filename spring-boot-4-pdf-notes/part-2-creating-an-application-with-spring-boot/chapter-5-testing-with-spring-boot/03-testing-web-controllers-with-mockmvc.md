---
category: spring-test
concept: mockmvc-web-slice
title: "MockMvc로 Web Controller 테스트"
source: "Learning Spring Boot 4, Ch. 5, pp. 161-165 (PDF pp. 186-190)"
terms: [WebMvcTest, MockMvc, web slice, MockitoBean, WithMockUser, CSRF test postprocessor]
status: seed
---

# MockMvc로 Web Controller 테스트

## 한눈에 보기

`@WebMvcTest(HomeController.class)`는 전체 애플리케이션 대신 MVC 관련 Bean만 올리고 `MockMvc`로 가짜 서버 요청을 수행한다. controller의 `VideoService` collaborator는 `@MockitoBean`으로 교체하며 Spring Security filter도 적용된다.

## 1. 왜 이게 필요한가

controller method를 직접 호출하면 request mapping, argument binding, view rendering, filter, status·redirect를 건너뛴다. 실제 port를 열고 end-to-end로 실행하면 피드백이 느리다. MVC slice는 web machinery를 포함하면서 데이터·외부 서비스는 제외한다.

## 2. 어떻게 동작하는가

`mvc.perform(get("/"))` 뒤에 status와 HTML 내용을 assertion한다. `@WithMockUser`는 security context에 test principal을 넣는다. POST form은 `.param`으로 값을 주고 `.with(csrf())`로 유효 token을 추가한다. redirect URL을 확인한 뒤 `verify(videoService).create(..., "user")`로 controller가 인증 이름과 DTO를 올바르게 넘겼는지 검증한다.

Boot 4에서 `@WebMvcTest` package와 Mockito 기반 Bean override 이름이 바뀌었으므로 import를 확인한다. MockMvc는 실제 network stack이나 JavaScript 동작을 시험하지 않는다는 경계도 기억한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    T[Test method] --> M[MockMvc request]
    M --> F[Security + MVC filters]
    F --> C[HomeController]
    C --> S[@MockitoBean service]
    C --> R[status·view·redirect·body]
    R --> A[assertions]
    S --> V[verify interaction]
```

## 4. 이 노트에 나온 용어

- **web slice**: MVC에 필요한 context 부분만 선택적으로 로딩한 테스트 범위.
- **MockMvc**: 실제 server socket 없이 Spring MVC request/response pipeline을 실행하는 도구.
- **MockitoBean**: application context의 특정 Bean을 Mockito mock으로 override하는 테스트 애노테이션.

## 7. 연결

- [[04-testing-services-with-mocks]] — controller에서 사용한 mock의 unit-test 원리를 더 깊게 본다.
- [[08-testing-security-policies]] — 동일한 MockMvc로 보안 성공·실패 행렬을 검증한다.
- [[chapter-4-securing-an-application-with-spring-boot/05-protecting-against-csrf|CSRF]] — POST 테스트에 token을 넣는 이유다.

## 8. 스스로 확인

- 전체 1차 정리 후: controller direct call과 MockMvc test가 검증하는 범위 차이를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



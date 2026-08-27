---
category: spring-security
concept: method-security-ownership
title: "데이터 메서드와 객체 소유권 보호"
source: "Learning Spring Boot 4, Ch. 4, pp. 116-126 (PDF pp. 141-151)"
terms: [method security, ownership, Authentication, PreAuthorize, EnableMethodSecurity, SpEL]
status: seed
---

# 데이터 메서드와 객체 소유권 보호

## 한눈에 보기

URL 역할만으로는 “Alice가 Bob의 동영상을 삭제할 수 없는가?”를 판단할 수 없다. Entity에 owner username을 저장하고 repository `delete(entity)`에 `@PreAuthorize("#entity.username == authentication.name")`를 적용하면 현재 principal과 대상 객체를 비교한다.

## 1. 왜 이게 필요한가

두 요청이 같은 DELETE/POST 경로와 같은 USER 역할을 사용해도 대상 자원의 소유자가 다르면 결과가 달라야 한다. 객체 수준 규칙을 URL 조합으로 표현하면 컨트롤러 밖의 호출 경로에서 우회될 수 있다. 실제 데이터 연산 경계에 정책을 둔다.

## 2. 어떻게 동작하는가

1. `VideoEntity`에 username ownership을 추가한다.
2. 생성 컨트롤러가 Spring MVC로 주입된 `Authentication.getName()`을 서비스에 넘겨 소유자를 기록한다.
3. 삭제 UI는 CSRF token과 video ID를 POST한다.
4. 서비스가 ID로 Entity를 읽고 repository `delete`를 호출한다.
5. overridden method의 `@PreAuthorize` SpEL이 인자 owner와 현재 인증 이름을 비교한다.
6. `@EnableMethodSecurity`가 프록시 기반 pre/post 검사를 활성화한다. 실패하면 403이 된다.

템플릿에 username·authorities를 보여주고 POST `/logout`을 만들 수 있지만 password 같은 민감 정보는 절대 노출하지 않는다. UI에서 버튼을 숨기는 것은 편의일 뿐 서버 method check를 대신하지 않는다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    U[현재 Authentication.name] --> P[@PreAuthorize]
    I[delete 대상 Entity.username] --> P
    P --> C{같은가?}
    C -- 예 --> D[repository.delete 실행]
    C -- 아니오 --> F[403 Forbidden]
```

## 4. 이 노트에 나온 용어

- **method security**: Spring Bean 메서드 호출 전후에 authorization을 적용하는 기능.
- **ownership**: 특정 사용자와 자원 사이의 소유 관계.
- **SpEL**: 메서드 인자·인증 문맥을 참조해 조건을 쓰는 Spring Expression Language.
- **PreAuthorize**: 메서드 실행 전에 표현식 기반 접근을 검사하는 애노테이션.

## 7. 연결

- [[04-securing-web-routes-and-http-verbs]] — URL 수준의 거친 정책을 객체 수준으로 보완한다.
- [[05-protecting-against-csrf]] — 삭제 폼은 소유권 검사와 별도로 요청 위조도 막아야 한다.
- [[chapter-5-testing-with-spring-boot/08-testing-security-policies|보안 정책 테스트]] — owner/non-owner 성공·실패 경로를 검증한다.

## 8. 스스로 확인

- 전체 1차 정리 후: UI에서 삭제 버튼을 숨겨도 repository method security가 필요한 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



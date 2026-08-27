---
category: spring-test
concept: data-jpa-embedded-test
title: "Embedded Database로 Repository 테스트"
source: "Learning Spring Boot 4, Ch. 5, pp. 169-174 (PDF pp. 194-199)"
terms: [DataJpaTest, embedded database, HSQLDB, test transaction, SQL dialect, repository integration test]
status: seed
---

# Embedded Database로 Repository 테스트

## 한눈에 보기

`@DataJpaTest`는 Entity와 JPA repository 중심의 slice를 올리고 클래스패스의 HSQLDB 같은 embedded DB로 DataSource를 구성한다. 각 test 전에 데이터를 넣어 custom finder의 대소문자·부분 일치와 실제 mapping을 검증한다.

## 1. 왜 이게 필요한가

Mock repository는 서비스가 기대한 method를 호출했는지만 말할 뿐 method name이 올바른 SQL로 번역되는지는 확인하지 못한다. Embedded DB는 같은 process에서 빠르게 실제 JPA provider와 repository proxy를 실행한다.

## 2. 어떻게 동작하는가

`@DataJpaTest`가 필요한 persistence Bean만 scan하고 test transaction으로 격리한다. `@BeforeEach`에서 세 Entity를 저장한 뒤 `findByNameContainsIgnoreCase` 같은 application query의 결과 수와 field를 AssertJ `extracting`으로 확인한다. 순서 조건이 없는 SQL은 insertion order를 보장하지 않으므로 순서 무관 assertion을 쓴다.

Embedded DB는 빠른 모형 도로다. SQL 표준 차이, case sensitivity, index, transaction/locking behavior가 PostgreSQL 등 운영 engine과 다를 수 있어 production parity의 최종 증거가 아니다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    T[@DataJpaTest] --> C[JPA slice]
    C --> R[실제 Repository proxy]
    R --> H[(HSQLDB in-process)]
    H --> Q[query 결과]
    Q --> A[AssertJ]
```

## 4. 이 노트에 나온 용어

- **embedded database**: application process 안에서 실행 가능한 경량 DB engine.
- **DataJpaTest**: JPA Entity·repository와 관련 자동 구성만 로딩하는 test slice.
- **SQL dialect**: DB 제품이 SQL 표준을 구현·확장하는 구체적 문법과 behavior.

## 7. 연결

- [[04-testing-services-with-mocks]] — 더 빠르지만 실제 persistence를 제외한 계층이다.
- [[06-adding-testcontainers]] — 운영 DB dialect 차이를 줄이기 위한 다음 단계다.
- [[07-testing-repositories-with-testcontainers]] — 동일 repository test를 PostgreSQL에 실행한다.

## 8. 스스로 확인

- 전체 1차 정리 후: HSQLDB test가 통과해도 PostgreSQL에서 실패할 수 있는 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



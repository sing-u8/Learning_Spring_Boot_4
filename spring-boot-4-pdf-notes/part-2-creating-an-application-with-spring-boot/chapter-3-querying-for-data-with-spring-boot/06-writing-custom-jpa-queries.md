---
category: spring-data-jpa
concept: custom-jpa-query
title: "Custom JPA와 Native Query 작성하기"
source: "Learning Spring Boot 4, Ch. 3, pp. 93-96 (PDF pp. 118-121)"
terms: [JPQL, Query annotation, named parameter, native SQL, count query, AOT repository]
status: seed
---

# Custom JPA와 Native Query 작성하기

## 한눈에 보기

파생 이름과 QBE로 의도가 흐려지면 `@Query`에 JPQL을 직접 쓰고 위치 또는 이름 파라미터를 바인딩한다. DB 고유 기능·대형 보고서에는 `nativeQuery=true`로 SQL을 사용할 수 있지만 이식성, 동적 정렬, 페이지 count 쿼리 책임이 커진다.

## 1. 왜 이게 필요한가

여러 관계 JOIN, 외부 조인, 집계, 서브쿼리를 긴 메서드 이름에 억지로 담으면 검토가 어렵다. 직접 쿼리는 실제 실행 의도를 한곳에 보여주고 메서드 이름은 `findVideosThatArentPopular`처럼 비즈니스 의미에 집중하게 한다.

## 2. 어떻게 동작하는가

JPQL은 테이블·열이 아니라 Entity와 속성을 대상으로 한다. `:minimumViews` 같은 이름 파라미터는 `@Param` 인자와 결합되어 안전하게 바인딩된다. JPA가 JPQL을 DB SQL로 번역하고 Spring은 연결·트랜잭션·결과 매핑을 계속 관리한다. Native SQL은 번역 계층을 건너뛰므로 데이터베이스 기능을 직접 쓰지만 동적 Sort가 제한되고 Pageable에는 별도 `countQuery`가 필요할 수 있다.

책은 빌드 시 repository 구현을 생성하는 Spring Data AOT도 언급한다. 시작 시간과 디버깅 가능성을 개선할 수 있지만 지원 모듈과 생성 제약을 확인해야 한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart TD
    N{쿼리 복잡도} -- 단순·고정 --> D[Derived finder]
    N -- 선택 조건 --> E[Query by Example]
    N -- 복잡한 Entity 관계 --> J[@Query JPQL]
    N -- DB 고유·대형 보고서 --> S[@Query native SQL]
    J --> M[Spring 트랜잭션·매핑]
    S --> M
```

## 4. 이 노트에 나온 용어

- **JPQL**: 관계형 테이블 대신 JPA Entity 모델을 대상으로 하는 쿼리 언어.
- **native SQL**: JPA 번역 없이 특정 데이터베이스에 직접 전달할 SQL.
- **count query**: 페이지 전체 수 계산에 사용하는 별도 집계 쿼리.
- **AOT repository**: 런타임 대신 빌드 시점에 구현을 생성한 repository.

## 7. 연결

- [[04-using-custom-finders-sorting-and-limits]] — 직접 쿼리로 넘어가기 전 가장 간단한 선택이다.
- [[05-query-by-example-for-dynamic-search]] — 선택적 동등·문자열 검색을 더 짧게 표현한다.
- [[chapter-8-going-native-with-spring-boot/05-configuring-runtime-hints|AOT와 runtime hints]] — 빌드 시 처리와 네이티브 실행의 더 큰 맥락이다.

## 8. 스스로 확인

- 전체 1차 정리 후: JPQL과 native SQL 중 후자를 선택할 때 새로 떠안는 책임을 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



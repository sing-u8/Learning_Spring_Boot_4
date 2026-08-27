---
category: java
concept: jspecify-null-safety
title: "JSpecify로 null-safe 애플리케이션 작성하기"
source: "Learning Spring Boot 4, Ch. 2, pp. 65-69 (PDF pp. 90-94)"
terms: [JSpecify, NullMarked, Nullable, NullUnmarked, NonNull, static analysis]
status: seed
---

# JSpecify로 null-safe 애플리케이션 작성하기

## 한눈에 보기

Spring Boot 4와 Spring Framework 7은 JSpecify를 사용해 API의 null 계약을 명시한다. `@NullMarked`는 범위를 non-null 기본값으로 만들고, 실제로 null을 허용하는 지점만 `@Nullable`로 표시한다. IDE·정적 분석기가 위반을 실행 전에 찾을 수 있다.

## 1. 왜 이게 필요한가

Java 타입만 보면 매개변수·반환값·컬렉션 원소가 null일 수 있는지 알기 어렵다. 그 결과 호출자는 추측하고 `NullPointerException`은 늦게 발견된다. 공통 의미를 가진 애노테이션은 암묵적 가정을 검증 가능한 계약으로 바꾼다.

## 2. 어떻게 동작하는가

- `@NullMarked`: 패키지·클래스·모듈 범위의 참조 타입을 기본 non-null로 본다.
- `@Nullable`: 의도한 null 예외를 표시해 호출자에게 처리를 요구한다.
- `@NullUnmarked`: 기본 규칙을 해제해 레거시·서드파티 코드의 점진적 이행 경계를 만든다.
- `@NonNull`: 혼합 범위나 개별 위치에서 non-null을 명시하지만 NullMarked 안에서는 대개 중복이다.

`package-info.java`의 `@NullMarked`는 하위 패키지에 상속되지 않는다. 제네릭 타입 위치에도 애노테이션을 붙일 수 있어 `List<Video>`와 `List<@Nullable Video>`를 구분한다. 객체 필드의 null 가능성은 컬렉션 원소 null 가능성과 별개다. JSpecify는 `Optional`을 대체하지 않으며, 애노테이션 자체가 런타임 검사를 삽입하지도 않는다. CI에서 NullAway 같은 분석기를 연결해야 빌드 실패 수준의 강제력이 생긴다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart TD
    P[package-info.java @NullMarked] --> D[기본: null 불가]
    D --> M[메서드 매개변수·반환값]
    D --> G[제네릭 원소 타입]
    N[@Nullable 예외] --> M
    N --> G
    M --> I[IDE 검사]
    G --> S[정적 분석·빌드 검사]
```

## 4. 이 노트에 나온 용어

- **nullness contract**: 값이 null일 수 있는지 타입 사용 위치에 명시한 약속.
- **type-use annotation**: 선언뿐 아니라 제네릭 인자 같은 타입 사용 위치에 붙는 애노테이션.
- **static analysis**: 프로그램을 실행하지 않고 코드·타입 흐름을 검사하는 분석.

## 7. 연결

- [[05-creating-json-based-apis]] — JSON 경계의 누락 필드는 null 계약을 시험하는 대표 지점이다.
- [[chapter-15-whats-new-in-spring-boot-4/01-core-framework-and-module-changes|Boot 4 핵심 변화]] — JSpecify 전환이 전체 프레임워크 변화로 다시 정리된다.

## 8. 스스로 확인

- 전체 1차 정리 후: `@NullMarked`가 있어도 런타임 NPE를 완전히 막지는 못하는 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



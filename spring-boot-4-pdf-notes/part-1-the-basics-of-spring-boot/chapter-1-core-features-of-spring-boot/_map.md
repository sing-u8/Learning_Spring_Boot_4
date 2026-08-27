# Chapter 1 지도 — Core Features of Spring Boot

## 목차 흐름

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    T[00 학습 환경] --> A[01 자동 구성]
    A --> S[02 스타터]
    S --> P[03 외부 설정]
    P --> D[04 의존성 관리]
    S --> A
    D --> S
```

## 문제 → 해결 축

| 문제 | Spring Boot의 해법 | 노트 |
|---|---|---|
| 반복되는 인프라 Bean 조립 | 조건부 자동 구성과 back-off | [[01-autoconfiguring-spring-beans]] |
| 기능마다 긴 의존성 목록 | 기술 단위 스타터 | [[02-adding-portfolio-components-using-spring-boot-starters]] |
| 환경마다 다른 값·구현 | 외부 설정, 프로파일, 조건부 Bean | [[03-customizing-the-setup-with-configuration-properties]] |
| 라이브러리 버전 충돌 | Boot BOM과 정렬된 생태계 | [[04-managing-application-dependencies]] |

## 원인 → 결과 축

`스타터 선택 → 클래스패스 변화 → 자동 구성 조건 충족 → 기본 Bean 생성 → 프로퍼티로 조정 → BOM으로 호환성 유지`

## 다음 Chapter로

Chapter 2는 이 네 원리를 실제 웹 프로젝트에 적용한다. Initializr에서 스타터를 선택하고, MVC 컨트롤러·템플릿·JSON API를 순서대로 추가한다.


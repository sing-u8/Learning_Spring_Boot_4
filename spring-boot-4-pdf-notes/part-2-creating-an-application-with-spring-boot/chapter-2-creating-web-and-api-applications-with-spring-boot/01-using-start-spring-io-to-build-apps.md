---
category: spring-boot
concept: spring-initializr
title: "start.spring.io로 애플리케이션 시작하기"
source: "Learning Spring Boot 4, Ch. 2, pp. 26-30 (PDF pp. 51-55)"
terms: [Spring Initializr, project coordinates, JAR, WAR, starter]
status: seed
---

# start.spring.io로 애플리케이션 시작하기

## 한눈에 보기

Spring Initializr는 Boot 버전, 언어, Maven/Gradle, 그룹·아티팩트, Java 버전, 패키징, 설정 형식, 스타터 선택을 받아 재현 가능한 프로젝트 ZIP을 만든다. 책은 Spring Boot 4.1.x, Java 25, Maven, JAR, Properties, Spring Web을 선택한다.

## 1. 왜 이게 필요한가

예전 프로젝트 복사나 블로그의 낡은 POM 조각은 불필요한 파일과 호환되지 않는 버전을 함께 가져온다. Initializr는 현재 Boot 메타데이터로 최소 골격을 생성하여 첫 비즈니스 코드까지의 거리를 줄인다.

## 2. 어떻게 동작하는가

1. 빌드 도구·언어·Boot 버전을 정해 빌드 모델을 고정한다.
2. `group`과 `artifact`로 좌표와 기본 패키지를 정한다.
3. 실행 가능한 JAR 또는 외부 서버용 WAR를 선택한다. 책은 내장 서버를 활용하는 JAR를 기본으로 삼는다.
4. Spring Web 같은 capability를 고르면 대응 스타터가 빌드 파일에 들어간다.
5. GENERATE가 래퍼, 빌드 파일, 애플리케이션 클래스, 테스트 골격을 묶어 내려준다.

Initializr는 프로젝트의 맞춤 재단 패턴이다. 시작 치수는 정확히 잡지만 이후의 패키지 경계와 도메인 설계까지 결정하지는 않는다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    A[Boot·Java·빌드 선택] --> B[좌표·패키징 선택]
    B --> C[스타터 선택]
    C --> D[GENERATE]
    D --> E[래퍼·POM·소스 골격]
    E --> F[IDE 가져오기]
```

## 4. 이 노트에 나온 용어

- **Spring Initializr**: 선택한 메타데이터와 의존성으로 Spring Boot 프로젝트를 생성하는 서비스.
- **project coordinates**: Maven/Gradle이 프로젝트를 식별하는 group·artifact 등의 값.
- **JAR/WAR**: 각각 독립 실행 패키지와 외부 서블릿 컨테이너 배포에 전통적으로 쓰이는 패키지 형식.

## 7. 연결

- [[02-creating-a-spring-mvc-web-controller]] — 생성한 Spring Web 프로젝트의 첫 요청 처리 지점이다.
- [[03-augmenting-an-existing-project-with-initializr]] — 기존 프로젝트에는 GENERATE 대신 EXPLORE를 활용한다.
- [[chapter-1-core-features-of-spring-boot/02-adding-portfolio-components-using-spring-boot-starters|스타터]] — 의존성 선택의 실질적 단위다.

## 8. 스스로 확인

- 전체 1차 정리 후: 책이 JAR를 기본 선택으로 권한 이유를 내장 서버와 연결해 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



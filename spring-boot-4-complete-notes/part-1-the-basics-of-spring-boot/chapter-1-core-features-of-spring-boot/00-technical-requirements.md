---
category: chapter-1-core-features-of-spring-boot
concept: 00-technical-requirements
title: "Technical requirements: Java 25, IDE, and GitHub"
source: "Learning Spring Boot 4 · Ch.1 · 책 p.4–6 / PDF p.29–31"
terms: [jdk, lts, sdkman, ide, github]
status: prepared
---

# Technical requirements: Java 25, IDE, and GitHub

## 한눈에 보기

| 준비물 | 책의 기준 | 확인점 |
|---|---|---|
| Java | JDK 25, Temurin 예시 | `java --version`이 실제로 25를 가리키는가 |
| IDE | IntelliJ IDEA 또는 Spring Tools 4 계열 | Spring Boot 프로젝트를 불러오고 실행할 수 있는가 |
| GitHub | 책의 예제 저장소 접근 | 코드를 내려받고 변경 이력을 관리할 수 있는가 |

## 1. 왜 이게 필요한가

책의 첫 예제를 입력했는데 컴파일러가 문법을 거부하거나 IDE와 터미널이 서로 다른 Java를 사용하면, 이후의 모든 오류가 Spring 문제처럼 보인다. 그래서 기능을 배우기 전에 실행 환경을 하나의 기준으로 맞춘다. 책은 Spring Boot 4.1의 실습 환경으로 Java 25를 사용하며, Spring Boot 4 자체는 Java 17 이상을 전제로 설명한다.

**[[jdk]]**(= Java 코드를 컴파일하고 실행하는 도구 묶음)는 최신 장기 지원 버전인 **[[lts]]**(= 오랫동안 유지보수되는 릴리스) 25를 사용한다. 여러 JDK를 바꾸어 써야 한다면 **[[sdkman]]**(= 셸에서 SDK 버전을 설치·전환하는 도구)이 편리하다. **[[ide]]**(= 편집·빌드·실행·디버깅을 묶은 개발 환경)는 취향에 맞게 선택하고, **[[github]]**(= Git 저장소를 호스팅하고 협업하는 서비스)에서 책의 예제 코드를 확인한다.

### 비유로 잡기

실습 환경은 요리 전에 칼, 불, 계량컵을 같은 단위로 맞추는 준비와 비슷하다. 재료가 같아도 도구의 눈금이 다르면 결과를 비교할 수 없다.

→ 비유가 깨지는 지점: 개발 도구는 수동 도구와 달리 프로젝트·터미널·CI마다 서로 다른 버전을 조용히 선택할 수 있다. 한 번 설치한 뒤에도 각 실행 지점의 버전을 확인해야 한다.

## 2. 어떻게 동작하는가

1. **JDK를 설치한다** — 컴파일러와 런타임의 기준을 책과 맞추기 위해서다. 책은 SDKMAN으로 Temurin 25를 설치하는 흐름을 예로 든다.
2. **터미널에서 버전을 검증한다** — 설치 성공과 현재 활성 버전은 다른 문제이므로 `java --version`으로 실제 선택을 확인한다.
3. **IDE의 Project SDK를 맞춘다** — IDE가 자체 JDK를 가리키면 터미널 빌드와 결과가 달라질 수 있기 때문이다.
4. **GitHub 예제 저장소를 준비한다** — 입력 실수를 원본과 비교하고 Chapter별 완성 상태를 확인하기 위해서다.
5. **상업 지원 여부를 결정한다** — 무료 OpenJDK 배포판으로 충분한지, 조직 정책상 유료 지원 JDK가 필요한지 구분하기 위해서다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': { 'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    A["JDK 25 설치"] --> B["java --version 확인"]
    B --> C["IDE Project SDK = 25"]
    C --> D["책의 GitHub 예제 가져오기"]
    D --> E["Maven Wrapper로 빌드"]
    E --> F["Spring Boot 학습 시작"]
```

## 4. 이 노트에 나온 용어

| 용어 | 한 줄 | 자세히 |
|---|---|---|
| jdk | Java 컴파일러·런타임·개발 도구 묶음 | [[_glossary#jdk]] |
| lts | 장기간 보안 수정과 유지보수를 제공하는 릴리스 | [[_glossary#lts]] |
| sdkman | 여러 SDK 버전을 설치하고 전환하는 셸 도구 | [[_glossary#sdkman]] |
| ide | 코드 작성부터 디버깅까지 통합한 개발 환경 | [[_glossary#ide]] |
| github | Git 저장소 호스팅과 협업 서비스 | [[_glossary#github]] |

## 5. 자주 헷갈리는 것

- **JDK 설치 vs 활성 JDK** — 디스크에 Java 25가 있어도 `PATH`, `JAVA_HOME`, IDE 설정이 Java 17을 가리킬 수 있다. 설치 목록이 아니라 실제 명령과 프로젝트 설정을 확인한다.

## 6. 언제 안 쓰나 / 경계

- SDKMAN은 편리한 선택지일 뿐 필수는 아니다. Windows 네이티브 환경이나 조직 표준 이미지에서는 Temurin 설치 프로그램·패키지 관리자·사내 배포판을 사용할 수 있다.
- IDE 선택은 결과물의 요구사항이 아니다. 다만 책의 화면과 메뉴는 사용하는 IDE에 따라 다를 수 있다.

## 7. 연결

- [[01-autoconfiguring-spring-beans]] — 환경 준비가 끝난 뒤 가장 먼저 Application Context와 자동 구성을 실행해 본다.
- [[02-adding-portfolio-components-using-spring-boot-starters]] — Maven Wrapper와 JDK가 맞아야 스타터 의존성을 같은 버전으로 재현할 수 있다.

## 8. 스스로 확인

1. 터미널에서는 Java 25인데 IDE 실행에서는 Java 17이 쓰일 수 있는 이유는 무엇인가?
2. Temurin과 Oracle JDK의 선택이 Spring Boot 코드 자체보다 조직의 지원 정책과 더 관련 있는 이유는 무엇인가?
3. 책의 예제 저장소를 그대로 실행하는 것과 직접 입력해 보는 것은 학습에서 각각 어떤 역할을 하는가?

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도

## 막혔던 지점

## 리뷰 이력

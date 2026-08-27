---
category: spring-boot
concept: externalized-configuration
title: "Configuration Properties로 설정 사용자화하기"
source: "Learning Spring Boot 4, Ch. 1, pp. 12-20 (PDF pp. 37-45)"
terms: [configuration properties, externalized configuration, profile, property precedence, conditional bean]
status: seed
---

# Configuration Properties로 설정 사용자화하기

## 한눈에 보기

Spring Boot는 서버 포트 같은 기본값을 제공하지만 `application.properties`/YAML, 환경 변수, 시스템 프로퍼티, 명령행 인자 등으로 덮어쓸 수 있다. `@ConfigurationProperties`는 관련 키를 타입 있는 객체에 묶고, `@ConditionalOnProperty`는 값에 따라 Bean 구성을 바꾼다.

## 1. 왜 이게 필요한가

같은 애플리케이션 바이너리를 개발·테스트·운영에서 재사용하려면 서버 주소, 인증 정보, 기능 플래그를 코드 밖으로 빼야 한다. 설정을 하드코딩하면 값 하나를 바꿀 때도 다시 빌드하고, 비밀값이 소스와 산출물에 남는다. 외부 설정은 코드와 배포 환경의 결정을 분리한다.

## 2. 어떻게 동작하는가

`server.port=9000`처럼 기존 자동 구성 값을 덮어쓸 수 있다. 애플리케이션 고유 설정은 `my.app.*` 같은 네임스페이스를 만들고 `@ConfigurationProperties(prefix = "my.app")` 객체에 바인딩한다. 가변 JavaBean은 `@Component`로 등록할 수 있고, record는 `@ConfigurationPropertiesScan` 또는 `@EnableConfigurationProperties`로 명시적으로 등록한다.

설정 소스가 여러 개라면 우선순위가 높은 값이 낮은 값을 덮는다. 책의 핵심 흐름은 패키지 내부 기본 설정 → 외부 파일 → 환경/시스템 값 → 명령행·테스트 오버라이드다. 정확한 전체 목록보다 “더 구체적이고 실행 시점에 가까운 소스가 우선할 수 있다”는 모델이 중요하다.

프로파일은 `application-test.properties`처럼 이름 붙은 환경별 덮어쓰기다. 반면 `@ConditionalOnProperty(prefix="my.app", name="video", havingValue="youtube")`는 설정값을 읽는 데서 더 나아가 어떤 구현 Bean을 만들지 결정한다.

설정은 건물의 배전반과 비슷하다. 같은 내부 배선을 유지한 채 외부 스위치로 동작을 바꾼다. 다만 모든 비밀을 일반 프로퍼티 파일에 두면 배전반에 열쇠를 붙여놓는 셈이므로 운영 비밀 저장소와 접근 제어가 별도로 필요하다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart TD
    A[패키지 내부 기본 설정] --> M[Environment 병합]
    B[외부 application 파일] --> M
    C[활성 profile 파일] --> M
    D[환경 변수·시스템 프로퍼티] --> M
    E[명령행·테스트 override] --> M
    M --> F[@ConfigurationProperties 바인딩]
    M --> G[@ConditionalOnProperty 평가]
    F --> H[타입 있는 설정 Bean]
    G --> I[환경별 구현 Bean]
```

## 4. 이 노트에 나온 용어

- **externalized configuration**: 실행 환경의 값을 애플리케이션 코드·바이너리 밖에서 공급하는 방식.
- **profile**: 함께 활성화할 설정과 Bean의 이름 붙은 집합.
- **binding**: 문자열 기반 설정값을 타입 있는 객체 필드로 변환·주입하는 과정.
- **property precedence**: 같은 키가 여러 소스에 있을 때 최종 값을 정하는 우선순위.

## 7. 연결

- [[01-autoconfiguring-spring-beans]] — 자동 구성 조건과 기본값이 프로퍼티를 소비한다.
- [[chapter-6-configuring-an-application-with-spring-boot/05-ordering-property-overrides|프로퍼티 덮어쓰기 순서]] — Chapter 6에서 환경별 설정을 더 깊게 다룬다.
- [[chapter-4-securing-an-application-with-spring-boot/10-securing-data-in-transit-and-at-rest|데이터 보호]] — 외부화한 비밀값도 저장·전송 보호가 필요하다.

## 8. 스스로 확인

- 전체 1차 정리 후: 프로파일과 `@ConditionalOnProperty`의 역할 차이를 사례로 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



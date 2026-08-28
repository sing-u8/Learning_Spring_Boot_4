# Chapter 1 용어집

> Chapter 1에서 사용하는 전문 용어의 정의 원본이다. 개념 노트에서는 첫 등장 때 이 용어집을 링크하고, 여기서는 책의 문맥에 맞춰 쉬운 말과 구분 기준을 함께 적는다.

## 자바-개발-키트 (Java Development Kit, JDK)
Java 소스를 바이트코드로 컴파일하는 도구, 실행 환경, 진단 도구를 한데 묶은 개발용 배포판이다. 단순 실행기인 JVM보다 범위가 넓다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: JVM, JRE

## 장기지원 (Long-Term Support, LTS)
일반 릴리스보다 긴 기간 동안 공급자가 업데이트와 지원을 제공하는 릴리스 계열이다. 지원 기간과 조건은 JDK 배포판 공급자마다 다르다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 최신 버전, 무료 지원

## SDKMAN (Software Development Kit Manager)
Unix 계열 셸에서 여러 JDK와 JVM 생태계 도구를 설치하고 버전을 전환하는 도구다. Windows에서는 보통 WSL 안에서 사용한다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: JDK 배포판

## Eclipse-Temurin (Eclipse Temurin)
Eclipse Adoptium 프로젝트가 제공하는 무료 OpenJDK 바이너리 배포판이다. Java라는 언어의 다른 구현이 아니라 OpenJDK를 배포하는 선택지 중 하나다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: Oracle JDK, Azul Zulu, OpenJDK

## TCK (Technology Compatibility Kit)
특정 Java 사양 구현이 표준 요구사항을 만족하는지 검증하는 호환성 시험 모음이다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 단위 테스트, 성능 벤치마크

## IDE (Integrated Development Environment)
코드 편집, 빌드, 실행, 디버깅, 탐색을 한 환경에서 제공하는 개발 도구다. Spring 지원 기능은 편의성을 높이지만 애플리케이션 실행의 필수 조건은 아니다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 텍스트 편집기, 빌드 도구

## GitHub
Git 저장소를 원격으로 호스팅하고 협업 기능을 제공하는 서비스다. 이 책에서는 완성 예제와 장별 코드를 확인하는 기준 저장소로 사용한다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: Git

## 스프링-프레임워크 (Spring Framework)
객체 생성과 연결, 웹, 데이터 접근 등 Java 애플리케이션의 기반 기능을 제공하는 프레임워크다. Spring Boot는 이를 대체하지 않고 그 위에서 설정과 조립을 간소화한다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[스프링-부트]]

## 스프링-부트 (Spring Boot)
Spring Framework 기반 애플리케이션을 적은 수동 설정으로 시작하고 운영할 수 있게 자동 구성, 스타터, 외부 설정, 의존성 관리 등을 제공하는 프로젝트다.
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: [[스프링-프레임워크]]

## 애플리케이션-컨텍스트 (application context)
Spring 애플리케이션이 시작될 때 만들어져 객체의 생성, 설정, 의존 관계, 생명주기를 관리하는 컨테이너다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[스프링-빈]], IoC 컨테이너

## 스프링-빈 (Spring bean)
애플리케이션 컨텍스트에 등록되어 Spring이 생성·연결·관리하는 Java 객체다. 클래스 모양을 설명하는 JavaBean과는 기준이 다르다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[자바빈]]

## 자바빈 (JavaBean)
일반적으로 private 필드, getter/setter, 인자 없는 생성자 같은 관례를 따르는 Java 객체다. Spring 컨테이너에 등록되어야 한다는 뜻은 아니다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[스프링-빈]]

## 의존성-주입 (dependency injection, DI)
객체가 필요한 협력 객체를 내부에서 직접 만들지 않고 외부 컨테이너로부터 전달받는 방식이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 서비스 로케이터, 객체 생성

## 와이어링 (wiring)
애플리케이션 컨텍스트가 서로 필요한 빈들을 찾아 의존 관계로 연결하는 과정이다. 전선 연결처럼 객체 사이의 연결을 완성한다는 데서 붙은 이름이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[의존성-주입]]

## 클래스패스 (classpath)
JVM과 프레임워크가 실행 시 클래스와 리소스를 찾는 경로들의 집합이다. Spring Boot는 어떤 기술의 클래스가 여기에 존재하는지를 자동 구성 조건으로 사용한다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 빌드 파일, 모듈 경로

## 자동-구성 (auto-configuration)
클래스패스, 기존 빈, 구성값 같은 실행 조건을 검사해 흔히 필요한 Spring 빈을 조건부로 등록하는 Spring Boot 기능이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 컴포넌트 스캔, [[스타터]]

## 자동-구성-정책 (auto-configuration policy)
특정 기술이 있을 때 어떤 빈을 어떤 조건과 순서로 만들지 표현한 자동 구성 클래스와 규칙이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 일반 `@Configuration`

## 조건부-구성 (conditional configuration)
클래스 존재, 빈 존재 여부, 프로퍼티 값 등의 조건이 맞을 때만 구성 클래스나 빈 정의를 적용하는 방식이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: [[프로파일]], [[조건부-빈]]

## 백오프 (back-off)
사용자가 같은 역할의 빈을 명시적으로 제공하면 Spring Boot의 기본 자동 구성이 물러나 중복 생성을 하지 않는 정책이다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 자동 구성 제외

## 데이터소스 (DataSource)
애플리케이션이 데이터베이스 연결을 얻는 표준 JDBC 진입점이다. Spring Boot의 데이터베이스 자동 구성을 설명할 때 대표 예제로 사용된다.
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: JDBC 드라이버, 커넥션 풀

## 스타터 (starter)
웹 MVC나 JPA처럼 하나의 기능 영역에 필요한 의존성들을 의도 있는 묶음으로 선언한 Spring Boot 모듈이다. 스타터 자체가 빈을 직접 만드는 것은 아니다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: [[자동-구성]], [[BOM]]

## 전이-의존성 (transitive dependency)
프로젝트가 직접 선언한 라이브러리가 다시 요구하기 때문에 빌드에 간접적으로 포함되는 의존성이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: 직접 의존성

## Spring-MVC
Servlet API와 전통적인 요청-응답 모델을 기반으로 웹 애플리케이션을 만드는 Spring Framework의 웹 스택이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: [[Spring-WebFlux]], [[Spring-Web]]

## Spring-WebFlux
논블로킹·리액티브 실행 모델을 지원하는 Spring Framework의 웹 스택이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: [[Spring-MVC]]

## Spring-Web
Spring MVC와 WebFlux가 공유하는 HTTP 추상화와 애노테이션 기반 프로그래밍 기반을 제공하는 모듈 또는 공통 영역이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: [[Spring-MVC]], [[Spring-WebFlux]]

## 서블릿 (servlet)
서블릿 컨테이너가 HTTP 요청을 Java 코드로 전달하고 응답을 만들게 하는 Jakarta EE 서버 측 규약이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: 웹 서버, 리액티브 서버

## 내장-서블릿-컨테이너 (embedded servlet container)
별도 애플리케이션 서버에 배포하지 않고 애플리케이션 프로세스 안에서 함께 시작되는 Tomcat 또는 Jetty 같은 Servlet 실행 환경이다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: 외부 WAS

## Jakarta-EE (Jakarta Enterprise Edition)
Servlet, Persistence, Validation 등 엔터프라이즈 Java 표준 사양들의 모음이다. Java EE가 Eclipse Foundation으로 이관된 뒤 사용되는 이름과 `jakarta.*` 네임스페이스다.
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: Java EE, Spring Framework

## 구성-프로퍼티 (configuration properties)
`server.port`처럼 외부 입력으로 Spring Boot나 사용자 빈의 설정을 조정하는 이름-값 기반 구성 모델이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: JVM 시스템 프로퍼티, 필드

## 외부화된-구성 (externalized configuration)
환경마다 달라질 값을 소스 코드와 애플리케이션 바이너리 밖에서 주입해 같은 빌드를 여러 환경에서 재사용하는 방식이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 비밀 관리, [[프로파일]]

## 프로퍼티-바인딩 (property binding)
문자열 중심의 구성 값을 Java 객체의 필드나 생성자 매개변수에 타입에 맞게 변환해 연결하는 과정이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: [[의존성-주입]]

## 프로퍼티-소스 (property source)
프로퍼티 값을 공급하는 한 출처다. 기본값, 설정 파일, 환경 변수, 시스템 프로퍼티, 명령행 인자, 테스트 설정 등이 각각 하나의 출처가 될 수 있다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 설정 파일

## 프로파일 (profile)
`dev`, `test`, `prod`처럼 이름을 붙여 함께 활성화할 환경별 구성 묶음이다. 프로파일별 파일은 기본 파일의 값을 덮어쓸 수 있다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: [[조건부-빈]], 배포 환경

## 우선순위 (property precedence)
같은 키가 여러 프로퍼티 소스에 존재할 때 어느 값이 최종 승자가 되는지를 정하는 순서다. Spring Boot 문서의 목록은 뒤에 오는 높은 우선순위가 앞의 값을 덮는 방식으로 읽는다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 파일 검색 순서

## 조건부-빈 (conditional bean)
프로퍼티 같은 조건이 맞을 때만 애플리케이션 컨텍스트에 등록되는 빈이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: [[조건부-구성]], [[프로파일]]

## 구성-메타데이터 (configuration metadata)
IDE가 `application.properties`에서 키 자동완성, 설명, 타입 정보를 제공할 수 있게 구성 프로퍼티 정보를 기술한 메타데이터다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 런타임 프로퍼티 값

## 환경-변수 (environment variable)
운영체제나 실행 플랫폼이 프로세스에 전달하는 이름-값 설정이다. Spring Boot 외부 구성의 한 공급원이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: [[시스템-프로퍼티]]

## 시스템-프로퍼티 (Java system property)
`-Dname=value` 형태나 `System.getProperties()`로 JVM 프로세스에 제공하는 이름-값 설정이다.
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: [[환경-변수]], 명령행 애플리케이션 인자

## 의존성-관리 (dependency management)
직접·전이 의존성에 적용할 버전 제약을 중앙에서 선언해 프로젝트 전체의 선택 버전을 통제하는 빌드 기능이다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: [[스타터]], 의존성 선언

## BOM (Bill of Materials)
함께 사용하도록 검증된 라이브러리 버전 제약을 한곳에 모은 의존성 관리 명세다. Spring Boot에서는 `spring-boot-dependencies`가 이 역할을 한다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: [[스타터]], parent POM

## 버전-정렬 (version alignment)
서로 연동되는 Spring 모듈과 주요 서드파티 라이브러리의 버전을 호환되는 조합으로 맞추는 일이다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: 최신 버전 선택

## CVE (Common Vulnerabilities and Exposures)
공개된 보안 취약점을 공통 식별자로 추적하는 체계와 그 개별 항목을 가리킨다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: 보안 패치, 버그

## Maven
POM을 중심으로 프로젝트 빌드와 의존성을 관리하는 Java 빌드 도구다. Spring Boot의 parent POM 또는 BOM import를 사용할 수 있다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: [[Gradle]]

## Gradle
Groovy 또는 Kotlin DSL을 사용하는 빌드 도구다. Spring Boot 플러그인과 dependency-management 방식 또는 Gradle 플랫폼 기능으로 관리 버전을 적용할 수 있다.
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: [[Maven]]

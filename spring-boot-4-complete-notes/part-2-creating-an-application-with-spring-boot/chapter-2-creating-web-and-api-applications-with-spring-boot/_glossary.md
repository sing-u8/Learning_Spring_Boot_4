# Creating Web and Api Applications with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## nodejs
브라우저 밖에서 JavaScript와 프런트엔드 도구를 실행하는 런타임
- 처음 나온 곳: [[05-nodejs-react-frontend-integration]]
- 섞이는 말: npm

## frontend-maven-plugin
Node, npm, npx 작업을 Maven 생명주기에 연결하는 플러그인
- 처음 나온 곳: [[05-nodejs-react-frontend-integration]]
- 섞이는 말: spring-boot-maven-plugin

## parcel
JavaScript 모듈과 의존성을 브라우저가 읽을 번들로 만드는 도구
- 처음 나온 곳: [[05-nodejs-react-frontend-integration]]
- 섞이는 말: npm

## react
상태 변화로부터 컴포넌트 UI를 다시 계산하는 JavaScript 라이브러리
- 처음 나온 곳: [[05-nodejs-react-frontend-integration]]
- 섞이는 말: Mustache

## static-resource
Spring Boot가 가공 없이 HTTP로 제공하는 JavaScript, CSS, 이미지 등의 파일
- 처음 나온 곳: [[05-nodejs-react-frontend-integration]]
- 섞이는 말: server-side-template

## spring-initializr
(start.spring.io) 프로젝트 설정과 의존성을 선택해 초기 코드를 자동 생성해 주는 서비스
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## executable-jar
내장 서버(Tomcat 등)를 포함하여 독립적으로 런타임에 실행할 수 있게 만든 JAR 파일 포맷
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-mvc
Model-View-Controller 패턴을 사용하여 서블릿 기반 웹 애플리케이션을 만드는 스프링 프레임워크 핵심 모듈
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## controller
사용자(클라이언트)의 HTTP 요청을 받아서 적절한 로직으로 연결하고 응답을 돌려주는 컴포넌트
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## get-mapping
특정 HTTP GET 요청 경로를 컨트롤러의 특정 메서드와 연결해주는 애노테이션
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## component-scanning
스프링이 특정 패키지를 뒤져서 @Controller, @Service 등의 애노테이션이 붙은 클래스를 찾아 빈으로 자동 등록하는 기능
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## template-engine
템플릿 파일과 서버의 데이터를 결합하여 최종 HTML을 생성하는 도구
- 처음 나온 곳: [[03-leveraging-templates-to-create-content]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mustache
로직이 없는(Logic-less) 단순하고 가벼운 템플릿 엔진
- 처음 나온 곳: [[03-leveraging-templates-to-create-content]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## model-attribute
뷰로 데이터를 전달하거나, 폼 요청 데이터를 자바 객체로 바인딩할 때 사용하는 애노테이션
- 처음 나온 곳: [[03-leveraging-templates-to-create-content]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## post-mapping
HTTP POST 요청을 특정 컨트롤러 메서드에 매핑하는 애노테이션
- 처음 나온 곳: [[03-leveraging-templates-to-create-content]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## redirect
클라이언트(브라우저)에게 다른 URL로 다시 요청하라고 지시하는 HTTP 응답 방식
- 처음 나온 곳: [[03-leveraging-templates-to-create-content]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## rest-controller
메서드의 반환값을 뷰(템플릿)가 아닌 데이터(JSON 등) 자체로 HTTP 응답 본문에 쓰는 애노테이션
- 처음 나온 곳: [[04-creating-json-based-apis]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## jackson
자바 객체와 JSON 데이터 간의 양방향 자동 변환을 처리하는 강력한 기본 라이브러리
- 처음 나온 곳: [[04-creating-json-based-apis]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## request-body
클라이언트가 보낸 HTTP 요청 본문(JSON 등)을 자바 객체로 변환하여 주입받는 애노테이션
- 처음 나온 곳: [[04-creating-json-based-apis]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## api-versioning
호환성을 깨지 않고 서비스를 발전시키기 위해 API 엔드포인트에 버전을 부여하고 나누는 기법
- 처음 나온 곳: [[06-versioning-api-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## http-service-interface-client
복잡한 HTTP 통신 코드 없이 자바 인터페이스 선언만으로 외부 REST API를 호출하게 해주는 기능
- 처음 나온 곳: [[06-versioning-api-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## get-exchange
HTTP Service Interface 내부에서 GET 방식의 API 호출을 선언하고 버전을 명시할 수 있는 애노테이션
- 처음 나온 곳: [[06-versioning-api-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## jspecify
자바 진영의 여러 Null 관련 애노테이션을 통합한 표준 명세
- 처음 나온 곳: [[07-writing-null-safe-applications-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## null-marked
해당 영역(패키지/클래스)의 기본 상태를 'Null 금지'로 설정하는 애노테이션
- 처음 나온 곳: [[07-writing-null-safe-applications-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## null-unmarked
기본 상태를 강제하지 않아 레거시 코드와 혼용할 수 있게 해주는 애노테이션
- 처음 나온 곳: [[07-writing-null-safe-applications-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## non-null
특정 요소가 절대 Null이 아님을 명시하는 애노테이션
- 처음 나온 곳: [[07-writing-null-safe-applications-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## nullable
특정 요소가 Null이 될 수 있음을 명시하여, 호출자가 반드시 방어 코드를 짜도록 유도하는 애노테이션
- 처음 나온 곳: [[07-writing-null-safe-applications-with-spring-boot-4]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

# Chapter 2 용어집

> Chapter 2에서 사용하는 전문 용어의 정의 원본이다. 개념 노트는 첫 등장 때 `**[[용어]]**(= 한 줄 풀이)` 형태로 여기를 링크하고, 정의 자체는 이 파일에만 둔다. Chapter 1에서 이미 나온 말이라도 Chapter 2 노트에서 링크하려면 여기에 다시 정의가 있어야 하므로, 그런 항목은 Chapter 2 문맥에 맞춰 다시 적었다.

## 스프링-이니셜라이저 (Spring Initializr)
Spring 팀이 운영하는 프로젝트 생성 서비스다. Boot 버전·빌드 도구·언어·프로젝트 좌표·Java 버전·스타터·패키징·설정 파일 형식을 고르면 그 조합에 맞는 빌드 파일과 최소 골격을 만들어 준다. 코드를 대신 짜 주는 도구가 아니라 "시작 지점의 빌드 파일"을 정확하게 만들어 주는 도구다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: [[스타터]], 프로젝트 템플릿

## 프로젝트-좌표 (project coordinates)
빌드 시스템이 산출물을 유일하게 식별하는 이름표다. Maven에서는 group, artifact, version 세 가지가 핵심이며 Initializr의 Group/Artifact/Name/Description/Package name 입력이 여기에 대응한다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: 패키지 이름, [[베이스-패키지]]

## 패키징 (packaging)
빌드 결과물을 어떤 배포 형식으로 묶을지 정하는 선택이다. Spring Boot에서는 JAR과 WAR 중 하나이며, 이 선택이 "누가 서버를 띄우는가"를 결정한다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: [[실행-가능-JAR]], [[외부-서블릿-컨테이너]]

## 실행-가능-JAR (executable JAR)
애플리케이션 코드, 의존 라이브러리, 내장 서버를 한 파일에 담아 `java -jar`만으로 뜨는 JAR이다. 실행 환경에 별도 서버를 미리 깔아 둘 필요가 없다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: [[패키징]], 일반 라이브러리 JAR

## 외부-서블릿-컨테이너 (external servlet container)
애플리케이션과 별도로 미리 설치·운영되고, 그 안에 WAR을 배치해서 실행하는 서버다. Tomcat이나 WebSphere를 조직이 이미 운영 중일 때 WAR이 필요해진다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: [[서블릿]], [[실행-가능-JAR]]

## 스타터 (starter)
어떤 기능을 쓰기 시작하는 데 필요한 의존성 묶음을 하나의 이름으로 제공하는 Maven/Gradle 아티팩트다. 스타터 자체에는 보통 코드가 거의 없고, 필요한 라이브러리들을 전이 의존성으로 끌어온다.
- 처음 나온 곳: [[01-using-start-spring-io-to-build-apps]]
- 섞이는 말: [[자동-구성]], 라이브러리

## 자동-구성 (auto-configuration)
클래스패스에 무엇이 있는지, 사용자가 어떤 빈을 이미 만들었는지, 어떤 프로퍼티가 설정됐는지를 보고 Spring Boot가 기반 빈을 조건부로 등록하는 기능이다. Chapter 1의 핵심 개념이며 Chapter 2에서는 Mustache 엔진 빈과 Jackson 변환기 빈이 이 경로로 들어온다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[스타터]], [[컴포넌트-스캔]]

## 웹-컨트롤러 (web controller)
HTTP 요청을 받아 처리하고 응답할 내용을 정하는 컴포넌트다. HTML을 돌려주기도 하고 JSON을 돌려주기도 하며, 들어오는 JSON 본문을 받아 상태를 바꾸기도 한다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[서비스-계층]], [[서블릿]]

## Spring-MVC (Spring MVC)
서블릿 기반 컨테이너 위에서 Model-View-Controller 방식으로 웹 애플리케이션을 만들게 해 주는 Spring Framework 모듈이다. 요청을 컨트롤러 메서드로 라우팅하고, 결과를 뷰나 메시지 본문으로 바꾸는 일을 맡는다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: Spring WebFlux, [[웹-컨트롤러]]

## 서블릿 (servlet)
Java 표준으로 정의된 "HTTP 요청 하나를 처리하는 객체" 모델이다. Spring MVC는 자체 프로토콜을 새로 만든 것이 아니라 이 표준 위에 얹혀 동작한다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[외부-서블릿-컨테이너]], [[Spring-MVC]]

## 요청-매핑 (request mapping)
어떤 HTTP 메서드와 어떤 경로의 요청을 어느 컨트롤러 메서드가 처리할지 연결하는 선언이다. `@GetMapping`, `@PostMapping` 같은 애노테이션이 이 선언을 담는다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[논리적-뷰-이름]], URL 라우팅

## 논리적-뷰-이름 (logical view name)
컨트롤러가 "무엇을 그릴지"만 이름으로 말하고 "그 파일이 어디에 어떤 확장자로 있는지"는 말하지 않는 문자열이다. `"index"`가 곧 `templates/index.mustache`를 뜻하지만, 그 변환은 컨트롤러 바깥에서 일어난다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[뷰-해석]], 파일 경로

## 뷰-해석 (view resolution)
논리적 뷰 이름을 실제로 렌더링할 템플릿 파일과 엔진으로 바꾸는 Spring MVC의 단계다. 접두사(디렉터리)와 접미사(확장자)를 붙여 파일을 찾는 것이 기본 동작이다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[논리적-뷰-이름]], [[템플릿-엔진]]

## 컴포넌트-스캔 (component scanning)
`@Component` 계열 애노테이션이 붙은 클래스를 시작 시점에 찾아 인스턴스로 만들고 애플리케이션 컨텍스트에 등록하는 동작이다. 개발자가 빈 목록을 손으로 관리하지 않아도 되게 한다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[자동-구성]], [[오토와이어링]]

## 베이스-패키지 (base package)
컴포넌트 스캔이 시작되는 기준 패키지다. Initializr가 만든 메인 애플리케이션 클래스가 놓인 패키지가 기본 기준이 되며, 그 아래 하위 패키지가 스캔 대상이다.
- 처음 나온 곳: [[02-creating-a-spring-mvc-web-controller]]
- 섞이는 말: [[컴포넌트-스캔]], [[패키지-전용-가시성]]

## 템플릿-엔진 (template engine)
데이터와 골격 문서를 합쳐 최종 문서를 만들어 내는 라이브러리다. 웹에서는 보통 모델 데이터와 HTML 골격을 합쳐 완성된 HTML을 만든다.
- 처음 나온 곳: [[03-augmenting-an-existing-project-with-initializr]]
- 섞이는 말: [[Mustache]], [[뷰-해석]]

## Spring-Boot-CLI (Spring Boot CLI)
`spring init` 같은 명령으로 Initializr가 웹에서 하는 일을 명령행에서 하게 해 주는 도구다. 프로젝트 생성을 스크립트에 넣어 반복 가능하게 만들 때 쓴다.
- 처음 나온 곳: [[03-augmenting-an-existing-project-with-initializr]]
- 섞이는 말: [[스프링-이니셜라이저]], `mvnw`

## Mustache (Mustache)
`{{name}}` 같은 이중 중괄호 자리표시자로 데이터를 끼워 넣는 템플릿 언어다. 이름이 중괄호 `{{`가 옆으로 누운 콧수염 모양에서 왔다.
- 처음 나온 곳: [[04-leveraging-templates-to-create-content]]
- 섞이는 말: [[로직-없는-템플릿]], Thymeleaf

## 로직-없는-템플릿 (logic-less template)
템플릿 문법 안에 조건식·반복 카운터·임의 표현식 같은 프로그래밍 구문을 두지 않는 설계다. 값의 존재 여부와 목록 여부만으로 출력이 결정되므로 화면 로직이 자연히 서버 코드 쪽으로 밀려난다.
- 처음 나온 곳: [[04-leveraging-templates-to-create-content]]
- 섞이는 말: [[Mustache]], JSP scriptlet

## 관례-우선-설정 (convention over configuration)
자주 쓰는 배치와 이름을 프레임워크가 기본값으로 미리 정해 두고, 그 관례를 따르면 설정을 아예 쓰지 않아도 되게 하는 설계 방침이다. 관례를 벗어나고 싶을 때만 설정을 쓴다.
- 처음 나온 곳: [[04-leveraging-templates-to-create-content]]
- 섞이는 말: [[구성-프로퍼티]], 명시적 설정

## 구성-프로퍼티 (configuration properties)
`application.properties`나 `application.yaml` 같은 외부 파일의 키-값으로 프레임워크와 애플리케이션의 동작을 조정하는 설정 값이다. Chapter 2에서는 템플릿 위치·확장자·API 버전 전략을 이 값으로 바꾼다.
- 처음 나온 곳: [[04-leveraging-templates-to-create-content]]
- 섞이는 말: [[관례-우선-설정]], 환경 변수

## 모델 (Model)
컨트롤러가 뷰에 넘길 데이터를 이름을 붙여 담아 두는 Spring MVC의 그릇이다. 컨트롤러 메서드가 파라미터로 요구하면 Spring MVC가 채워서 넘겨준다.
- 처음 나온 곳: [[04a-adding-demo-data-to-a-template]]
- 섞이는 말: [[모델-속성]], 도메인 모델

## 모델-속성 (model attribute)
모델 안에 들어 있는 "이름 → 값" 한 쌍이다. 템플릿은 이 이름으로만 값을 찾으므로, 이름이 템플릿과 컨트롤러 사이의 계약이 된다.
- 처음 나온 곳: [[04a-adding-demo-data-to-a-template]]
- 섞이는 말: [[모델]], [[폼-바인딩]]

## 레코드 (record)
필드 목록만 선언하면 생성자, 접근자, `equals`, `hashCode`, `toString`을 컴파일러가 만들어 주는 Java의 불변 데이터 전용 클래스 형태다. 접근자 이름이 `getName()`이 아니라 `name()`인 점이 기존 JavaBean 관례와 다르다.
- 처음 나온 곳: [[04a-adding-demo-data-to-a-template]]
- 섞이는 말: JavaBean, DTO

## Mustache-섹션 (Mustache section)
`{{#이름}}`으로 열고 `{{/이름}}`으로 닫는 Mustache 블록이다. 그 이름의 값이 목록이면 블록이 항목 수만큼 반복되고, 값이 없거나 거짓이면 블록 전체가 사라진다.
- 처음 나온 곳: [[04a-adding-demo-data-to-a-template]]
- 섞이는 말: [[로직-없는-템플릿]], for 루프

## 불변-컬렉션 (immutable collection)
만들어진 뒤에는 원소를 더하거나 빼거나 바꿀 수 없는 컬렉션이다. `List.of(...)`가 만드는 목록이 여기 해당하며, `add()`를 호출하면 `UnsupportedOperationException`이 난다.
- 처음 나온 곳: [[04a-adding-demo-data-to-a-template]]
- 섞이는 말: [[복사-후-교체]], `Collections.unmodifiableList`

## 계층-분리 (layering)
요청 처리, 업무 규칙, 데이터 접근처럼 성격이 다른 책임을 서로 다른 클래스 묶음으로 나누는 설계다. 한 계층이 바뀔 때 다른 계층을 건드리지 않게 하는 것이 목적이다.
- 처음 나온 곳: [[04b-building-our-app-with-a-better-design]]
- 섞이는 말: [[서비스-계층]], 패키지 구조

## 서비스-계층 (service layer)
웹이나 저장소 같은 바깥 기술에 매이지 않고 업무 동작 자체를 담당하는 계층이다. Spring에서는 `@Service`가 붙은 빈이 이 자리에 놓인다.
- 처음 나온 곳: [[04b-building-our-app-with-a-better-design]]
- 섞이는 말: [[웹-컨트롤러]], [[계층-분리]]

## 패키지-전용-가시성 (package-private visibility)
`public`·`protected`·`private` 중 아무것도 쓰지 않았을 때 Java가 적용하는 기본 접근 범위다. 같은 패키지 안에서만 보이며, 클래스·record·인터페이스의 기본값이다.
- 처음 나온 곳: [[04b-building-our-app-with-a-better-design]]
- 섞이는 말: [[베이스-패키지]], `public`

## 생성자-주입 (constructor injection)
빈이 필요로 하는 협력 객체를 생성자 매개변수로 받는 의존성 주입 방식이다. 객체가 만들어지는 순간 필요한 것이 모두 채워져 있음이 보장된다.
- 처음 나온 곳: [[04c-injecting-dependencies-through-constructor-calls]]
- 섞이는 말: [[오토와이어링]], setter 주입

## 오토와이어링 (autowiring)
주입이 필요한 지점을 발견하면 컨테이너가 타입이 맞는 빈을 컨텍스트에서 찾아 자동으로 끼워 넣는 동작이다. "무엇이 필요한지"만 선언하면 "어디서 가져올지"는 컨테이너가 정한다.
- 처음 나온 곳: [[04c-injecting-dependencies-through-constructor-calls]]
- 섞이는 말: [[생성자-주입]], [[주입-지점]]

## 주입-지점 (injection point)
컨테이너가 값을 채워 넣을 수 있는 자리다. 생성자 매개변수, setter 메서드, 필드가 모두 후보가 된다.
- 처음 나온 곳: [[04c-injecting-dependencies-through-constructor-calls]]
- 섞이는 말: [[오토와이어링]], `@Autowired`

## 폼-바인딩 (form binding)
브라우저가 보낸 폼 필드 이름과 값을 Java 객체의 속성으로 옮겨 담는 과정이다. `@ModelAttribute`가 이 변환을 지시한다.
- 처음 나온 곳: [[04d-changing-the-data-through-html-forms]]
- 섞이는 말: [[요청-본문]], [[모델-속성]]

## 리다이렉트 (redirect)
서버가 응답 본문 대신 "다른 URL로 다시 요청하라"는 지시와 위치를 돌려주는 방식이다. Spring MVC에서는 뷰 이름 앞에 `redirect:`를 붙여 표현한다.
- 처음 나온 곳: [[04d-changing-the-data-through-html-forms]]
- 섞이는 말: [[PRG]], forward

## PRG (Post/Redirect/Get)
POST로 상태를 바꾼 뒤 곧바로 HTML을 돌려주지 않고 리다이렉트를 보내, 브라우저가 GET으로 결과를 다시 읽게 하는 흐름이다. 새로고침이 POST 재전송이 되는 문제를 없앤다.
- 처음 나온 곳: [[04d-changing-the-data-through-html-forms]]
- 섞이는 말: [[리다이렉트]], 이중 제출

## 복사-후-교체 (copy-on-write)
불변 자료구조를 "바꿔야" 할 때, 원본을 고치는 대신 원본 내용에 변경을 더한 새 불변 인스턴스를 만들어 참조를 갈아 끼우는 방식이다.
- 처음 나온 곳: [[04d-changing-the-data-through-html-forms]]
- 섞이는 말: [[불변-컬렉션]], [[경쟁-상태]]

## 경쟁-상태 (race condition)
여러 실행 흐름이 같은 상태를 동시에 읽고 쓸 때, 순서에 따라 결과가 달라지고 일부 변경이 사라질 수 있는 상황이다. 각 단계가 개별적으로는 안전해도 전체가 원자적이지 않으면 발생한다.
- 처음 나온 곳: [[04d-changing-the-data-through-html-forms]]
- 섞이는 말: [[복사-후-교체]], thread-safe

## Jackson (Jackson)
Java 객체와 JSON을 서로 변환하는 라이브러리다. Spring Boot 4에서는 `spring-boot-starter-webmvc`가 `spring-boot-starter-jackson`을 전이 의존성으로 끌어오므로 별도 설정 없이 쓸 수 있다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[직렬화]], Gson

## 직렬화 (serialization)
메모리 안의 객체를 전송·저장할 수 있는 문자열이나 바이트열로 바꾸는 일이다. 여기서는 Java 객체를 JSON 텍스트로 바꾸는 방향을 가리킨다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[역직렬화]], [[Jackson]]

## 역직렬화 (deserialization)
전송받은 JSON 텍스트를 Java 객체로 되돌리는 일이다. 방향만 반대이지 규칙은 직렬화와 같은 매핑을 쓴다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[직렬화]], [[요청-본문]]

## 요청-본문 (request body)
HTTP 요청의 헤더 뒤에 실려 오는 데이터 덩어리다. `@RequestBody`는 이 본문 전체를 하나의 객체로 역직렬화하라는 지시다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[폼-바인딩]], 쿼리 파라미터

## 안전한-메서드 (safe method)
호출해도 서버의 상태를 바꾸지 않는다고 약속된 HTTP 메서드다. GET이 대표적이며, 이 약속 덕분에 중간 캐시나 크롤러가 마음대로 호출할 수 있다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[멱등성]], POST

## 멱등성 (idempotent)
같은 요청을 여러 번 보내도 한 번 보낸 것과 최종 상태가 같은 성질이다. 안전함과는 다르다 — PUT은 상태를 바꾸므로 안전하지 않지만 멱등하다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: [[안전한-메서드]], 재시도

## curl (curl)
명령행에서 HTTP 요청을 만들어 보내고 응답을 그대로 보여 주는 도구다. 브라우저 없이 API의 실제 요청·응답을 확인할 때 쓴다.
- 처음 나온 곳: [[05-creating-json-based-apis]]
- 섞이는 말: Postman, 브라우저 개발자 도구

## Node.js (Node.js)
브라우저 밖에서 JavaScript를 실행하는 런타임이다. 프런트엔드 자산을 만들고 관리하는 도구 대부분이 이 위에서 돈다.
- 처음 나온 곳: [[06-integrating-nodejs-with-a-spring-boot-web-app]]
- 섞이는 말: [[npm]], JVM

## npm (npm)
Node.js의 패키지 관리자다. 의존성을 내려받아 설치하고 `package.json`에 기록한다.
- 처음 나온 곳: [[06-integrating-nodejs-with-a-spring-boot-web-app]]
- 섞이는 말: [[npx]], Maven

## frontend-maven-plugin (frontend-maven-plugin)
Node.js·npm·npx를 프로젝트 안에 내려받아 설치하고, Maven 생명주기의 정해진 단계에서 그 도구들을 실행해 주는 Maven 플러그인이다. 개발자 PC마다 다른 Node 버전에 빌드가 휘둘리지 않게 한다.
- 처음 나온 곳: [[06-integrating-nodejs-with-a-spring-boot-web-app]]
- 섞이는 말: [[Maven-생명주기]], [[npm]]

## Maven-생명주기 (Maven lifecycle)
Maven이 빌드를 진행하며 정해진 순서로 지나가는 단계들의 열이다. `generate-resources`, `compile`, `package` 같은 이름이 각 단계이며, 플러그인은 자기 작업을 어느 단계에 붙일지 선언한다.
- 처음 나온 곳: [[06-integrating-nodejs-with-a-spring-boot-web-app]]
- 섞이는 말: [[frontend-maven-plugin]], goal

## 정적-리소스 (static resources)
서버가 가공 없이 그대로 내보내는 파일이다. Spring Boot는 `src/main/resources/static` 아래의 파일을 애플리케이션 루트 경로에서 자동으로 서빙한다.
- 처음 나온 곳: [[06-integrating-nodejs-with-a-spring-boot-web-app]]
- 섞이는 말: [[템플릿-엔진]], [[번들]]

## 번들러 (bundler)
여러 JavaScript 모듈과 그 의존성을 브라우저가 한 번에 읽을 수 있는 소수의 파일로 합치고 변환하는 도구다. Parcel, webpack, Vite가 이 부류다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[번들]], 컴파일러

## 번들 (bundle)
번들러가 만들어 낸 최종 산출물 파일이다. 소스에 있던 모듈 경계와 JSX 같은 확장 문법은 이 단계에서 브라우저가 이해하는 형태로 바뀌어 사라진다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[번들러]], [[정적-리소스]]

## Parcel (Parcel)
설정 파일을 거의 요구하지 않는 것을 목표로 만든 JavaScript 번들러다. 엔트리 포인트 하나와 출력 디렉터리만 알려 주면 나머지는 관례로 처리한다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[번들러]], webpack

## npx (npx)
설치된 Node 패키지의 실행 파일을 찾아 실행해 주는 도구다. `npm`이 "가져오는" 쪽이라면 `npx`는 "돌리는" 쪽이다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[npm]], `mvnw`

## 개발-의존성 (dev dependency)
빌드하거나 테스트할 때만 필요하고 배포되는 산출물에는 들어가지 않는 의존성이다. `npm install --save-dev`가 이 구분으로 기록한다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[npm]], Maven `provided` scope

## 엔트리-포인트 (entry point)
번들러가 의존성 그래프를 따라가기 시작하는 첫 파일이다. 이 파일에서 도달할 수 없는 모듈은 번들에 포함되지 않는다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: [[번들러]], `main` 메서드

## ES6-모듈 (ES module)
`import`/`export` 문법으로 파일 사이의 의존 관계를 선언하는 JavaScript 표준 모듈 형식이다. 브라우저에서는 `<script type="module">`로 읽어들인다.
- 처음 나온 곳: [[07-bundling-javascript-with-nodejs]]
- 섞이는 말: CommonJS, [[번들]]

## React (React.js)
화면을 컴포넌트 단위로 선언하고, 상태가 바뀌면 그 컴포넌트를 다시 그리는 방식의 JavaScript UI 라이브러리다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: [[JSX]], Vue.js

## JSX (JavaScript XML)
JavaScript 코드 안에 HTML을 닮은 태그 문법을 직접 쓸 수 있게 한 확장 문법이다. 브라우저가 직접 이해하지 못하므로 번들 단계에서 일반 함수 호출로 변환된다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: [[React]], 템플릿 문자열

## 가상-DOM (virtual DOM)
실제 브라우저 DOM 대신 메모리 안에 두는 가벼운 화면 구조 표현이다. React는 상태가 바뀌면 새 가상 구조를 만들어 이전 것과 비교하고, 달라진 부분만 실제 DOM에 반영한다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: Shadow DOM, 직접 DOM 조작

## 컴포넌트-상태 (state)
컴포넌트가 자기 안에서 관리하며 시간이 지나면서 바뀌는 값이다. 이 값이 바뀌면 React가 해당 컴포넌트를 다시 그린다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: [[컴포넌트-속성]], 전역 상태

## 컴포넌트-속성 (props)
부모가 자식 컴포넌트에 밖에서 넣어 주는 값이다. 받은 컴포넌트 안에서는 바꾸지 않는 것으로 취급한다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: [[컴포넌트-상태]], 생성자 인자

## 마운트 (mount)
컴포넌트가 처음으로 실제 DOM에 삽입되어 화면에 등장하는 순간이다. `componentDidMount`는 그 직후에 호출되는 훅이다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: 렌더, 언마운트

## 프로미스 (Promise)
아직 끝나지 않은 비동기 작업의 미래 결과를 나타내는 JavaScript 객체다. `await`는 그 결과가 나올 때까지 함수 실행을 잠시 멈추게 한다.
- 처음 나온 곳: [[07a-creating-a-reactjs-app]]
- 섞이는 말: 콜백, Java `CompletableFuture`

## API-계약 (API contract)
API 제공자와 소비자 사이의 약속이다. 경로, 요청 형식, 응답 필드와 타입, 의미가 모두 계약에 속하며, 한쪽이 말없이 바꾸면 상대가 깨진다.
- 처음 나온 곳: [[08-versioning-apis-with-spring-boot-4]]
- 섞이는 말: [[API-버전-관리]], 문서

## API-버전-관리 (API versioning)
호환되지 않는 여러 계약을 동시에 제공하면서 어느 계약을 쓸지 요청마다 명시하게 하는 방식이다. 소비자가 준비될 때까지 옛 계약을 살려 두기 위한 장치다.
- 처음 나온 곳: [[08-versioning-apis-with-spring-boot-4]]
- 섞이는 말: [[API-계약]], 하위 호환

## 경로-세그먼트 (path segment)
URL 경로를 `/`로 나눴을 때 생기는 각 조각이다. `/api/v2/videos`의 조각은 0번 `api`, 1번 `v2`, 2번 `videos`이며 번호는 0부터 센다.
- 처음 나온 곳: [[08-versioning-apis-with-spring-boot-4]]
- 섞이는 말: 쿼리 파라미터, path variable

## 콘텐츠-협상 (content negotiation)
클라이언트가 `Accept` 헤더로 원하는 표현 형식을 알리고 서버가 그에 맞춰 응답을 고르는 HTTP 메커니즘이다. 미디어 타입 버전 전략은 이 헤더에 버전 파라미터를 얹는다.
- 처음 나온 곳: [[08-versioning-apis-with-spring-boot-4]]
- 섞이는 말: [[API-버전-관리]], Content-Type

## HTTP-서비스-인터페이스 (HTTP Service Interface)
원격 HTTP 호출을 Java 인터페이스의 메서드 선언으로 표현하는 Spring의 모델이다. 구현체는 개발자가 쓰지 않고 런타임에 프록시로 생성된다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[선언적-클라이언트]], `RestTemplate`

## 선언적-클라이언트 (declarative client)
"어떻게 호출할지"의 절차 대신 "무엇을 호출할지"의 계약만 적어 두면 나머지를 프레임워크가 채우는 클라이언트 방식이다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[HTTP-서비스-인터페이스]], 명령형 호출 코드

## 프록시 (proxy)
어떤 타입인 척하면서 호출을 가로채 실제 동작을 대신 수행하는 객체다. 여기서는 인터페이스만 있는 `VideoClient` 자리에 들어가 실제 HTTP 요청을 보내는 객체를 가리킨다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[선언적-클라이언트]], 리버스 프록시

## RestClient (RestClient)
Spring Framework 6.1에서 도입된 동기 방식 HTTP 클라이언트다. Spring Boot 4에서 HTTP Service Interface의 기본 백엔드로 쓰인다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[WebClient]], `RestTemplate`

## WebClient (WebClient)
논블로킹·리액티브 방식의 HTTP 클라이언트다. 같은 HTTP Service Interface를 뒤에서 받칠 수 있으며, 호출 모델이 비동기라는 점이 RestClient와 다르다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[RestClient]], Reactor

## ApiVersionInserter (ApiVersionInserter)
클라이언트가 나가는 요청에 API 버전을 어떤 방식으로 실을지 정하는 Spring의 전략 객체다. 헤더, 경로 세그먼트, 쿼리 파라미터, 미디어 타입 파라미터 중 하나를 고른다.
- 처음 나온 곳: [[09-calling-versioned-apis-with-http-service-clients]]
- 섞이는 말: [[API-버전-관리]], 서버 측 version resolver

## 널-안전성 (null safety)
값이 없을 수 있는 자리와 절대 없어서는 안 되는 자리를 코드에 명시하고, 그 약속이 지켜지는지 도구가 검사할 수 있게 하는 성질이다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[널-계약]], `Optional`

## JSpecify (JSpecify)
Java의 nullness 애노테이션에 하나의 표준 의미를 부여하려는 명세다. 여러 라이브러리가 제각각 만든 `@Nullable`들이 서로 다른 뜻을 갖던 문제를 없애려고 만들어졌다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[널-계약]], JSR-305

## 널-계약 (nullness contract)
어떤 반환값·파라미터·필드가 null일 수 있는지를 타입 수준에서 선언한 약속이다. 선언만으로는 실행이 막히지 않고, 검사 도구가 위반을 지적하는 근거가 된다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[JSpecify]], 런타임 검증

## 정적-분석 (static analysis)
프로그램을 실행하지 않고 소스나 바이트코드만 읽어 문제를 찾아내는 검사다. IDE의 실시간 경고와 빌드 단계의 검사 도구가 모두 여기에 속한다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[NullAway]], 테스트

## NullAway (NullAway)
Error Prone 위에서 도는 정적 분석 도구로, JSpecify 널 계약이 깨지면 빌드를 실패시킬 수 있다. IDE 경고와 달리 무시하고 지나갈 수 없다는 점이 핵심이다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[정적-분석]], IDE inspection

## 제네릭-타입-인자 (generic type argument)
`List<Video>`의 `Video`처럼 제네릭 타입의 각괄호 안에 들어가는 타입이다. JSpecify는 이 자리에도 애노테이션을 붙일 수 있어 "목록 자체"와 "목록의 원소"의 nullability를 따로 말할 수 있다.
- 처음 나온 곳: [[10-writing-null-safe-applications-with-jspecify]]
- 섞이는 말: [[널-계약]], 배열 타입

# 02-web 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 디스패처-서블릿 (dispatcher servlet)
HTTP 요청이 들어왔을 때 가장 앞에서 요청을 수신하여 적절한 컨트롤러로 위임하고, 처리 결과를 뷰나 JSON으로 변환하여 응답하는 Spring MVC의 프론트 컨트롤러.
- 처음 나온 곳: [[01-spring-mvc-architecture-and-controllers]]
- 섞이는 말: [[핸들러-매핑]], [[뷰-리졸버]]

## 핸들러-매핑 (handler mapping)
클라이언트가 보낸 HTTP URL 경로, HTTP 메서드, 헤더 정보를 분석하여 어떤 컨트롤러 메서드가 이 요청을 처리해야 하는지 찾아주는 디스패처 서블릿의 내부 라우팅 컴포넌트.
- 처음 나온 곳: [[01-spring-mvc-architecture-and-controllers]]
- 섞이는 말: [[디스패처-서블릿]]

## 뷰-리졸버 (view resolver)
컨트롤러가 반환한 논리적 뷰 이름(예: `"index"`)을 실제 물리적인 템플릿 파일(예: `templates/index.html`)로 변환하고 렌더링을 지시하는 컴포넌트.
- 처음 나온 곳: [[01-spring-mvc-architecture-and-controllers]]
- 섞이는 말: [[서버사이드-템플릿]]

## 서버사이드-템플릿 (server-side template)
서버에서 HTML 파일 내부의 동적 표현식을 실제 데이터로 치환하여 완성된 정적 HTML을 클라이언트에 내려보내는 기술 (Thymeleaf, Mustache 등).
- 처음 나온 곳: [[02-server-side-templates-thymeleaf]]
- 섞이는 말: [[뷰-리졸버]], [[모델]]

## 모델 (model)
컨트롤러가 데이터베이스나 서비스에서 조회한 비즈니스 데이터를 뷰 템플릿 엔진으로 전달하기 위해 담아두는 Key-Value 형태의 데이터 바구니 객체.
- 처음 나온 곳: [[02-server-side-templates-thymeleaf]]
- 섞이는 말: [[서버사이드-템플릿]]

## 레스트-컨트롤러 (rest controller)
HTML 뷰를 렌더링하지 않고, 자바 객체를 JSON이나 XML 데이터 자체로 직렬화하여 HTTP 응답 본문(ResponseBody)으로 반환하는 API 전용 컨트롤러 (`@RestController`).
- 처음 나온 곳: [[03-json-rest-api-jackson3]]
- 섞이는 말: [[디스패처-서블릿]], [[잭슨]]

## 잭슨 (jackson)
자바 객체와 JSON 포맷 문자열 간의 상호 변환(직렬화/역직렬화)을 담당하는 Spring Boot의 표준 직렬화 라이브러리 (Spring Boot 4에서는 Jackson 3 탑재).
- 처음 나온 곳: [[03-json-rest-api-jackson3]]
- 섞이는 말: [[레스트-컨트롤러]]

## 에이피아이-버전관리 (api versioning)
클라이언트의 하위 호환성을 유지하면서 API를 점진적으로 개선하기 위해, URL 경로, HTTP 요청 헤더, 쿼리 파라미터 등을 기준으로 서로 다른 버전의 엔드포인트를 매핑하는 체계.
- 처음 나온 곳: [[04-native-api-versioning]]
- 섞이는 말: [[레스트-컨트롤러]]

## 선언적-에이치티티피-인터페이스 (declarative http interface)
RestTemplate이나 WebClient처럼 복잡한 호출 코드를 직접 작성하지 않고, 자바 인터페이스에 `@HttpExchange`, `@GetExchange` 어노테이션만 선언하면 프레임워크가 프록시 구현체를 자동 생성해 주는 원격 API 클라이언트 기술.
- 처음 나온 곳: [[05-declarative-http-interfaces]]
- 섞이는 말: [[레스트-컨트롤러]]

## 싱글-페이지-애플리케이션 (single page application)
초기에 단일 HTML 페이지와 자바스크립트 번들을 로드한 뒤, 페이지 전환 없이 백엔드 JSON API와 비동기 통신하며 화면을 동적으로 다시 그리는 클라이언트 웹 앱 (React, Vue 등).
- 처음 나온 곳: [[06-frontend-integration-react]]
- 섞이는 말: [[서버사이드-템플릿]]

# chapter-w1 용어집

> 서블릿 층에서 쓰는 말의 뜻. 정의는 이 파일 한 곳에만 둔다. 개념 노트는 정의를 다시 쓰지 않고 여기를 링크한다.

## 서블릿 (servlet)

HTTP 요청 하나를 처리하는 Java 객체를 정의한 규약이자 그 규약을 구현한 클래스. `jakarta.servlet.Servlet` 인터페이스가 본체이고, 웹에서 쓰는 것은 대개 그 하위의 `HttpServlet`이다.

핵심은 **서블릿이 스스로 실행되지 않는다는 것**이다. `main()`도 없고 소켓도 열지 않는다. 누군가 요청을 받아서 `service(request, response)`를 대신 불러 줘야만 동작한다. 그 "누군가"가 [[서블릿-컨테이너]]다.

이름은 `server` + `-let`이다. 브라우저 안에서 도는 작은 프로그램을 애플릿(applet)이라 부른 것과 같은 조어법으로, **서버 안에서 도는 작은 프로그램**이라는 뜻이다. 이름 자체가 "혼자 못 돌고 무언가의 안에 들어가야 한다"를 말하고 있다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[서블릿-명세]], [[DispatcherServlet]]

## 서블릿-명세 (Servlet specification)

서블릿 API가 어떤 인터페이스와 동작을 제공해야 하는지 규정한 버전 있는 문서. Jakarta EE의 일부이며 `jakarta.servlet` 네임스페이스를 쓴다.

버전이 있다는 점이 실무에서 중요하다. Spring Boot 4는 **Servlet 6.1** 호환 런타임을 요구하고, 이 기준선을 못 맞추는 구현은 후보에서 빠진다. Undertow가 Boot 4에서 제거된 이유가 정확히 이것이다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[서블릿]], Jakarta EE

## 서블릿-컨테이너 (servlet container)

[[서블릿-명세]]를 실제로 구현한 제품. 소켓을 열어 HTTP를 받고, 파싱해서 `HttpServletRequest` 객체를 만들고, 스레드를 배정해 등록된 [[서블릿]]의 메서드를 호출하고, 결과를 HTTP 응답으로 되돌린다. Tomcat·Jetty·Undertow가 여기 속한다.

"컨테이너"는 서블릿을 담아 두고 그 생명주기(초기화 → 서비스 → 소멸)를 대신 관리한다는 뜻이다. 웹 컨테이너(web container)라고도 부른다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[커넥터]], 웹 서버

## 내장-서블릿-컨테이너 (embedded servlet container)

[[서블릿-컨테이너]] 제품을 별도 설치하지 않고 **라이브러리 의존성으로 끌어와 애플리케이션 프로세스 안에서 직접 시작하는 방식**. `java -jar`만으로 서버가 함께 뜬다.

제품이 다른 것이 아니라 시작 주체가 다르다. 예전에는 컨테이너가 `main()`을 갖고 애플리케이션(WAR)이 그 안에 얹히는 손님이었는데, 내장 방식에서는 애플리케이션이 `main()`을 갖고 컨테이너가 그 안에서 만들어지는 객체가 된다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[외부-서블릿-컨테이너]], 실행 가능 JAR

## 외부-서블릿-컨테이너 (external servlet container)

애플리케이션과 별도로 설치·운영되고 그 안에 배포물(WAR)을 얹는 서버. 전통적인 WAS 배포 방식이다.

Spring Boot 4도 여전히 이 방식을 지원한다 — 패키징을 `war`로 바꾸고, 주 클래스가 `SpringBootServletInitializer`를 상속하고, 내장 컨테이너 의존성을 `provided` 범위로 내려 배포 대상 컨테이너와 충돌하지 않게 한다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[내장-서블릿-컨테이너]]

## 커넥터 (connector)

[[서블릿-컨테이너]] 제품 안에서 **네트워크 쪽 절반**을 담당하는 부분. TCP 소켓을 열고, 바이트를 읽고, HTTP 메시지로 파싱하고, 요청 하나에 처리 스레드를 배정한다.

이 구분이 필요한 이유는 "Tomcat은 웹 서버인가 서블릿 컨테이너인가"라는 혼동 때문이다. Tomcat은 커넥터(웹 서버 역할)와 서블릿 컨테이너 역할을 한 제품 안에 함께 담고 있다. Nginx 같은 순수 웹 서버는 앞의 절반만 하고 서블릿을 모른다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[서블릿-컨테이너]], 리버스 프록시

## DispatcherServlet

Spring MVC가 컨테이너에 등록하는 **단 하나의 [[서블릿]]**. 모든 요청을 받아서 어느 컨트롤러 메서드가 처리할지 찾아 넘기고, 반환값을 응답으로 바꾼다.

컨테이너 입장에서 Spring 애플리케이션은 "서블릿 하나 등록한 웹앱"일 뿐이다. 컨트롤러·`@RequestMapping`·메시지 컨버터는 전부 이 서블릿 **안쪽**의 이야기라 컨테이너는 알지 못한다 — 서버를 갈아 끼워도 컨트롤러 코드가 그대로인 이유가 여기 있다.

"dispatcher"는 들어온 요청을 알맞은 처리기로 **배차**한다는 뜻이다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[서블릿]], 프런트 컨트롤러

## 서블릿-웹서버-팩터리 (ServletWebServerFactory)

Spring Boot가 내장 서버를 만들 때 쓰는 **공통 인터페이스**. 구현체가 제품마다 하나씩 있고(Tomcat용·Jetty용), 자동 구성이 클래스패스를 보고 그중 하나를 빈으로 등록한다.

공식 문서 기준으로 `ServletWebServerApplicationContext`가 시작하면서 이 팩터리 빈을 찾아 서버를 만든다. `server.port` 같은 공통 프로퍼티가 제품과 무관하게 통하는 것도 이 층이 값을 받아 각 제품의 API로 번역하기 때문이다.

- 처음 나온 곳: [[01-servlet-and-embedded-containers]]
- 섞이는 말: [[내장-서블릿-컨테이너]], 자동 구성

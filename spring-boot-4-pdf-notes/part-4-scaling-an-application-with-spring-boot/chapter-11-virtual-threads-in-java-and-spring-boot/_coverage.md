# Chapter 11 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 11 *Virtual Threads in Java and Spring Boot*, 책 pp. 295–314 / PDF pp. 320–339. PDF를 `pdftotext -layout -f 320 -l 339`로 새로 추출해 886줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

상위 절이 6개이고 **실제 하위 제목은 1개**(*Using RestClient with Virtual Threads*)뿐이다. 그 하나는 상위 절 *Using Virtual Threads with RestClient*의 도입 두 문단 바로 뒤에 붙어 **사실상 같은 절의 본문**이므로 쪼개지 않고 [[04-using-virtual-threads-with-restclient]] 한 노트에 담았다. 나머지는 절당 노트 하나다.

**기존 초안 6개의 파일 이름은 하나도 바꾸지 않았다.** Ch12가 `01-understanding-virtual-threads`·`03-integrating-virtual-threads-with-taskexecutor`를, Ch10이 `04-using-virtual-threads-with-restclient`를 참조한다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-understanding-virtual-threads]] | Understanding Virtual Threads | 296–297 | 321–322 |
| [[02-using-virtual-threads-in-a-spring-boot-application]] | Using Virtual Threads in a Spring Boot application | 297–302 | 322–327 |
| [[03-integrating-virtual-threads-with-taskexecutor]] | Integrating Virtual Threads with Spring Boot's TaskExecutor | 302–305 | 327–330 |
| [[04-using-virtual-threads-with-restclient]] | Using Virtual Threads with RestClient (+ 하위 *Using RestClient with Virtual Threads*) | 305–308 | 330–333 |
| [[05-using-interface-proxy-http-service-clients]] | Using Interface-Proxy HTTP service clients in Spring Boot 4 | 309–310 | 334–335 |
| [[06-error-handling-in-concurrent-tasks]] | Error handling in concurrent tasks | 311–314 | 336–339 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 295 | 320 | 장 도입: 리액티브 모델은 강력하지만 **코드를 쓰고 조합하고 이해하는 방식에 복잡도**를 더한다, 가상 스레드는 Java 21에서 Project Loom을 통해 final(19·20은 preview), 다룰 6개 주제 | [[_map]] | 반영 |
| 295 | 320 | Note: 이 장의 소스는 저장소 `ch11` 폴더 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 296 | 321 | 동시성의 정의 — **동시에 실행되지 않더라도** 여러 작업을 함께 다루는 능력, 전통적으로 자바는 OS 스레드에 직접 대응하는 **플랫폼 스레드**로 해결했다 | [[01-understanding-virtual-threads]] | 반영 |
| 296 | 321 | 플랫폼 스레드는 메모리와 스케줄링 비용이 커서 개수가 제한된다, 그래서 스레드 풀·비동기 모델·리액티브 프레임워크에 의존했고 **모두 복잡도를 더한다** | [[01-understanding-virtual-threads]] | 반영 |
| 296 | 321 | 가상 스레드는 **JVM이 관리하는** 경량 스레드, 수백만 개를 최소 오버헤드로 만들 수 있다 | [[01-understanding-virtual-threads]] | 반영 |
| 296 | 321 | 핵심 이점 — **단순한 명령형 블로킹 스타일 코드를 쓰면서 높은 확장성**을 얻는다. 블로킹 시 JVM이 가상 스레드를 중단하고 밑의 플랫폼 스레드를 풀어 준다 | [[01-understanding-virtual-threads]] | 반영 |
| 296 | 321 | Spring Boot 관점 — MVC·데이터 접근·서비스 컴포넌트가 **리액티브로 옮기지 않고도** 확장성을 얻는다 | [[01-understanding-virtual-threads]] | 반영 |
| 296 | 321 | 경계 — I/O 바운드에 특히 잘 맞지만 **논블로킹 데이터 파이프라인이나 세밀한 배압 제어가 필요한 곳에서는 리액티브의 대체가 아니다** | [[01-understanding-virtual-threads]] | 반영 |
| 297 | 322 | Note: JEP 444가 Java 21에서 가상 스레드를 final로 전달한 최종 JEP다 | [[01-understanding-virtual-threads]] | 반영 |
| 297 | 322 | Chapter 9·10의 employee 애플리케이션 아이디어를 재사용하되 **리액티브 대신 명령형**으로 돌아간다, Initializr 좌표 9개 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 297–298 | 322–323 | 의존성 4개(Spring Web·Spring Data JPA·H2·Thymeleaf), **가상 스레드 관련은 아무것도 없다** | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 298 | 323 | `Employee` 엔티티, **record가 아니라 클래스인 이유** — JPA 엔티티는 영속성 컨텍스트가 생명주기를 관리하는 가변 객체다 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 298–299 | 323–324 | `@Entity`·`@GeneratedValue(IDENTITY)`·`@Id` 항목별 3개 설명 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 299 | 324 | `EmployeeRepository extends JpaRepository`, `Startup` 클래스의 `CommandLineRunner initDatabase`와 항목별 3개 설명 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 299–300 | 324–325 | 웹 계층은 `HomeController`와 Thymeleaf — Chapter 2·9에서 이미 다뤄 상세 설명 생략, Figure 11.1 화면 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 (Figure 미추출) |
| 300 | 325 | 직원을 추가해도 **로그에 가상 스레드 관련 항목이 없다** — 아직 켜지 않았기 때문 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 300 | 325 | `spring.threads.virtual.enabled=true` 한 줄, 이 프로퍼티가 켜는 것과 **켜지 않는 것** | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 301 | 326 | 켜도 로그에 표시가 없다 → `ThreadLoggingFilter`를 만들어 확인, 항목별 5개 설명 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 301–302 | 326–327 | 실제 로그 4줄과 항목별 4개 해설 — `VirtualThread[#…]`, `tomcat-handler-X`, **`ForkJoinPool-worker`가 캐리어 스레드**, `isVirtual: true` | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 302 | 327 | `/` 앞이 가상 스레드, 뒤가 **마운트된 캐리어 플랫폼 스레드**. JEP 444의 마운트 설명과 일치 | [[02-using-virtual-threads-in-a-spring-boot-application]] | 반영 |
| 302 | 327 | 요청마다 독립 처리하면서 제한된 플랫폼 스레드를 공유한다, 그런데 **애플리케이션 안에서 비동기로 더 할 일**이 있다는 전환 | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 302–303 | 327–328 | 지금까지 모든 연산이 요청 스레드에서 실행됐다, **HTTP 응답을 지연시키면 안 되는 작업**(감사 로그·알림·외부 프로세스) | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 303 | 328 | `TaskExecutor` 추상, 가상 스레드와 결합하면 **제출된 작업마다 자기 가상 스레드**에서 돈다 | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 303–304 | 328–329 | `AuditService`의 `registerEmployeeCreation`과 항목별 3개 설명 | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 304 | 329 | `HomeController.newEmployee`에서 감사 서비스 호출, **HTTP 응답이 기다리지 않고 즉시 반환된다** | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 304–305 | 329–330 | 배경 작업의 로그 한 줄과 항목별 3개 관찰 — `task-1`이 요청 스레드가 아님을 보여 준다 | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 305 | 330 | Note: `TaskExecutor`는 fire-and-forget에 충분, 결과 추적·예외 처리에는 **`AsyncTaskExecutor`**(Future·CompletableFuture 지원) | [[03-integrating-virtual-threads-with-taskexecutor]] | 반영 |
| 305 | 330 | 외부 서비스 HTTP 호출이 또 다른 흔한 시나리오, **전형적인 I/O 바운드 연산** | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 305 | 330 | `RestClient`는 현대적 **동기** HTTP 클라이언트, 블로킹 모델이라 **가상 스레드와 자연스럽게 통합**된다 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 306 | 331 | Note: `WebClient`도 `.block()`으로 함께 쓸 수 있지만 리액티브 스타일을 우회한다, **명령형에는 RestClient, 리액티브에만 WebClient** | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 306 | 331 | `spring-boot-starter-restclient` + `-test` 의존성과 각각의 역할 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 306–307 | 331–332 | 실제 외부 시스템 대신 `ApiNotificationController`로 알림 API를 시뮬레이션 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 307 | 332 | `NotificationService`가 `RestClient.Builder`로 baseUrl을 잡고 `/notify`를 호출 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 307–308 | 332–333 | 블로킹 호출이지만 가상 스레드에서는 가볍다 — **JVM이 중단하고 플랫폼 스레드를 풀어 준다** | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 308 | 333 | `newEmployee`에 알림 호출 추가, 새 직원 생성 시 세 단계 흐름 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 308 | 333 | 실제 로그 2줄(수신 측·발신 측)과 핵심 3가지 — **양쪽 다 가상 스레드**, 스타일은 블로킹이지만 자원 사용은 아니다 | [[04-using-virtual-threads-with-restclient]] | 반영 |
| 309 | 334 | `RestClient`를 직접 쓰면 요청 구성·URI 정의·응답 처리를 손으로 해야 하고 **반복적이고 덜 표현적인 코드**가 된다 | [[05-using-interface-proxy-http-service-clients]] | 반영 |
| 309 | 334 | Spring Boot 4가 Spring Framework를 통해 **HTTP 인터페이스 프록시**를 제공, 원격 서비스를 자바 인터페이스로 표현 | [[05-using-interface-proxy-http-service-clients]] | 반영 |
| 309 | 334 | `NotificationClient` 인터페이스와 `@PostExchange` 항목별 2개 설명 | [[05-using-interface-proxy-http-service-clients]] | 반영 |
| 309–310 | 334–335 | `HttpClientConfig`의 프록시 빈 — `RestClient.Builder`·`RestClientAdapter`·`HttpServiceProxyFactory` 항목별 3개 설명 | [[05-using-interface-proxy-http-service-clients]] | 반영 |
| 310 | 335 | `NotificationClientService`로 서비스 계층 단순화, 읽고 유지하기 쉬워진다 | [[05-using-interface-proxy-http-service-clients]] | 반영 |
| 311 | 336 | 동기 흐름에서는 예외가 호출 스택으로 자연스럽게 전파되지만, `TaskExecutor`에서는 **별도 스레드라 원래 요청으로 전파되지 않는다** | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 311 | 336 | 이 분리는 **의도적**이다 — 비핵심 실패가 사용자 응답에 영향을 주지 않게 한다 | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 311–312 | 336–337 | 실패를 시뮬레이션하는 `AuditService`, 이름이 "error"면 예외를 던지지만 **HTTP 응답은 정상 반환된다** | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 312 | 337 | 컨트롤러 스레드가 완료를 기다리지 않으므로 예외가 원래 요청 컨텍스트로 전파되지 않는다, **작업 안에서 명시적으로 처리해야 한다** | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 312 | 337 | try-catch로 감싸는 방법, 지역 처리로 **조용한 실패를 막는다** | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 312–313 | 337–338 | 더 고급 시나리오에는 `CompletableFuture` — 여러 비동기 연산의 조율·병렬 호출·응답 결합·폴백·후속 단계 | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 313 | 338 | `CompletableFuture.runAsync(...).exceptionally(...)` 예제와 항목별 3개 설명 — **`runAsync`는 기본적으로 JVM 공용 스레드 풀을 쓴다** | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 313 | 338 | fire-and-forget 방식이며 반환된 `CompletableFuture`를 결합·연결·대기시킬 수도 있다 | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 313 | 338 | **가상 스레드와 `CompletableFuture`는 상호 보완적**이다 — 앞은 블로킹 실행을 단순화, 뒤는 비동기 워크플로를 제어 | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 313–314 | 338–339 | Note: **구조적 동시성(preview)** — 관련 작업을 하나의 스코프로 묶어 완료 보장·일관된 실패 전파·함께 취소, 아직 preview라 이 장은 검증된 방식을 쓴다, JEP 505 | [[06-error-handling-in-concurrent-tasks]] | 반영 |
| 314 | 339 | Summary: Project Loom과 경량 스레딩 → TaskExecutor → RestClient → 인터페이스 프록시 → 오류 처리, 다음 장 예고(Kafka) | [[_map]] | 반영 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 |
|---:|---|---:|---|
| 1 | `Employee` 엔티티 | 298 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 2 | `EmployeeRepository extends JpaRepository` | 299 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 3 | `Startup`의 `CommandLineRunner initDatabase` | 299 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 4 | `spring.threads.virtual.enabled=true` | 300 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 5 | `ThreadLoggingFilter` | 301 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 6 | 가상 스레드 확인 로그 4줄 | 301–302 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 7 | `AuditService.registerEmployeeCreation` (TaskExecutor) | 303 | [[03-integrating-virtual-threads-with-taskexecutor]] |
| 8 | `HomeController.newEmployee` (감사 호출 추가) | 304 | [[03-integrating-virtual-threads-with-taskexecutor]] |
| 9 | 배경 작업 로그 1줄 | 304 | [[03-integrating-virtual-threads-with-taskexecutor]] |
| 10 | `spring-boot-starter-restclient` + `-test` | 306 | [[04-using-virtual-threads-with-restclient]] |
| 11 | `ApiNotificationController` | 306–307 | [[04-using-virtual-threads-with-restclient]] |
| 12 | `NotificationService` (RestClient) | 307 | [[04-using-virtual-threads-with-restclient]] |
| 13 | `HomeController.newEmployee` (알림 호출 추가) | 308 | [[04-using-virtual-threads-with-restclient]] |
| 14 | 클라이언트·서버 양쪽 로그 2줄 | 308 | [[04-using-virtual-threads-with-restclient]] |
| 15 | `NotificationClient` 인터페이스 + `@PostExchange` | 309 | [[05-using-interface-proxy-http-service-clients]] |
| 16 | `HttpClientConfig`의 프록시 빈 | 309–310 | [[05-using-interface-proxy-http-service-clients]] |
| 17 | `NotificationClientService` | 310 | [[05-using-interface-proxy-http-service-clients]] |
| 18 | 실패를 시뮬레이션하는 `AuditService` | 311 | [[06-error-handling-in-concurrent-tasks]] |
| 19 | try-catch로 감싼 `registerEmployeeCreation` | 312 | [[06-error-handling-in-concurrent-tasks]] |
| 20 | `CompletableFuture.runAsync(...).exceptionally(...)` | 312–313 | [[06-error-handling-in-concurrent-tasks]] |

## 3. Tip / Note 블록 → 노트 매핑

| # | 종류 | 요지 | 책 쪽 | 노트 |
|---:|---|---|---:|---|
| 1 | Note | 이 장의 소스는 `ch11` 폴더 | 295 | [[02-using-virtual-threads-in-a-spring-boot-application]] |
| 2 | Note | JEP 444가 Java 21에서 가상 스레드를 final로 전달 | 297 | [[01-understanding-virtual-threads]] |
| 3 | Note | `AsyncTaskExecutor`는 결과 추적·예외 처리가 필요할 때 | 305 | [[03-integrating-virtual-threads-with-taskexecutor]] |
| 4 | Note | `WebClient`는 리액티브 전용, 명령형에는 `RestClient` | 306 | [[04-using-virtual-threads-with-restclient]] |
| 5 | Note | 구조적 동시성(preview)과 JEP 505 | 313–314 | [[06-error-handling-in-concurrent-tasks]] |

## 4. Figure 처리 판단

`pdfimages -f 320 -l 339 -list` 결과 raster 이미지가 **1개**뿐이다(Figure 11.1). PNG로 뽑아 육안 대조한 뒤 **추출하지 않았다.**

| Figure | 책 쪽 / PDF 쪽 | 판단 | 근거 |
|---|---:|---|---|
| 11.1 Employee Application | 300 / 325 | 미추출 | 스타일 없는 HTML 화면이다 — `Employees` 제목, 목록 세 줄(Frodo·Samwise·Bilbo), 입력 두 칸과 Submit 버튼. **이 장의 주제인 가상 스레드에 대한 정보가 하나도 없다.** 본문도 이 화면 바로 뒤에서 "직원을 추가하고 로그를 봐도 가상 스레드 관련 항목이 보이지 않을 것"이라고 말한다. 이 장의 진짜 증거는 화면이 아니라 **로그 출력**이며, 그것은 책에 텍스트로 실려 있어 노트에 그대로 인용했다 |

## 5. 원문의 오류·불일치 (노트에 명시)

| # | 위치 | 내용 |
|---:|---|---|
| 1 | 책 p. 296 vs p. 295 | 장 도입은 "가상 스레드가 **Project Loom을 통해** Java 21에서 final이 됐다"고 정확히 쓰는데, 본문에서는 "**Project Loom, introduced in Java 21**"이라고 해 프로젝트 자체가 Java 21에 도입된 것처럼 읽힌다. Project Loom은 2017년경 시작된 OpenJDK 프로젝트이고, Java 21에서 최종화된 것은 그 산물인 가상 스레드다 |
| 2 | 책 p. 308 (로그) | 알림 수신 측 로그의 스레드 이름이 `VirtualThread[#72,**http-nio-8080-exec-1**]`인데, 같은 애플리케이션의 다른 로그(p.301–302, p.308)는 전부 `tomcat-handler-N` 형식이다. `http-nio-8080-exec-N`은 가상 스레드를 켜지 않은 Tomcat의 전통적 워커 이름이라, 한 실행에서 두 명명 규칙이 섞여 나오는 것이 설명되지 않는다 |
| 3 | 책 pp. 307–308 | `NotificationService`가 `baseUrl("http://localhost:8080")`으로 **자기 자신을 호출한다.** 예제 단순화 목적은 이해되지만, 이 구조가 왜 안전한지(가상 스레드라 캐리어를 점유하지 않아 자기 호출 교착이 생기지 않는다는 점)는 언급되지 않는다. 플랫폼 스레드였다면 부하 상황에서 스레드 고갈로 교착될 수 있는 형태다 |
| 4 | 책 pp. 309–310 | HTTP 인터페이스 프록시를 `HttpServiceProxyFactory`로 **손수 조립**한다. Spring Boot 4에는 같은 일을 선언으로 하는 `@ImportHttpServices`와 `spring.http.serviceclient.*` 프로퍼티가 있고, Chapter 2 `09-calling-versioned-apis-with-http-service-clients`가 그 방식을 다뤘는데 이 장은 그것을 언급하지 않는다 |
| 5 | 책 p. 313 | `runAsync()`가 "JVM의 공용 스레드 풀"을 쓴다고 하고 커스텀 executor를 줄 수 있다고 덧붙이지만, **예제 코드는 executor를 주지 않는다.** 즉 이 절의 `CompletableFuture` 예제는 앞에서 켠 가상 스레드가 아니라 `ForkJoinPool.commonPool()`의 플랫폼 스레드에서 돈다. 장의 주제와 어긋나는데 그 사실이 강조되지 않는다 |

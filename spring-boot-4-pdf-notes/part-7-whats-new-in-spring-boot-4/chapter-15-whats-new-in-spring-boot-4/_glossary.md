# Chapter 15 용어집

> Chapter 15에서 사용하는 전문 용어의 정의 원본이다. 이 Chapter는 노트가 하나뿐이므로, 그 노트가 첫 등장 때 `**[[용어]]**(= 한 줄 풀이)` 형태로 여기를 링크한다. 앞 Chapter에서 이미 나온 말이라도 이 Chapter의 노트에서 링크하려면 여기에 다시 정의가 있어야 하므로, 그런 항목은 Boot 4 문맥에 맞춰 다시 적었다.

## 기준선 (baseline)
프레임워크가 요구하는 최소 버전이다. Spring Boot 4의 Java 기준선은 17이며, 그보다 낮은 버전에서는 아예 동작하지 않는다. "권장 버전"과 다르다 — 기준선은 하한이고 권장은 선택이다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[Jakarta-EE]], 지원 종료

## Jakarta-EE (Jakarta Enterprise Edition)
Java EE가 Oracle에서 Eclipse 재단으로 이관되며 바뀐 이름이자 그 사양 모음이다. 이관 과정에서 패키지 접두어가 `javax.*`에서 `jakarta.*`로 바뀌었고, 그래서 버전을 올릴 때 import 문이 대거 바뀐다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[서블릿-명세]], Spring Framework

## 서블릿-명세 (Servlet specification)
HTTP 요청 하나를 처리하는 객체 모델과 그 컨테이너의 동작을 정의한 Java 표준이다. 버전마다 컨테이너가 구현해야 할 기능이 정해지므로, 기준선이 올라가면 그 버전을 구현하지 못한 컨테이너는 지원 목록에서 빠진다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[Jakarta-EE]], Tomcat·Jetty·Undertow

## JSpecify (JSpecify)
Java의 nullness 애노테이션에 하나의 표준 의미를 부여하려는 벤더 중립 명세다. 라이브러리마다 제각각이던 `@Nullable`들이 서로 다른 뜻을 갖던 문제를 없애려고 만들어졌다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[널-계약]], [[정적-분석]]

## 널-계약 (nullness contract)
어떤 반환값·파라미터·필드가 `null`일 수 있는지를 타입 수준에서 선언한 약속이다. 선언만으로는 실행이 막히지 않고, 검사 도구가 위반을 지적하는 근거가 된다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[JSpecify]], `Optional`

## 정적-분석 (static analysis)
프로그램을 실행하지 않고 소스나 바이트코드만 읽어 문제를 찾아내는 검사다. IDE의 실시간 경고와 빌드 단계의 NullAway 같은 도구가 모두 여기 속한다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[널-계약]], 테스트

## BeanRegistrar (BeanRegistrar)
Spring Framework 7이 도입한 가벼운 프로그래밍 방식 빈 등록 API다. 환경 프로퍼티·조건 분기·반복문처럼 `@Bean` 메서드만으로는 표현이 어색한 등록 로직을 코드로 쓰게 해 준다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: `@Bean`, `BeanDefinitionRegistryPostProcessor`

## Jackson-3 (Jackson 3)
Spring Boot 4가 선호 JSON 라이브러리로 채택한 Jackson의 새 메이저 버전이다. 대부분의 Maven 좌표와 패키지 접두어가 `com.fasterxml.jackson`에서 `tools.jackson`으로 옮겨 갔다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[사용-중단]], `jackson-annotations`

## 스타터 (starter)
어떤 기능을 쓰기 시작하는 데 필요한 의존성 묶음을 하나의 이름으로 제공하는 Maven/Gradle 아티팩트다. 스타터 자체에는 보통 코드가 거의 없고 필요한 라이브러리들을 전이 의존성으로 끌어온다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[집중형-스타터]], [[전이-의존성]]

## 집중형-스타터 (focused starter)
여러 기술을 한꺼번에 덮는 넓은 스타터 대신, 애플리케이션이 실제로 쓰는 기술 하나에 대응하는 좁은 스타터다. `spring-boot-starter-web`이 `spring-boot-starter-webmvc`로 바뀐 것이 대표 예다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[스타터]], [[클래식-스타터]]

## 클래식-스타터 (classic starter)
Spring Boot 3.x에 가까운 넓은 구성을 그대로 제공해 업그레이드를 돕는 임시 스타터다. `spring-boot-starter-classic`과 `spring-boot-starter-test-classic`이 있으며, 마이그레이션 보조 수단으로만 쓰도록 안내된다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[집중형-스타터]], [[사용-중단]]

## 전이-의존성 (transitive dependency)
내가 직접 선언하지 않았지만 내가 선언한 의존성이 다시 의존해서 함께 딸려 오는 라이브러리다. 스타터가 동작하는 원리이자, 클래스패스에 예상 밖의 기술이 들어오는 원인이기도 하다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[스타터]], 클래스패스

## API-버전-관리 (API versioning)
호환되지 않는 여러 HTTP 계약을 동시에 제공하면서 요청마다 어느 계약을 쓸지 명시하게 하는 방식이다. Spring Framework 7에서 프레임워크의 일급 개념이 되었다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[사용-중단]], 계약

## HTTP-서비스-클라이언트 (HTTP service client)
원격 HTTP 호출을 Java 인터페이스의 메서드 선언으로 표현하는 Spring의 모델이다. 구현체는 개발자가 쓰지 않고 런타임 프록시로 생성된다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[프록시]], `RestClient`·`WebClient`

## 프록시 (proxy)
어떤 타입인 척하면서 호출을 가로채 실제 동작을 대신 수행하는 객체다. HTTP 서비스 클라이언트의 구현, 트랜잭션 적용, 리포지토리 구현이 모두 이 방식으로 만들어진다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[HTTP-서비스-클라이언트]], 리버스 프록시

## 정적-리소스 (static resources)
서버가 가공 없이 그대로 내보내는 파일이다. Spring Boot는 정해진 경로들을 "공통 정적 리소스 위치"로 취급하며, 이 목록이 보안 설정의 기본 허용 대상과 맞물린다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: 템플릿, `PathRequest`

## 모듈-세분화 (modularization)
하나의 큰 자동 구성 묶음을 기술별 작은 모듈로 나누는 것이다. 무엇이 왜 켜졌는지 빌드 파일에서 읽히게 만드는 대신, 안 넣은 것은 안 켜진다는 책임이 개발자에게 넘어온다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[집중형-스타터]], 자동 구성

## 빈-오버라이드 (bean override)
테스트에서 컨텍스트의 특정 빈을 가짜 객체로 갈아 끼우는 기능이다. Spring Boot 4는 자기 고유 애노테이션을 걷어내고 Spring Framework의 공통 모델로 통일했다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[테스트-슬라이스]], Mockito

## 테스트-슬라이스 (test slice)
애플리케이션 전체가 아니라 특정 계층만 띄워 검증하는 테스트 구성이다. `@WebMvcTest`·`@DataJpaTest`처럼 필요한 자동 구성만 켜므로 빠르고 관심사가 좁다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[빈-오버라이드]], `@SpringBootTest`

## Testcontainers (Testcontainers)
테스트 실행 중 도커 컨테이너로 실제 데이터베이스·메시지 브로커를 띄워 주는 라이브러리다. 내장 대체물이 아니라 운영과 같은 제품으로 검증하게 해 준다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[테스트-슬라이스]], 내장 데이터베이스

## 재시도 (retry)
실패한 작업을 정해진 정책에 따라 다시 시도하는 장치다. 일시적 장애를 흡수하지만, 멱등하지 않은 작업에 걸면 중복을 만든다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: 백오프, 멱등성

## 배치-메타데이터 (batch metadata, JobRepository)
배치 작업의 인스턴스·실행 이력·재시작 정보를 담는 저장소다. 이것이 영속적이어야 중단된 작업을 이어서 재시작할 수 있다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: 인메모리, `DataSource`

## OpenTelemetry (OpenTelemetry, OTel)
메트릭·트레이스·로그를 수집하고 내보내는 방식을 벤더 중립으로 표준화한 명세와 SDK다. 특정 관측 백엔드에 코드를 묶지 않기 위해 만들어졌다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[OTLP]], [[Observation-API]]

## OTLP (OpenTelemetry Protocol)
OpenTelemetry가 정의한 텔레메트리 전송 프로토콜이다. 애플리케이션이 이 형식으로 내보내면 이를 이해하는 어떤 수집기·백엔드로도 보낼 수 있다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[OpenTelemetry]], 익스포터

## Observation-API (Micrometer Observation API)
애플리케이션 코드가 "관측할 만한 일이 일어났다"를 한 번 알리면 그것이 메트릭과 트레이스로 동시에 흘러가게 하는 Micrometer의 추상화다. 계측 코드를 두 번 쓰지 않게 한다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[OpenTelemetry]], Micrometer

## 상태-프로브 (health probe)
컨테이너 오케스트레이터가 애플리케이션이 살아 있는지(liveness), 트래픽을 받을 준비가 됐는지(readiness) 확인하는 엔드포인트다. 두 질문의 답이 다를 수 있어 별도로 존재한다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: Actuator, Kubernetes

## 작업-데코레이터 (TaskDecorator)
비동기·스케줄 작업이 실제로 실행되기 전에 그 작업을 감싸 부가 처리를 넣는 장치다. 추적 컨텍스트나 보안 컨텍스트를 다른 스레드로 옮기는 데 쓴다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[프록시]], `TaskExecutor`

## 네이티브-이미지 (native image)
JVM 없이 바로 실행되는 기계어 실행 파일로 애플리케이션을 미리 컴파일한 것이다. 시작이 빠르고 메모리를 덜 쓰지만, 실행 중 동적으로 결정되는 것들을 빌드 시점에 미리 알려 줘야 한다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[AOT]], [[런타임-힌트]]

## AOT (Ahead-of-Time)
실행 전, 빌드 시점에 미리 처리해 두는 방식이다. Spring의 AOT 엔진은 애플리케이션을 빌드 때 분석해 네이티브 이미지가 필요로 하는 메타데이터를 만들어 낸다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[네이티브-이미지]], [[AOT-캐시]]

## AOT-캐시 (Java AOT Cache)
JVM이 한 번의 학습 실행에서 시작 관련 데이터를 기록해 두고 이후 실행에서 재사용하는 Java 24 도입 기능이다. 네이티브 이미지와 달리 **애플리케이션은 계속 일반 JVM 위에서 돈다.**
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[AOT]], [[네이티브-이미지]]

## 런타임-힌트 (runtime hints)
리플렉션·리소스·프록시·직렬화처럼 실행 중에 동적으로 결정되는 요소를 빌드 시점에 미리 알려 주는 메타데이터다. 이것이 없으면 네이티브 이미지에서 그 경로가 통째로 빠진다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[네이티브-이미지]], [[AOT]]

## 구성-메타데이터 (configuration metadata)
어떤 구성 프로퍼티가 존재하고 어떤 타입이며 무엇을 뜻하는지를 담은 기계 판독용 정보다. IDE의 자동 완성과 문서화가 이 정보를 근거로 동작한다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: `@ConfigurationProperties`, 모듈

## 프로퍼티-마이그레이터 (spring-boot-properties-migrator)
빌드에 잠시 넣어 두면 애플리케이션이 쓰는 구성 프로퍼티 중 사용 중단되었거나 이름이 바뀐 것을 찾아 알려 주는 Spring Boot 모듈이다. 업그레이드 초기에 손으로 뒤질 범위를 크게 줄여 준다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[사용-중단]], 마이그레이션 가이드

## 사용-중단 (deprecation)
아직 동작하지만 앞으로 제거될 예정이라고 표시하는 것이다. 제거와 다르다 — 사용 중단은 옮길 시간을 주고, 제거는 그 시간이 끝났다는 뜻이다.
- 처음 나온 곳: [[01-whats-new-in-spring-boot-4]]
- 섞이는 말: [[클래식-스타터]], 제거

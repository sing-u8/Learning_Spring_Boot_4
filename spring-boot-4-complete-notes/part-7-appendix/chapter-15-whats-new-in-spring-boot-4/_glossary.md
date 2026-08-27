# Whats New In Spring Boot 4 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## spring-framework-7
Spring Boot 4가 기반으로 삼는 핵심 컨테이너·웹 프레임워크 세대
- 처음 나온 곳: [[00-core-framework-changes]]
- 섞이는 말: spring-boot-4

## jakarta-ee-11
Servlet 6.1, Persistence 3.2, Validation 3.1 등을 묶은 Jakarta 표준 세대
- 처음 나온 곳: [[00-core-framework-changes]]
- 섞이는 말: Spring Framework

## jspecify
Java API에서 null 허용 여부를 도구 중립적으로 표현하는 어노테이션 모델
- 처음 나온 곳: [[00-core-framework-changes]]
- 섞이는 말: 런타임 null 검사

## bean-registrar
애플리케이션 컨텍스트 초기화 중 조건과 반복으로 빈 정의를 등록하는 API
- 처음 나온 곳: [[00-core-framework-changes]]
- 섞이는 말: @Bean

## jackson-3
Spring Boot 4가 우선 사용하는 JSON 처리 라이브러리 세대
- 처음 나온 곳: [[00-core-framework-changes]]
- 섞이는 말: Jackson 2

## starter
개발자가 복잡한 라이브러리 의존성 버전을 일일이 맞추지 않도록, 특정 목적(예: 웹 개발, DB 연결)에 필요한 의존성들을 한 덩어리로 묶어놓은 Spring Boot의 편리한 의존성 패키지
- 처음 나온 곳: [[01-renamed-and-restructured-starters]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## classic-starter
Spring Boot 4의 깐깐해진 명시적 의존성 선언 규칙 때문에 3.x에서 마이그레이션하기 힘든 개발자들을 위해 제공되는, 과거의 관대한(Broad) 의존성 묶음을 그대로 제공하는 임시 스타터
- 처음 나온 곳: [[01-renamed-and-restructured-starters]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## api-versioning
클라이언트 하위 호환성을 유지하기 위해 URL이나 헤더를 통해 API의 버전을 관리하는 기법 (예: v1, v2)
- 처음 나온 곳: [[02-web-api-and-security-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## http-service-proxy
RestClient 코드를 직접 짤 필요 없이, 인터페이스에 @GetExchange 같은 애노테이션만 붙여두면 스프링이 런타임에 HTTP 통신 코드를 대신 작성(프록시 생성)해주는 선언적 통신 기술
- 처음 나온 곳: [[02-web-api-and-security-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## hibernate-7
자바 진영의 표준 ORM인 JPA 3.2 스펙을 구현한 최신 하이버네이트 버전
- 처음 나온 곳: [[03-data-layer-and-testing-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mockitobean
(구 @MockBean) 스프링 통합 테스트 시 ApplicationContext 안에 들어있는 실제 객체 대신 Mockito가 만든 가짜(Mock) 객체를 주입시켜 특정 컴포넌트의 동작을 고립(Isolation) 테스트하게 해주는 애노테이션
- 처음 나온 곳: [[03-data-layer-and-testing-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## testcontainers
로컬에 DB나 인프라를 직접 설치할 필요 없이, JUnit 테스트가 실행될 때 도커(Docker) 컨테이너를 띄워서 통합 테스트를 수행하고 끝나면 자동으로 지워주는 자바 라이브러리
- 처음 나온 곳: [[03-data-layer-and-testing-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## opentelemetry
(OTel) 애플리케이션의 메트릭, 분산 추적, 로그를 수집하여 모니터링 시스템(Grafana, Datadog 등)으로 전송하기 위한 벤더 중립적인 오픈소스 표준 규격
- 처음 나온 곳: [[04-observability-native-image-and-other-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## task-decorator
비동기 쓰레드 풀(TaskExecutor)로 작업을 던질 때, 원본 쓰레드에 있던 중요한 컨텍스트(Security, MDC, Trace ID 등)를 대상 쓰레드로 안전하게 복사(전파)해주는 스프링의 인터페이스
- 처음 나온 곳: [[04-observability-native-image-and-other-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## aot-cache
Ahead-Of-Time Cache. JVM 애플리케이션의 초기 구동(클래스 로딩, JIT 컴파일 등) 비용을 줄이기 위해, 첫 실행 시의 상태를 디스크에 캐싱해두고 다음 실행부터는 이를 재사용해 스타트업 시간을 줄여주는 최신 Java 스펙
- 처음 나온 곳: [[04-observability-native-image-and-other-changes]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

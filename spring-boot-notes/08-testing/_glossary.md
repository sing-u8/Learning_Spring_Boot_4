# 08-testing 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 제이유닛6 (junit 6)
Spring Boot 4에서 기본으로 채택된 차세대 자바 표준 단위 테스트 프레임워크로, 모듈화된 테스트 런타임과 향상된 파라미터화 테스트 및 라이프사이클 훅을 제공함.
- 처음 나온 곳: [[01-junit6-and-domain-unit-testing]]
- 섞이는 말: [[어서트제이]], [[스프링-부트-테스트]]

## 어서트제이 (assertj)
`assertThat(actual).isEqualTo(expected)`와 같이 물 흐르듯 읽히는 Fluent API 체이닝으로 테스트 결과를 단언(Assertion)할 수 있게 해주는 표준 테스트 라이브러리.
- 처음 나온 곳: [[01-junit6-and-domain-unit-testing]]
- 섞이는 말: [[제이유닛6]]

## 슬라이스-테스트 (slice test)
전체 무거운 `ApplicationContext`를 다 띄우지 않고, 특정 계층(웹 계층, JPA 계층 등)에 필요한 최소한의 빈들만 격리 로드하여 초고속으로 검증하는 스프링 부트의 분할 테스트 기법.
- 처음 나온 곳: [[02-web-mvc-test-mockmvc-mockito-bean]]
- 섞이는 말: [[목엠브이씨]], [[데이터-제이피에이-테스트]]

## 목엠브이씨 (mockmvc)
실제 HTTP 서블릿 컨테이너(Tomcat)를 띄우지 않고, 스프링 MVC의 `DispatcherServlet` 요청 처리 파이프라인을 인메모리에서 가상 시뮬레이션하여 컨트롤러를 검증하는 테스트 도구.
- 처음 나온 곳: [[02-web-mvc-test-mockmvc-mockito-bean]]
- 섞이는 말: [[슬라이스-테스트]], [[레스트-테스트-클라이언트]]

## 목키토-빈 (mockito bean)
Spring Boot 4에서 구형 `@MockBean`을 대체하여 스프링 코어 프레임워크 표준으로 통합된 어노테이션으로, 컨텍스트 내의 실제 빈을 Mockito 가짜 객체로 오버라이드 주입하는 어노테이션 (`@MockitoBean`).
- 처음 나온 곳: [[02-web-mvc-test-mockmvc-mockito-bean]]
- 섞이는 말: [[슬라이스-테스트]]

## 데이터-제이피에이-테스트 (data jpa test)
JPA 엔티티, 리포지토리, EntityManager, 데이터소스 관련 빈들만 선별 로드하고 각 테스트 메서드마다 자동으로 트랜잭션을 롤백하는 JPA 전용 슬라이스 테스트 어노테이션 (`@DataJpaTest`).
- 처음 나온 곳: [[03-data-jpa-test-and-embedded-db]]
- 섞이는 말: [[슬라이스-테스트]], [[테스트컨테이너]]

## 테스트컨테이너 (testcontainers)
단위/통합 테스트 실행 시 Docker 데몬과 연동하여 실제 운영과 동일한 경량 컨테이너(PostgreSQL, Kafka 등)를 자바 코드로 자동 기동하고 테스트 종료 후 폐기하는 오픈소스 라이브러리 (`@Testcontainers`).
- 처음 나온 곳: [[04-testcontainers-and-service-connection]]
- 섞이는 말: [[서비스-커넥션]], [[데이터-제이피에이-테스트]]

## 서비스-커넥션 (service connection)
Spring Boot 4와 Testcontainers 연동 시, 컨테이너의 동적 포트와 접속 정보를 `spring.datasource.url` 등에 수동 매핑할 필요 없이 자동으로 스프링 부트 프로퍼티에 바인딩해 주는 제로 구성 어노테이션 (`@ServiceConnection`).
- 처음 나온 곳: [[04-testcontainers-and-service-connection]]
- 섞이는 말: [[테스트컨테이너]]

## 스프링-시큐리티-테스트 (spring security test)
Spring Security의 인증/인가 필터체인과 보안 컨텍스트를 테스트 환경에서 손쉽게 검증할 수 있도록 돕는 전용 테스트 서브시스템 (`spring-security-test`).
- 처음 나온 곳: [[05-spring-security-test-and-mock-user]]
- 섞이는 말: [[위드-목-유저]], [[목엠브이씨]]

## 위드-목-유저 (with mock user)
실제 DB 로그인 절차 없이, 특정 권한(Role/Authority)과 사용자명을 가진 가짜 `SecurityContext` 인증 객체를 테스트 메서드에 즉시 주입해 주는 보안 테스트 어노테이션 (`@WithMockUser`).
- 처음 나온 곳: [[05-spring-security-test-and-mock-user]]
- 섞이는 말: [[스프링-시큐리티-테스트]]

## 레스트-테스트-클라이언트 (rest test client)
Spring Boot 4에 새롭게 도입된 고성능 동기식 REST API 테스트 클라이언트로, 실제 포트로 실행 중인 서버나 MockMvc 환경에 대해 직관적인 Fluent API로 HTTP 요청을 보내고 검증하는 도구 (`RestTestClient`).
- 처음 나온 곳: [[06-rest-test-client-and-integration]]
- 섞이는 말: [[스프링-부트-테스트]], [[목엠브이씨]]

## 스프링-부트-테스트 (spring boot test)
애플리케이션의 모든 빈과 설정을 포함하여 실제 운영과 동일한 완전한 `ApplicationContext`를 기동하고 엔드투엔드(End-to-End) 통합 검증을 수행하는 어노테이션 (`@SpringBootTest`).
- 처음 나온 곳: [[06-rest-test-client-and-integration]]
- 섞이는 말: [[레스트-테스트-클라이언트]], [[슬라이스-테스트]]

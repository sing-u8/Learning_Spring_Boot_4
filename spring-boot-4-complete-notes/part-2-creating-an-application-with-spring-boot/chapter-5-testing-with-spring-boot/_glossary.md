# Testing with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## junit-6
스프링 부트 4의 기본 테스팅 프레임워크로, 테스트를 정의하고 실행하는 가장 필수적인 자바 표준 도구
- 처음 나온 곳: [[01-adding-junit-6-to-the-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mockito
실제 동작하는 객체 대신, "이 메서드를 부르면 무조건 A를 반환해라"라고 조작할 수 있는 가짜(Mock) 객체를 만들어주는 프레임워크
- 처음 나온 곳: [[01-adding-junit-6-to-the-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## assertj
테스트의 결과가 예상과 일치하는지 확인할 때, 메서드 체이닝을 이용해 사람이 읽기 쉬운 유창한(Fluent) 문법을 제공하는 검증 라이브러리
- 처음 나온 곳: [[01-adding-junit-6-to-the-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## test-suite
연관된 여러 개의 테스트 케이스(메서드)들을 논리적으로 묶어놓은 클래스나 모듈 단위. 주로 클래스명 끝에 Test를 붙인다
- 처음 나온 곳: [[02-creating-tests-for-your-domain-objects]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## assertion
테스트를 수행한 후, 예상했던 결과(Expected)와 실제 결과(Actual)가 똑같은지 단언(확인)하는 행위 및 그 메서드들
- 처음 나온 곳: [[02-creating-tests-for-your-domain-objects]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## test-coverage
전체 애플리케이션 코드 중에서, 자동화된 테스트 코드가 실제로 실행해 본 코드의 비율(줄 수, 브랜치 등)을 시각적으로 나타내는 품질 지표
- 처음 나온 곳: [[02-creating-tests-for-your-domain-objects]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## web-mvc-test
스프링 부트에서 제공하는 슬라이스 테스트 애노테이션으로, 전체 컨텍스트를 로드하지 않고 웹 컨트롤러 관련 빈(Bean)들만 골라서 빠르게 로드해 준다
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mock-mvc
톰캣 같은 진짜 웹 서버를 띄우지 않고도, 스프링 MVC 구조 내에서 HTTP 요청(GET, POST 등)과 응답을 흉내 내고 검증할 수 있게 해주는 핵심 유틸리티
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mockito-bean
테스트 컨텍스트에 등록된 기존 빈을 무시하고, Mockito를 이용해 만든 가짜(Mock) 객체를 스프링 컨텍스트에 주입해주는 애노테이션
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## with-mock-user
스프링 시큐리티 테스트 라이브러리가 제공하며, 테스트 메서드 실행 시 가짜 인증 세션(Username, Role)을 강제로 만들어 시큐리티 필터를 통과하게 해준다
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mockito-extension
무거운 스프링 컨텍스트를 로드하지 않고 순수 JUnit 5/6 환경에서 Mockito의 애노테이션(@Mock, @InjectMocks)을 활성화해주는 확장 클래스
- 처음 나온 곳: [[04-testing-data-repositories-with-mocks]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mock
내부에 아무런 깡통 로직도 없이, 개발자가 테스트 시점에 "이렇게 물어보면 저렇게 대답해"라고 세팅한 대로만 동작하는 더미 객체
- 처음 나온 곳: [[04-testing-data-repositories-with-mocks]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## bdd-mockito
기존 Mockito의 when() 키워드를 given()으로 바꾸어, 소프트웨어 개발 방법론인 행동 주도 개발(BDD)의 Given-When-Then 흐름에 자연스럽게 읽히도록 만든 API
- 처음 나온 곳: [[04-testing-data-repositories-with-mocks]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## data-jpa-test
전체 애플리케이션을 띄우지 않고, JPA 엔티티와 리포지토리 구성 요소만 로드하여 데이터 액세스 계층을 초고속으로 테스트하게 해주는 슬라이스 테스트 애노테이션
- 처음 나온 곳: [[05-testing-data-repositories-with-embedded-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## embedded-database
외부 서버에 별도로 설치할 필요 없이 애플리케이션과 동일한 JVM 내에서 실행되는 가벼운 데이터베이스 엔진 (예: H2, HSQLDB, Derby)
- 처음 나온 곳: [[05-testing-data-repositories-with-embedded-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## in-memory-database
디스크에 데이터를 영구 저장하지 않고 주 메모리(RAM)에만 데이터를 보관하여, 입출력 속도가 극단적으로 빠르며 앱 종료 시 데이터가 휘발되는 데이터베이스
- 처음 나온 곳: [[05-testing-data-repositories-with-embedded-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## testcontainers
자바(JUnit) 환경에서 Docker를 프로그래밍 방식으로 제어하여, 테스트 시점에만 일회용으로 데이터베이스나 메시지 브로커 등을 띄워주는 라이브러리
- 처음 나온 곳: [[06-testing-data-repositories-using-containerized-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## auto-configure-test-database
@DataJpaTest 사용 시, 클래스패스에 H2 같은 인메모리 DB가 있으면 원래 설정된 DB를 무시하고 덮어쓰는 기능. replace = Replace.NONE으로 이 동작을 막을 수 있다
- 처음 나온 곳: [[06-testing-data-repositories-using-containerized-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## service-connection
스프링 부트 3.1부터 도입된 애노테이션으로, 띄워진 Testcontainers의 동적 포트와 연결 정보를 수동 설정 없이 스프링의 DataSource 등에 자동으로 바인딩해 준다
- 처음 나온 곳: [[06-testing-data-repositories-using-containerized-databases]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-security-test
스프링 시큐리티의 인증 및 인가 과정을 모의(Mock)로 시뮬레이션할 수 있도록 @WithMockUser와 SecurityMockMvcRequestPostProcessors 등을 제공하는 전용 테스팅 툴킷
- 처음 나온 곳: [[07-testing-security-policies-with-spring-security-test]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## negative-path
성공하는 정상적인 흐름(해피 패스)의 반대말로, 예외가 발생하거나 접근이 거부되어야 하는 상황이 우리가 의도한 대로 잘 실패(?)하는지 확인하는 테스트 경로
- 처음 나온 곳: [[07-testing-security-policies-with-spring-security-test]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## authorization
사용자가 시스템에 들어온 후(인증 완료), '이 버튼을 누를 수 있는가', '이 데이터를 볼 수 있는가' 등의 접근 권한 유무를 검사하는 통제 행위(인가)
- 처음 나온 곳: [[07-testing-security-policies-with-spring-security-test]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

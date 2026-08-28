# Chapter 5 용어집

> Chapter 5에서 사용하는 전문 용어의 정의 원본이다. 개념 노트는 첫 등장 때 `**[[용어]]**(= 한 줄 풀이)` 형태로 여기를 링크하고, 정의 자체는 이 파일에만 둔다. 앞 Chapter에서 이미 나온 말이라도 이 Chapter의 노트에서 링크하려면 여기에 다시 정의가 있어야 하므로, 그런 항목은 테스트 문맥에 맞춰 다시 적었다.

## JUnit (JUnit)
Java에서 가장 널리 쓰이는 테스트 프레임워크다. 테스트 메서드를 표시하고, 실행 순서와 생명주기를 관리하고, 결과를 보고한다. Spring Boot 4의 기본은 JUnit 6다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[테스트-스타터]], Mockito

## 테스트-스타터 (test starter)
테스트에 필요한 도구 묶음을 하나의 좌표로 제공하는 스타터다. Spring Boot 4는 하나의 거대한 스타터 대신 웹·데이터·보안·템플릿처럼 관심사별로 나뉜 집중형 스타터를 제공한다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[JUnit]], 의존성 scope

## 모킹 (mocking)
협력 객체를 가짜로 바꿔 놓고, **결과가 아니라 어떤 메서드가 불렸는지**를 검증하는 테스트 방식이다. 진짜 협력자를 부르지 않으므로 빠르고 격리되지만, 잘못 쓰면 가짜 자신을 테스트하게 된다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[스텁]], [[행위-검증]]

## AssertJ (AssertJ)
`assertThat(값).isEqualTo(...)`처럼 점으로 이어 쓰는 유창한 단언 API를 제공하는 라이브러리다. 실패 메시지가 무엇을 기대했고 무엇이 왔는지 구체적으로 알려 준다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[단언]], [[Hamcrest]]

## Hamcrest (Hamcrest)
`containsString(...)` 같은 **matcher** 객체를 조합해 조건을 표현하는 라이브러리다. MockMvc의 `content().string(...)`처럼 matcher를 인자로 받는 API에서 함께 쓰인다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[AssertJ]], matcher

## Mockito (Mockito)
Java에서 가장 널리 쓰이는 모킹 프레임워크다. 가짜 객체를 만들고, 그 객체가 무엇을 돌려줄지 정하고(stub), 무엇이 불렸는지 확인한다(verify).
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[모킹]], [[스텁]]

## JSONPath (JSONPath)
JSON 문서 안의 값을 경로 표현식으로 집어내는 질의 언어다. `$.videos[0].name` 같은 표현으로 응답의 특정 부분만 단언할 수 있다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[JSONassert]], XPath

## JSONassert (JSONassert)
두 JSON 문서를 비교하되 **키 순서나 공백 같은 무의미한 차이를 무시**하고 의미 단위로 단언하는 라이브러리다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[JSONPath]], 문자열 비교

## XMLUnit (XMLUnit)
XML 문서를 구조 단위로 비교·검증하는 도구다. JSON 쪽의 JSONassert에 대응한다.
- 처음 나온 곳: [[01-junit-6-and-focused-test-starters]]
- 섞이는 말: [[JSONassert]], XPath

## 도메인-모델 (domain model)
시스템의 핵심 업무 개념을 나타내는 클래스들이다. 컨트롤러·서비스·리포지토리가 전부 이 위에 얹히므로, 단순해 보여도 가장 먼저 검증할 가치가 있다.
- 처음 나온 곳: [[02-testing-domain-objects]]
- 섞이는 말: 엔티티, DTO

## 테스트-케이스 (test case)
하나의 시나리오를 검증하는 테스트 메서드다. 이름이 곧 문서이므로 "무엇이 어떠해야 한다"를 문장처럼 적는 것이 관례다.
- 처음 나온 곳: [[02-testing-domain-objects]]
- 섞이는 말: 테스트 스위트, [[단언]]

## 단언 (assertion)
기대한 값·상태와 실제를 비교해, 다르면 테스트를 실패시키는 문장이다. 단언이 없는 테스트는 코드를 실행할 뿐 아무것도 검증하지 않는다.
- 처음 나온 곳: [[02-testing-domain-objects]]
- 섞이는 말: [[AssertJ]], [[행위-검증]]

## 유창한-API (fluent API)
메서드가 자기 자신(또는 같은 계열)을 돌려주어 점으로 계속 이어 쓸 수 있게 만든 API 문체다. 코드가 문장처럼 읽힌다.
- 처음 나온 곳: [[02-testing-domain-objects]]
- 섞이는 말: [[AssertJ]], MockMvc

## 테스트-커버리지 (test coverage)
테스트를 돌렸을 때 실제로 실행된 코드의 비율이다. 실행됐다는 사실만 말할 뿐 **검증됐다는 뜻은 아니라는 점**이 이 지표의 한계다.
- 처음 나온 곳: [[02-testing-domain-objects]]
- 섞이는 말: [[단언]], 커버리지 하이라이팅

## MockMvc (MockMvc)
실제 서버를 띄우지 않고 Spring MVC의 요청 처리 기계를 그대로 통과시키는 테스트 도구다. 요청을 만들어 넣고 응답 상태·헤더·본문을 단언한다.
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: [[테스트-슬라이스]], TestRestTemplate

## 테스트-슬라이스 (test slice)
애플리케이션 전체가 아니라 특정 계층만 띄워 검증하는 테스트 구성이다. `@WebMvcTest`는 웹 계층만, `@DataJpaTest`는 JPA 계층만 켠다.
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: `@SpringBootTest`, [[빈-오버라이드]]

## 빈-오버라이드 (bean override)
테스트 컨텍스트의 특정 빈을 가짜 객체로 갈아 끼우는 기능이다. Spring Boot 4에서는 `@MockitoBean`이 이 역할을 하며, 이름 자체가 Mockito 기반임을 드러낸다.
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: [[모킹]], [[테스트-슬라이스]]

## CSRF (Cross-Site Request Forgery)
로그인한 사용자의 브라우저를 이용해 사용자가 의도하지 않은 요청을 보내게 만드는 공격이다. 방어는 서버가 발급한 토큰을 요청에 함께 담게 하는 것이며, 그래서 테스트도 그 토큰을 공급해야 한다.
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: [[인증]], 폼 제출

## 리다이렉트 (redirect)
서버가 응답 본문 대신 "다른 URL로 다시 요청하라"는 지시를 돌려주는 방식이다. 상태 코드가 300번대이며, 테스트에서는 목적지 URL까지 함께 확인한다.
- 처음 나온 곳: [[03-testing-web-controllers-with-mockmvc]]
- 섞이는 말: PRG, [[단언]]

## 협력자 (collaborator)
어떤 객체가 자기 일을 하기 위해 호출하는 다른 객체다. 무엇을 테스트할지 정할 때 먼저 할 일이 이 협력자 목록을 식별하는 것이다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: 의존성, [[모킹]]

## 단위-테스트 (unit test)
원칙적으로 **클래스 하나만** 검증하는 테스트다. 바깥 서비스는 전부 가짜로 바꾼다. 빠르지만, 잘못하면 가짜 자신을 테스트하는 데 그칠 위험이 있다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[통합-테스트]], [[모킹]]

## 통합-테스트 (integration test)
협력자들의 실제 또는 시뮬레이션 버전을 함께 띄워 검증하는 테스트다. 더 현실에 가까워 신뢰가 높지만 설계와 준비가 더 들고 느리다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[단위-테스트]], [[Testcontainers]]

## 스텁 (stub)
특정 호출에 대해 미리 정해 둔 값을 돌려주도록 설정한 가짜다. `when(...).thenReturn(...)`이 이것을 만든다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[상태-검증]], [[Mockito]]

## 상태-검증 (state verification)
호출 뒤의 **반환값이나 상태**를 단언해 옳음을 확인하는 방식이다. 스텁으로 입력을 고정하고 결과를 본다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[행위-검증]], [[스텁]]

## 행위-검증 (behavior verification)
반환값 대신 **어떤 메서드가 어떤 인자로 불렸는지**를 확인하는 방식이다. `verify(mock).method(args)`가 이것을 한다. 반환값이 없거나 부수 효과가 본질인 연산에 맞다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[상태-검증]], [[모킹]]

## BDD (behavior-driven development)
"주어진 상황(given)에서 어떤 행동(when)을 하면 이런 결과(then)를 기대한다"는 형식으로 요구사항과 테스트를 함께 표현하는 방식이다. 개발자가 아닌 사람도 읽을 수 있게 하는 것이 목적이다.
- 처음 나온 곳: [[04-testing-services-with-mocks]]
- 섞이는 말: [[테스트-케이스]], BDDMockito

## 인메모리-데이터베이스 (in-memory database)
**애플리케이션과 같은 메모리 공간에서** 도는 데이터베이스다. 별도 서버 프로세스가 없어 기동이 빠르지만, 프로세스가 끝나면 데이터도 사라진다.
- 처음 나온 곳: [[05-testing-repositories-with-embedded-databases]]
- 섞이는 말: [[HSQLDB]], [[Testcontainers]]

## HSQLDB (HyperSQL Database)
Java로 작성된 관계형 데이터베이스로, 인메모리 모드로 띄울 수 있어 테스트에 자주 쓴다. H2·Apache Derby와 같은 부류다.
- 처음 나온 곳: [[05-testing-repositories-with-embedded-databases]]
- 섞이는 말: [[인메모리-데이터베이스]], PostgreSQL

## SQL-방언 (SQL dialect)
같은 표준 SQL이라도 제품마다 다른 문법·함수·타입·인덱싱·대소문자 처리·트랜잭션 동작의 차이다. 표준에 빈틈이 있고 제품마다 그 빈틈을 다르게 메우기 때문에 생긴다.
- 처음 나온 곳: [[05-testing-repositories-with-embedded-databases]]
- 섞이는 말: [[인메모리-데이터베이스]], JPQL

## 필드-주입 (field injection)
필드에 직접 애노테이션을 붙여 의존성을 받는 방식이다. 운영 코드에서는 권장되지 않지만, 생명주기를 JUnit이 관리하는 **테스트 클래스에서는 허용 가능한 예외**로 본다.
- 처음 나온 곳: [[05-testing-repositories-with-embedded-databases]]
- 섞이는 말: [[생성자-주입]], `@Autowired`

## 생성자-주입 (constructor injection)
필요한 협력자를 생성자 매개변수로 받는 방식이다. 객체가 만들어지는 순간 필요한 것이 모두 채워져 있음이 보장된다.
- 처음 나온 곳: [[05-testing-repositories-with-embedded-databases]]
- 섞이는 말: [[필드-주입]], [[협력자]]

## Testcontainers (Testcontainers)
테스트 실행 중 도커 컨테이너로 실제 데이터베이스·브로커를 띄우고, 테스트가 끝나면 내려 주는 라이브러리다. 기동·종료를 사람이 하지 않는다는 점이 수동 로컬 설치와 다르다.
- 처음 나온 곳: [[06-adding-testcontainers]]
- 섞이는 말: [[컨테이너]], [[인메모리-데이터베이스]]

## 컨테이너 (container)
애플리케이션과 그 실행 환경을 함께 묶어 어디서나 같게 실행되도록 만든 격리 단위다. Docker 이미지가 그 정의이고 컨테이너는 그것을 띄운 실행 인스턴스다.
- 처음 나온 곳: [[06-adding-testcontainers]]
- 섞이는 말: [[Testcontainers]], 가상 머신

## BOM (Bill of Materials)
서로 맞물려 동작하는 여러 아티팩트의 검증된 버전 조합을 모아 둔 Maven 아티팩트다. 이것을 import하면 개별 의존성에 버전을 쓰지 않아도 된다.
- 처음 나온 곳: [[06-adding-testcontainers]]
- 섞이는 말: [[의존성-scope]], `dependencyManagement`

## 의존성-scope (dependency scope)
어떤 의존성이 컴파일·테스트·실행 중 어느 단계에 필요한지 표시하는 Maven 값이다. `runtime`은 컴파일 경로에서 빠지고, `test`는 테스트 코드에서만 보인다.
- 처음 나온 곳: [[06-adding-testcontainers]]
- 섞이는 말: [[BOM]], 전이 의존성

## 스모크-테스트 (smoke test)
기능을 깊이 검증하기보다 **전체가 일단 켜지고 돌아가는지**를 확인하는 테스트다. 이름은 전자 기기에 전원을 넣고 연기가 나는지 보던 관행에서 왔다.
- 처음 나온 곳: [[07-testing-repositories-with-testcontainers]]
- 섞이는 말: [[통합-테스트]], [[단언]]

## 서비스-연결 (@ServiceConnection)
Testcontainers가 띄운 컨테이너의 접속 정보(호스트·포트·계정)를 Spring 애플리케이션 컨텍스트의 연결 설정에 자동으로 이어 주는 Spring Boot 4 애노테이션이다. 덕분에 `spring.datasource.*`를 손으로 쓰지 않아도 된다.
- 처음 나온 곳: [[07-testing-repositories-with-testcontainers]]
- 섞이는 말: [[Testcontainers]], `@DynamicPropertySource`

## DDL-자동화 (ddl-auto)
JPA 구현이 엔티티 매핑을 보고 표 생성·삭제 문장을 자동으로 실행할지 정하는 설정이다. `create-drop`은 컨텍스트 시작 시 만들고 종료 시 지운다.
- 처음 나온 곳: [[07-testing-repositories-with-testcontainers]]
- 섞이는 말: 스키마 마이그레이션, [[Testcontainers]]

## 인증 (authentication)
**당신이 누구인지** 증명하는 일이다. 로그인이 대표적이며, 실패하면 HTTP 401 Unauthorized가 나간다.
- 처음 나온 곳: [[08-testing-security-policies]]
- 섞이는 말: [[인가]], `@WithMockUser`

## 인가 (authorization)
**당신이 무엇을 해도 되는지** 판단하는 일이다. 인증은 됐지만 권한이 없으면 HTTP 403 Forbidden이 나간다. 401의 이름이 "Unauthorized"라 용어가 어긋나 보이는 것이 흔한 혼동의 원인이다.
- 처음 나온 곳: [[08-testing-security-policies]]
- 섞이는 말: [[인증]], [[역할]]

## 역할 (role)
사용자에게 부여되는 권한 묶음의 이름이다. Spring Security에서는 관례상 `ROLE_` 접두어가 붙으며, 정책이 역할별로 갈리면 **역할마다 테스트가 하나씩** 필요해진다.
- 처음 나온 곳: [[08-testing-security-policies]]
- 섞이는 말: [[인가]], authority

## 부정-경로-테스트 (negative path test)
"되면 안 되는 것이 실제로 안 되는가"를 검증하는 테스트다. 보안에서는 긍정 경로만 검증하면 정책이 사실상 열려 있어도 통과하므로, 이쪽이 더 중요할 때가 많다.
- 처음 나온 곳: [[08-testing-security-policies]]
- 섞이는 말: [[인가]], 긍정 경로

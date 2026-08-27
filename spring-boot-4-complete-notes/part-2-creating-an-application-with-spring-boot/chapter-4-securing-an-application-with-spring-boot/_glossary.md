# Securing An Application with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## spring-security
인증(Authentication)과 인가(Authorization)를 포함한 보안 기능을 스프링 애플리케이션에 제공하는 강력하고 유연한 프레임워크
- 처음 나온 곳: [[01-adding-spring-security-to-our-project]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## user-details-service
스프링 시큐리티에서 사용자의 이름, 비밀번호, 권한 등의 정보를 가져오기 위해 정의된 핵심 인터페이스
- 처음 나온 곳: [[01-adding-spring-security-to-our-project]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## in-memory-user-details-manager
UserDetailsService의 구현체 중 하나로, 데이터베이스 없이 메모리 상에 사용자 정보를 하드코딩하여 보관하는 매니저 클래스
- 처음 나온 곳: [[01-adding-spring-security-to-our-project]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## user-account-entity
시큐리티 시스템에서 사용자의 계정 정보(이름, 패스워드, 권한)를 실제 데이터베이스 테이블에 저장하기 위해 매핑된 JPA 클래스
- 처음 나온 곳: [[02-swapping-hardcoded-users-with-a-spring-data-backed-set-of-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## command-line-runner
스프링 부트 애플리케이션이 구동될 때 특정 코드를 자동으로 실행하게 해주는 단일 추상 메서드(SAM) 인터페이스로, 람다식으로 쉽게 구현 가능함
- 처음 나온 곳: [[02-swapping-hardcoded-users-with-a-spring-data-backed-set-of-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## user-details
스프링 시큐리티가 요구하는 사용자 정보의 표준 규격(인터페이스)으로, 애플리케이션의 고유 엔티티 객체를 이 규격으로 변환해야 시큐리티가 이해할 수 있음
- 처음 나온 곳: [[02-swapping-hardcoded-users-with-a-spring-data-backed-set-of-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## authentication
사용자가 자신이 누구인지(아이디/비밀번호 등)를 시스템에 증명하는 과정 (인증)
- 처음 나온 곳: [[03-securing-web-routes-and-http-verbs]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## authorization
인증된 사용자가 특정 자원이나 기능에 접근할 수 있는 권한이 있는지를 검사하고 통제하는 과정 (인가)
- 처음 나온 곳: [[03-securing-web-routes-and-http-verbs]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## security-filter-chain
스프링 시큐리티 아키텍처의 핵심으로, 서블릿 컨테이너로 들어온 요청이 컨트롤러에 도달하기 전 인증 및 인가 검사를 수행하는 필터들의 묶음
- 처음 나온 곳: [[03-securing-web-routes-and-http-verbs]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## authorize-http-requests
최신 스프링 시큐리티에서 제공하는 람다 기반의 DSL로, HTTP 요청의 경로와 메서드에 따라 세밀한 인가(Authorization) 규칙을 설정하는 설정 메서드
- 처음 나온 곳: [[03-securing-web-routes-and-http-verbs]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## csrf
사용자가 자신의 의지와는 무관하게 공격자가 의도한 행위(수정, 삭제 등)를 서버에 요청하게 만드는 웹 해킹 기법
- 처음 나온 곳: [[04-to-csrf-or-not-to-csrf]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## nonce
Number Used Once의 약자로, CSRF 방어를 위해 서버가 폼을 렌더링할 때마다 발급하는 예측 불가능한 일회용 난수 토큰
- 처음 나온 곳: [[04-to-csrf-or-not-to-csrf]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## stateless-api
브라우저 세션이나 쿠키에 의존하여 상태를 저장하지 않고, 토큰(예: JWT) 등을 주고받으며 통신하는 서버 환경
- 처음 나온 곳: [[04-to-csrf-or-not-to-csrf]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## method-level-security
URL 기반 보안의 한계를 넘어, 특정 서비스나 리포지토리의 자바 메서드가 호출될 때 인자값을 검사하거나 반환값을 필터링하는 세밀한 보안 기법
- 처음 나온 곳: [[05-securing-spring-data-methods]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## pre-authorize
메서드가 실제 실행되기 직전에 SpEL(Spring Expression Language)을 평가하여, 결과가 참일 때만 실행을 허용하는 애노테이션
- 처음 나온 곳: [[05-securing-spring-data-methods]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## principal
시스템을 사용하기 위해 인증을 거친 사용자, 디바이스, 또는 시스템 자체를 뜻하는 자바 보안 표준 용어
- 처음 나온 곳: [[05-securing-spring-data-methods]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## model-attribute
스프링 MVC 컨트롤러가 처리한 데이터를 뷰(템플릿 엔진)가 꺼내어 쓸 수 있도록 연결해 주는 저장 바구니(모델)의 항목
- 처음 나온 곳: [[06-displaying-user-details-on-the-site]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## logout
사용자의 현재 세션을 파기하고 인증 정보를 삭제하는 행위로, 보안상 GET이 아닌 POST로 요청하는 것이 표준
- 처음 나온 곳: [[06-displaying-user-details-on-the-site]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## oauth
사용자가 자신의 비밀번호를 제3자 앱에 노출하지 않고도, 특정 리소스에 대한 접근 권한을 제한적으로 위임할 수 있게 하는 인가 프레임워크
- 처음 나온 곳: [[07-understanding-oauth-2-1]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## oidc
OAuth 위에 구축된 얇은 신원 확인 레이어로, 액세스 토큰 외에 ID 토큰을 추가로 발급하여 애플리케이션이 사용자가 누구인지 알 수 있게 해주는 프로토콜
- 처음 나온 곳: [[07-understanding-oauth-2-1]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## pkce
Proof Key for Code Exchange의 약자로, 인가 코드를 가로챈 악의적인 앱이 토큰을 탈취하지 못하도록 암호학적 난수 증명을 추가한 최신 필수 보안 매커니즘
- 처음 나온 곳: [[07-understanding-oauth-2-1]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## client-registration
OAuth 통신을 위해 사용할 외부 제공자(Google, Github 등)의 클라이언트 ID, 시크릿, 스코프 등의 정보를 애플리케이션에 등록하는 설정 객체
- 처음 나온 곳: [[08-leveraging-google-to-authenticate-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## oauth2-authorized-client
성공적으로 OAuth 인증을 마치고 발급받은 '액세스 토큰'과 해당 사용자의 정보, 클라이언트 정보를 모두 묶어서 관리하는 스프링의 컨테이너 객체
- 처음 나온 곳: [[08-leveraging-google-to-authenticate-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## rest-client
스프링 프레임워크 최신 버전에서 도입된, 유창한(Fluent) 빌더 패턴 기반의 모던 동기 HTTP 클라이언트로 RestTemplate을 대체하는 객체
- 처음 나온 곳: [[08-leveraging-google-to-authenticate-users]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## data-in-transit
네트워크를 통해 한 시스템에서 다른 시스템으로 이동 중인 데이터로, 스니핑(가로채기)을 막기 위해 반드시 TLS 등으로 암호화해야 한다
- 처음 나온 곳: [[09-securing-data-in-transit-and-ssl-bundles]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## ssl-bundle
스프링 부트 3.1에서 도입된 기능으로, 인증서(키스토어, 트러스트스토어) 설정을 논리적 묶음(번들)으로 정의하여 여러 프레임워크 컴포넌트에 걸쳐 재사용할 수 있게 하는 설정 메커니즘
- 처음 나온 곳: [[09-securing-data-in-transit-and-ssl-bundles]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## keystore
자바 환경에서 서버의 개인 키(Private Key)와 디지털 인증서를 안전하게 보관하는 암호화된 파일(주로 PKCS#12 형식 사용)
- 처음 나온 곳: [[09-securing-data-in-transit-and-ssl-bundles]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## data-at-rest
데이터베이스, 파일 시스템, 백업 스토리지 등에 물리적으로 저장되어 머물러 있는 데이터. 유출 시 치명적이므로 반드시 암호화하여 저장해야 한다
- 처음 나온 곳: [[10-securing-data-at-rest]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## password-encoder
비밀번호를 단방향(해독 불가능)으로 안전하게 변환하고, 입력받은 값과 비교하는 기능을 제공하는 스프링 시큐리티의 핵심 인터페이스
- 처음 나온 곳: [[10-securing-data-at-rest]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## bcrypt
비밀번호 저장 목적으로 특별히 설계된 해시 알고리즘. 임의의 난수(Salt)를 더하고 연산 속도를 의도적으로 늦춰서 해커의 무차별 대입 공격(Brute-force)을 지연시킨다
- 처음 나온 곳: [[10-securing-data-at-rest]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

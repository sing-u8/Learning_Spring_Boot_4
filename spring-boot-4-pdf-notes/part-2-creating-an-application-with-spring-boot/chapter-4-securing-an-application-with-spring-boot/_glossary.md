# Chapter 4 용어집

> *Learning Spring Boot 4*, Ch. 4 *Securing an Application with Spring Boot* (책 pp. 97–151 / PDF pp. 122–176)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 인증 (authentication)

"이 요청을 보낸 사람이 누구인가"를 확인하는 절차. 아이디·비밀번호, 토큰, 외부 제공자의 응답 같은 **자격 증명**을 검사해 신원을 확정한다. 실패하면 신원을 아직 모르는 상태이므로 서버는 401을 주거나 로그인 화면으로 보낸다.

## 인가 (authorization)

신원이 확정된 사용자가 "이 일을 해도 되는가"를 판정하는 절차. [[인증]]이 끝난 뒤에 일어나며, 실패하면 "누구인지는 알지만 권한이 없다"는 뜻이므로 403을 준다.

## 필터-체인 (filter chain)

서블릿 컨테이너가 요청을 컨트롤러에 넘기기 전에 통과시키는 필터들의 줄. Spring Security는 이 줄 중간에 자기 필터들을 끼워 넣어, 컨트롤러 코드가 실행되기 **전에** 인증·인가·CSRF 검사를 끝낸다.

## SecurityFilterChain (SecurityFilterChain)

Spring Security의 보안 정책 한 벌을 담는 빈 타입. 어떤 경로에 어떤 규칙을 적용하고 어떤 로그인 방식을 켤지가 모두 이 객체 안에 들어간다. 이 타입의 빈을 직접 정의하면 Spring Boot의 기본 보안 자동 설정이 물러선다.

## HttpSecurity (HttpSecurity)

`SecurityFilterChain`을 조립하기 위한 빌더. `authorizeHttpRequests`, `formLogin`, `csrf` 같은 메서드를 이어 붙여 규칙을 쌓은 뒤 `build()`로 실제 체인을 만든다.

## 자동-설정-백오프 (auto-configuration back-off)

같은 역할의 빈을 개발자가 직접 정의하면 Spring Boot의 자동 설정이 자기 빈 등록을 포기하고 물러서는 동작. `@ConditionalOnMissingBean` 조건으로 구현된다.

## 폼-로그인 (form login)

HTML `<form>`으로 아이디·비밀번호를 POST해 인증하는 방식. 화면을 마음대로 꾸밀 수 있고 로그아웃 개념이 있다.

## HTTP-Basic (HTTP Basic authentication)

`Authorization: Basic <base64(id:pw)>` 헤더로 인증하는 HTTP 표준 방식. 브라우저가 자체 팝업을 띄우며 꾸밀 수 없고, 자격 증명을 버리려면 브라우저를 닫아야 한다. 대신 `curl` 같은 명령줄 도구에서 쓰기 쉽다.

## 401-Unauthorized (401 Unauthorized)

"신원이 확인되지 않았다"는 HTTP 상태 코드. 이름과 달리 인가가 아니라 [[인증]] 실패를 뜻한다.

## 403-Forbidden (403 Forbidden)

"신원은 알지만 이 일은 허용되지 않는다"는 HTTP 상태 코드. [[인가]] 실패의 신호다.

## 스타터 (starter)

관련 라이브러리와 자동 설정을 묶어 두어 의존성 한 줄로 기능 한 벌을 켜 주는 Spring Boot의 의존성 묶음. Spring Boot 4에서는 큰 스타터 하나 대신 기능별로 쪼갠 집중형 스타터를 쓴다.

## UserDetailsService (UserDetailsService)

"사용자 이름을 받아 그 사용자의 정보를 돌려주는" 단 하나의 메서드 `loadUserByUsername(String)`을 가진 인터페이스. 사용자를 어디에 보관하든(메모리·DB·LDAP) 이 인터페이스만 구현하면 Spring Security가 쓸 수 있다.

## UserDetails (UserDetails)

Spring Security가 이해하는 사용자 정보의 표준 모양. 사용자 이름, 비밀번호, 권한 목록, 그리고 잠김·만료·활성 여부를 담는다.

## InMemoryUserDetailsManager (InMemoryUserDetailsManager)

사용자를 메모리 맵에 담아 두는 `UserDetailsService` 구현. 데모와 테스트에 쓰고, 앱을 재시작하면 내용이 사라진다.

## 역할 (role)

`ADMIN`, `USER`처럼 사용자를 묶어 부르는 이름표. Spring Security 내부에서는 `ROLE_` 접두사를 붙인 [[authority]]로 저장된다.

## authority (authority)

"무언가에 접근할 수 있다"는 권한 하나를 나타내는 문자열. Spring Security의 권한 모델에서 가장 작은 단위이며, [[역할]]은 그중 `ROLE_`로 시작하는 관례적 부분집합이다.

## ROLE-접두사 (ROLE_ prefix)

역할을 authority로 표현할 때 붙이는 관례적 접두사. `hasRole("ADMIN")`은 내부적으로 authority `ROLE_ADMIN`을 찾는다. 그래서 데이터에 저장할 때는 `ROLE_ADMIN`, 규칙에 쓸 때는 `ADMIN`이라고 적는 비대칭이 생긴다.

## 비밀번호-인코더 (PasswordEncoder)

평문 비밀번호를 저장·비교 가능한 형태로 바꾸는 전략 인터페이스. `encode`로 저장값을 만들고 `matches`로 제출값과 저장값을 비교한다.

## EnableWebSecurity (@EnableWebSecurity)

웹 보안에 필요한 필터와 인프라 빈을 한꺼번에 켜는 Spring Security 애노테이션. Spring Boot는 Spring Security가 classpath에 있으면 이 설정을 자동으로 활성화한다.

## 컴포넌트-스캔 (component scanning)

지정한 패키지 아래를 훑어 `@Component`·`@Configuration` 같은 표시가 붙은 클래스를 찾아 빈으로 등록하는 Spring의 동작.

## ElementCollection (@ElementCollection)

엔티티가 소유한 **값들의 모음**을 별도 테이블에 저장하도록 지시하는 JPA 애노테이션. 대상은 기본 타입이거나 `@Embeddable`이어야 하며, 다른 엔티티를 가리키는 연관관계와는 다르다.

## CommandLineRunner (CommandLineRunner)

애플리케이션 컨텍스트가 다 뜬 직후 한 번 실행되는 콜백 인터페이스. 초기 데이터 적재나 기동 시 점검에 쓴다.

## SAM (single abstract method)

추상 메서드가 딱 하나뿐인 인터페이스. 자바가 람다식을 그 인터페이스의 구현체로 변환해 주기 때문에 익명 클래스 없이 한 줄로 구현할 수 있다.

## Repository-마커-인터페이스 (Repository)

Spring Data의 최상위 마커 인터페이스. 메서드가 하나도 없어서, 이걸 확장하면 **직접 선언한 메서드만** 노출되는 리포지토리가 만들어진다.

## 파생-질의 (derived query)

메서드 이름을 규칙에 따라 해석해 질의를 자동 생성하는 Spring Data 기능. `findByUsername`은 "`username` 필드가 인자와 같은 행을 찾아라"로 번역된다.

## authorizeHttpRequests (authorizeHttpRequests)

경로·HTTP 메서드별 접근 규칙을 선언하는 `HttpSecurity`의 진입점. 규칙은 **선언 순서대로** 검사되고 처음 일치한 규칙에서 판정이 끝난다.

## requestMatcher (RequestMatcher)

"이 요청이 이 규칙에 해당하는가"를 판정하는 조건. 경로 패턴만 쓸 수도 있고 `HttpMethod`와 결합해 "GET일 때만"처럼 좁힐 수도 있다.

## AuthorizationManager (AuthorizationManager)

인가 판정 하나를 담당하는 함수형 타입. `AuthorizationManagers.allOf`/`anyOf`/`not`으로 조합해 내장 규칙에 없는 조건을 만들 수 있다.

## 람다-DSL (lambda DSL)

`http.csrf(csrf -> csrf.disable())`처럼 설정 블록을 람다로 받아 구성하는 Spring Security의 현대적 설정 문법. 예전의 `and()` 연쇄 방식을 대체한다.

## CSRF (Cross-Site Request Forgery)

이미 로그인한 사용자의 브라우저가 자동으로 쿠키를 실어 보낸다는 점을 악용해, 공격자의 페이지가 사용자 대신 상태 변경 요청을 보내게 만드는 공격.

## nonce (nonce)

"한 번만 쓰는 수"라는 뜻으로, 서버가 만든 준랜덤 값. 요청이 정말 우리 서버가 내려준 화면에서 출발했는지 확인하는 데 쓴다.

## CSRF-토큰 (CSRF token)

서버가 발급한 [[nonce]]를 폼의 hidden input이나 헤더에 실어 보내는 값. 서버는 이 값이 없거나 틀린 상태 변경 요청을 거부한다.

## 상태-변경-요청 (state-changing request)

서버의 데이터를 바꾸는 요청. POST·PUT·PATCH·DELETE가 여기 해당하며, CSRF 방어는 이 요청들에만 적용된다.

## 무상태 (stateless)

서버가 요청 사이에 세션 같은 대화 상태를 보관하지 않는 방식. 매 요청이 필요한 정보를 스스로 들고 오므로 브라우저 쿠키에 기대는 CSRF 공격이 성립하지 않는다.

## 메서드-레벨-보안 (method-level security)

URL이 아니라 **자바 메서드 호출**을 단위로 인가를 거는 방식. 호출 인자와 반환값을 볼 수 있어서 "이 객체의 소유자인가" 같은 판정이 가능하다.

## AOP-프록시 (AOP proxy)

원본 빈을 감싸 호출 전후에 부가 동작을 끼워 넣는 대리 객체. 메서드 보안은 이 프록시가 실제 메서드 대신 먼저 호출돼 권한을 검사하는 방식으로 동작한다.

## 소유권 (ownership)

데이터 한 건이 어떤 사용자에게 속하는지를 나타내는 관계. 보통 엔티티에 소유자 식별자 필드를 두어 표현한다.

## Authentication (Authentication)

현재 요청의 인증 결과를 담은 Spring Security 객체. 사용자 이름(`getName()`), 권한 목록, 자격 증명, 인증 여부를 들고 있다.

## Principal (java.security.Principal)

"이름을 가진 인증된 주체"를 뜻하는 자바 표준 인터페이스. Spring Security의 `Authentication`이 이 인터페이스를 확장하기 때문에 `getName()`을 쓸 수 있다.

## 보안-컨텍스트 (SecurityContext)

현재 스레드(요청)에 묶인 `Authentication`을 보관하는 자리. 컨트롤러 파라미터 주입이나 `authentication.name` 같은 표현식이 여기서 값을 꺼내 온다.

## PathVariable (@PathVariable)

URL 경로의 일부를 메서드 인자로 꺼내 주는 Spring MVC 애노테이션. `/delete/videos/{videoId}`의 `{videoId}`가 이름이 같은 인자에 대응된다.

## 소프트-리다이렉트 (302 Found)

"이 주소로 다시 요청하라"고 브라우저에 알리는 HTTP 상태 코드. Spring MVC의 `"redirect:/"` 반환값이 이 응답을 만든다.

## PreAuthorize (@PreAuthorize)

메서드를 **실행하기 전에** 표현식을 평가해 통과 여부를 정하는 Spring Security 애노테이션. 표현식 안에서 호출 인자와 현재 인증 정보를 함께 볼 수 있다.

## SpEL (Spring Expression Language)

Spring이 문자열 안에서 객체 그래프를 읽고 계산할 때 쓰는 식 언어. `@PreAuthorize`의 `#entity.username == authentication.name`이 이 언어로 쓰인 식이다.

## EnableMethodSecurity (@EnableMethodSecurity)

`@PreAuthorize`·`@PostAuthorize` 같은 메서드 보안 애노테이션을 실제로 동작시키는 스위치. 이게 없으면 애노테이션은 붙어만 있고 아무 일도 하지 않는다.

## 모델-속성 (model attribute)

컨트롤러가 템플릿에 넘기는 이름 붙은 값. `model.addAttribute("authentication", authentication)`으로 넣으면 템플릿에서 `{{authentication.name}}`으로 꺼낸다.

## FactorGrantedAuthority (FactorGrantedAuthority)

"어떤 방식으로 인증을 통과했는가"를 나타내는 Spring Security 7의 authority. 비밀번호로 로그인하면 `FACTOR_PASSWORD`가 권한 목록에 함께 들어가며, 다중 인증 요구를 표현하는 데 쓴다.

## OAuth (OAuth)

사용자의 비밀번호를 넘기지 않고도 다른 서비스에 있는 사용자 자원에 접근할 권한을 위임받기 위한 표준 인가 프레임워크.

## 위임-인가 (delegated authorization)

자원 소유자(사용자)가 자기 자격 증명을 넘기는 대신, 제3의 애플리케이션에 **제한된 권한만** 넘기는 모델. OAuth가 푸는 핵심 문제다.

## 스코프 (scope)

발급되는 토큰이 무엇까지 할 수 있는지 나타내는 권한 목록. `youtube.readonly`처럼 "읽기만"으로 좁힐 수 있다.

## 액세스-토큰 (access token)

인가 서버가 발급하는, 자원 접근에 쓰는 단기 자격 증명. 비밀번호를 대신하되 [[스코프]]와 유효 기간으로 힘이 제한된다.

## 리프레시-토큰 (refresh token)

액세스 토큰이 만료됐을 때 사용자를 다시 로그인시키지 않고 새 액세스 토큰을 받아 오는 데 쓰는 장기 자격 증명.

## 인가-서버 (authorization server)

사용자를 인증하고 동의를 받아 토큰을 발급하는 쪽. Google 로그인에서는 Google이 이 역할을 한다.

## OIDC (OpenID Connect)

OAuth 2.0 위에 **신원 확인**을 얹은 규격. [[ID-토큰]]을 추가해 "이 사용자가 누구인가"에 형식을 갖춘 답을 준다.

## ID-토큰 (ID Token)

OIDC가 발급하는, 사용자 신원 정보가 담기고 서명이 붙은 토큰. 접근 권한을 나타내는 액세스 토큰과 목적이 다르다.

## 인가-코드-플로우 (Authorization Code Flow)

사용자를 인가 서버로 보내 인증시키고, 짧은 수명의 **코드**를 받아 온 뒤, 서버 대 서버 통신으로 그 코드를 토큰과 바꾸는 흐름. 토큰이 브라우저에 노출되지 않는 것이 핵심 성질이다.

## PKCE (Proof Key for Code Exchange)

인가 코드를 가로채도 토큰으로 바꾸지 못하게 막는 확장. 클라이언트가 만든 비밀값의 해시를 미리 보내 두고, 코드를 교환할 때 원본 비밀값을 제시해 같은 요청임을 증명한다.

## 코드-검증자 (code verifier)

PKCE에서 클라이언트가 매 요청 새로 만드는 랜덤 비밀값. 토큰 교환 단계에서 원본 그대로 제출한다.

## 코드-챌린지 (code challenge)

[[코드-검증자]]를 해시한 값. 인가 요청 단계에서 미리 보내 두며, 가로채도 원본을 되돌릴 수 없다.

## 클라이언트-자격-증명-플로우 (Client Credentials Flow)

사용자가 개입하지 않고 서비스가 자기 자격 증명으로 직접 토큰을 받는 흐름. 배치 작업이나 서비스 간 호출에 쓴다.

## 임플리싯-플로우 (Implicit Flow)

액세스 토큰을 브라우저 리다이렉트로 곧장 돌려주던 옛 흐름. 토큰이 주소창·히스토리·중간 경로에 노출돼 OAuth 2.1에서 제거됐다.

## 신원-제공자 (identity provider)

사용자 계정과 인증을 대신 책임지는 외부 서비스. Google, GitHub, Okta 같은 곳이 해당한다.

## Spring-Authorization-Server (Spring Authorization Server)

직접 운영하는 인가 서버를 만들 수 있게 해 주는 Spring 프로젝트. 개발·테스트 환경에서 외부 네트워크 의존 없이 사용자·스코프·토큰 정책을 통제하고 싶을 때 쓴다.

## 클라이언트-ID (Client ID)

인가 서버가 등록된 애플리케이션에 부여하는 공개 식별자. 비밀이 아니며 인가 요청 URL에 그대로 실린다.

## 클라이언트-시크릿 (Client secret)

애플리케이션이 자신을 증명할 때 쓰는 비밀 값. 서버 쪽에만 두어야 하며 유출되면 앱을 사칭할 수 있다.

## 리다이렉트-URI (redirect URI)

인가 서버가 인증을 마친 뒤 사용자를 되돌려 보낼 주소. 미리 등록한 값과 정확히 일치해야만 인가 서버가 응답을 보낸다.

## 동의-화면 (consent screen)

"이 앱에 이런 권한을 주겠습니까"를 사용자에게 묻는 인가 서버의 화면. 요청한 [[스코프]]가 여기에 그대로 나열된다.

## ClientRegistrationRepository (ClientRegistrationRepository)

설정에 적어 둔 OAuth 제공자별 등록 정보(클라이언트 ID·시크릿·엔드포인트)를 담아 두는 저장소 빈. 여러 제공자를 동시에 지원하기 위한 조회 창구다.

## OAuth2AuthorizedClient (OAuth2AuthorizedClient)

"어떤 사용자가 어떤 제공자에서 어떤 토큰을 받아 둔 상태"를 묶어 표현하는 객체. 발급받은 토큰을 다시 쓰려면 이 형태로 보관해야 한다.

## OAuth2AuthorizedClientManager (OAuth2AuthorizedClientManager)

필요할 때 토큰을 새로 받거나 갱신해 [[OAuth2AuthorizedClient]]를 마련해 주는 관리자 빈. 어떤 흐름을 지원할지는 provider 조합으로 정한다.

## CommonOAuth2Provider (CommonOAuth2Provider)

Google·GitHub·Facebook·Okta의 엔드포인트와 기본 스코프를 미리 담아 둔 Spring Security의 열거형. 등록 이름을 이 목록과 맞추면 클라이언트 ID·시크릿만 적어도 동작한다.

## 완화된-바인딩 (relaxed binding)

`client-id`, `clientId`, `CLIENT_ID`처럼 표기가 달라도 같은 설정 키로 묶어 주는 Spring Boot의 프로퍼티 바인딩 규칙.

## RestClient (RestClient)

Spring Framework 6.1이 들여온 동기 HTTP 클라이언트. `RestTemplate`을 대체하는 유연한 API를 제공하며 인터셉터·HTTP 서비스 프록시와 자연스럽게 붙는다.

## 요청-인터셉터 (ClientHttpRequestInterceptor)

HTTP 클라이언트가 요청을 보내기 직전에 끼어들어 헤더를 붙이거나 요청을 가로채는 훅. 서블릿 필터가 들어오는 요청에 하는 일을 나가는 요청에 한다.

## GetExchange (@GetExchange)

인터페이스 메서드를 원격 HTTP GET 호출로 바꿔 주는 Spring Framework 애노테이션. 요청을 **받는** 쪽의 `@GetMapping`과 짝을 이루는 **보내는** 쪽 표기다.

## HTTP-서비스-프록시 (HTTP service proxy)

`@GetExchange` 같은 표기가 붙은 인터페이스를 Spring이 런타임 구현체로 만들어 주는 기능. 요청 조립과 응답 변환이 감춰져 호출부는 평범한 메서드 호출처럼 보인다.

## record (record)

필드·생성자·접근자·`equals`/`hashCode`/`toString`을 자동으로 만들어 주는 자바의 불변 데이터 타입. JSON 응답을 옮겨 담기에 잘 맞는다.

## 마샬링 (marshalling)

객체와 전송 형식(JSON 등) 사이를 변환하는 일. 나갈 때는 직렬화, 들어올 때는 역직렬화가 된다.

## Mustache (Mustache)

`{{ }}` 표기만으로 값을 끼워 넣는 템플릿 엔진. 로직을 거의 담지 못하는 대신 가볍고 규칙이 단순하다.

## 로직리스-템플릿 (logic-less template)

조건문·반복문 같은 프로그램 로직을 템플릿 안에 두지 않는다는 설계 원칙. 판단이 필요하면 템플릿이 아니라 모델 객체 쪽에 메서드를 만들어 해결한다.

## 정적-자원 (static resources)

CSS·이미지처럼 서버가 가공 없이 그대로 내려 주는 파일. Spring Boot는 `src/main/resources/static` 아래를 자동으로 제공한다.

## 전송-중-데이터 (data in transit)

브라우저와 서버 사이, 또는 서비스와 서비스 사이를 **이동하는 중인** 데이터. 암호화하지 않으면 중간에서 엿보거나 바꿔치기할 수 있다.

## 저장-중-데이터 (data at rest)

데이터베이스·파일 시스템·백업처럼 **머물러 있는** 데이터. 저장소가 통째로 유출되는 상황을 전제로 보호해야 한다.

## TLS (Transport Layer Security)

전송 구간을 암호화하고 무결성을 지키며 서버 신원을 증명하는 프로토콜. HTTPS는 HTTP를 이 위에 얹은 것이다.

## HTTPS (HTTPS)

HTTP를 [[TLS]] 위에서 주고받는 방식. 주소가 `https://`로 시작하고 기본 포트가 443이다.

## 인증서 (certificate)

"이 공개 키가 이 도메인의 것"임을 발급자가 서명으로 보증하는 문서. 서버는 TLS 연결을 열 때 이것을 제시한다.

## 인증기관 (Certificate Authority)

인증서를 발급하고 그 내용을 보증하는 신뢰받는 제3자. 브라우저와 운영체제가 미리 신뢰 목록을 들고 있다.

## 자체-서명-인증서 (self-signed certificate)

[[인증기관]] 없이 스스로 서명해 만든 인증서. 암호화 자체는 되지만 신원을 보증할 제3자가 없어 브라우저가 경고를 띄운다.

## 키스토어 (keystore)

개인 키와 인증서를 함께 담아 두는 암호화된 파일. 서버는 여기서 키를 꺼내 TLS 연결을 맺는다.

## PKCS12 (PKCS#12)

키와 인증서를 하나로 묶는 표준 키스토어 형식. 확장자로는 보통 `.p12`를 쓴다.

## keytool (keytool)

JDK가 함께 배포하는 키·인증서 관리 명령줄 도구. 키 쌍 생성, 키스토어 만들기, 인증서 확인에 쓴다.

## 별칭 (alias)

키스토어 안의 항목 하나를 가리키는 이름표. 한 키스토어에 여러 키가 있을 수 있어서 어느 것을 쓸지 이 이름으로 지정한다.

## SSL-번들 (SSL bundle)

키스토어 위치·비밀번호·별칭 같은 TLS 재료를 이름 붙여 한 번만 정의해 두고, 웹 서버·HTTP 클라이언트·Kafka 등 여러 곳에서 그 이름으로 재사용하게 해 주는 Spring Boot 3.1의 기능.

## 트러스트스토어 (truststore)

"내가 신뢰하는 상대 인증서" 목록을 담는 저장소. 서버가 자기 신원을 증명할 때 쓰는 [[키스토어]]와 방향이 반대다.

## 해시 (hash)

임의 길이 입력을 고정 길이 값으로 바꾸는 계산. 같은 입력은 항상 같은 결과를 내지만, 결과에서 입력을 되돌릴 수는 없다.

## 단방향-함수 (one-way function)

계산은 쉬운데 역산은 현실적으로 불가능한 함수. 비밀번호를 복호화할 필요 없이 **비교만** 하면 되기 때문에 저장에 알맞다.

## 솔트 (salt)

해시 계산에 섞어 넣는, 사용자마다 다른 랜덤 값. 같은 비밀번호라도 저장값이 달라지므로 미리 계산해 둔 표로 한꺼번에 뚫는 공격이 통하지 않는다.

## BCrypt (BCrypt)

비밀번호 저장을 위해 설계된 적응형 해시 알고리즘. [[솔트]]를 자동으로 만들고 반복 횟수를 조절할 수 있어 하드웨어가 빨라져도 난이도를 올려 대응할 수 있다.

## 무차별-대입-공격 (brute-force attack)

가능한 값을 하나씩 대입해 비밀번호를 알아내려는 공격. 해시 한 번의 계산 비용을 일부러 높이면 이 공격의 비용도 같이 올라간다.

## 레인보우-테이블 (rainbow table)

흔한 비밀번호의 해시값을 미리 계산해 둔 표. [[솔트]]가 없으면 저장된 해시를 이 표에서 찾아 원문을 곧장 되찾을 수 있다.

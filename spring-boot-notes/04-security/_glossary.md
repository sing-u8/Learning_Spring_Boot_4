# 04-security 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 보안-필터체인 (security filter chain)
서블릿 컨테이너로 들어오는 모든 HTTP 요청을 가로채어 인증, 인가, CSRF 검증, 세션 방어 등을 순차적으로 수행하는 Spring Security의 핵심 필터 파이프라인 (`SecurityFilterChain`).
- 처음 나온 곳: [[01-spring-security-architecture-filterchain]]
- 섞이는 말: [[인증]], [[인가]]

## 인증 (authentication)
시스템에 접근하려는 사용자가 "정말로 주장하는 본인이 맞는지" 신원(아이디/비밀번호, 토큰 등)을 검증하는 프로세스 (Who you are).
- 처음 나온 곳: [[01-spring-security-architecture-filterchain]]
- 섞이는 말: [[인가]], [[유저-디테일즈-서비스]]

## 인가 (authorization)
신원이 확인된 사용자가 특정 URL이나 자원, 비즈니스 메서드에 접근할 수 있는 "적절한 권한(Role/Authority)을 가지고 있는지" 확인하는 권한 부여 프로세스 (What you can do).
- 처음 나온 곳: [[01-spring-security-architecture-filterchain]]
- 섞이는 말: [[인증]], [[메서드-수준-보안]]

## 유저-디테일즈-서비스 (user details service)
데이터베이스 등 사용자 저장소로부터 아이디(Username)를 기반으로 사용자 신원 정보와 패스워드, 권한 목록을 조회하여 Spring Security에 전달하는 표준 인터페이스 (`UserDetailsService`).
- 처음 나온 곳: [[02-authentication-user-details-service]]
- 섞이는 말: [[인증]], [[패스워드-인코더]]

## 패스워드-인코더 (password encoder)
사용자의 비밀번호를 평문으로 저장하지 않고 단방향 암호화 해시(BCrypt, Argon2 등) 및 솔트(Salt)를 적용하여 안전하게 저장하고 검증하는 인터페이스 (`PasswordEncoder`).
- 처음 나온 곳: [[02-authentication-user-details-service]]
- 섞이는 말: [[유저-디테일즈-서비스]]

## 메서드-수준-보안 (method level security)
URL 접근 제어에 그치지 않고 자바 메서드 실행 직전/직후에 `@PreAuthorize` 어노테이션을 통해 작성자 본인 여부 등 세밀한 데이터 소유권을 검증하는 보안 체계.
- 처음 나온 곳: [[03-authorization-and-method-security]]
- 섞이는 말: [[인가]]

## 크로스-사이트-요청-위조 (cross site request forgery)
사용자가 로그인된 세션을 악용하여 제3자 악성 사이트가 사용자의 브라우저를 통해 원치 않는 상태 변경 요청(POST/DELETE)을 서버로 몰래 전송하게 만드는 웹 취약점 공격 (CSRF).
- 처음 나온 곳: [[04-csrf-protection-and-session]]
- 섞이는 말: [[보안-필터체인]]

## 오픈오스 (oauth)
사용자의 비밀번호를 직접 공유하지 않고도 특정 서드파티 애플리케이션에 제한된 권한(Scope)을 위임하여 자원에 접근할 수 있게 해주는 인가 표준 프레임워크 (OAuth 2.1).
- 처음 나온 곳: [[05-oauth2-oidc-social-login]]
- 섞이는 말: [[오픈아이디-커넥트]], [[인증]]

## 오픈아이디-커넥트 (openid connect)
OAuth 2.0/2.1의 인가 프레임워크 위에 사용자 신원 인증 계층을 추가하여 ID 토큰(ID Token)을 발행하는 표준 사용자 인증 프로토콜 (OIDC).
- 처음 나온 곳: [[05-oauth2-oidc-social-login]]
- 섞이는 말: [[오픈오스]], [[인증]]

## 에스에스엘-번들 (ssl bundles)
스프링 부트 설정 파일에서 키스토어, 신뢰스토어, 인증서 체인을 묶음 단위로 명명하여 웹 서버와 HTTP 클라이언트에 유연하게 적용하는 차세대 TLS 인증서 관리 기능.
- 처음 나온 곳: [[06-ssl-bundles-and-data-protection]]
- 섞이는 말: [[보안-필터체인]]

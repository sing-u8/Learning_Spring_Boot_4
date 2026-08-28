# Chapter 4 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 4 *Securing an Application with Spring Boot*, 책 pp. 97–151 / PDF pp. 122–176. PDF를 `pdftotext -layout -f 122 -l 176`으로 새로 추출해 2,372줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

이 Chapter는 상위 절 9개에 **실제 하위 제목 14개**를 가진 이 책에서 가장 긴 장이다. 상위 절 하나에 독립 개념이 여러 개 들어 있으므로 **책에 인쇄된 하위 제목을 그대로 분할선으로 삼아** 23개 노트로 나눴다. 하위 제목을 새로 만들어 쪼갠 곳은 없다.

기존 초안 10개는 파일 이름이 실제 절 구조와 맞지 않아(예: `05-protecting-against-csrf`가 상위 절 *Securing web routes and HTTP verbs*의 하위 제목이었다) 전부 교체했다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-spring-security-filter-chain-foundations]] | Exploring the foundations of Spring Security | 98–101 | 123–126 |
| [[02-adding-spring-security-to-the-project]] | Adding Spring Security to our project | 101–102 | 126–127 |
| [[03-creating-users-with-userdetailsservice]] | Creating our own users with a custom security policy | 102–105 | 127–130 |
| [[04-spring-data-backed-users]] | Swapping hardcoded users with a Spring Data-backed set of users | 105–109 | 130–134 |
| [[05-securing-web-routes-and-http-verbs]] | Securing web routes and HTTP verbs | 109–113 | 134–138 |
| [[05a-to-csrf-or-not-to-csrf]] | └ To CSRF or not to CSRF, that is the question | 113–116 | 138–141 |
| [[06-securing-spring-data-methods]] | Securing Spring Data methods | 116–117 | 141–142 |
| [[06a-updating-our-model]] | └ Updating our model | 117–118 | 142–143 |
| [[06b-taking-ownership-of-data]] | └ Taking ownership of data | 118–119 | 143–144 |
| [[06c-adding-a-delete-button]] | └ Adding a delete button | 119–121 | 144–146 |
| [[06d-locking-down-access-to-the-owner]] | └ Locking down access to the owner of the data | 121–122 | 146–147 |
| [[06e-enabling-method-level-security]] | └ Enabling method-level security | 122 | 147 |
| [[06f-displaying-user-details-on-the-site]] | └ Displaying user details on the site | 122–127 | 147–152 |
| [[07-understanding-oauth-2-1]] | Understanding OAuth 2.1 | 127–128 | 152–153 |
| [[07a-oauth-vs-openid-connect]] | └ OAuth vs. OpenID Connect (OIDC) | 128–129 | 153–154 |
| [[08-leveraging-google-to-authenticate-users]] | Leveraging Google to authenticate users | 129–130 | 154–155 |
| [[08a-creating-a-google-oauth-application]] | └ Creating a Google OAuth 2.0 application | 130–132 | 155–157 |
| [[08b-adding-oauth-client-to-a-spring-boot-project]] | └ Adding OAuth Client to a Spring Boot project | 131–135 | 156–160 |
| [[08c-invoking-an-oauth-2-api-remotely]] | └ Invoking an OAuth 2 API remotely | 135–139 | 160–164 |
| [[08d-creating-an-oauth2-powered-web-app]] | └ Creating an OAuth2-powered web app | 139–146 | 164–171 |
| [[09-securing-data-in-transit]] | Securing data in transit and at rest + └ Securing data in transit | 146–148 | 171–173 |
| [[09a-introducing-ssl-bundles]] | └ Introducing SSL Bundles | 148–150 | 173–175 |
| [[09b-securing-data-at-rest]] | └ Securing data at rest | 150–151 | 175–176 |

상위 절 *Securing data in transit and at rest*의 도입부(146쪽)는 "전송 중 데이터"와 "저장 중 데이터"를 정의하는 두 문단뿐이라 독립 노트로 만들지 않고 [[09-securing-data-in-transit]]의 `## 1. 왜 이게 필요한가`에 넣었다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 97–98 | 122–123 | 장 도입: "보안되기 전엔 진짜 애플리케이션이 아니다", 직접 만들지 말라는 경고, Spring Security가 2003년부터 공개 개발돼 왔다는 배경, 다룰 8개 주제 | [[_map]] | 반영 |
| 98 | 123 | Note: 이 장의 소스는 저장소 `ch4` 폴더 | [[02-adding-spring-security-to-the-project]] | 반영 |
| 98–99 | 123–124 | `SecurityFilterChain`이 중심이라는 구조, 필터가 하는 4가지 일(인증 정보 추출·인증·인가·CSRF 방어) | [[01-spring-security-filter-chain-foundations]] | 반영 |
| 99 | 124 | 인증(누구인가) vs 인가(무엇을 해도 되는가)의 구분, classpath에 있으면 기본 `SecurityFilterChain` 자동 등록, 직접 정의하면 back off | [[01-spring-security-filter-chain-foundations]] | 반영 |
| 99–100 | 124–125 | Figure 4.1 요청 처리 흐름 다이어그램과 8단계 서술(401 vs 403 분기 포함) | [[01-spring-security-filter-chain-foundations]] | 반영 (Mermaid로 재현) |
| 101 | 126 | start.spring.io로 의존성 뽑는 7단계, `spring-boot-starter-security` + `spring-boot-starter-security-test` | [[02-adding-spring-security-to-the-project]] | 반영 |
| 101–102 | 126–127 | 시작하면 랜덤 비밀번호로 전부 잠긴다, 재시작마다 바뀌는 문제, `application.properties` 오버라이드가 확장되지 않는 이유 | [[02-adding-spring-security-to-the-project]] | 반영 |
| 102 | 127 | 보안의 4가지 핵심 축(사용자 출처·접근 규칙·연결·전 영역 적용) | [[03-creating-users-with-userdetailsservice]] | 반영 |
| 102–103 | 127–128 | `SecurityConfig` + `InMemoryUserDetailsManager`로 user/admin 생성, 항목별 3개 설명 | [[03-creating-users-with-userdetailsservice]] | 반영 |
| 103 | 128 | `@EnableWebSecurity` 활성화, MVC/WebFlux에 따라 컴포넌트가 갈린다, `UserDetailsService` 빈이 있으면 자동 설정이 물러선다 | [[03-creating-users-with-userdetailsservice]] | 반영 |
| 103 | 128 | Tip: `withDefaultPasswordEncoder()`는 deprecated, 운영에서 쓰지 말 것 | [[03-creating-users-with-userdetailsservice]] | 반영 |
| 103 | 128 | Figure 4.2 Spring Security 기본 로그인 폼 | [[03-creating-users-with-userdetailsservice]] | 반영 (이미지 추출) |
| 105 | 130 | 하드코딩된 사용자의 한계, 사용자 관리와 인증의 분리가 보안을 높이는 이유 | [[04-spring-data-backed-users]] | 반영 |
| 105 | 130 | `UserAccount` 엔티티(`@Entity`, `@Id`, `@GeneratedValue`, `@ElementCollection` authorities)와 항목별 4개 설명 | [[04-spring-data-backed-users]] | 반영 |
| 106 | 131 | `UserManagementRepository extends JpaRepository`, `CommandLineRunner initUsers` | [[04-spring-data-backed-users]] | 반영 |
| 106 | 131 | Tip: `CommandLineRunner`는 SAM이라 람다로 만들 수 있다 | [[04-spring-data-backed-users]] | 반영 |
| 107 | 132 | `UserRepository extends Repository` + `findByUsername`, `JpaRepository`와 다른 두 가지 | [[04-spring-data-backed-users]] | 반영 |
| 108 | 133 | `UserDetailsService userService(UserRepository)` 람다 빈, `UserDetails`의 구성 요소, 서비스와 값 객체의 구분 | [[04-spring-data-backed-users]] | 반영 |
| 108 | 133 | `asUser()` 변환 메서드 | [[04-spring-data-backed-users]] | 반영 |
| 108 | 133 | Note: 비밀번호 인코딩은 사용자 관리 도구의 몫, 역할 갱신과 해시 테이블 공격 대비 필요 | [[04-spring-data-backed-users]] | 반영 |
| 109 | 134 | 인증 → 인가로 넘어가는 전환, "정체를 증명하는 것만으로는 부족하다" | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 109–110 | 134–135 | Boot 기본 정책을 단순화한 `defaultSecurityFilterChain`과 `ServletWebSecurityAutoConfiguration`, 항목별 7개 설명 | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 110 | 135 | Form 인증 vs Basic 인증의 차이(스타일링·로그아웃·팝업·curl) | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 111 | 136 | 상세 정책 예제(`permitAll`, `hasRole("ADMIN")` + `HttpMethod.GET`, `AuthorizationManagers.allOf`, `denyAll`)와 절별 6개 설명 | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 111 | 136 | 커스텀 접근 검사가 필요한 이유, `hasAnyRole`은 있지만 "모두 만족"은 내장이 없다 | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 111–112 | 136–137 | Note: authority와 `ROLE_` 접두사, `ROLE_ADMIN` = role `ADMIN` | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 112 | 137 | 동영상 사이트 요구사항 6줄과 그것을 옮긴 `configureSecurity` 정책 | [[05-securing-web-routes-and-http-verbs]] | 반영 |
| 112–113 | 137–138 | 정책의 절별 설명 6개 | [[05-securing-web-routes-and-http-verbs]] | 반영 (본문·코드 불일치 명시) |
| 113 | 138 | CSRF 공격 방식, nonce와 CSRF 토큰의 원리 | [[05a-to-csrf-or-not-to-csrf]] | 반영 |
| 113 | 138 | Thymeleaf는 자동, Mustache는 `spring.mustache.servlet.expose-request-attributes=true` 필요 | [[05a-to-csrf-or-not-to-csrf]] | 반영 |
| 114 | 139 | `_csrf` hidden input을 넣은 search 폼과 new-video 폼 | [[05a-to-csrf-or-not-to-csrf]] | 반영 |
| 114 | 139 | 값이 매 요청 바뀌어 캐시·예측이 불가능하다는 설명 | [[05a-to-csrf-or-not-to-csrf]] | 반영 |
| 114–115 | 139–140 | CSRF는 템플릿과 JSON API에 한꺼번에 적용되거나 한꺼번에 꺼진다, 애플리케이션 분리가 맞는 구조라는 판단 | [[05a-to-csrf-or-not-to-csrf]] | 반영 |
| 115 | 140 | `.csrf(csrf -> csrf.disable())`를 넣은 정책, `ApiController`를 덜어내기로 한 결정 | [[05a-to-csrf-or-not-to-csrf]] | 반영 (두 정책의 실제 차이 명시) |
| 116 | 141 | Note: 이 절의 소스는 `ch4-method-security` 폴더 | [[06-securing-spring-data-methods]] | 반영 |
| 116 | 141 | URL 기반 보안의 한계, 메서드 레벨 보안이 "더 촘촘한 잠금"인 이유 | [[06-securing-spring-data-methods]] | 반영 |
| 117 | 142 | `VideoEntity`에 `username` 필드 추가, protected 무인자 생성자 유지 | [[06a-updating-our-model]] | 반영 |
| 117–118 | 142–143 | 사용자를 alice·bob·admin으로 확장한 `initUsers`, "alice는 자기 것만 지운다"는 목표 | [[06a-updating-our-model]] | 반영 |
| 117 | 142 | Note: Alice와 Bob은 1978년 RSA 논문에서 온 관례 | [[06a-updating-our-model]] | 반영 |
| 118 | 143 | `HomeController.newVideo`에 `Authentication` 주입, `Authentication`이 `java.security.Principal`을 확장한다는 사실 | [[06b-taking-ownership-of-data]] | 반영 |
| 118–119 | 143–144 | `VideoService.create(newVideo, username)`의 두 변화 | [[06b-taking-ownership-of-data]] | 반영 |
| 119–120 | 144–145 | `index.mustache`의 `{{#videos}}` 반복과 DELETE 폼, 항목별 4개 설명 | [[06c-adding-a-delete-button]] | 반영 |
| 120 | 145 | HTML 폼이 GET/POST만 지원해서 DELETE 대신 POST를 쓴다는 설명, `_csrf` 필요성 | [[06c-adding-a-delete-button]] | 반영 |
| 120 | 145 | `HomeController.deleteVideo`와 항목별 4개 설명(302 soft redirect 포함) | [[06c-adding-a-delete-button]] | 반영 |
| 121 | 146 | `VideoService.delete(Long)`과 항목별 5개 설명(`Optional.map`이 반환값을 요구해서 `true`를 돌려주는 이유) | [[06c-adding-a-delete-button]] | 반영 |
| 121–122 | 146–147 | `VideoRepository`에서 `delete(VideoEntity)`를 `@Override` + `@PreAuthorize`로 재선언, 4개 항목 해설(`#entity.username`, `authentication.name`) | [[06d-locking-down-access-to-the-owner]] | 반영 |
| 122 | 147 | `@EnableMethodSecurity`를 `SecurityConfig`에 추가 | [[06e-enabling-method-level-security]] | 반영 |
| 122 | 147 | Note: `@EnableGlobalMethodSecurity`는 deprecated, 새 애노테이션이 켜는 것과 끄는 것, `AuthorizationManager` 기반으로 바뀐 이유 | [[06e-enabling-method-level-security]] | 반영 |
| 122–123 | 147–148 | `HomeController.index`에 `Authentication` 주입하고 모델 속성으로 전달 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 123 | 148 | `index.mustache`의 User Profile 블록과 `/logout` 폼, 항목별 3개 설명 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 123 | 148 | Note: 모든 HTML 폼에 `_csrf`가 필요하다, Thymeleaf는 자동 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 123–124 | 148–149 | `@PostConstruct initDatabase()`를 alice·bob 소유로 갱신, 항목별 2개 설명 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 124 | 149 | Figure 4.3 alice로 로그인하는 화면 | [[06f-displaying-user-details-on-the-site]] | 반영 (미추출 — Figure 4.2와 같은 폼) |
| 125 | 150 | Figure 4.4 인증 정보가 렌더된 index 화면 | [[06f-displaying-user-details-on-the-site]] | 반영 (이미지 추출) |
| 125 | 150 | Note: 비밀번호를 화면에 넣지 말 것, authority 목록도 굳이 넣지 말 것, Thymeleaf의 보안 확장 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 126 | 151 | Figure 4.5 403 화면, 자기 동영상은 정상 삭제된다는 확인 | [[06d-locking-down-access-to-the-owner]] | 반영 (미추출 — 브라우저 기본 오류 화면) |
| 126–127 | 151–152 | 세밀한 제어의 대가: 사용자·역할 관리 부담, 그래서 외부 제공자로 눈을 돌린다 | [[06f-displaying-user-details-on-the-site]] | 반영 |
| 127 | 152 | OAuth는 "소셜 로그인"이 아니라 위임 인가 프레임워크, 비밀번호를 공유하지 않고 접근하는 질문 | [[07-understanding-oauth-2-1]] | 반영 |
| 127 | 152 | scope와 access token, YouTube 예시 4단계 | [[07-understanding-oauth-2-1]] | 반영 |
| 128 | 153 | OAuth는 인증 프로토콜이 아니다, OIDC가 ID Token으로 신원을 더한다, 둘의 역할 대비 | [[07a-oauth-vs-openid-connect]] | 반영 |
| 128 | 153 | Authorization Code Flow 4단계와 두 가지 성질(토큰이 브라우저에 노출되지 않음, 서버 대 서버 교환) | [[07a-oauth-vs-openid-connect]] | 반영 |
| 128–129 | 153–154 | PKCE의 4단계 동작과 OAuth 2.1에서의 의무화 | [[07a-oauth-vs-openid-connect]] | 반영 |
| 129 | 154 | Client Credentials Flow, Implicit Flow의 문제와 폐기, OAuth 2.1이 정리한 것 | [[07a-oauth-vs-openid-connect]] | 반영 |
| 129 | 154 | 신원 시스템을 직접 운영하지 않고 위임할 때의 이득 | [[08-leveraging-google-to-authenticate-users]] | 반영 |
| 129–130 | 154–155 | Note: 로컬 authorization server 대안(Spring Authorization Server)과 그 장단 | [[08-leveraging-google-to-authenticate-users]] | 반영 |
| 130 | 155 | Google·GitHub·Microsoft 등 여러 제공자 중 Google을 고른다는 선택 | [[08-leveraging-google-to-authenticate-users]] | 반영 |
| 130–131 | 155–156 | Google Cloud 대시보드 15단계(프로젝트 생성 → YouTube Data API v3 → OAuth Client ID → redirect URI → test users) | [[08a-creating-a-google-oauth-application]] | 반영 |
| 131 | 156 | 어느 플랫폼이든 필요한 4가지(앱 정의·승인된 API·지원 사용자·콜백) | [[08a-creating-a-google-oauth-application]] | 반영 |
| 131 | 156 | Note: 지금 앱은 test mode라 본인만 접근 가능 | [[08a-creating-a-google-oauth-application]] | 반영 |
| 131 | 156 | Note: 이 절의 소스는 `ch4-oauth` 폴더 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 131–132 | 156–157 | Initializr 재시작 절차와 선택 의존성 4개(OAuth 2 Client, Spring Web, HTTP Client, Mustache) | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 132 | 157 | `application.properties` → `application.yaml` 전환 이유, `spring.security.oauth2.client.registration.google` 트리 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 132–133 | 157–158 | Note: `CommonOAuth2Provider`가 Google·GitHub·Facebook·Okta 설정을 미리 담고 있다, scope는 YouTube 때문에 추가 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 133 | 158 | `OAuth2AuthorizedClient` 개념, `ClientRegistrationRepository`·`OAuth2AuthorizedClientRepository` 자동 설정, 다중 제공자 지원이 이유 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 133–134 | 158–159 | `SecurityConfig.clientManager()` 빈과 `authorizationCode/refreshToken/clientCredentials` 조합 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 134 | 159 | Tip: OAuth2 흐름은 oauth.net/2에서 더 읽어라, 보일러플레이트지만 한 번이면 된다 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 134 | 159 | OAuth2가 classpath에 오면 자동 설정이 앱을 잠그지만 이번엔 랜덤 비밀번호 대신 OAuth2 빈이 쓰인다 | [[08b-adding-oauth-client-to-a-spring-boot-project]] | 반영 |
| 135 | 160 | `RestClient`가 `RestTemplate`보다 앞선 선택인 이유, `YouTubeConfig`와 `OAuth2ClientHttpRequestInterceptor` | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 135 | 160 | Note: HTTP request interceptor는 `RestClient` 파이프라인 안의 서블릿 필터 같은 것 | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 135–136 | 160–161 | HTTP client proxy(인터페이스 선언 + 자동 마샬링)의 이점 | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 136 | 161 | `YouTube` 인터페이스, `@GetExchange`, `@RequestParam`, `Sort` enum | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 136 | 161 | `@GetMapping`(수신) vs `@GetExchange`(발신)의 대비, base URL과 경로의 결합, 쿼리 파라미터 이름 규칙 | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 136–137 | 161–162 | 요청 바디가 없는 API, 필요하면 `@PostExchange` + `@RequestBody` | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 137 | 162 | Search API의 JSON 응답 구조와 `SearchListResponse` record | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 137–138 | 162–163 | 중첩 타입을 문서 따라 record로 옮기는 절차, `PageInfo`·`SearchResult`·`SearchId`·`SearchSnippet`·`SearchThumbnail` | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 138 | 163 | Tip: record 타입 이름은 상관없다, 필드 이름이 JSON과 맞아야 한다 | [[08c-invoking-an-oauth-2-api-remotely]] | 반영 |
| 139 | 164 | OAuth 앱의 `HomeController`(생성자 주입, 채널 ID·10건·조회수 정렬), 항목별 4개 설명 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 139–140 | 164–165 | `index.mustache` HTML5 테이블 전체 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 141 | 166 | Mustache 문법 3가지(중괄호, `#` 반복, 로직 없음), 그래서 record에 메서드를 더한다 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 141 | 166 | `SearchSnippet.shortDescription()`과 `thumbnail()` 구현, 두 메서드의 동작 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 142 | 167 | `style.css`와 `src/main/resources/static`의 정적 자원 규칙 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 (CSS 선택자 오류 명시) |
| 143 | 168 | Figure 4.6 Google 로그인(계정 선택) 화면 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 (미추출 — Figure 4.7과 중복, 개인 이메일 노출) |
| 144 | 169 | 기본 scope였다면 계정 정보만 요청했을 것이다, scope를 넓혀서 채널 선택 프롬프트가 뜬다(Figure 4.7) | [[08d-creating-an-oauth2-powered-web-app]] | 반영 (이미지 추출) |
| 145 | 170 | Figure 4.8 렌더된 YouTube 테이블, 썸네일 하이퍼링크 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 (이미지 추출) |
| 145 | 170 | Tip: 아무 채널 ID나 넣어도 된다(vanity URL 아님), Dan Vega 채널 예시 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 146 | 171 | OAuth2로 사용자 관리를 넘겨 위험을 줄였다는 정리 | [[08d-creating-an-oauth2-powered-web-app]] | 반영 |
| 146 | 171 | Note: 이 절의 소스는 `ch4-data-transit-rest-security` 폴더 | [[09-securing-data-in-transit]] | 반영 |
| 146 | 171 | 전송 중 데이터와 저장 중 데이터의 정의, 각각이 깨질 때 일어나는 일 | [[09-securing-data-in-transit]] | 반영 |
| 146–147 | 171–172 | HTTPS = HTTP over TLS, TLS가 주는 3가지(암호화·무결성·서버 인증), CA와 자체 서명 인증서 | [[09-securing-data-in-transit]] | 반영 |
| 147 | 172 | `keytool -genkeypair` 명령, `changeit` 비밀번호, `src/main/resources/keystore.p12` 배치 | [[09-securing-data-in-transit]] | 반영 |
| 147 | 172 | `server.port=8443` 외 `server.ssl.*` 6개 프로퍼티와 각각의 역할 4가지 | [[09-securing-data-in-transit]] | 반영 |
| 148 | 173 | `https://localhost:8443` 접속, 자체 서명 경고(Figure 4.9), "Proceed to localhost (unsafe)" | [[09-securing-data-in-transit]] | 반영 (이미지 추출) |
| 148–149 | 173–174 | 웹 서버 외에도 TLS가 필요한 곳(아웃바운드 클라이언트·Kafka), 중복 설정의 위험, Boot 3.1의 SSL Bundle 도입 | [[09a-introducing-ssl-bundles]] | 반영 |
| 149 | 174 | 번들 정의 2줄과 각 프로퍼티 설명, `server.ssl.bundle=mybundle`, `spring.kafka.ssl.bundle=mybundle` | [[09a-introducing-ssl-bundles]] | 반영 (프로퍼티 오류 정정) |
| 149 | 174 | SSL Bundle의 핵심 이점: 한 번 정의하고 여러 곳에서 재사용 | [[09a-introducing-ssl-bundles]] | 반영 |
| 150 | 175 | 저장 중 보안의 대표 사례가 비밀번호, 평문 저장 금지와 단방향 해시 | [[09b-securing-data-at-rest]] | 반영 |
| 150 | 175 | `PasswordEncoder` 빈과 `BCryptPasswordEncoder`, BCrypt가 salt와 반복 라운드를 자동 적용한다는 설명 | [[09b-securing-data-at-rest]] | 반영 |
| 150 | 175 | `encoder.encode("password")`를 거치도록 바꾼 `initUsers` | [[09b-securing-data-at-rest]] | 반영 |
| 150–151 | 175–176 | 인증 시 제출 비밀번호를 해시해 비교한다, 유출돼도 원문 복구 불가 | [[09b-securing-data-at-rest]] | 반영 |
| 151 | 176 | `asUser()`를 `User.withUsername()`으로 교체, `withDefaultPasswordEncoder()`와의 차이 | [[09b-securing-data-at-rest]] | 반영 |
| 151 | 176 | Summary: 커스텀 사용자 → 경로 제어 → 메서드 제어 → OAuth2 위임 → 전송·저장 보안, 다음 장 예고 | [[_map]] | 반영 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 |
|---:|---|---:|---|
| 1 | `spring-boot-starter-security` + `spring-boot-starter-security-test` 의존성 | 101–102 | [[02-adding-spring-security-to-the-project]] |
| 2 | `SecurityConfig` + `InMemoryUserDetailsManager` (user/admin) | 102–103 | [[03-creating-users-with-userdetailsservice]] |
| 3 | `UserAccount` 엔티티 | 105 | [[04-spring-data-backed-users]] |
| 4 | `UserManagementRepository extends JpaRepository` | 106 | [[04-spring-data-backed-users]] |
| 5 | `CommandLineRunner initUsers` (user/admin) | 106 | [[04-spring-data-backed-users]] |
| 6 | `UserRepository extends Repository` + `findByUsername` | 107 | [[04-spring-data-backed-users]] |
| 7 | `UserDetailsService userService(UserRepository)` 람다 빈 | 108 | [[04-spring-data-backed-users]] |
| 8 | `asUser()` — `withDefaultPasswordEncoder()` 판 | 108 | [[04-spring-data-backed-users]] |
| 9 | Boot 기본 정책 `defaultSecurityFilterChain` | 110 | [[05-securing-web-routes-and-http-verbs]] |
| 10 | 상세 정책 예제 (`/resources`, `/about`, `/admin/**`, `/db/**`) | 111 | [[05-securing-web-routes-and-http-verbs]] |
| 11 | 동영상 사이트 정책 `configureSecurity` | 112 | [[05-securing-web-routes-and-http-verbs]] |
| 12 | `spring.mustache.servlet.expose-request-attributes=true` | 113 | [[05a-to-csrf-or-not-to-csrf]] |
| 13 | `_csrf` hidden input을 넣은 search 폼 | 114 | [[05a-to-csrf-or-not-to-csrf]] |
| 14 | `_csrf` hidden input을 넣은 new-video 폼 | 114 | [[05a-to-csrf-or-not-to-csrf]] |
| 15 | `.csrf(csrf -> csrf.disable())` 정책 | 115 | [[05a-to-csrf-or-not-to-csrf]] |
| 16 | `username`이 추가된 `VideoEntity` | 117 | [[06a-updating-our-model]] |
| 17 | `CommandLineRunner initUsers` (alice/bob/admin) | 118 | [[06a-updating-our-model]] |
| 18 | `HomeController.newVideo(..., Authentication)` | 118 | [[06b-taking-ownership-of-data]] |
| 19 | `VideoService.create(newVideo, username)` | 119 | [[06b-taking-ownership-of-data]] |
| 20 | `index.mustache`의 `{{#videos}}` + DELETE 폼 | 119–120 | [[06c-adding-a-delete-button]] |
| 21 | `HomeController.deleteVideo(@PathVariable Long)` | 120 | [[06c-adding-a-delete-button]] |
| 22 | `VideoService.delete(Long)` | 121 | [[06c-adding-a-delete-button]] |
| 23 | `VideoRepository`의 `@PreAuthorize` + `@Override delete` | 122 | [[06d-locking-down-access-to-the-owner]] |
| 24 | `@EnableMethodSecurity`가 붙은 `SecurityConfig` | 122 | [[06e-enabling-method-level-security]] |
| 25 | `HomeController.index(Model, Authentication)` | 123 | [[06f-displaying-user-details-on-the-site]] |
| 26 | `index.mustache`의 User Profile + Logout 폼 | 123 | [[06f-displaying-user-details-on-the-site]] |
| 27 | `@PostConstruct initDatabase()` (alice/bob 소유) | 123–124 | [[06f-displaying-user-details-on-the-site]] |
| 28 | `application.yaml`의 `spring.security.oauth2.client.registration.google` | 132 | [[08b-adding-oauth-client-to-a-spring-boot-project]] |
| 29 | `SecurityConfig.clientManager()` | 133–134 | [[08b-adding-oauth-client-to-a-spring-boot-project]] |
| 30 | `YouTubeConfig.youtubeRestClient()` | 135 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 31 | `YouTube` 인터페이스 + `Sort` enum | 136 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 32 | Search API JSON 응답 구조 | 137 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 33 | `SearchListResponse` record | 137 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 34 | `PageInfo`·`SearchResult` record | 138 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 35 | `SearchId`·`SearchSnippet` record | 138 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 36 | `SearchThumbnail` record | 138 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 37 | OAuth 앱의 `HomeController` | 139 | [[08d-creating-an-oauth2-powered-web-app]] |
| 38 | OAuth 앱의 `index.mustache` 테이블 | 139–140 | [[08d-creating-an-oauth2-powered-web-app]] |
| 39 | `SearchSnippet`의 `shortDescription()` + `thumbnail()` | 141 | [[08d-creating-an-oauth2-powered-web-app]] |
| 40 | `style.css` | 142 | [[08d-creating-an-oauth2-powered-web-app]] |
| 41 | `keytool -genkeypair` 명령 | 147 | [[09-securing-data-in-transit]] |
| 42 | `src/main/resources/keystore.p12` 배치 경로 | 147 | [[09-securing-data-in-transit]] |
| 43 | `server.ssl.*` 프로퍼티 6줄 | 147 | [[09-securing-data-in-transit]] |
| 44 | `spring.ssl.bundle.pkcs12.mybundle.*` 2줄 | 149 | [[09a-introducing-ssl-bundles]] |
| 45 | `server.ssl.bundle=mybundle` | 149 | [[09a-introducing-ssl-bundles]] |
| 46 | `spring.kafka.ssl.bundle=mybundle` | 149 | [[09a-introducing-ssl-bundles]] |
| 47 | `PasswordEncoder passwordEncoder()` 빈 | 150 | [[09b-securing-data-at-rest]] |
| 48 | `CommandLineRunner initUsers(repository, encoder)` | 150 | [[09b-securing-data-at-rest]] |
| 49 | `asUser()` — `User.withUsername()` 판 | 151 | [[09b-securing-data-at-rest]] |

## 3. Tip / Note 블록 → 노트 매핑

| # | 종류 | 요지 | 책 쪽 | 노트 |
|---:|---|---|---:|---|
| 1 | Note | 이 장의 소스는 `ch4` 폴더 | 98 | [[02-adding-spring-security-to-the-project]] |
| 2 | Tip | `withDefaultPasswordEncoder()`는 deprecated, 운영 금지 | 103 | [[03-creating-users-with-userdetailsservice]] |
| 3 | Note | 비밀번호 인코딩·역할 갱신·해시 테이블 공격은 사용자 관리 도구의 몫 | 108 | [[04-spring-data-backed-users]] |
| 4 | Note | authority와 `ROLE_` 접두사의 관계 | 111–112 | [[05-securing-web-routes-and-http-verbs]] |
| 5 | Note | 이 절의 소스는 `ch4-method-security` 폴더 | 116 | [[06-securing-spring-data-methods]] |
| 6 | Note | Alice와 Bob은 1978년 RSA 논문에서 온 관례 | 117 | [[06a-updating-our-model]] |
| 7 | Tip | `CommandLineRunner`는 SAM이라 람다로 만든다 | 106 | [[04-spring-data-backed-users]] |
| 8 | Note | `@EnableGlobalMethodSecurity`는 deprecated, 새 애노테이션의 기본값 차이 | 122 | [[06e-enabling-method-level-security]] |
| 9 | Note | 모든 HTML 폼에 `_csrf` 필요, Thymeleaf는 자동 | 123 | [[06f-displaying-user-details-on-the-site]] |
| 10 | Note | 비밀번호·authority를 화면에 넣지 말 것 | 125 | [[06f-displaying-user-details-on-the-site]] |
| 11 | Note | 로컬 authorization server 대안(Spring Authorization Server) | 129–130 | [[08-leveraging-google-to-authenticate-users]] |
| 12 | Note | 지금 Google 앱은 test mode | 131 | [[08a-creating-a-google-oauth-application]] |
| 13 | Note | 이 절의 소스는 `ch4-oauth` 폴더 | 131 | [[08b-adding-oauth-client-to-a-spring-boot-project]] |
| 14 | Note | `CommonOAuth2Provider`가 Google·GitHub·Facebook·Okta를 미리 담는다 | 132–133 | [[08b-adding-oauth-client-to-a-spring-boot-project]] |
| 15 | Tip | OAuth2 흐름은 oauth.net/2 참고, 보일러플레이트지만 한 번뿐 | 134 | [[08b-adding-oauth-client-to-a-spring-boot-project]] |
| 16 | Note | HTTP request interceptor는 `RestClient` 안의 필터 | 135 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 17 | Tip | record 타입 이름은 상관없고 필드 이름이 JSON과 맞아야 한다 | 138 | [[08c-invoking-an-oauth-2-api-remotely]] |
| 18 | Tip | 아무 채널 ID나 넣어도 된다, Dan Vega 채널 예시 | 145 | [[08d-creating-an-oauth2-powered-web-app]] |
| 19 | Note | 이 절의 소스는 `ch4-data-transit-rest-security` 폴더 | 146 | [[09-securing-data-in-transit]] |

## 4. Figure 처리 판단

`pdfimages -f 122 -l 176 -list` 결과 raster 이미지 9개(Figure 4.1–4.9)를 확인하고 전부 PNG로 뽑아 육안 대조한 뒤, **5개만** `_assets/`에 남겼다.

| Figure | 책 쪽 / PDF 쪽 | 판단 | 근거 |
|---|---:|---|---|
| 4.1 요청 처리 흐름 | 100 / 124 | **미추출 · Mermaid 재현** | 화면이 아니라 개념 관계도(sequence diagram)다. CLAUDE.md의 "개념 관계는 Mermaid 우선" 규칙에 따라 [[01-spring-security-filter-chain-foundations]]에서 다시 그렸다 |
| 4.2 기본 로그인 폼 | 103 / 128 | **추출** | "직접 만들 필요가 없다"는 주장의 증거물 자체다. `lsb4-p103-fig4-2-spring-security-default-login-form.png` |
| 4.3 alice로 로그인 | 124 / 149 | 미추출 | Figure 4.2와 같은 폼에 `alice`만 입력된 화면이라 새 정보가 없다 |
| 4.4 인증 정보가 렌더된 index | 125 / 150 | **추출** | `{{authentication.authorities}}`가 실제로 무엇을 출력하는지 보여 준다. 화면에는 책 본문이 한 번도 언급하지 않는 **`FactorGrantedAuthority [authority=FACTOR_PASSWORD, …]`**가 `ROLE_USER` 옆에 찍혀 있다. 또 alice에게 bob 소유 동영상의 Delete 버튼까지 보인다는 사실이 드러난다. `lsb4-p125-fig4-4-index-rendering-authentication-details.png` |
| 4.5 403 화면 | 126 / 151 | 미추출 | 브라우저가 만든 일반 오류 화면("Access to localhost was denied / HTTP ERROR 403")이라 본문 서술로 충분하다 |
| 4.6 Google 계정 선택 | 143 / 168 | 미추출 | Figure 4.7과 같은 계정 선택 단계이고, 가려지지 않은 개인 이메일 주소가 그대로 노출돼 있다 |
| 4.7 YouTube 채널 선택 | 144 / 169 | **추출** | scope를 넓혔기 때문에 "브랜드 계정" 선택 단계가 하나 더 생겼다는 인과를 눈으로 확인시켜 준다. Google Cloud에 등록한 앱 이름(YouTube Manager)이 동의 화면에 그대로 나온다는 것도 보인다. `lsb4-p144-fig4-7-google-brand-account-selection.png` |
| 4.8 렌더된 YouTube 테이블 | 145 / 170 | **추출** | `shortDescription()`이 100자에서 자른 흔적("…enjoy thes", "…What is something you can do")과 `style.css`의 초록 테두리가 함께 보인다. 반면 열 너비 규칙은 적용돼 있지 않다. `lsb4-p145-fig4-8-youtube-data-rendered-in-mustache.png` |
| 4.9 자체 서명 인증서 경고 | 148 / 173 | **추출** | 경고의 원인이 `NET::ERR_CERT_AUTHORITY_INVALID`(신뢰할 수 없는 발급자)임을 코드로 못 박아 준다. `lsb4-p148-fig4-9-self-signed-certificate-warning.png` |

## 5. 원문의 오류·불일치 (노트에 명시)

| # | 위치 | 내용 |
|---:|---|---|
| 1 | 책 p.108 | `UserDetailsService`의 메서드 이름을 **`loadUserByName`**이라 쓰고, 두 문단 뒤에는 **`UserDetailsService.loadUserName()`**이라 쓴다. 실제 이름은 `loadUserByUsername(String)`이다(Spring Security 7.1.0 jar로 확인) |
| 2 | 책 pp. 112–113 | 정책 코드에는 규칙이 6줄인데 본문 설명은 5개뿐이고 `.requestMatchers("/admin").hasRole("ADMIN")`을 통째로 건너뛴다. 또 코드의 `POST /api/**`를 본문은 `/api/new-video`라고 옮긴다 |
| 3 | 책 p.115 | CSRF를 끈 정책을 두고 "직전 정책과 **마지막 줄 하나만 다르다**"고 하지만, 실제로는 `/admin` 규칙도 함께 사라져 있다 |
| 4 | 책 p.105 | `@ElementCollection private List<GrantedAuthority> authorities` — `GrantedAuthority`는 인터페이스라서 JPA의 element collection 대상(기본 타입 또는 `@Embeddable`)이 될 수 없다. 또 `new UserAccount("user", "password", "ROLE_USER")`가 쓰는 3인자 생성자를 끝까지 보여 주지 않는다 |
| 5 | 책 pp. 119–121 | `/delete/videos/{id}`로 POST하는 버튼을 만들면서, 그 경로를 허용하는 `requestMatchers` 규칙은 어디에도 추가하지 않는다. 앞 절의 정책(`anyRequest().denyAll()`)을 그대로 쓰면 소유자 본인도 403을 받는다 |
| 6 | 책 pp. 136·139 | `@GetExchange`를 붙인 `YouTube` 인터페이스를 만들고 `HomeController`에 주입하지만, 그 인터페이스를 프록시 빈으로 등록하는 코드(`@ImportHttpServices` 또는 `HttpServiceProxyFactory`)는 나오지 않는다 |
| 7 | 책 p.149 | SSL Bundle 프로퍼티를 `spring.ssl.bundle.pkcs12.mybundle.key.store` / `.key.password`로 적는다. Boot 4.1의 번들 타입은 `jks`와 `pem` 두 가지뿐이고, PKCS#12 파일도 `spring.ssl.bundle.jks.<name>.keystore.location` 아래에 놓는다 |
| 8 | 책 p.148 | "`server.ssl` 대신 **`server.ssl.bundle` 아래에** 재사용 번들을 정의한다"고 서술하지만, 번들을 정의하는 자리는 `spring.ssl.bundle.*`이고 `server.ssl.bundle`은 이미 정의된 번들을 **참조**하는 키다 |
| 9 | 책 pp. 140·142 | `index.mustache`의 헤더 행이 `<th>`가 아니라 `<td>`인데 `style.css`는 `thead th:nth-child(n)`로 열 너비를 지정한다. 선택자가 맞지 않아 너비 규칙이 적용되지 않는다(Figure 4.8에서도 확인된다) |
| 10 | 책 p.136 | 쿼리 문자열 예시가 `?channelId=<value>&maxResults=<value>ℴ=<value>`로 인쇄돼 있다. `&order`가 HTML 엔티티 `&order;`로 해석돼 생긴 조판 사고이며 실제 파라미터 이름은 `order`다 |

## 공식 문서 대조 검증 (2026-08-29)

> 이 챕터는 **노트당 공식 문서 인용 0.09회**로 저장소에서 가장 낮았고, 23개 노트로 가장 크며, 보안이라 실수 대가가 가장 크다. 그래서 우선순위 상위로 대조했다.

### 결과 — 정정 0건

인용 밀도가 낮은 것은 **근거가 없어서가 아니라 이 챕터의 내용이 코드·설정 중심이라 도출 주장이 적기 때문**이었다. 검증 가치가 높은 지점을 골라 확인한 결과는 이렇다.

| 확인한 것 | 결과 |
|---|---|
| **메서드 보안의 자기 호출 우회** | `06` §2·§6과 `06e` §6이 **둘 다** 명시한다 — "같은 클래스에서 `this.delete(...)`를 부르면 프록시를 우회해 애노테이션이 무시된다". 보안에서는 이것이 인가 우회를 뜻하므로 가장 중요한 확인이었다. **누락 없음** |
| `@EnableMethodSecurity` 없이 애노테이션만 붙인 경우 | `06e`가 "애노테이션은 메타데이터일 뿐, 주석과 다를 바 없다"로 정확히 짚는다 |
| `SecurityFilterChain` 빈이 기본 설정을 **대체**하는가 추가하는가 | `01` §5가 "대체된다. 폼 로그인·HTTP Basic도 다시 켜야 한다"로 옳게 적는다 |
| `withDefaultPasswordEncoder()` | deprecated·평문·운영 금지를 세 노트에서 반복해 경고하고, `09b`에서 `BCryptPasswordEncoder`로 갚는 구조까지 연결한다 |
| BCrypt 라운드 수 | `09b` §6이 "기본값을 쓴다. 운영에서는 목표 지연 시간을 측정해 정하라"고 경계를 남긴다 |
| 해시 vs 암호화의 경계 | `09b` §6이 "되돌려 읽어야 하는 데이터에는 해시를 쓸 수 없다"로 구분한다 |
| CSRF를 무상태 API에서 끄는 조언 | `05a` §6이 **"세션 쿠키를 쓰지 않고 매 요청 토큰을 명시적으로 싣는다면"**이라는 조건을 달아 놓았다. 조건 없는 "API면 끄라"가 아니다 |
| `UserDetailsService`가 없는 사용자에 `null`을 반환하는 문제 | `04` §6이 "규격대로라면 `UsernameNotFoundException`을 던져야 한다"고 이미 지적한다 |
| `fetch = EAGER`가 권한 로딩에 필요한 이유 | `04`가 영속성 컨텍스트가 닫힌 뒤 접근하면 실패한다는 근거를 든다. `part-0-jpa-foundations` j2의 지연 로딩 설명과 일치 |

**0건이 "검사하지 않았다"가 아니라 "대조했고 어긋난 곳을 못 찾았다"임을 구분해 적는다.**

### 이 챕터가 시사하는 것

인용 밀도를 위험 지표로 쓴 것은 **후보를 고르는 데는 유효했지만 판정 기준은 아니었다.** 도출 주장이 많은 챕터(c1~c4, Ch9, Ch12)에서 오류가 나왔고, 코드·설정 중심 챕터는 인용이 없어도 정확했다. **위험은 "인용이 없다"가 아니라 "책을 넘어 스스로 추론했다"에 있다.**

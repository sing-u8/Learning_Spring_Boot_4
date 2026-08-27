# Chapter 4 용어집

- **SecurityFilterChain**: HTTP 요청 보안 필터와 정책을 묶은 중심 Bean. → [[01-spring-security-foundations]]
- **authentication**: 주체가 누구인지 확인하는 과정. → [[01-spring-security-foundations]]
- **authorization**: 주체가 무엇을 할 수 있는지 판단하는 과정. → [[04-securing-web-routes-and-http-verbs]]
- **UserDetailsService**: username으로 인증 사용자 정보를 읽는 전략. → [[02-adding-spring-security-and-custom-users]]
- **authority/role**: 구체 permission과 `ROLE_` 관례로 묶은 권한 범주. → [[04-securing-web-routes-and-http-verbs]]
- **CSRF**: 브라우저의 자동 credential을 악용한 교차 출처 상태 변경 공격. → [[05-protecting-against-csrf]]
- **method security**: Bean 메서드 호출에 적용하는 인가. → [[06-securing-data-methods-and-object-ownership]]
- **OAuth**: password 공유 없이 resource access를 위임하는 authorization framework. → [[07-understanding-oauth-2-1-and-oidc]]
- **OIDC**: OAuth 위에 identity 확인과 ID token을 추가한 프로토콜. → [[07-understanding-oauth-2-1-and-oidc]]
- **TLS**: 전송 암호화·무결성·peer 인증 프로토콜. → [[09-securing-data-in-transit-with-tls-and-ssl-bundles]]
- **BCrypt**: salt와 cost를 내장한 adaptive password hash. → [[10-securing-data-at-rest]]


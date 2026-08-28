# 모범답안 — 05 웹 경로와 HTTP 동사 보안

> **먼저 답하고 나서 열 것.** [[05-securing-web-routes-and-http-verbs]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- **✅** = 노트가 Spring Security/Boot 실제 소스와 대조해 확인한 항목
- 본문 점검: **8문항 모두 답이 충분**했다. 이 노트는 이미 책의 서술 누락(규칙 6줄인데 설명 5개)을 잡아 두었다.

---

## Q1. `anyRequest().authenticated()`만 있으면 `/admin`에 들어가지는 이유

**그 규칙이 "아무 요청이나, 인증만 되어 있으면 OK"라고만 말하기 때문이다. 역할은 한 번도 언급되지 않는다.**

```java
.authorizeHttpRequests(auth -> auth
    .anyRequest().authenticated()      // ← 역할 이야기가 없다
)
```

**"인증만으로는 부족하다."** 문을 잠그는 것과 **방마다 출입 등급을 나누는 것**은 다른 일이다.

✅ 이 코드는 책의 단순화가 아니라 실제와 같다 — Boot 4.1.0의 `ServletWebSecurityAutoConfiguration$SecurityFilterChainConfiguration#defaultSecurityFilterChain`을 열어 보면 메서드 이름까지 같고 내용도 `authorizeHttpRequests(anyRequest().authenticated())` → `formLogin` → `httpBasic` → `build()`로 동일하다.

**함정의 성질**: 앱이 **잠겨 보인다.** 로그인 화면이 뜨고 인증을 요구하므로 "보안이 켜졌다"고 느낀다. **로그인한 사람은 아무 데나 갈 수 있다는 사실이 안 보인다.**

---

## Q2. `formLogin`을 빼면

**로그인 화면이 사라진다.**

`SecurityFilterChain` 빈을 정의하면 **자동 설정 백오프**로 기본 정책이 **통째로** 사라진다. 기본이 켜 주던 것을 내가 다시 켜지 않으면 함께 사라진다.

| 빠뜨린 것 | 결과 |
|---|---|
| `formLogin` | **로그인 화면이 사라진다.** 인증은 요구하는데 인증할 방법이 없다 |
| `httpBasic` | `curl`로 접근할 수 없다 |
| `authorizeHttpRequests` | 인가 규칙이 없다 |
| 반환 타입이 `SecurityFilterChain`이 아님 | **백오프가 안 일어나** 기본 정책이 남는다 |

**"기본값에 얹는" 게 아니라 "대체한다"** — [[01-spring-security-filter-chain-foundations]]에서 본 그대로다.

**그래서 이 장의 모든 정책 예제가 `formLogin`과 `httpBasic`을 매번 다시 적는다.**

---

## Q3. 폼 인증과 Basic 인증을 둘 다 켜는 실질적 이유

**대상 사용자가 다르다.**

| | 폼 인증 | Basic 인증 |
|---|---|---|
| 화면 | HTML 폼. **앱 테마에 맞춰 꾸밀 수 있다** | 브라우저 내장 팝업. **꾸밀 수 없다** |
| 로그아웃 | 지원한다 | **없다.** 브라우저를 닫거나 재시작해야 자격 증명이 버려진다 |
| 명령줄 도구 | 쓰기 어렵다 | **`curl -u user:password`로 간단하다** |
| 주 사용자 | **사람(브라우저)** | **스크립트·CI·API 호출** |

> **브라우저 사용자는 폼으로, 프로그램은 Basic으로.**

**이 앱에 둘 다 필요한 이유**: 웹 페이지와 `/api` JSON을 **함께 서빙하기 때문**이다. 사람이 쓰는 화면과 프로그램이 쓰는 API가 한 애플리케이션 안에 있다.

**주의**: Basic 인증에 **로그아웃이 없다**는 점은 실무에서 놀라운 지점이다. 브라우저가 자격 증명을 캐시하므로 "로그아웃했는데 계속 들어가진다"가 된다.

---

## Q4. 규칙 순서가 결정적인 이유

**규칙은 선언 순서대로 검사되고 처음 일치한 규칙에서 판정이 끝난다.**

> **넓은 규칙을 위에 두면 아래 규칙이 죽는다.**

**잘못된 순서의 예**:

```java
.authorizeHttpRequests(auth -> auth
    .anyRequest().denyAll()                        // ← 첫 줄에 두면
    .requestMatchers("/login").permitAll()         // ← 여기는 절대 도달하지 않는다
    .requestMatchers("/admin/**").hasRole("ADMIN") // ← 여기도
)
```

**모든 요청이 첫 줄에 걸려 403이 된다.** 로그인조차 못 한다.

**또 다른 흔한 실수**:
```java
.requestMatchers("/**").authenticated()        // ← 모든 경로에 걸린다
.requestMatchers("/login").permitAll()          // ← 죽은 규칙
```

**규칙**: **구체적인 것을 위에, 넓은 것을 아래에.** `anyRequest()`는 반드시 **마지막**이다.

**증상**: 오류가 아니라 **403**이다. "권한 설정이 잘못됐나" 하며 역할을 뒤지게 되지 **순서를 의심하지 않는다.**

---

## Q5. `denyAll()`을 마지막에 두면 막아 주는 실수

**새 엔드포인트를 추가하고 규칙 추가를 잊는 실수다.**

```java
.anyRequest().denyAll()    // 어디에도 안 걸리면 거절
```

**없다면**: 규칙에 안 걸린 경로가 **어떻게 될지 불명확**하거나 통과한다. 새 컨트롤러를 만들고 정책 파일을 안 고치면 **그 엔드포인트만 무방비**가 된다.

**있다면**: **뚫리는 게 아니라 막힌다.** 개발 중에 즉시 발견된다 — 화면이 403이니까.

> **실패의 방향을 안전한 쪽으로 정하는 패턴이다.**

**[[01-spring-security-filter-chain-foundations]]의 "기본값이 잠김"과 같은 원리가 정책 수준에서 반복된다.** 프레임워크가 그렇게 하듯, 내 정책도 **명시적으로 허용한 것만 통과**시킨다.

**대가**: 경로를 추가할 때마다 정책도 함께 고쳐야 한다. **그 마찰이 곧 안전장치다** — 잊으면 막히므로 반드시 알게 된다.

---

## Q6. `.roles("ADMIN")` / `hasRole("ADMIN")` / DB의 `ROLE_ADMIN`

**Spring Security의 근본 단위는 authority 하나뿐이고, "역할"은 그중 `ROLE_` 접두사로 시작하는 것들을 부르는 이름일 뿐이다.**

| 표기 | 어디서 | 실제 저장/비교되는 값 |
|---|---|---|
| `.roles("ADMIN")` | 사용자 생성 빌더 | **`ROLE_ADMIN`** (빌더가 붙여 준다) |
| `hasRole("ADMIN")` | 인가 규칙 | **`ROLE_ADMIN`** (매니저가 붙여 준다) |
| `"ROLE_ADMIN"` | **DB에 직접 적을 때** | 그대로 |
| `hasAuthority("ADMIN")` | 인가 규칙 | **`ADMIN`** (접두사 없음) |

**즉 "역할"이라는 별도 개념이 있는 게 아니라 편의 API가 접두사를 대신 붙여 주는 것이다.**

**그래서 DB에 직접 적을 때는 내가 붙여야 한다** — [[04-spring-data-backed-users]]에서 `ROLE_USER`·`ROLE_ADMIN`을 그대로 저장한 이유.

**전형적 실수**: `.roles("ADMIN")`으로 만들고 `hasAuthority("ADMIN")`으로 검사 → **안 맞는다.** 저장된 것은 `ROLE_ADMIN`이다. **증상은 403**이라 문자열 불일치를 의심하기 어렵다.

**규칙**: **`role` 계열끼리, `authority` 계열끼리 짝을 맞춘다.**

---

## Q7. "모든 역할을 가졌는가"가 내장에 없는데도 쓸 수 있는 이유

**`AuthorizationManager`를 조합할 수 있게 열어 두었기 때문이다.**

✅ Spring Security 7.1.0의 `AuthorityAuthorizationManager`를 열어 보면 `hasRole`·`hasAuthority`·`hasAnyRole`·`hasAnyAuthority`뿐이고 **`hasAllRoles`는 없다.**

```java
.requestMatchers("/db/**").access(
    AuthorizationManagers.allOf(
        hasRole("ADMIN"),
        hasRole("DBA")
    )
)
```

**`AuthorizationManagers`에 `allOf`·`anyOf`·`not`이 있고, 이것들로 대부분의 조합을 만들 수 있다.**

**왜 이런 설계인가**: **프레임워크가 모든 조합을 미리 만들어 두는 것은 불가능하다.** `hasAllRoles`를 넣으면 다음엔 `hasAllAuthoritiesExcept`가 필요해진다. **조합 가능한 원소를 주는 것**이 유한한 해법이다.

**책의 경고**: 이렇게 직접 쓴 규칙일수록 **성공 경로와 실패 경로를 둘 다 테스트해야 한다.** 규칙이 복잡할수록 **"통과해야 할 사람이 막히는"** 실수와 **"막혀야 할 사람이 통과하는"** 실수가 동시에 가능하다.

---

## Q8. 출입 등급표 비유가 깨지는 지점

**출입 등급표는 표를 훑어 가장 적합한 항목을 찾지만, Spring Security는 처음 일치하는 규칙에서 멈춘다.**

비유는 여기까지 맞는다 — 경로마다 필요한 등급을 적어 둔 표가 있고, 요청이 오면 그 표를 본다.

**깨지는 지점 셋**:

1. **"가장 구체적인 규칙"이 아니라 "먼저 쓴 규칙"이 이긴다.** 사람이 표를 보면 `/admin/users`에 대해 `/admin/**`보다 더 구체적인 항목을 찾겠지만, Spring Security는 **순서대로 훑다가 처음 걸리는 것**을 쓴다 → Q4.
2. **표에 없는 항목의 처리가 명시돼야 한다.** 사람이라면 "표에 없으면 물어본다"가 자연스럽지만, 여기서는 `anyRequest()`를 **내가 적어야** 한다 → Q5.
3. **이 표는 URL만 본다.** "이 문서의 작성자인가" 같은 규칙은 등급표에 적을 수 없다 — 데이터를 봐야 답이 나온다. 그래서 [[06-securing-spring-data-methods]]의 메서드 레벨 보안이 따로 필요하다.

**3번이 [[01-spring-security-filter-chain-foundations]] Q7과 같은 지점이다.**

---

## 재출제 문항

1. `user`로 로그인해서 `/admin`에 들어가진다. 정책에 무엇이 빠졌는가?
2. `anyRequest().denyAll()`을 첫 줄에 뒀다. 무슨 일이 일어나고 증상은 무엇인가?
3. 로그아웃했는데 계속 들어가진다. 어떤 인증 방식을 쓰고 있겠는가?
4. `.roles("ADMIN")`으로 만들고 `hasAuthority("ADMIN")`으로 막았다. 왜 403이 나는가?
5. "ADMIN이면서 DBA가 아닌 사람"을 어떻게 표현하겠는가?
6. 새 컨트롤러를 만들고 정책을 안 고쳤다. `denyAll()`이 있을 때와 없을 때 각각 어떻게 되는가?

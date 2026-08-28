# 모범답안 — 06b 데이터의 소유권 갖기

> **먼저 답하고 나서 열 것.** [[06b-taking-ownership-of-data]]의 `## 8. 스스로 확인` 일곱 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **7문항 모두 답이 충분**했다.

---

## Q1. 소유자를 폼 입력으로 받으면 가능한 공격

**bob이 개발자 도구로 입력값을 `alice`로 바꿔 제출하면, bob이 올린 동영상이 alice 소유로 저장된다.**

**그러면 모든 보안이 무너진다.**
- bob이 **남의 이름으로 콘텐츠를 올릴 수 있다** — 명의 도용
- bob이 **자기 이름으로 올려야 할 것을 남에게 떠넘길 수 있다** — 책임 회피
- **소유권 기반 삭제 규칙이 무의미해진다** — bob이 모든 것을 자기 소유로 만들면 다 지울 수 있다

> **클라이언트가 보낸 값으로 소유권을 정하면 소유권이 아무 의미가 없다.**

**값은 서버가 이미 확실히 알고 있는 곳에서 와야 한다** — 보안 컨텍스트. 로그인 과정에서 **비밀번호를 검사하고 신원을 확정한 것은 서버**이고, 그 결과가 거기 있다.

---

## Q2. hidden input이 안전하지 않은 이유 — HTTP 관점

**hidden은 화면에 안 보일 뿐, 요청에는 평범한 파라미터로 실린다.**

```
<input type="hidden" name="username" value="bob">
        ↓ 제출되면
POST /new-video
username=bob&name=...&description=...
        ↑ 다른 파라미터와 구별되지 않는다
```

**HTTP 요청은 클라이언트가 만드는 것이고, 브라우저 화면은 그것을 제약하지 못한다.**

**공격 방법이 여럿이다**:
- 개발자 도구로 **DOM의 value를 고쳐** 제출
- **`curl`로 직접** 요청 작성 — 브라우저를 아예 안 쓴다
- 프록시로 **전송 중인 요청을 가로채 수정**

**`type="hidden"`은 렌더링 지시일 뿐 보안 속성이 아니다.** 서버는 그 값이 hidden에서 왔는지 text에서 왔는지 **알 수도 없다** — 요청에는 그 정보가 없다.

> **클라이언트가 보내는 모든 값은 조작 가능하다고 봐야 한다.**

---

## Q3. `Authentication` 파라미터에 애노테이션이 필요 없는 이유

**타입 자체가 신호이기 때문이다.**

```java
public String newVideo(@ModelAttribute NewVideo newVideo,
                       Authentication authentication) {   // ← 애노테이션 없음
```

Spring Security가 classpath에 있으면 Spring MVC는 **`Authentication` 타입 파라미터를 알아보고 보안 컨텍스트에서 꺼내 넣어 준다.**

**모호함이 없다** — 이 타입을 다른 목적으로 쓸 일이 없다. `String`이나 `Long`이라면 "요청 파라미터인가, 경로 변수인가, 헤더인가"를 애노테이션으로 밝혀야 하지만, `Authentication`은 **출처가 하나뿐**이다.

**[[../chapter-2-creating-web-and-api-applications-with-spring-boot/04a-adding-demo-data-to-a-template|Ch2의 `Model` 파라미터]]와 같은 방식이다** — 타입만 선언하면 프레임워크가 채워 준다.

**이 방식의 이점은 명시성이다**: 메서드 시그니처만 봐도 **"이 핸들러는 인증된 사용자를 필요로 한다"**가 드러난다. `SecurityContextHolder.getContext().getAuthentication()`처럼 **전역 상태를 뒤지는 코드보다 읽기 쉽고 테스트하기도 쉽다.**

---

## Q4. `getName()`이 `Authentication`에 있는 근본 이유

**`Authentication`이 자바 표준 `java.security.Principal`을 상속하기 때문이다.**

```
java.security.Principal  (자바 표준 · getName())
        ↑
org.springframework.security.core.Authentication
        (+ getAuthorities() + isAuthenticated() + getCredentials())
        ↑
UsernamePasswordAuthenticationToken 등 실제 구현
```

**`Principal`은 JDK에 원래 있는 타입이다.** Spring Security가 자기 `Authentication`을 **그 위에 얹은 것은 우연이 아니다.**

> **자바 표준 어휘를 재사용하면 다른 라이브러리와 말이 통한다.**

**구체적 이득**: 서블릿 API의 `HttpServletRequest.getUserPrincipal()`도 **같은 타입을 돌려준다.** Spring Security를 모르는 코드도 표준 API로 현재 사용자를 알 수 있다.

**`getName()`이 돌려주는 값**: "인증에 쓰인 주체의 이름", 즉 보통 **로그인 아이디**다. **이 값이 [[06a-updating-our-model]]의 `username` 필드와 같은 값이어야 한다는 것이 전체 설계의 전제다.**

**경계**: **항상 로그인 아이디인 것은 아니다.** OAuth 로그인에서는 **제공자가 주는 식별자**가 들어갈 수 있다 — [[08-leveraging-google-to-authenticate-users]]에서 인증 방식을 바꾸면 이 값의 의미가 달라진다.

---

## Q5. `VideoService`가 `String`을 받는 것의 이점 셋

```java
public VideoEntity create(NewVideo newVideo, String username) { ... }
                                             ↑ Authentication 이 아니다
```

| 이점 | 설명 |
|---|---|
| **계층 분리** | 서비스가 **웹·보안 프레임워크에 의존하지 않는다.** 배치 작업에서 같은 메서드를 부를 수 있다 |
| **테스트 용이** | 테스트에서 `Authentication` **목을 만들 필요 없이 문자열만** 주면 된다 |
| **책임 명확** | **"현재 사용자를 알아내는 일"은 웹 계층의 책임**이고, 서비스는 받은 값을 쓰기만 한다 |

**첫 번째가 가장 실질적이다.** 밤에 도는 배치 작업에는 HTTP 요청도 세션도 없다. `Authentication`을 요구하면 **가짜 객체를 만들어 넘겨야** 한다. 문자열이면 그냥 `"system"`을 넘긴다.

**[[../chapter-3-querying-for-data-with-spring-boot/02b-pojos-and-the-spring-programming-model|Ch3의 POJO 원칙]]이 여기서 적용된다** — 서비스가 프레임워크 타입을 몰라야 **테스트에서 프레임워크를 안 띄운다.**

**반대 선택의 유혹**: `Authentication`을 그대로 넘기면 서비스가 권한 목록도 볼 수 있어 "편하다". 하지만 그 순간 **서비스가 웹·보안에 묶인다.**

---

## Q6. 클라이언트가 정할 수 있는 값과 없는 값

```
요청 본문에서 온 것 (클라이언트가 정한다):   name, description
서버 안쪽에서 합류한 것 (정할 수 없다):      username
```

**전체 경로**:

```
브라우저 → POST /new-video (name, description, 세션 쿠키)
         → 보안 필터: 세션에서 인증 복원 → 보안 컨텍스트에 저장
         → 컨트롤러: newVideo(NewVideo, Authentication)
                     ↑ username은 요청 본문이 아니라 Authentication에서
         → 서비스: create(newVideo, "alice")
         → DB: INSERT (username=alice, name, description)
```

> **`username`이 브라우저에서 출발하지 않는다. 화살표의 출처가 다르다.**

**판별 기준**: **이 값이 요청을 파싱해서 나온 것인가, 서버가 세션에서 복원한 것인가.** 전자면 조작 가능하고 후자면 아니다.

**세션 쿠키도 클라이언트가 보낸다는 반론**: 맞다. 하지만 **쿠키 값 자체는 의미 없는 식별자**이고, 그것이 가리키는 **세션 데이터는 서버에만 있다.** bob이 쿠키를 바꿔도 **다른 사람의 세션을 맞히지 못한다.**

---

## Q7. 은행 창구 비유가 깨지는 지점

**한 사람이 여러 계좌를 가질 수 있다는 현실을 담지 못한다.**

비유는 여기까지 맞는다 — **손님은 금액만 적고, 계좌 명의는 이미 확인된 신분증에서 온다.** 손님이 남의 명의를 적을 수 없다.

**깨지는 지점 둘**:

1. **여기서는 인증된 사용자 하나에 이름 하나가 대응한다고 전제한다.** 실제 은행은 한 사람이 여러 계좌를 갖고, 그중 어느 것에 넣을지 **손님이 고른다.** 이 코드에는 그 선택지가 없다.
2. **대리 입금 같은 상황을 표현할 수 없다.** 관리자가 남을 대신해 등록하는 것 — 은행에서는 위임장으로 가능하지만, 이 코드는 **`authentication.getName()` 하나만** 쓰므로 표현할 방법이 없다.

**2번이 실무에서 실제로 필요해지는 요구다.** 그때는 "누가 실행했는가(actor)"와 "누구의 것인가(owner)"를 **분리해야** 하고, 후자에 대해서는 **다시 인가 규칙이 필요하다** — "이 사람이 저 사람을 대신할 권한이 있는가".

---

## 재출제 문항

1. 소유자를 hidden input으로 받았다. 어떻게 공격하는지 구체적으로 말해 보라.
2. `Authentication`에 애노테이션이 없어도 되는데 `String username`에는 왜 필요한가?
3. 배치 작업에서 `create()`를 부르려 한다. 파라미터가 `Authentication`이면 무엇이 곤란한가?
4. `getName()`이 로그인 아이디가 아닌 경우가 있는가?
5. 세션 쿠키도 클라이언트가 보낸다. 그럼 `username`도 조작 가능한 것 아닌가?
6. 관리자가 다른 사용자 명의로 동영상을 등록해야 한다. 이 코드로 가능한가?

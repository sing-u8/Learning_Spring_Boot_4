# 모범답안 — 08c OAuth 2 API 원격 호출하기

> **먼저 답하고 나서 열 것.** [[08c-invoking-an-oauth-2-api-remotely]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다. 이 노트는 이미 책의 조판 사고(`ℴ`)와 코드 공백(프록시 등록)을 잡아 두었다.

---

## Q1. 토큰을 손으로 붙이는 방식의 문제 넷과 각각의 해결 도구

| 문제 | 결과 | **해결 도구** |
|---|---|---|
| 토큰 확보·갱신 코드가 **호출 지점마다 반복** | API가 열 개면 **열 번 복사** | **`OAuth2ClientHttpRequestInterceptor`** |
| **만료 처리를 빠뜨리기 쉽다** | **한동안 잘 되다가 갑자기 401** | **`OAuth2AuthorizedClientManager`** (인터셉터가 위임) |
| URL과 파라미터 조립이 **문자열 작업** | **오타가 런타임에야** 드러난다 | **`@GetExchange` + `@RequestParam`** |
| **JSON 파싱이 수작업** | 응답 구조가 바뀌면 **조용히 깨진다** | **record 타입** |

**앞의 둘은 §2.2가, 뒤의 둘은 §2.3~2.4가 푼다.**

**두 번째가 가장 고약하다** — **개발·테스트에서는 토큰이 아직 유효하므로 안 드러난다.** 몇십 분 지난 뒤에야 나타나고, **재시작하면 다시 잘 된다.**

---

## Q2. 요청 인터셉터와 서블릿 필터의 방향 차이

| | **서블릿 필터** | **요청 인터셉터** |
|---|---|---|
| 대상 | **들어오는** 요청 | **나가는** 요청 |
| 하는 일 | 인증 정보를 **꺼내 검증** | 인증 정보를 **붙여 내보냄** |
| 이 장에서 | [[01-spring-security-filter-chain-foundations]] | 이 노트 |

**역할이 같되 위치가 반대다** — 하나는 서버로 들어오는 파이프라인, 하나는 `RestClient`의 나가는 파이프라인.

**같은 구조적 이점을 준다**: **횡단 관심사를 한 곳에 모은다.** 필터가 "모든 요청을 검사"하듯, 인터셉터는 **"이 `RestClient`를 지나는 모든 요청에 토큰을 붙인다."**

**둘 다 호출부가 그 존재를 모른다.** 컨트롤러가 필터를 모르듯, `YouTube` 인터페이스도 인터셉터를 모른다.

**경계**: **인터셉터는 이 `RestClient` 인스턴스에만 적용된다.** 다른 API를 부르는 별도 클라이언트를 만들면 **그쪽에도 따로 붙여야** 한다.

---

## Q3. `setClientRegistrationIdResolver`가 없으면

**여러 제공자 중 어느 토큰인지 알 수 없다.**

```java
oauth2.setClientRegistrationIdResolver(request -> "google");
```

[[08b-adding-oauth-client-to-a-spring-boot-project]]에서 본 대로 **`ClientRegistrationRepository`는 여러 등록을 이름으로 보관**한다. Facebook·GitHub·Google을 함께 지원하는 앱이라면 **토큰도 여러 벌**이다.

**인터셉터가 알아야 하는 것**: **"이 나가는 요청에는 어느 등록의 토큰을 붙여야 하는가."**

**요청 URL만 봐서는 알 수 없다** — `googleapis.com`이라고 해서 반드시 `google` 등록의 토큰인 것은 아니다(같은 제공자에 등록을 여러 개 둘 수 있다).

**여기서는 람다가 `request`를 무시하고 항상 `"google"`을 돌려준다.** **이 빈은 Google 전용**이라는 선언이다. 요청마다 다르게 정해야 한다면 `request`를 보고 판단하면 된다.

---

## Q4. `@GetMapping`과 `@GetExchange`가 거울상인 이유

| | 요청을 **받는** 쪽 | 요청을 **보내는** 쪽 |
|---|---|---|
| 애노테이션 | **`@GetMapping`** | **`@GetExchange`** |
| 뜻 | **"이 URL로 GET이 오면 이 메서드를 실행하라"** | **"이 메서드를 부르면 이 URL로 GET을 보내라"** |
| 구현 | **내가 쓴다** | **Spring이 만든다** |
| 어디서 | Chapter 2의 컨트롤러 | 이 노트 |

**두 번째 줄이 정확히 대칭이다** — URL과 메서드를 잇는다는 점은 같고, **인과의 방향이 반대**다.

**세 번째 줄도 그렇다** — 컨트롤러는 몸통을 내가 쓰고 프레임워크가 부른다. HTTP 서비스는 **몸통이 없고 프레임워크가 만든다.**

> **같은 개념을 거울에 비춘 짝이다. 하나를 이해하면 나머지가 따라온다.**

**`@RequestParam`도 마찬가지다** — **"받은 요청에서 값을 꺼내는 게 아니라 보낼 요청에 값을 붙인다."**

---

## Q5. `order`를 enum으로 둔 것이 막는 실수

**API가 받지 않는 문자열을 넘기는 실수다.**

```java
// String이면:  order = "viewCounts"   ← 오타. 컴파일 통과. 런타임 400
// enum이면:    YouTube.Sort.VIEW_COUNTS  ← 컴파일 오류
```

**enum이 허용값을 컴파일 시점에 제한한다.**

> **API 명세를 타입으로 옮기는 것이다.**

**부수 이점 둘**:
- **IDE 자동완성**이 가능한 값을 보여 준다. 문서를 안 찾아도 된다.
- **API가 값을 추가하면** enum에 상수를 더하는 것으로 **명시적으로 반영**된다. 문자열이면 아무 데서나 새 값을 쓸 수 있어 추적이 안 된다.

**[[../chapter-2-creating-web-and-api-applications-with-spring-boot/10-writing-null-safe-applications-with-jspecify|Ch2의 JSpecify]]와 같은 방향이다** — **런타임에 드러날 문제를 컴파일 시점으로 끌어온다.**

---

## Q6. record 타입 이름은 자유롭고 필드 이름은 자유롭지 않은 이유

**JSON 역직렬화가 필드 이름으로 매칭하기 때문이다.**

```json
{ "kind": "...", "etag": "...", "items": [] }
```
```java
record SearchListResponse(String kind, String etag, SearchResult[] items) {}
       ↑ 아무 이름이나         ↑ 이 이름들은 JSON 키와 같아야 한다
```

**Jackson은 JSON의 키를 record 컴포넌트 이름과 대조**해 값을 채운다. **타입 이름은 대조 대상이 아니다** — 어디에도 등장하지 않는다.

**즉 "이 타입을 무엇이라 부를지"는 우리 자유이고, "그 안의 이름"은 상대가 정한다.**

**같은 원리를 [[../chapter-2-creating-web-and-api-applications-with-spring-boot/04d-changing-the-data-through-html-forms|Ch2의 폼 바인딩]]에서도 봤다** — 폼의 `name` 속성과 record 컴포넌트 이름이 맞아야 했다. **경계를 넘는 데이터는 이름으로 매칭된다.**

**record가 잘 맞는 이유**: 이 타입들은 **데이터를 담아 옮기는 것 말고 하는 일이 없다.** 동작이 없으니 캡슐화할 상태도 없고, **응답은 한 번 만들어지면 바뀌지 않으니 불변이 맞다.**

---

## Q7. 이 절의 코드만으로 `YouTube` 빈이 만들어지는가

**만들어지지 않는다. 프록시 등록 코드가 빠져 있다.**

**`YouTube`는 인터페이스일 뿐 구현이 없다.** 누군가 **`HttpServiceProxyFactory`나 `@ImportHttpServices`로 프록시 빈을 만들어 등록**해야 [[08d-creating-an-oauth2-powered-web-app]]의 `HomeController`가 `YouTube`를 주입받을 수 있다.

**책은 그 코드를 끝내 보여 주지 않는다.**

**Boot 4의 선언 방식은 다른 곳에 있다** — [[../chapter-2-creating-web-and-api-applications-with-spring-boot/09-calling-versioned-apis-with-http-service-clients|Chapter 2 · HTTP Service Client]]에서 `@ImportHttpServices(VideoClient.class)`와 configurer 빈으로 하는 것을 봤다.

**증상**: `HomeController`를 만들면 **시작 시점에 "`YouTube` 타입 빈이 없다"**로 실패한다. 컴파일은 통과한다.

> **같은 대목의 조판 사고**: 책은 쿼리 문자열 예시를 `?channelId=<value>&maxResults=<value>ℴ=<value>`로 인쇄하는데, **`&order`가 HTML 엔티티 `&order;`로 해석돼 한 글자로 뭉개진 것**이다. 실제 파라미터 이름은 **`order`**다.

---

## Q8. 발송실 비유가 깨지는 지점

**직인이 만료된다는 점을 담지 못한다.**

비유는 여기까지 맞는다 — **사무실 우편물이 나갈 때 우체국 직인을 자동으로 찍어 주는 발송실.** 보내는 사람은 직인을 신경 쓸 필요가 없다.

**깨지는 지점**:

> **실제로는 발송실이 매번 "이 직인이 아직 유효한가"를 확인하고, 만료됐으면 새로 받아 온 뒤에 찍는다.**

> **도장통이 아니라 도장을 매번 발급받는 창구에 가깝다.**

**실제 도장은 한 번 사면 계속 쓴다.** 액세스 토큰은 **수십 분**이고, 인터셉터는 **매 요청 유효성을 확인**한다.

**"인터셉터는 첫 요청에만 토큰을 붙인다"는 오해**: **매 요청 붙인다.** 그래서 **중간에 만료돼도 다음 요청이 갱신된 토큰을 갖는다** — Q1의 두 번째 문제가 이렇게 해결된다.

**두 번째로 깨지는 점**: 발송실은 **모든 우편물**에 같은 직인을 찍지만, 인터셉터는 **이 `RestClient`를 지나는 것만** 처리한다. 다른 클라이언트는 다른 발송실이다.

---

## 재출제 문항

1. API 호출이 개발에서는 잘 되는데 한참 뒤에 401이 난다. 재시작하면 다시 된다. 무엇이 빠졌는가?
2. 서블릿 필터와 요청 인터셉터의 방향 차이를 한 문장으로 말해 보라.
3. 제공자를 둘 쓰는데 `ClientRegistrationIdResolver`를 고정값으로 뒀다. 무엇이 문제인가?
4. `@GetExchange`가 붙은 메서드의 이름을 바꿨다. 동작이 바뀌는가?
5. record의 필드 이름을 `videoId`에서 `id`로 바꿨다. 무엇이 깨지는가?
6. `HomeController`가 시작 시점에 "빈이 없다"로 실패한다. 무엇을 안 만들었는가?

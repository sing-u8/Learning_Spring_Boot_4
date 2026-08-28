# 모범답안 — 03 인자 해석기와 반환값 처리기

> **먼저 답하고 나서 열 것.** [[03-argument-resolvers-and-return-value-handlers]]의 `## 8. 스스로 확인` 열 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **10문항 모두 답이 충분**했다.

---

## Q1. `BindingResult`의 위치가 동작을 바꾸는 이유 — "짝짓기"로

**`BindingResult`는 독립적으로 해석될 수 없다. "무엇에 대한 검증 결과인가"가 있어야 의미가 생긴다.**

**대부분의 인자는 자기 완결적이다**:

```text
@PathVariable UUID id     → URI 에서 가져온다. 앞뒤 인자와 무관
@RequestParam int page    → 쿼리에서 가져온다. 무관
Locale locale             → 로케일 해석기에서. 무관

BindingResult errors      → 무엇의 검증 결과인지가 없으면 의미가 없다
```

**그래서 규칙이 위치로 정해졌다** — 공식 문서는 `Errors`·`BindingResult` 인자가 검증된 `@ModelAttribute`·`@RequestBody`·`@RequestPart` 인자 **바로 다음에 선언되어야 한다**고 명시한다.

```java
@Valid @RequestBody MaterialRequest request,
BindingResult errors,             // ← 검증 대상 바로 뒤 ✅
Locale locale
```

**비유와 그 한계 — 서류와 그 서류의 검토 의견서**: 의견서에는 **"이 서류에 대한 검토"라고 적혀 있지 않고**, **바로 앞에 붙어 있다는 사실**로만 대상이 식별된다. **사이에 다른 서류가 끼면 짝이 깨진다.**

→ **깨지는 지점**: 종이 서류라면 사람이 보고 **"아, 이건 앞앞 서류에 대한 것이겠지"라고 추론할 수 있다.** 프레임워크는 **추론하지 않는다** — **위치가 곧 규칙**이고, 어긋나면 **조용히 다른 경로로 간다.**

**왜 애노테이션으로 짝을 지정하지 않았을까** — 그럴 수도 있었지만, **검증 대상이 여럿일 때만 필요한 정보**다. 대부분은 하나뿐이므로 **위치 규칙이 더 간결하다.** 대가는 이 함정이다.

---

## Q2. 위치가 틀렸을 때 실제로 일어나는 일

**프레임워크가 "이 검증 결과를 받을 사람이 없다"고 판단하고, 검증 실패를 예외로 던진다.**

```text
@Valid @RequestBody MaterialRequest request,
Locale locale,                    ← 사이에 끼었다
BindingResult errors

잘못된 본문을 보내면
  → 검증 실패
  → request 바로 뒤에 BindingResult 가 없다
  → "받을 사람이 없다" → MethodArgumentNotValidException 을 던진다
  → errors.hasErrors() 분기에 아예 들어오지 않는다
  → 프레임워크 기본 400 응답이 나간다
```

**증상이 헷갈리는 이유**:

- **400이 나가긴 한다** — 완전히 망가진 게 아니라 **"내가 만든 400이 아닌 400"**이다
- **`errors` 파라미터는 여전히 있다** — 컴파일도 되고 선언도 그대로다
- **정상 요청은 잘 동작한다** — 검증이 통과하면 예외가 없으니 분기까지 온다

**그래서 "검증 실패 케이스에서만" 다르게 동작한다.** 테스트에 실패 케이스가 없으면 안 잡힌다.

> **파라미터 순서가 동작을 바꿨다. 자바에서 파라미터 순서는 보통 호출부만 신경 쓰면 되는 문제인데, 여기서는 프레임워크의 동작이 달라진다.**

**§6의 권고**: **`BindingResult`를 컨트롤러마다 받지 않는다.** **예외가 던져지게 두고 `@RestControllerAdvice`에서 한 곳에 모아 처리하는 편이 반복이 적다** — 그러면 이 함정 자체가 사라진다.

---

## Q3. 애노테이션 생략 시 폴백 규칙 두 갈래

**공식 문서가 한 문장으로 못박는다**:

> *"메서드 인자가 앞선 표의 어떤 값에도 매칭되지 않고 **단순 타입**(`BeanUtils#isSimpleProperty` 기준)이면 **`@RequestParam`**으로 해석된다. 그렇지 않으면 **`@ModelAttribute`**로 해석된다."*

```java
// ① 단순 타입 → @RequestParam
@GetMapping("/materials")
public List<MaterialSummary> list(int page, int size) { ... }

// ② 객체 → @ModelAttribute
@GetMapping("/materials/search")
public List<MaterialSummary> search(MaterialFilter filter) { ... }
```

**값이 없으면 어떻게 되는가 — 여기가 결정적으로 다르다**:

| 축 | **단순 타입 → `@RequestParam`** | **객체 → `@ModelAttribute`** |
|---|---|---|
| **값이 없으면** | **필수면 400** | **그냥 비어 있음** |
| 이름 매칭 | 파라미터 이름 하나 | **객체의 필드 이름들** |
| 타입 변환 실패 | 400 | 바인딩 오류로 수집 |

**②는 `@RequestParam`이 아니라 데이터 바인딩이다** — 쿼리 파라미터 이름과 `MaterialFilter`의 **필드 이름을 맞춰 채운다.** **없는 파라미터는 그냥 비어 있고 오류가 나지 않는다.**

> **필수값이 안 왔는데 200이 나가는 상황이 여기서 생긴다.**

**§5**: **"값이 없으면"의 차이가 위험하다.** 객체로 받으면 **필수값 누락이 오류가 아니라 빈 필드**가 된다.

**§6**: **폴백 규칙에 기대지 말고 애노테이션을 명시하는 편이 낫다.**

> **코드를 읽는 사람이 `BeanUtils#isSimpleProperty`의 판정을 머릿속으로 돌려야 하는 코드는 좋은 코드가 아니다.**

---

## Q4. 자유로운 시그니처를 가능하게 하는 메커니즘

**한 문장**:

> **파라미터 타입과 애노테이션을 보고 값을 만들어 주는 전략들의 목록을 두고, 파라미터 하나하나를 따로 해석한다.**

```text
서블릿    : service(HttpServletRequest, HttpServletResponse)  ← 고정
            요청 객체 하나를 받아 내가 다 꺼낸다

Spring MVC: create(@PathVariable UUID id, @RequestBody Req r, Locale l)
            파라미터마다 담당 해석기가 값을 채운다
```

**`@PathVariable`·`@RequestParam`·`@RequestBody`·`Locale`·`Principal`마다 담당자가 따로 있다.**

**이 설계가 주는 것**:

- **새로운 종류의 파라미터가 필요하면 해석기를 추가하면 된다** — 프레임워크를 안 고쳐도 된다
- **컨트롤러 코드는 필요한 것만 선언하면 된다** — 안 쓰는 `HttpServletResponse`를 받을 이유가 없다
- **타입이 문서가 된다** — 시그니처만 봐도 이 엔드포인트가 무엇을 받는지 안다

**반환값도 대칭이다** — **반환 타입마다 담당 **반환값 처리기**가 있어**, 같은 `String`이라도 **어떤 처리기가 맡느냐에 따라 뷰 이름이 되기도 하고 응답 본문이 되기도 한다**(Q6).

**[[01-dispatcherservlet-as-front-controller]]의 대조표에 대한 답이 이것이다** — "컨트롤러는 시그니처가 자유롭다"는 관찰의 **메커니즘**이 여기 있다.

---

## Q5. 핸들러 어댑터 안의 6단계

1. **메서드의 파라미터를 하나씩 순회한다** — 각각을 채워야 리플렉션으로 호출할 수 있다
2. **각 파라미터를 지원하는 **인자 해석기**(`HandlerMethodArgumentResolver`)를 찾아 값을 만든다** — **파라미터 종류마다 값을 얻는 방법이 완전히 다르다**(`@PathVariable`은 URI에서, `@RequestBody`는 본문에서, `Principal`은 보안 컨텍스트에서)
3. **채워진 인자로 메서드를 호출한다** — **여기가 우리가 쓴 코드가 실행되는 유일한 지점이다**
4. **반환값을 지원하는 **반환값 처리기**(`HandlerMethodReturnValueHandler`)를 찾아 응답으로 바꾼다**
5. **`@ResponseBody` 계열이면 이 안에서 응답을 쓰고 커밋한다** — 뷰 렌더링 단계가 필요 없으므로
6. **뷰를 쓰는 경우에는 `ModelAndView`를 `DispatcherServlet`에 돌려준다** — 뷰 해석과 렌더링은 `DispatcherServlet`의 5단계 일이다

**3번이 관점을 바꾼다** — 우리가 쓰는 컨트롤러 코드는 **여섯 단계 중 한 단계**다. 앞뒤로 프레임워크가 하는 일이 훨씬 많다.

**5번이 이 챕터에서 가장 중요한 사실 중 하나다**:

> **REST 컨트롤러의 응답은 `DispatcherServlet`으로 돌아오기 전에 이미 나가 있다.**

**이것이 Q7과 [[05-exception-resolution-and-filter-vs-interceptor]] 두 함정의 원인이다.**

---

## Q6. 같은 `String`이 뷰 이름도 되고 본문도 되는 이유

**담당 **반환값 처리기**가 다르기 때문이다.**

```java
@Controller
public class ViewController {
    @GetMapping("/hello")
    public String hello() { return "hello"; }   // → 뷰 이름. templates/hello.html
}

@RestController                 // = @Controller + @ResponseBody
public class ApiController {
    @GetMapping("/hello")
    public String hello() { return "hello"; }   // → 응답 본문 그대로 "hello"
}
```

**코드가 글자 하나 다르지 않은데 결과가 완전히 다르다.**

```text
@ResponseBody 있음 → 본문 작성 처리기가 맡는다 → 컨버터로 직렬화
@ResponseBody 없음 → 뷰 이름 처리기가 맡는다   → ViewResolver 로 간다
```

**주요 반환 타입**:

| 반환 타입 | 처리 | 뷰 렌더링 |
|---|---|---|
| `String` (`@ResponseBody` 없음) | 논리 뷰 이름 | **거친다** |
| `String` (`@ResponseBody` 있음) | 응답 본문 | 안 거침 |
| `ModelAndView` | 뷰 + 모델 | **거친다** |
| 임의 객체 (`@ResponseBody`) | 컨버터로 직렬화 | 안 거침 |
| `ResponseEntity<T>` | 상태·헤더·본문 전부 제어 | 안 거침 |
| `void` | 응답을 직접 썼거나 응답 없음 | 안 거침 |
| `Callable`, `DeferredResult` | 비동기 처리 | 나중에 결정 |

**§5의 정정**: **"뷰 리졸버가 못 찾아서 본문으로 나가는 것"이 아니다.** **애초에 다른 처리기가 맡아 뷰 단계를 거치지 않는다.** 그래서 **`@RestController`만 쓰는 프로젝트에서는 `ViewResolver` 설정이 아무 영향이 없다.**

**§6**: **반환 타입을 `Object`로 두지 않는다.** **어느 처리기가 맡을지 컴파일 시점에 알 수 없어진다.**

---

## Q7. `@ResponseBody`일 때 응답이 커밋되는 시점과 그 중요성

**어댑터 안, 즉 5단계에서 커밋된다 — `DispatcherServlet`으로 돌아오기 전이다.**

```text
DispatcherServlet
  4단계 어댑터 호출
        ├ 인자 해석
        ├ 컨트롤러 메서드 실행
        ├ 반환값 처리기 → 본문 작성 → 커밋 ★ 여기
        └ null 반환
  5단계 모델이 없으므로 뷰 렌더링 건너뜀
  (인터셉터 postHandle 은 이 근처에서 불린다 — 이미 늦었다)
```

**왜 중요한가 — 커밋 후에는 상태 코드도 헤더도 바꿀 수 없다.**

**§5**: **이것이 [[05-exception-resolution-and-filter-vs-interceptor]]에서 다루는 두 함정의 원인이다**:

| 함정 | 내용 |
|---|---|
| **인터셉터 `postHandle`의 무력함** | 헤더를 붙여도 **이미 나간 뒤**라 반영되지 않는다 |
| **응답 도중 예외를 오류 응답으로 못 바꿈** | **상태 코드가 이미 200으로 나갔다** |

**뷰 컨트롤러에서는 다르다** — 뷰 렌더링이 5단계에서 일어나므로 **`postHandle` 시점에는 아직 응답이 안 나갔다.** 그래서 **같은 인터셉터 코드가 뷰 컨트롤러에서는 동작한다**(c3-05 Q2).

**이 시점 차이 하나가 "왜 내 코드가 어떤 컨트롤러에서만 동작하는가"를 설명한다.**

---

## Q8. `@RequestBody` 해석기가 위임하는 일

**본문의 실제 역직렬화다 — **메시지 컨버터**가 한다.**

> **인자 해석기는 "본문을 이 타입으로 만들어 줘"라고 위임할 뿐, 실제 역직렬화는 컨버터가 한다.**

```text
@RequestBody MaterialRequest request

인자 해석기 (RequestResponseBodyMethodProcessor)
  ├ Content-Type 을 읽는다
  ├ MaterialRequest 를 만들 수 있는 컨버터를 찾는다
  └ 컨버터에게 위임한다 ─────▶ MappingJackson2HttpMessageConverter
                                 └ Jackson 이 JSON → 객체
```

**층이 나뉘어 있는 이득**:

- **같은 컨버터를 `@ResponseBody`도 쓴다** — 읽기와 쓰기가 같은 목록을 공유한다
- **컨버터를 추가하면 모든 엔드포인트가 그 형식을 지원한다** — 인자 해석기를 고칠 필요가 없다
- **`Content-Type`에 따른 선택이 한곳에 모인다**

**본문을 다루는 다른 인자들도 같은 경로다**:

| 인자 | 컨버터 경유 |
|---|---|
| `@RequestBody` | ✅ |
| `HttpEntity<B>` | ✅ (헤더 + 본문) |
| `@RequestPart` | ✅ (멀티파트 파트) |

**실패하면 415 또는 400**이고, **415의 흔한 원인이 "읽을 컨버터가 없음"이다**(c3-02 Q6).

**컨버터 쪽 상세는 [[04-httpmessageconverter-and-content-negotiation]]에 있다.**

---

## Q9. `HttpSession` 인자를 선언하는 것의 부작용

**세션이 없으면 만들어서 준다.**

공식 문서의 단서: **`HttpSession`은 절대 `null`이 아니며**, 따라서 **이 인자를 선언하는 것만으로 세션이 강제로 만들어진다.**

```text
@GetMapping("/materials")
public List<X> list(HttpSession session) { ... }
                    ↑ 이 선언만으로

요청 → 세션이 없다 → 만든다 → JSESSIONID 쿠키가 나간다
```

**무상태 REST API에서 무슨 문제인가**:

| 문제 | 내용 |
|---|---|
| **메모리** | 요청마다 세션이 생성될 수 있다 |
| **무상태 위반** | 클라이언트에 `JSESSIONID` 쿠키가 생긴다 |
| **확장성** | 세션 클러스터링이 필요해진다 |
| **보안 검토 대상** | 안 쓰는 세션이 존재한다 |

**§5**: **`null`이 아니라는 보장은 편리하지만 부작용이 있다.**

**대안**(§5): **읽기만 하려면 `@SessionAttribute`나 `WebRequest`를 쓴다.**

**두 번째 단서도 있다** — **`synchronizeOnSession=true`가 아니면 스레드 안전하지 않다.** 같은 세션에 동시 요청이 오면 경쟁 상태가 생길 수 있다.

**§6**: **무상태 API에서 `HttpSession`을 선언하지 않는다.**

**이 항목이 알려 주는 일반 원칙** — **인자를 선언하는 것 자체가 부작용을 가질 수 있다.** 대부분의 인자는 "읽기만" 하지만, `HttpSession`처럼 **없으면 만드는** 것이 있다.

---

## Q10. `Resolver`와 `Handler` 접미사의 어법

**`Resolver`(해석기) — "미정 상태를 확정 상태로 바꾸는 것"**

```text
파라미터: 선언만 있고 값이 없다  →  해석기가 요청에서 값을 찾아 확정한다
```

**같은 어법의 것들**:

| 이름 | 무엇을 확정하나 |
|---|---|
| `HandlerMethodArgumentResolver` | **파라미터 → 값** |
| `ViewResolver` | **뷰 이름 → 실제 뷰** |
| `LocaleResolver` | **요청 → 로케일** |
| `HandlerExceptionResolver` | **예외 → 응답/뷰** |

**전부 "A라는 미정 상태에서 B라는 확정 상태로"** 바꾼다.

**`Handler`(처리기) — "무언가를 맡아 처리하는 전략"**

**같은 단어지만 층이 다르다**:

| 이름 | 무엇을 처리하나 |
|---|---|
| **핸들러** ([[02-handlermapping-and-handleradapter]]) | **요청**을 처리하는 것 |
| `HandlerMethodReturnValueHandler` | **반환값**을 처리하는 것 |

> **Spring에서 `Handler`는 특정 개념이 아니라 "무언가를 맡아 처리하는 전략"을 가리키는 일반 접미사로 쓰인다.**

**그래서 `HandlerMethodReturnValueHandler`처럼 `Handler`가 두 번 나오는 이름이 생긴다** — "**핸들러 메서드**의 **반환값**을 처리하는 **핸들러**". 길지만 정확하다.

**이 어법을 알면 처음 보는 클래스 이름도 읽힌다**:

```text
XxxResolver  → "Xxx 를 확정하는 것". 무엇에서 무엇으로 바꾸는지 물어보면 된다
XxxHandler   → "Xxx 를 맡아 처리하는 것". 무엇을 받아 무엇을 하는지 물어보면 된다
XxxAdapter   → "규약을 변환하는 것" (c3-02)
XxxPostProcessor → "이미 만들어진 것을 후처리하는 것" (c1-02)
```

**Spring의 클래스 이름은 대개 이런 접미사 규약을 지킨다.** 규약을 알면 **이름만으로 역할을 짐작**할 수 있고, 그게 이 프레임워크를 읽는 속도를 바꾼다.

---

## 재출제 문항

1. `BindingResult`를 검증 대상 바로 뒤가 아닌 곳에 뒀다. 무슨 일이 나고, 어떤 요청에서만 드러나는가?
2. 대부분의 인자와 달리 `BindingResult`가 위치에 의존하는 이유는?
3. 애노테이션 없이 `int page`와 `MaterialFilter filter`를 받았다. 각각 어떻게 해석되고, 값이 없으면?
4. 컨트롤러가 자유로운 시그니처를 갖는 메커니즘을 한 문장으로.
5. 어댑터 안의 6단계 중 내가 쓴 코드는 몇 번인가?
6. `@RestController`에서 `return "hello"`가 뷰를 안 찾는 이유는? "리졸버가 못 찾아서"인가?
7. `@ResponseBody` 응답은 언제 커밋되는가? 그 사실이 무엇을 불가능하게 하는가?
8. `@RequestBody`가 JSON을 객체로 만드는 일을 직접 하는가?
9. 무상태 API에 `HttpSession` 인자를 선언했다. 무엇이 생기는가?
10. 처음 보는 `XxxResolver` 클래스를 만났다. 무엇을 물어보면 역할을 알 수 있는가?

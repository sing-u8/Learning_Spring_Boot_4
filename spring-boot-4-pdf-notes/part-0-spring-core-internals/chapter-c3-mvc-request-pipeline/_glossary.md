# chapter-c3 용어집

> HTTP 요청 하나가 컨트롤러 메서드에 도달했다가 응답이 되어 나가기까지의 말들. 정의는 여기 한 곳에만 둔다.
>
> `서블릿`·`서블릿 컨테이너`·`DispatcherServlet`의 서블릿 층 정의는 `part-0-web-foundations/chapter-w1-servlet-and-containers`의 용어집이 원본이다. 이 챕터는 그 `DispatcherServlet` **안에서** 무슨 일이 일어나는지를 다룬다. `빈 후처리기`·`프록시` 관련 용어는 c1·c2의 용어집이 원본이다.

## 프런트-컨트롤러 (front controller)

모든 요청을 **하나의 중앙 진입점**이 받아, 공통 알고리즘을 수행한 뒤 실제 처리를 개별 컴포넌트에 위임하는 웹 아키텍처 패턴.

공식 문서가 Spring MVC의 설계를 이 패턴으로 규정한다 — 중앙 `Servlet`인 `DispatcherServlet`이 **요청 처리를 위한 공유 알고리즘**을 제공하고, 실제 작업은 설정 가능한 위임 컴포넌트들이 수행한다.

핵심은 "공유 알고리즘"이라는 표현이다. 요청마다 달라지는 부분(어느 핸들러인가, 어떻게 직렬화하는가)은 위임하고, 모든 요청에 공통인 뼈대(핸들러 찾기 → 실행 → 응답 쓰기 → 예외 처리)만 중앙이 갖는다.

- 처음 나온 곳: [[01-dispatcherservlet-as-front-controller]]
- 섞이는 말: [[특수-빈-타입]]

## 특수-빈-타입 (special bean types)

`DispatcherServlet`이 자기 일을 위임하기 위해 컨텍스트에서 찾는 정해진 타입의 빈들.

공식 문서가 표로 제시하는 항목은 `HandlerMapping`, `HandlerAdapter`, `HandlerExceptionResolver`, `ViewResolver`, `LocaleResolver`/`LocaleContextResolver`, `MultipartResolver`, `FlashMapManager`다.

이 목록이 곧 **Spring MVC의 확장 지점 목록**이다. 각 타입의 빈을 직접 등록하면 그 단계의 동작을 바꿀 수 있고, 등록하지 않으면 Boot의 자동 구성이 기본값을 넣는다.

- 처음 나온 곳: [[01-dispatcherservlet-as-front-controller]]
- 섞이는 말: [[프런트-컨트롤러]], [[핸들러-매핑]], [[핸들러-어댑터]]

## 핸들러 (handler)

요청을 실제로 처리할 대상. `@RequestMapping` 메서드일 수도 있고, 정적 리소스 처리기나 다른 형태일 수도 있다.

"컨트롤러"라고 하지 않고 "핸들러"라고 부르는 데 이유가 있다. `DispatcherServlet`은 처리 대상이 애노테이션 컨트롤러인지, 함수형 라우터인지, 정적 리소스 핸들러인지 **알 필요가 없도록** 설계됐다. 그 무지를 유지해 주는 것이 [[핸들러-어댑터]]다.

- 처음 나온 곳: [[02-handlermapping-and-handleradapter]]
- 섞이는 말: [[핸들러-매핑]], [[핸들러-어댑터]], [[실행-체인]]

## 핸들러-매핑 (HandlerMapping)

요청을 [[핸들러]]에, 그리고 전·후처리를 위한 **인터셉터 목록**과 함께 매핑하는 전략.

공식 문서의 설명대로 매핑 기준은 구현체마다 다르다. 주요 구현이 둘이다 — `RequestMappingHandlerMapping`(`@RequestMapping` 애노테이션 메서드를 지원)과 `SimpleUrlHandlerMapping`(URI 경로 패턴과 핸들러의 명시적 등록을 관리).

**"핸들러 + 인터셉터"를 함께 돌려준다**는 점이 중요하다. 어떤 인터셉터가 적용될지는 컨트롤러가 정하는 것이 아니라 이 단계에서 정해진다.

- 처음 나온 곳: [[02-handlermapping-and-handleradapter]]
- 섞이는 말: [[핸들러-어댑터]], [[실행-체인]], [[핸들러-인터셉터]]

## 핸들러-어댑터 (HandlerAdapter)

`DispatcherServlet`이 **핸들러를 어떻게 호출하는지 몰라도 되도록** 실제 호출을 대신해 주는 전략.

공식 문서가 목적을 직접 밝힌다 — 애노테이션 컨트롤러를 호출하려면 애노테이션을 해석해야 하는데, `HandlerAdapter`의 **주된 목적은 `DispatcherServlet`을 그런 세부 사항으로부터 차단하는 것**이다.

이름 그대로 어댑터 패턴이다. `DispatcherServlet`은 "이 핸들러를 실행해 달라"고만 말하고, 어댑터가 그 핸들러의 종류에 맞는 호출 방식(인자 해석, 반환값 처리 등)을 안다.

- 처음 나온 곳: [[02-handlermapping-and-handleradapter]]
- 섞이는 말: [[핸들러-매핑]], [[인자-해석기]], [[반환값-처리기]]

## 실행-체인 (HandlerExecutionChain)

[[핸들러-매핑]]이 돌려주는, **핸들러 하나와 그에 적용될 [[핸들러-인터셉터]] 목록**을 묶은 것.

공식 문서의 처리 순서 서술에서 "핸들러와 연결된 실행 체인(전처리기, 후처리기, 컨트롤러)이 실행된다"고 표현되는 대상이다.

체인이라는 이름대로 인터셉터들이 핸들러를 감싸고 있고, 앞에서부터 `preHandle`이 실행되어 하나라도 `false`를 반환하면 나머지와 핸들러가 건너뛰어진다.

- 처음 나온 곳: [[02-handlermapping-and-handleradapter]]
- 섞이는 말: [[핸들러-매핑]], [[핸들러-인터셉터]]

## 인자-해석기 (HandlerMethodArgumentResolver)

컨트롤러 메서드의 **파라미터 하나를 실제 값으로 채워 주는** 전략.

컨트롤러 메서드가 유연한 시그니처를 가질 수 있는 이유가 이것이다. `@PathVariable`, `@RequestParam`, `@RequestHeader`, `@CookieValue`, `@RequestBody`, `@ModelAttribute`, `HttpSession`, `Principal`, `Locale` 등 지원되는 타입마다 담당 해석기가 있다.

애노테이션이 없을 때의 규칙을 공식 문서가 명시한다 — 앞선 어떤 항목에도 매칭되지 않은 인자가 **단순 타입**(`BeanUtils#isSimpleProperty` 기준)이면 `@RequestParam`으로, 아니면 `@ModelAttribute`로 해석된다. `@RequestParam`을 안 붙여도 동작하는 이유가 이 폴백 규칙이다.

- 처음 나온 곳: [[03-argument-resolvers-and-return-value-handlers]]
- 섞이는 말: [[반환값-처리기]], [[메시지-컨버터]], [[핸들러-어댑터]]

## 반환값-처리기 (HandlerMethodReturnValueHandler)

컨트롤러 메서드의 **반환값을 응답으로 바꾸는** 전략.

같은 `String`을 반환해도 `@ResponseBody`가 있으면 본문에 그대로 쓰이고, 없으면 뷰 이름으로 해석된다. 그 분기를 만드는 것이 이 처리기들이다. `ResponseEntity`, `ModelAndView`, `void`, `Callable`, `DeferredResult` 등 반환 타입마다 담당자가 있다.

**응답이 언제 쓰이는가**를 결정하는 것도 이 층이다. `@ResponseBody`·`ResponseEntity`의 경우 응답이 [[핸들러-어댑터]] 안에서 쓰이고 커밋되므로, 그 뒤에 오는 [[핸들러-인터셉터]]의 `postHandle`에서는 이미 늦다.

- 처음 나온 곳: [[03-argument-resolvers-and-return-value-handlers]]
- 섞이는 말: [[인자-해석기]], [[메시지-컨버터]]

## 메시지-컨버터 (HttpMessageConverter)

HTTP 본문(바이트 스트림)과 자바 객체를 **양방향으로 변환**하는 전략.

`@RequestBody`·`HttpEntity`·`@RequestPart` 인자의 본문이 이 구현체들을 통해 선언된 타입으로 역직렬화되고, `@ResponseBody`·`ResponseEntity`의 반환값이 같은 방식으로 직렬화된다.

각 컨버터는 자기가 다룰 수 있는 **미디어 타입 목록**을 갖는다. 그래서 "어떤 컨버터를 쓸 것인가"는 [[콘텐트-협상]]의 결과에 달려 있다. JSON이 기본처럼 보이는 것은 Jackson 컨버터가 클래스패스에 있을 때 자동 등록되기 때문이지, 프레임워크가 JSON을 특별 취급해서가 아니다.

- 처음 나온 곳: [[04-httpmessageconverter-and-content-negotiation]]
- 섞이는 말: [[콘텐트-협상]], [[반환값-처리기]]

## 콘텐트-협상 (content negotiation)

클라이언트가 원하는 표현 형식과 서버가 만들 수 있는 형식을 맞춰 **응답 미디어 타입을 결정**하는 과정.

공식 문서 기준으로 Spring MVC는 **기본적으로 `Accept` 헤더만 확인한다.** 쿼리 파라미터나 경로 확장자(`.json`)를 쓰도록 설정할 수도 있지만, 문서는 URL 기반 해석이 꼭 필요하다면 **경로 확장자보다 쿼리 파라미터 전략을 쓰라**고 권한다.

`@RequestMapping`의 `produces`·`consumes` 속성도 이 협상에 참여한다 — 서버가 만들 수 있는 것과 받을 수 있는 것을 선언하는 자리다.

- 처음 나온 곳: [[04-httpmessageconverter-and-content-negotiation]]
- 섞이는 말: [[메시지-컨버터]]

## 예외-해석기 (HandlerExceptionResolver)

요청 처리 중 발생한 예외를 **대체 처리(대개 오류 응답)로 바꾸는** 전략.

공식 문서 표현으로, 요청 매핑 중이나 요청 핸들러에서 예외가 발생하면 `DispatcherServlet`이 `HandlerExceptionResolver` 빈들의 **체인**에 위임한다.

반환값 계약이 체인 동작을 만든다 — 오류 뷰를 가리키는 `ModelAndView`, 해석기 안에서 처리됐다면 빈 `ModelAndView`, 그리고 **미해결이면 `null`**을 반환해 다음 해석기가 시도하게 한다. 끝까지 남으면 서블릿 컨테이너로 올라간다.

내장 구현은 넷이다 — `SimpleMappingExceptionResolver`(예외 클래스명 → 오류 뷰 이름), `DefaultHandlerExceptionResolver`(Spring MVC가 던지는 예외 → HTTP 상태 코드), `ResponseStatusExceptionResolver`(`@ResponseStatus` 해석), `ExceptionHandlerExceptionResolver`(`@ExceptionHandler` 메서드 호출).

- 처음 나온 곳: [[05-exception-resolution-and-filter-vs-interceptor]]
- 섞이는 말: [[핸들러-인터셉터]], [[서블릿-필터]]

## 서블릿-필터 (servlet filter)

서블릿 명세가 정의하는, **`DispatcherServlet`보다 바깥**에서 요청·응답을 감싸는 컴포넌트.

Spring이 아니라 서블릿 컨테이너가 관리하는 층이라, `DispatcherServlet`이 아직 실행되지 않은 시점에도 동작한다. 그래서 요청 래핑, 인코딩 설정, 인증처럼 **핸들러가 정해지기 전에** 해야 하는 일에 맞다.

공식 문서가 보안 계층에 대해 방향을 제시한다 — [[핸들러-인터셉터]]는 애노테이션 컨트롤러의 경로 매칭과 불일치할 가능성이 있어 보안 계층으로 적합하지 않으며, Spring Security를 쓰거나 **서블릿 필터 체인에 통합된 유사한 방식을 가능한 한 이른 시점에** 적용할 것을 권한다.

- 처음 나온 곳: [[05-exception-resolution-and-filter-vs-interceptor]]
- 섞이는 말: [[핸들러-인터셉터]], [[프런트-컨트롤러]]

## 핸들러-인터셉터 (HandlerInterceptor)

`DispatcherServlet` **안쪽**에서, 핸들러가 정해진 뒤에 그 실행을 앞뒤로 감싸는 컴포넌트.

콜백이 셋이다.

- `preHandle` — 실제 핸들러 실행 **전**. `boolean`을 반환하며, `false`면 나머지 실행 체인이 건너뛰어지고 핸들러가 호출되지 않는다.
- `postHandle` — 핸들러 실행 **후**.
- `afterCompletion` — 요청 전체가 끝난 **후**.

`postHandle`에 중요한 함정이 있다. 공식 문서가 명시한다 — `@ResponseBody`와 `ResponseEntity` 컨트롤러 메서드의 경우 **응답이 `HandlerAdapter` 안에서 쓰이고 커밋된 뒤에 `postHandle`이 호출된다.** 그래서 헤더 추가 같은 응답 변경을 하기에는 이미 늦다. 대안으로 문서는 `ResponseBodyAdvice`를 권한다.

[[서블릿-필터]]와 달리 **핸들러가 무엇인지 알 수 있다**는 것이 이 층의 이점이다.

- 처음 나온 곳: [[05-exception-resolution-and-filter-vs-interceptor]]
- 섞이는 말: [[서블릿-필터]], [[실행-체인]], [[반환값-처리기]]

# chapter-c3 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다.
>
> 이 챕터가 존재하는 이유: *Learning Spring Boot 4*는 컨트롤러를 **쓰는 법**을 가르치지만, `@GetMapping`이 붙은 메서드가 **누구에 의해 언제 어떻게 호출되는지**는 다루지 않는다. `DispatcherServlet`·`HandlerMapping`·`HandlerAdapter`·`HttpMessageConverter`는 책에 나오지 않거나 이름만 스친다. 그런데 406·415·인터셉터 헤더 누락 같은 실무 문제는 전부 그 층에서 난다.

## 1. 1차 소스

> 아래 URL은 이 챕터를 쓰면서 **실제로 열어 대조한 페이지**다. 내 설명을 믿지 말고 이 주소에서 직접 확인할 수 있게 남긴다.

| 소스 | 정확한 위치 | 역할 |
|---|---|---|
| Framework Ref — DispatcherServlet | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet.html` | 프런트 컨트롤러 정의, "공유 알고리즘" 표현 |
| Framework Ref — Special Bean Types | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet/special-bean-types.html` | 특수 빈 타입 7종 표, `HandlerAdapter`의 "차단(shield)" 목적 |
| Framework Ref — Processing | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet/sequence.html` | 요청 처리 6단계 전문, "어댑터 안에서 렌더링될 수 있다"는 단서 |
| Framework Ref — Interception | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet/handlermapping-interceptor.html` | 3콜백, **`postHandle`이 커밋 이후라는 경고**, `ResponseBodyAdvice` 대안, 보안 계층 부적합 |
| Framework Ref — Exceptions | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-servlet/exceptionhandlers.html` | 예외 해석기 체인, 내장 4종, 반환값 계약, 컨테이너 ERROR 디스패치 |
| Framework Ref — Method Arguments | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller/ann-methods/arguments.html` | 지원 인자 표, 단순 타입 폴백 규칙, `BindingResult` 위치 규칙, `@RequestBody`의 컨버터 경유 |
| Framework Ref — Content Types | `https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-config/content-negotiation.html` | **기본은 `Accept` 헤더만**, 경로 확장자보다 쿼리 파라미터 권고 |
| **Javadoc — `DefaultHandlerExceptionResolver`** | `https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/mvc/support/DefaultHandlerExceptionResolver.html` | **415·406의 문서화된 원인이 "메시지 컨버터를 찾지 못함"이라는 것** (2026-08-28 정정 근거) |

## 2. 책 트랙과의 관계

| 책의 서술 | 이 챕터가 채우는 것 |
|---|---|
| Ch. 2 — `@GetMapping`으로 컨트롤러를 만든다 | 그 메서드를 **누가 찾아서 어떻게 호출하는지**, 매핑 테이블이 언제 만들어지는지 |
| Ch. 2 — 컨트롤러가 객체를 반환하면 JSON이 나간다 | 그 변환의 주체가 메시지 컨버터이고, 형식은 **협상 결과**라는 것 |
| Ch. 2 — 뷰 템플릿을 반환한다 | 같은 `String` 반환이 뷰 이름도 되고 본문도 되는 분기의 원리 |
| Ch. 3 — 예외를 던지면 오류 응답이 나간다 | 예외 해석기 체인이 순서대로 시도하는 구조 |
| Ch. 4 — 보안을 필터로 건다 | 필터와 인터셉터가 **다른 층**이라는 것, 왜 보안이 필터 쪽인지 |
| 책에 없음 — `HandlerMapping`·`HandlerAdapter`·인자 해석기·반환값 처리기·`HttpMessageConverter` | 이 챕터의 핵심 |

## 3. 주제 → 노트 매핑

| 주제 | 출처 | 정리 노트 | 상태 |
|---|---|---|---|
| 프런트 컨트롤러 패턴과 "공유 알고리즘" | Framework Ref · DispatcherServlet (원문) | [[01-dispatcherservlet-as-front-controller]] | 반영 — 1절·2.3 |
| 요청 처리 6단계 | Framework Ref · Processing (원문 전문) | [[01-dispatcherservlet-as-front-controller]] | 반영 — 2.1·3절 |
| 특수 빈 타입 7종과 각 책임 | Framework Ref · Special Bean Types (원문 표) | [[01-dispatcherservlet-as-front-controller]] | 반영 — 2.2 |
| 애노테이션 컨트롤러는 어댑터 안에서 렌더링될 수 있다 | Framework Ref · Processing (원문 단서) | [[01-dispatcherservlet-as-front-controller]] | 반영 — 2.1·5절 |
| 컨트롤러는 서블릿이 아니라는 구분 | 위 구조에서 도출 | [[01-dispatcherservlet-as-front-controller]] | 반영 — 1절·5절 |
| 서블릿 컨테이너와 Spring 컨테이너의 구분 | w1 챕터와의 층 정리 | [[01-dispatcherservlet-as-front-controller]] | 반영 — 5절 |
| `HandlerMapping`의 책임과 두 주요 구현 | Framework Ref · Special Bean Types (원문) | [[02-handlermapping-and-handleradapter]] | 반영 — 2.1 |
| `HandlerAdapter`의 "차단(shield)" 목적 | Framework Ref · Special Bean Types (원문) | [[02-handlermapping-and-handleradapter]] | 반영 — 1절·2.1 |
| 매핑 테이블이 시작 시점에 만들어진다는 사실 | `Ambiguous mapping` 기동 실패에서 도출 | [[02-handlermapping-and-handleradapter]] | 반영 — 1절·2.2·3절 |
| 매핑 조건이 경로만이 아니라는 것 | Framework Ref · 매핑 조건 속성들 | [[02-handlermapping-and-handleradapter]] | 반영 — 2.3 |
| 실행 체인 = 핸들러 + 인터셉터 목록 | Framework Ref · Processing·Special Bean Types | [[02-handlermapping-and-handleradapter]] | 반영 — 2.4 |
| 404·405·415·406의 신호 구분 | 매핑 조건 구조에서 도출 | [[02-handlermapping-and-handleradapter]] | 반영 — 5절 |
| 어댑터가 `null`을 반환하는 경우 | Framework Ref · Processing 5단계 | [[02-handlermapping-and-handleradapter]] | 반영 — 2.2·5절 |
| 컨트롤러 시그니처가 유연한 이유 | Framework Ref · Method Arguments | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 1절·2.1 |
| **`BindingResult` 위치 규칙** | Framework Ref · Method Arguments (원문 명시) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 1절·3절 |
| 단순 타입 폴백 규칙 | Framework Ref · Method Arguments (원문) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.2·5절 |
| 주요 인자 해석기와 값의 출처 | Framework Ref · Method Arguments (표) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.3 |
| `HttpSession` 인자가 `null`이 아니라는 것 | 같음 (원문) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.3·5절 |
| `@RequestBody`가 컨버터를 경유한다는 명시 | 같음 (원문) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.3 |
| 같은 `String` 반환의 두 갈래 | Framework Ref · Return Values | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.4 |
| 응답이 어댑터 안에서 커밋된다는 사실 | Framework Ref · Interception (원문) | [[03-argument-resolvers-and-return-value-handlers]] | 반영 — 2.1·5절 |
| 메시지 컨버터의 양방향 동작 | Framework Ref · Method Arguments·Return Values | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 2.1 |
| **기본은 `Accept` 헤더만 확인한다** | Framework Ref · Content Types (원문) | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 2.2 |
| 경로 확장자보다 쿼리 파라미터 권고 | 같음 (원문) | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 2.3 |
| `ContentNegotiationConfigurer` 설정 형태 | 같음 (원문 예제) | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 2.3 |
| `Accept: */*`에서 등록 순서가 결과를 바꾼다 | 협상 규칙에서 도출 | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 1절·3절 |
| `produces`로 형식을 고정하는 방법 | 매핑 조건 + 협상 규칙 종합 | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 2.4 |
| 415와 406의 방향 구분 | 읽기/쓰기 구조에서 도출 | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 5절 |
| 406과 500의 구분(선택 실패 vs 직렬화 실패) | 같음 | [[04-httpmessageconverter-and-content-negotiation]] | 반영 — 5절 |
| **`postHandle`이 커밋 이후라는 경고** | Framework Ref · Interception (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 1절·2.2 |
| `ResponseBodyAdvice` 대안 | 같음 (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 1절·3절 |
| 인터셉터 3콜백과 `preHandle`의 `false` 의미 | 같음 (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.2 |
| 인터셉터가 보안 계층에 부적합하다는 경고 | 같음 (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.3·6절 |
| 필터와 인터셉터의 위치·능력 차이 | 서블릿 명세 + Framework Ref 종합 | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.1·5절 |
| 예외 해석기 체인과 반환값 계약 | Framework Ref · Exceptions (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.4·3절 |
| 내장 예외 해석기 4종 | 같음 (원문 표) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.4 |
| `order`가 클수록 나중이라는 규칙 | 같음 (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.4 |
| 컨테이너 ERROR 디스패치와 `/error` | 같음 (원문) | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.4·3절 |
| 커밋 이후에는 예외 해석도 무력하다 | 위 사실들의 종합 | [[05-exception-resolution-and-filter-vs-interceptor]] | 반영 — 2.5 |
| `ViewResolver`와 뷰 기술(Thymeleaf 등) | Framework Ref · View Resolution | — | 미반영 — 특수 빈 타입 표에 위치만 잡아 뒀다. REST API 중심 학습에서는 쓰이지 않는 단계이고, 필요해지면 별도 주제로 다루는 편이 낫다 |
| `LocaleResolver`·`MultipartResolver`·`FlashMapManager`의 상세 | Framework Ref · 각 절 | — | 미반영 — 6단계 안의 위치와 책임만 표로 잡아 뒀다. 셋 다 독립적인 기능 주제이지 파이프라인 이해의 필수 고리가 아니다 |
| 비동기 처리(`Callable`·`DeferredResult`·SSE) | Framework Ref · Asynchronous Requests | — | 미반영 — 반환 타입 표에 존재만 표시했다. 서블릿 비동기 모델이 별도 전제라 동기 파이프라인을 먼저 굳힌 뒤가 맞는 순서다 |
| 함수형 엔드포인트(`RouterFunction`) | Framework Ref · Functional Endpoints | — | 미반영 — 애노테이션 기반과 별개 메커니즘이다. 경계만 6절에 표시했다 |

## 4. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "컨트롤러가 서블릿이다" | 서블릿은 `DispatcherServlet` 하나. 컨트롤러는 그것이 호출하는 평범한 메서드다 | 01 — 1절·5절 |
| "요청마다 애노테이션을 읽어 매핑한다" | 매핑 테이블은 **시작 시점에 한 번** 만들어진다 | 02 — 1절·2.2 |
| "경로가 겹치면 먼저 등록된 게 이긴다" | 기동이 **실패한다**(`Ambiguous mapping`) | 02 — 1절 |
| "파라미터 순서는 상관없다" | `BindingResult`는 검증 대상 **바로 뒤**여야 한다 | 03 — 1절 |
| "`@RequestParam`은 생략해도 똑같다" | 단순 타입만 그렇다. 객체면 `@ModelAttribute`가 되어 필수값 누락이 오류가 아니게 된다 | 03 — 2.2·5절 |
| "`@RestController`는 JSON을 반환한다" | 본문에 직접 쓴다는 뜻일 뿐. 형식은 협상 결과다 | 04 — 5절 |
| "Accept 헤더를 안 보내면 JSON이 온다" | `*/*`이면 **등록 순서가 이긴다.** 의존성 하나로 바뀐다 | 04 — 1절·3절 |
| "406은 서버 오류다" | 요청한 형식을 만들 수 있는 컨버터가 없다는 뜻. 400번대가 맞다 | 04 — 5절 |
| "인터셉터 `postHandle`에서 응답을 고칠 수 있다" | REST API에서는 이미 커밋된 뒤라 무시된다 | 05 — 1절 |
| "인증은 인터셉터로 구현한다" | 공식 문서가 매핑 불일치 위험을 이유로 권하지 않는다 | 05 — 2.3 |
| "`@RestControllerAdvice`가 모든 예외를 잡는다" | 필터에서 난 예외는 파이프라인 밖이라 못 잡는다 | 05 — 5절 |

## 5. 아직 다루지 않은 것

| 주제 | 왜 보류인가 |
|---|---|
| `ViewResolver`와 뷰 기술 | REST 중심 학습에서 쓰이지 않는 단계. 위치만 잡아 뒀다 |
| `LocaleResolver`·`MultipartResolver`·`FlashMapManager` 상세 | 독립 기능 주제이지 파이프라인 이해의 필수 고리가 아니다 |
| 비동기 요청 처리 | 서블릿 비동기 모델이 별도 전제다. 동기 파이프라인을 먼저 굳힌다 |
| 함수형 엔드포인트 | 애노테이션 기반과 별개 메커니즘. 경계만 표시했다 |
| WebFlux의 `DispatcherHandler` | 실행 모델이 달라 섞어 설명하면 오히려 해롭다 |
| Spring Security 필터 체인의 내부 순서 | 책 Ch. 4의 주제이고, 이 챕터는 "필터 층이라는 위치"까지만 다룬다 |
| CORS 처리의 상세 | 필터·인터셉터 선택 기준 표에 위치만 잡아 뒀다 |

## 6. 정정 이력

| # | 위치 | 처음에 쓴 것 | 실제 | 근거 |
|---|---|---|---|---|
| 1 | `02` §5 | 405 설명에 이어 **"같은 논리로 415는 `consumes`, 406은 `produces` 조건이 안 맞은 신호"**라고 썼다 | **415·406은 원인이 둘이다.** 매핑 조건(`consumes`/`produces`) 불일치와 **컨버터 선택 실패**가 같은 예외·같은 상태 코드로 수렴한다. 오히려 공식 문서가 명시하는 쪽은 컨버터다 | Javadoc `DefaultHandlerExceptionResolver` — 415 처리는 *"PUT 또는 POST된 컨텐츠에 대해 **메시지 컨버터를 찾지 못한** 경우"*, 406 처리는 *"클라이언트가 `Accept`로 표현한 요구에 **맞는 메시지 컨버터를 찾지 못한** 경우"* · `https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/servlet/mvc/support/DefaultHandlerExceptionResolver.html` |

**왜 위험했나.** 405는 정말로 매핑 단계 전용 신호라, 그 흐름을 따라 415·406까지 "같은 논리로" 묶은 것이 오류의 형태였다. 이 서술을 믿고 415를 진단하면 `consumes`부터 뒤지게 되는데, **대부분의 프로젝트에는 `consumes` 선언 자체가 없다.** 그러면 원인을 못 찾고 막힌다. 정정 후에는 컨버터를 먼저 보게 된다.

**이 노트가 그 자체로 반증을 갖고 있었다.** 같은 챕터의 `04`가 415·406을 컨버터 관점에서 옳게 설명하고 있었는데, `02`와 대조하지 않아 두 서술이 어긋난 채 남았다. **한 챕터 안의 두 노트를 교차 대조하는 것이 자체 검증에서 빠져 있었다는 뜻이다.**

# 모범답안 — 02 WebFlux 애플리케이션 만들기

> **먼저 답하고 나서 열 것.** [[02-creating-a-webflux-application]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. 기존 프로젝트에 얹지 않고 새로 만드는 이유

**리액티브 웹 앱은 기존 프로젝트에 얹는 기능이 아니라 런타임 자체가 다른 것이기 때문이다.**

> **Servlet 스택 위에 리액티브 컨트롤러를 얹는다고 리액티브가 되지 않는다.**

**지금까지의 장들은 기존 애플리케이션에 의존성을 더했다.** 보안·데이터·설정은 **같은 런타임 위의 기능 추가**였다. 이 장은 **웹 서버 자체가 바뀐다.**

```
Ch4 보안:   같은 Tomcat + 필터 체인 추가
Ch9 리액티브: Tomcat → Reactor Netty  (실행 모델이 다르다)
```

**의존성도 딱 하나** — Spring Reactive Web(**Spring WebFlux**). **그게 전부다.**

**섞으면 어떻게 되나** → Q3.

**비유로 보면** 수도 배관 교체 — **집 안의 수전(컨트롤러)을 아무리 좋은 것으로 바꿔도 건물로 들어오는 주 배관(웹 서버)이 좁으면 수압이 안 나온다.** WebFlux 의존성을 고르는 것은 **수전이 아니라 주 배관을 바꾸는 일**이다.

---

## Q2. 파이프라인이 논블로킹인데 서버가 블로킹이면

**요청마다 스레드가 묶여, [[01a-blocking-vs-non-blocking]]에서 얻으려던 절약이 일어나지 않는다.**

> **Servlet 컨테이너는 요청 하나에 스레드 하나를 붙들고 그 스레드가 응답을 다 쓸 때까지 잡고 있다.**

```
컨트롤러 안:  Flux 로 논블로킹하게 흘린다        ✅
컨트롤러 밖:  Servlet 스레드가 요청 전체를 잡고 있다  ❌
        ↓
"적은 스레드로 많은 동시 요청" 이 성립하지 않는다
```

**즉 낭비되는 것은 스레드다** — [[01a-blocking-vs-non-blocking]]의 세 한계(스택 메모리, 동시성 상한, 컨텍스트 스위칭)가 **그대로 남는다.**

**리액티브 프로그래밍의 근본 요구 하나는 끝에서 끝까지 논블로킹 실행을 지원하는 런타임이다.**

**그 자리에 오는 것이 Reactor Netty**:
- **Netty 위에 세워졌다** — 검증된 논블로킹 네트워크 라이브러리
- **Project Reactor와 통합됐다** — **웹 계층의 이벤트가 그대로 리액티브 타입으로 이어진다**
- **대량의 동시 연결을 효율적으로** 다룬다

**Netty가 쓰는 실행 모델이 이벤트 루프**이고, 그래서 [[04b-java-concurrency-history]]의 **"코어당 스레드 하나"**가 여기서 실체를 갖는다.

**같은 논리가 아래로도 이어진다** — **"WebFlux를 넣었으니 리액티브다"는 웹 계층만 리액티브가 된 것**이고, **데이터 접근이 JDBC면 거기서 스레드가 막힌다.**

---

## Q3. `starter-web`과 `starter-webflux`를 같이 넣으면

**Servlet 스택이 딸려 오고 Spring Boot는 기본적으로 MVC로 뜬다.**

> **WebFlux 의존성이 있어도 Reactor Netty가 아니라 Tomcat이 뜬다.**

**리액티브 프로젝트를 새로 만드는 이유가 여기 있다**(Q1).

**가장 나쁜 점**: **겉으로 티가 안 난다.** 같은 `@GetMapping`이 그대로 동작하므로 **실수로 Servlet 스택이 딸려 와도 코드가 컴파일되고 돌아간다.** 성능만 안 나올 뿐이고, **왜 안 나오는지 알기 어렵다.**

**확인하는 법**: 기동 로그에서 **어느 서버가 떴는지** 본다 — `Netty started on port 8080` vs `Tomcat started on port 8080`.

**전이 의존성으로도 들어올 수 있다** — [[06-building-reactive-hypermedia-apis]]에서 **HATEOAS starter를 피하는 이유**도 같은 문제다. **직접 넣지 않아도 남이 끌고 온다.**

**비유의 깨짐이 이것이다** — **배관은 굵기가 눈에 보이지만 웹 서버 교체는 겉으로 티가 안 난다.** 그리고 **주 배관을 바꿔도 집 안 어딘가에 좁은 관이 하나 남아 있으면 거기가 병목이 된다** — 그게 **블로킹 API**(JDBC·JPA·JMS·servlet)이며 [[04b-java-concurrency-history]]가 다룬다.

---

## Q4. Boot 4에서 WebFlux 앱의 테스트 의존성

**`spring-boot-starter-webflux-test`.**

> **Boot 4는 기능별 테스트 starter를 제공한다.** WebFlux 앱에는 **짝이 되는 WebFlux 테스트 starter**를 쓰며, **여기에 Reactor의 테스트 유틸 같은 리액티브 테스트 지원**이 들어 있다.

| 웹 스택 | 테스트 starter |
|---|---|
| WebFlux | **`spring-boot-starter-webflux-test`** |
| MVC | `spring-boot-starter-webmvc-test` |

**예전 습관대로 `spring-boot-starter-test`만 넣으면 리액티브 테스트 유틸이 빠질 수 있다.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/01-junit-6-and-focused-test-starters|Ch5]]에서 본 그 변화다** — **예전의 만능 `spring-boot-starter-test` 대신 웹 스택에 맞는 테스트 starter를 고른다.**

**Ch5의 논리와 일치한다**: 나눈 이유는 **배포물 크기가 아니라 "테스트 컨텍스트가 무엇을 켜는지"**다. WebFlux 테스트에 MVC 인프라가 딸려 오면 **무엇이 왜 켜졌는지 읽기 어려워진다.**

**주 의존성이 넣는 것도 함께 기억할 것**: `spring-boot-starter-webflux`는 **JSON 지원용 Jackson과 Project Reactor Core를 포함하고, Reactor Netty를 기본 임베디드 리액티브 웹 서버로 구성**한다.

---

## 재출제 문항

1. 기존 MVC 앱에 WebFlux 의존성을 더했다. 리액티브가 되는가?
2. 컨트롤러는 `Flux`를 반환하는데 Tomcat 위에서 돈다. 무엇이 낭비되는가?
3. 성능이 예상보다 안 나온다. 기동 로그에서 무엇을 확인하는가?
4. 직접 넣지 않은 Servlet 스택이 들어왔다. 어떻게 가능한가?
5. WebFlux 앱에 `spring-boot-starter-test`만 넣었다. 무엇이 빠지는가?
6. Ch5의 테스트 starter 분리 논리와 이 절의 선택이 같은 이유는?

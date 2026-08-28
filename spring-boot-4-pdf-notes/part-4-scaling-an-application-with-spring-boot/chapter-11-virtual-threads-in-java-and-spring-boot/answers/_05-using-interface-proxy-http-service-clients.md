# 모범답안 — 05 인터페이스 프록시 HTTP 서비스 클라이언트

> **먼저 답하고 나서 열 것.** [[05-using-interface-proxy-http-service-clients]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. `RestClient`를 직접 쓸 때 반복되는 네 가지

| 반복되는 것 | **문제** |
|---|---|
| **HTTP 메서드 선택** | 매번 `post()`/`get()`을 고른다 |
| **URI 문자열** | **오타를 컴파일러가 못 잡는다** |
| **본문·파라미터 조립** | 형태가 조금씩 다르다 |
| **응답 처리** | `retrieve().body(X.class)` 같은 반복 |

> **"이 방식은 유연하지만 요청을 손으로 구성하고, URI를 정의하고, 응답을 처리해야 한다. 애플리케이션이 커지면 반복적이고 덜 표현적인 코드로 이어질 수 있다."**

**두 번째가 가장 위험하다** — **URI 오타는 런타임 404**로만 드러나고, 그것도 **그 경로를 실제로 타야** 안다.

**한 곳이면 괜찮다** — 문제는 **엔드포인트가 열 개면 이런 블록이 열 개** 생긴다는 것이다.

---

## Q2. "덜 표현적"이라는 진단

> **코드를 읽어도 "이 서비스가 무엇을 제공하는가"가 한눈에 안 들어온다. HTTP 조립 절차에 가려진다.**

```java
restClient.post().uri("/notify").body(employee).retrieve().toBodilessEntity();
//         └──────────────── 절차 ────────────────┘
//         "무엇을 하는가"가 절차 안에 흩어져 있다

notificationClient.notifyEmployee(employee);
//                 └──────┬──────┘
//                 의도가 이름으로 드러난다
```

**표현력의 정의**: **코드가 "어떻게"가 아니라 "무엇을"을 말하는 정도.**

**직접 호출은 "어떻게"를 말한다** — POST를 보내고, 경로를 붙이고, 본문을 넣고, 응답을 버린다. **인터페이스는 "무엇을"을 말한다** — 직원에게 알린다.

**그리고 그 "무엇을"이 한 곳에 모인다** — 인터페이스를 열면 **이 외부 서비스가 제공하는 것 전부**가 목록으로 보인다. 직접 호출 방식에서는 **코드 전체를 grep**해야 한다.

---

## Q3. 인터페이스 세 줄이 기술하는 것

```java
public interface NotificationClient {
       @PostExchange("/notify")
       void notifyEmployee(@RequestBody Employee employee);
}
```

| 요소 | **하는 일** |
|---|---|
| **`@PostExchange("/notify")`** | **`/notify`로 POST를 보낸다** |
| `@RequestBody Employee employee` | **이 인자가 요청 본문이 된다** |
| `void` 반환 | **응답 본문을 쓰지 않는다** |

> **"Spring이 이 정의를 써서 HTTP 호출을 자동으로 생성한다."** **우리가 쓴 것은 선언이지 구현이 아니다.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-2-creating-web-and-api-applications-with-spring-boot/09-calling-versioned-apis-with-http-service-clients|Ch2]]에서 본 것과 같은 모델이고, 짝 관계도 그대로다** — **요청을 받는 쪽이 `@PostMapping`, 보내는 쪽이 `@PostExchange`**다.

**대칭이 기억을 돕는다**:
```
서버:  @PostMapping("/notify")  ResponseEntity<Void> notify(@RequestBody Employee e)
클라:  @PostExchange("/notify") void notifyEmployee(@RequestBody Employee e)
```

**"메서드 이름이 URL을 정한다"는 오해다**(§5) — **`@PostExchange`의 문자열이 정한다.** **메서드 이름은 우리가 읽기 위한 것**이다.

---

## Q4. `RestClientAdapter`가 필요한 설계상의 이유

**`HttpServiceProxyFactory`는 어떤 HTTP 클라이언트를 쓸지 모르기 때문이다.**

> **`RestClient`일 수도, `WebClient`일 수도, 다른 것일 수도 있다. 어댑터가 그 차이를 흡수하므로 프록시 기능과 전송 구현이 분리된다.**

```
NotificationClient 인터페이스 ──┐
                                ├─▶ HttpServiceProxyFactory ─▶ 런타임 프록시 빈
RestClient ─▶ RestClientAdapter ┘
```

| 부품 | 하는 일 |
|---|---|
| `RestClient.Builder` | **`RestClient`의 base URL 설정** |
| **`RestClientAdapter`** | **두 세계를 잇는다** |
| **`HttpServiceProxyFactory`** | **런타임 구현체 생성** |

**분리의 이득**: **전송 구현을 바꿔도 인터페이스 선언은 그대로**다. `WebClientAdapter`로 갈아 끼우면 **같은 인터페이스가 리액티브로** 돈다.

**"인터페이스만 만들면 주입된다"는 오해다**(§5) — **프록시 빈을 만들어 등록해야 한다.** 그것이 `HttpClientConfig`가 하는 일이다.

> **원문의 공백**: 이 절은 프록시 빈을 **손수 조립**한다. **Spring Boot 4에는 같은 일을 선언으로 하는 `@ImportHttpServices`와 `spring.http.serviceclient.*` 프로퍼티**가 있고 **[[../../part-2-creating-an-application-with-spring-boot/chapter-2-creating-web-and-api-applications-with-spring-boot/09-calling-versioned-apis-with-http-service-clients|Ch2]]가 그 방식을 다뤘는데 이 장은 언급하지 않는다.** **Boot의 자동 설정을 쓰면 설정 클래스 자체가 필요 없어진다.**

---

## Q5. 서비스 계층이 단순해진 것 — 다섯 축

| | **직접 `RestClient`** | **인터페이스 프록시** |
|---|---|---|
| **호출부** | `restClient.post().uri(…).body(…).retrieve().toBodilessEntity()` | **`notificationClient.notifyEmployee(employee)`** |
| **URI가 어디에** | **호출부마다** | **인터페이스 선언 한 곳** |
| **HTTP 세부** | 서비스가 안다 | **서비스가 모른다** |
| **오타** | **런타임 404** | 컴파일러가 메서드 이름을 검사 |
| **테스트** | **HTTP 목킹** | **인터페이스 목킹** |

> **마지막 줄이 실무에서 크다.** 인터페이스이므로 테스트에서 **`Mockito.mock(NotificationClient.class)`**로 대체할 수 있다.

**[[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/04-testing-services-with-mocks|Ch5]]의 목킹이 그대로 적용된다** — HTTP 목 서버를 띄우지 않고 **평범한 협력자 목**으로 다룬다.

**세 번째 줄도 설계상 중요하다** — **서비스가 HTTP 세부를 모른다**는 것은 **전송이 HTTP가 아니게 돼도 서비스는 안 바뀐다**는 뜻이다.

> **"이 서비스가 더 단순하다. HTTP 호출이 인터페이스를 통해 정의되므로 요청을 손으로 구성할 필요가 없어지고, 코드가 읽고 유지하기 쉬워진다."**

---

## Q6. 이 절이 동시성과 무관한 것이 배울 점인 이유

**두 관심사가 독립적이라는 것 자체가 설계 교훈이기 때문이다.**

> **가상 스레드는 실행 모델, 인터페이스 프록시는 API 표현이다.**

```
NotificationClientService → 프록시 → RestClient (블로킹) → 가상 스레드가 캐리어에서 내려온다
                            └─ 호출 구문만 바꾼다        └─ 동시성은 여기서 정해진다
```

> **프록시는 호출 구문만 바꾼다. 밑에서는 여전히 [[04-using-virtual-threads-with-restclient]]의 `RestClient`가 블로킹으로 돌고, 그래서 [[01-understanding-virtual-threads]]의 마운트/언마운트가 그대로 일어난다.**

**"인터페이스 프록시를 쓰면 더 빨라진다"는 오해다**(§5) — **성능은 같다. 바뀌는 것은 코드 표현력**이다.

**"프록시가 논블로킹으로 만들어 준다"도 오해다** — **밑의 클라이언트가 정한다.** `RestClientAdapter`를 쓰면 블로킹이고, `WebClientAdapter`를 쓰면 논블로킹이다.

**배울 점**: **개선 항목을 층으로 분리해 생각한다.** "코드가 지저분하다"와 "확장성이 부족하다"는 **다른 문제**이고, **각각 다른 해법**이 있다. 섞어 생각하면 **한쪽을 고쳐 놓고 다른 쪽이 해결됐다고 착각**한다.

---

## Q7. Boot 4의 더 선언적인 대안

**`@ImportHttpServices`와 `spring.http.serviceclient.*` 프로퍼티.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-2-creating-web-and-api-applications-with-spring-boot/09-calling-versioned-apis-with-http-service-clients|Ch2]]가 그 방식을 다뤘다.**

| | **이 장(수동 조립)** | **`@ImportHttpServices`** |
|---|---|---|
| 필요한 것 | **`@Configuration` 클래스 + 빈 메서드** | **애노테이션 + 프로퍼티** |
| 층 | **Spring Framework 수준** | **Spring Boot 자동 설정** |
| base URL | 코드에 | **프로퍼티에** |

> **수동 조립은 Spring Framework 수준의 방법이고 Boot의 자동 설정을 쓰면 설정 클래스 자체가 필요 없어진다.**

**base URL이 프로퍼티로 가는 것이 실무적으로 크다** — [[../../part-3-releasing-an-application-with-spring-boot/chapter-6-configuring-an-application-with-spring-boot/02-creating-profile-based-property-files|Ch6]]의 환경별 설정이 **그대로 적용**된다. 코드에 박으면 **환경마다 다른 빌드**가 필요해진다.

**"이게 Boot 4의 유일한 방법이다"는 오해다**(§5) — **이 장은 수동 조립만 보여 준다.**

---

## Q8. 메뉴판 비유가 깨지는 지점

**비유**: 인터페이스 프록시는 **"메뉴판"**이다. **손님은 "3번"이라고만 말하고 주방이 알아서 만든다.**

**깨지는 지점**: **메뉴에 없는 것을 시킬 수 없다는 제약을 가볍게 보이게 한다.**

> **선언에 없는 형태의 요청(런타임에 결정되는 경로, 동적 헤더)은 이 방식으로 표현할 수 없고, 그때는 다시 `RestClient`를 직접 써야 한다.**

**§6의 경계와 이어진다**:
- **호출이 한두 개면 과할 수 있다** — **설정 클래스와 인터페이스를 만드는 비용이 더 크다**
- **동적으로 URL이 정해지는 호출에는 맞지 않는다** — **선언이 정적이기 때문**
- **응답의 세밀한 제어가 필요하면** `RestClient`를 직접 쓰는 편이 낫다(**헤더 검사, 조건부 처리** 등)

**즉 선언적 방식의 이득(Q2·Q5)과 대가(정적)가 같은 성질에서 온다** — **미리 적어 두므로 읽기 쉽고, 미리 적어야 하므로 유연하지 않다.**

**비유가 맞는 부분은 남는다** — **주문이 간결해지고 조리 절차를 몰라도 된다**(Q5의 "서비스가 HTTP 세부를 모른다"). 깨지는 것은 **표현 가능한 범위**다.

**실무적 결론**: **정형화된 호출은 인터페이스, 예외적인 호출은 `RestClient` 직접** — 둘을 섞어 쓰는 것이 자연스럽다.

---

## 재출제 문항

1. 외부 API 경로에 오타를 냈다. 두 방식에서 각각 언제 드러나는가?
2. "덜 표현적"이 무엇을 뜻하는지 코드로 대비해 보라.
3. `@PostMapping`과 `@PostExchange`의 관계는?
4. `WebClient`로 전송을 바꾸려면 무엇을 고치는가?
5. 이 클라이언트를 쓰는 서비스를 테스트한다. HTTP 목 서버가 필요한가?
6. "코드가 지저분하다"와 "확장성이 부족하다"를 같은 해법으로 풀려 하면 무엇이 문제인가?
7. base URL이 코드에 박혀 있다. 환경이 셋이면 무엇이 문제인가?
8. 런타임에 경로가 정해지는 호출이 있다. 인터페이스로 표현되는가?

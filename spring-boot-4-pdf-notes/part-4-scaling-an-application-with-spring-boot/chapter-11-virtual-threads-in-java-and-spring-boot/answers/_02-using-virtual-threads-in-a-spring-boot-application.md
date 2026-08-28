# 모범답안 — 02 Spring Boot에서 가상 스레드 쓰기

> **먼저 답하고 나서 열 것.** [[02-using-virtual-threads-in-a-spring-boot-application]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 의존성이 필요 없는 이유

**가상 스레드는 라이브러리가 아니라 자바 런타임의 기능이기 때문이다.**

> **Java 21 이상에서 돌면 이미 거기 있다.**

**Initializr에서 고르는 넷** — Spring Web, Spring Data JPA, H2, Thymeleaf — 은 **전부 이전 장들에서 써 온 것**이다.

> **"가상 스레드와 관련된 것은 아직 아무것도 없다."**

**이것이 리액티브와의 결정적 차이다**: 리액티브는 **`spring-boot-starter-webflux`라는 의존성**이 필요했고 **웹 서버까지 바꿨다**([[../chapter-9-writing-reactive-web-controllers/02-creating-a-webflux-application|Ch9]]). 가상 스레드는 **아무것도 안 바꾼다.**

**대신 조건이 있다**(§6): **Java 21 미만에서는 켜지지 않는다.** **프로퍼티가 무시되거나 기동이 실패한다.**

---

## Q2. JPA 엔티티를 record로 만들지 않는 이유

**영속성 컨텍스트가 엔티티의 변화를 추적해 UPDATE를 만들어야 하는데, 불변이면 그 추적이 성립하지 않기 때문이다.**

| | **record** | **클래스** |
|---|---|---|
| 가변성 | **불변** | **가변** |
| 잘 맞는 곳 | **DTO, 값 객체** | **JPA 엔티티** |

> **JPA 엔티티는 영속성 컨텍스트가 생명주기를 관리하는 가변 객체이고, 로딩된 뒤에도 상태가 바뀐다. JPA는 그 변화를 추적해 UPDATE를 만든다.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-3-querying-for-data-with-spring-boot/02a-entities-in-jpa|Ch3]]에서 같은 이유로 `protected` 무인자 생성자를 남겨 뒀던 것과 이어진다.**

**[[../chapter-10-working-with-data-reactively/03-creating-reactive-repositories-and-r2dbc-access|Ch10]]과 정확히 반대다** — **R2DBC에는 영속성 컨텍스트가 없어 record가 그대로 통했다.** 같은 `Employee`가 **Ch10에서는 record, Ch11에서는 클래스**인 것이 그 차이의 결과다.

**"엔티티도 record로 만드는 게 현대적이다"는 오해다**(§5) — **JPA 엔티티는 가변이어야 한다. record는 DTO에 쓴다.**

**초기 데이터도 익숙한 형태다** — `CommandLineRunner`에 **`if (repository.count() == 0)` 가드**가 있어 **재시작해도 중복되지 않는다.** ([[../../part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/04c-running-the-setup-with-docker-compose|Ch7]]이 경고한 문제의 간단한 대응.)

---

## Q3. `spring.threads.virtual.enabled`가 켜는 것과 켜지 않는 것

| **켜지는 것** | **조건** |
|---|---|
| **컨트롤러의 HTTP 요청 처리** | 지원되는 내장 웹 서버 |
| **`@Async` 메서드** | **Spring Boot의 기본 실행자**를 쓸 때 |
| **`@Scheduled` 작업** | **Spring Boot의 기본 스케줄러**를 쓸 때 |

| **켜지지 않는 것** |
|---|
| **모든 JVM 스레드를 가상으로 바꾸지 않는다** |
| **애플리케이션이 직접 만든 실행자에는 영향이 없다** |

> **두 번째 줄이 실무에서 자주 놓치는 지점이다.** `Executors.newFixedThreadPool(10)`을 직접 만들어 쓰고 있다면 **이 프로퍼티와 무관하게 플랫폼 스레드로 돈다.**

**[[06-error-handling-in-concurrent-tasks]]의 `CompletableFuture.runAsync()`도 같은 함정에 걸린다.**

**대응**(§6): **직접 만든 실행자는 별도로 손봐야 한다** — **`Executors.newVirtualThreadPerTaskExecutor()`** 같은 것을 **명시적으로** 써야 한다. [[03-integrating-virtual-threads-with-taskexecutor]]가 그 방법이다.

**공통 조건이 "Spring Boot의 기본 것을 쓸 때"라는 점이 요령이다** — **자동 설정이 만든 것만 바뀐다.** 내가 만든 것은 내 책임이다.

---

## Q4. 켜도 로그에 표시가 없다는 사실이 보여 주는 성질

**동작이 달라지지 않는다는 것.**

> **코드도, 응답도, 로그도 같다. 달라지는 것은 자원 사용뿐이다.**

**이것이 [[01-understanding-virtual-threads]]의 약속이 실현된 모습이다** — **"단순하고 명령형이며 블로킹 스타일인 코드를 쓰면서도 높은 확장성을 얻는다."** **코드가 안 바뀌었으니 관찰되는 동작도 안 바뀐다.**

**리액티브와 대비하면 뚜렷하다**:
```
리액티브로 전환:  반환 타입이 Flux/Mono 로 바뀐다 → 눈에 보인다
가상 스레드 전환: 아무것도 안 바뀐다              → 눈에 안 보인다
```

**양날이다** — **마이그레이션이 쉬운 만큼 켜졌는지 확인하기도 어렵다.**

> **그래서 확인 수단을 직접 만든다** → Q5.

**"켜졌으면 로그에 표시가 난다"는 오해다**(§5) — **나지 않는다.**

---

## Q5. 확인 수단으로 필터를 고른 것이 좋은 이유

**컨트롤러마다 로그를 넣지 않아도 모든 요청을 한 지점에서 보기 때문이다.**

| 요소 | 하는 일 |
|---|---|
| `@Component` | 빈으로 등록되면 **모든 요청에 자동 적용** |
| **서블릿 필터** | **컨트롤러보다 먼저 실행돼 요청 스레드를 본다** |
| `Thread.currentThread()` | 현재 요청을 처리 중인 스레드 |
| **`isVirtual()`** | **가장 직접적인 증거** (Java 21 메서드) |
| `chain.doFilter(...)` | 다음 단계로 넘긴다 — **빼먹으면 요청이 멈춘다** |

**[[../../part-2-creating-an-application-with-spring-boot/chapter-4-securing-an-application-with-spring-boot/01-spring-security-filter-chain-foundations|Ch4]]에서 Spring Security가 같은 자리를 쓴 것과 같은 이유다** — **횡단 관심사는 필터가 자리다.**

**`isVirtual()`이 핵심이다** — 추측이 아니라 **런타임이 직접 답한다.**

**경계**(§6): **확인 필터는 개발용이다.** **요청마다 로그를 남기므로 운영에서는 부담이다.**

---

## Q6. 로그 한 줄에서 가상 스레드와 캐리어 구분

```text
Thread: VirtualThread[#61,tomcat-handler-0]/runnable@ForkJoinPool-1-worker-1, isVirtual: true
        └──────────────┬──────────────┘ │ └────────────┬────────────┘
              가상 스레드              경계          캐리어 스레드
```

| 조각 | **뜻** |
|---|---|
| `VirtualThread[#61,…]` | **가상 스레드**임을 표시하고 내부 식별자 |
| `tomcat-handler-0` | **웹 서버 안의 요청 처리 컨텍스트. 요청마다 하나** |
| **`/`** | **경계선** |
| `ForkJoinPool-1-worker-1` | **캐리어 스레드** — **지금 이 가상 스레드를 얹고 도는 플랫폼 스레드** |
| `isVirtual: true` | 확인 |

> **`/` 앞부분이 가상 스레드이고, 뒤의 `ForkJoinPool-1-worker-N` 부분이 지금 마운트돼 있는 캐리어 플랫폼 스레드다.** 이는 **JDK 스케줄러가 가상 스레드를 플랫폼 스레드 위에 마운트한다는 JEP 444의 설명과 일치**한다.

**"`ForkJoinPool-1-worker-1`이 가상 스레드다"는 오해다**(§5) — **그것은 캐리어**다.

**`ForkJoinPool`이 캐리어 풀로 쓰인다는 것도 여기서 드러난다** — **작업 훔치기 방식의 자바 스레드 풀.**

---

## Q7. 세 로그 줄에서 "캐리어를 공유한다"를 읽는 법

```text
#61 → worker-1
#65 → worker-1     ← 같은 캐리어!
#66 → worker-4
```

> **서로 다른 가상 스레드가 같은 캐리어를 쓴다.**

**이것이 "제한된 수의 JVM 관리 플랫폼 스레드를 공유하면서 각 요청을 독립적으로 처리한다"는 책의 결론이 눈에 보이는 형태다.**

**읽는 요령**: **`/` 앞의 `#N`은 매번 다르고, `/` 뒤의 `worker-N`은 반복된다.** **앞이 요청 수, 뒤가 실제 플랫폼 스레드 수**다.

**이것이 [[01-understanding-virtual-threads]]의 표를 실측으로 확인해 준다** — **가상 스레드는 수백만, 플랫폼 스레드는 수천.** 여기서는 **가상 3개에 캐리어 2개**로 나타난다.

**부하가 커지면 이 비율이 벌어진다** — 캐리어는 **코어 수 수준**에 머물고 가상 스레드만 는다. 그것이 확장성의 정체다.

---

## Q8. LED 교체 비유가 깨지는 지점

**비유**: 이 프로퍼티는 **"건물 전체의 조명을 LED로 교체하는 것"**이다. **스위치 하나로 바뀌고 밝기는 그대로인데 전기 요금만 준다.**

**깨지는 지점**: **교체 범위를 흐린다.**

> **실제로 바뀌는 것은 관리사무소가 설치한 조명뿐이고, 입주자가 개인적으로 가져다 놓은 스탠드는 그대로다. 그 스탠드가 이 장 뒤의 `CompletableFuture.runAsync()`다.**

```
관리사무소 조명 = Spring Boot 자동 설정 (웹 서버, 기본 @Async 실행자, 기본 스케줄러)
개인 스탠드     = 내가 만든 Executors.newFixedThreadPool(10)
                  → 프로퍼티와 무관하게 그대로
```

**Q3의 "켜지지 않는 것"이 이 비유로 표현된 것**이고, [[06-error-handling-in-concurrent-tasks]]에서 실제 문제로 나타난다.

**비유가 맞는 부분은 남는다** — **스위치 하나로 바뀌고 밝기(동작)는 그대로인데 비용만 준다**(Q4의 "동작이 달라지지 않는다"). 깨지는 것은 **범위**다.

**실무적 함의**: **"켰다"고 안심하지 말고 어디까지 켜졌는지 확인해야** 한다. Q5의 필터가 웹 요청은 확인해 주지만, **`@Async`나 직접 만든 실행자는 그 안에서 따로 로그를 찍어 봐야** 안다.

---

## 재출제 문항

1. 리액티브 전환과 가상 스레드 전환의 의존성 차이는?
2. 같은 `Employee`가 Ch10에서는 record, Ch11에서는 클래스다. 무엇이 갈랐는가?
3. `Executors.newFixedThreadPool(10)`을 쓰는 코드가 있다. 프로퍼티를 켜면 바뀌는가?
4. 가상 스레드가 켜졌는지 눈에 안 보인다. 그것이 왜 양날인가?
5. 필터 대신 컨트롤러마다 로그를 넣으면 무엇이 나빠지는가?
6. `VirtualThread[#61,tomcat-handler-0]/runnable@ForkJoinPool-1-worker-1`에서 플랫폼 스레드는 어디인가?
7. 부하가 커지면 로그의 어느 숫자가 늘고 어느 숫자가 머무는가?
8. "켰다"고 안심하면 안 되는 이유는?

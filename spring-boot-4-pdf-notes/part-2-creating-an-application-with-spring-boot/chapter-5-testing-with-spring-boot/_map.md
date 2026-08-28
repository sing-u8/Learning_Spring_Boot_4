# Chapter 5 개념 지도 — Testing with Spring Boot

> Chapter 5는 테스트 애노테이션 목록을 외우는 장이 아니다. **같은 애플리케이션 하나**를 두고 `가장 안쪽·가장 빠른 검증`에서 `가장 바깥쪽·가장 현실적인 검증`으로 올라가면서, 매 단계마다 **무엇을 새로 얻고 무엇을 대가로 치르는지**를 묻는 장이다. 원문 누락 여부는 [[_coverage]]에서 추적한다.

## 읽는 순서

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    T["01 도구 갖추기"] --> D["02 도메인 객체"]
    D --> W["03 컨트롤러 · MockMvc"]
    W --> S["04 서비스 · 목"]
    S --> H["05 리포지토리 · 인메모리 DB"]
    H --> A["06 Testcontainers 넣기"]
    A --> C["07 리포지토리 · 실제 DB"]
    C --> SEC["08 보안 정책"]
```

| 순서 | 노트 | 원문에서 답하는 질문 | 책 쪽 |
|---|---|---|---:|
| 01 | [[01-junit-6-and-focused-test-starters]] | 테스트를 시작하려면 무엇을 갖춰야 하나? | 154–155 |
| 02 | [[02-testing-domain-objects]] | 어디부터 테스트하고, 커버리지는 무엇을 말해 주나? | 155–161 |
| 03 | [[03-testing-web-controllers-with-mockmvc]] | 서버 없이 웹 요청을 어떻게 검증하나? | 161–165 |
| 04 | [[04-testing-services-with-mocks]] | 협력자가 있는 클래스를 어떻게 격리하나? | 165–169 |
| 05 | [[05-testing-repositories-with-embedded-databases]] | 쿼리가 옳은지 어떻게 아나? | 169–174 |
| 06 | [[06-adding-testcontainers]] | 운영과 같은 DB를 어떻게 테스트에 끌어오나? | 174–177 |
| 07 | [[07-testing-repositories-with-testcontainers]] | 실제 DB 테스트에서 무엇을 명시적으로 거절해야 하나? | 177–181 |
| 08 | [[08-testing-security-policies]] | "안 되는 것이 안 된다"를 어떻게 증명하나? | 181–185 |

## 축 1: 격리 ↔ 현실 — 이 장의 주 이동

이 축의 질문은 **"이 테스트는 얼마나 진짜에 가깝고, 그 대가로 무엇을 치르는가?"**다. Chapter 5의 여덟 절이 왼쪽에서 오른쪽으로 이동한다.

```text
  격리 · 빠름                                                        현실 · 느림
  ◀───────────────────────────────────────────────────────────────────────▶

  02 도메인        04 서비스        03 컨트롤러      05 리포지토리     07 리포지토리
  new 만으로       + 목             + MVC 슬라이스   + HSQLDB          + PostgreSQL 컨테이너
  ~49ms            밀리초 미만       sub-second       수십 ms           첫 테스트 401ms
     │                │                 │                │                  │
     ▼                ▼                 ▼                ▼                  ▼
  생성자·getter     서비스 로직        요청 매핑         쿼리 파생          + SQL 방언
  상태 변경         위임 여부          상태 코드         JPA 매핑           + 대소문자
                                      템플릿 렌더링                        + 트랜잭션 동작

  ▶ 오른쪽으로 갈수록 검증 범위가 넓어지고 실행이 느려진다.
  ▶ 08 보안은 이 축에 얹히지 않는다 — 03 과 같은 슬라이스를 쓰되 "주체"라는 다른 축을 더한다.
  ▶ 책의 Note(p.165): "진짜 애플리케이션은 대개 둘을 섞는다."
```

| | 목 ([[04-testing-services-with-mocks]]) | 인메모리 ([[05-testing-repositories-with-embedded-databases]]) | 컨테이너 ([[07-testing-repositories-with-testcontainers]]) |
|---|---|---|---|
| SQL 실행 | 없음 | 있음 (다른 엔진) | 있음 (**같은 엔진**) |
| 외부 전제 | 없음 | 없음 | **Docker** |
| 잡는 것 | 서비스 로직 | 쿼리·매핑 | + 방언·인덱싱·대소문자 |
| 못 잡는 것 | 쿼리 전부 | **방언 차이** | (거의 없음) |
| 대표 위험 | **목 자신만 테스트** | 운영에서 다르게 동작 | Docker 없으면 못 돎 |

## 축 2: 무엇을 단언하는가

이 축의 질문은 **"이 테스트가 옳음을 주장하는 근거는 무엇인가?"**다. 세 종류가 있고, 어느 것을 고르는지는 **검증 대상이 무엇을 돌려주는가**로 정해진다.

| 방식 | 문법 | 언제 쓰나 | 이 장의 예 |
|---|---|---|---|
| **상태 검증** | `assertThat(결과)…` | 반환값에 증거가 있을 때 | `getVideosShouldReturnAll`, `findByName…` |
| **행위 검증** | `verify(목).메서드(인자)` | 반환값에 **증거가 없을 때** | `deletingAVideoShouldWork`, `postNewVideoShouldWork` |
| **응답 검증** | `.andExpect(status()…)` | HTTP 계층의 결과가 대상일 때 | 컨트롤러·보안 테스트 전부 |

```text
  검증 대상이 값을 돌려주는가?
        │
        ├─ 예 ──────▶ 상태 검증
        │             스텁으로 입력 고정 → 결과 단언
        │
        └─ 아니오 ───▶ 행위 검증
                      "그 협력자가 그 인자로 불렸는가"

  ▶ delete() 와 컨트롤러 POST 가 같은 이유로 행위 검증을 쓴다 —
    돌려주는 것에 "일어났다"는 증거가 없기 때문이다.
```

## 축 3: 도구가 어느 자리에 서는가

이 축의 질문은 **"아홉 개 도구가 왜 다 필요한가?"**다. 겹쳐 보이는 것들의 자리가 실제로는 다르다.

| 층 | 도구 | 하는 일 |
|---|---|---|
| 실행 | JUnit 6 | 무엇이 테스트인지 표시하고 생명주기를 관리 |
| 실행 | Spring Test / Spring Boot Test | 테스트용 컨텍스트, 슬라이스 애노테이션 |
| 협력자 | Mockito | 가짜 생성·스텁·호출 검증 |
| 단언 | **AssertJ** | 값을 받아 **점으로 잇는다** |
| 단언 | **Hamcrest** | 조건을 **matcher 객체로 만들어 넘긴다** |
| 단언 | JSONPath / JSONassert / XMLUnit | 문서 형식별 질의·비교 |
| 인프라 | Testcontainers | 실제 서비스를 컨테이너로 |

**AssertJ와 Hamcrest가 중복이 아니라는 증거**가 [[03-testing-web-controllers-with-mockmvc]]의 한 메서드 안에 있다 — `.andExpect(content().string(containsString(…)))`는 조건 객체를 요구하므로 Hamcrest이고, `assertThat(html).contains(…)`는 이미 값을 손에 넣은 뒤라 AssertJ다.

## 축 4: Boot 4가 이 장에서 바꾼 것

이 축의 질문은 **"Boot 3 시절 예제를 그대로 쓰면 어디서 걸리는가?"**다. 전부 [[../../part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/01-whats-new-in-spring-boot-4|Chapter 15]]가 정리한 방향의 사례다.

| 무엇 | 이전 | Boot 4 | Chapter 15의 방향 |
|---|---|---|---|
| 테스트 프레임워크 | JUnit 5 | **JUnit 6** (모델·패키지 유지) | — |
| test starter | 단일 거대 스타터 | **관심사별 집중형** | ② 모듈 세분화 |
| `@WebMvcTest` import | `…boot.test.autoconfigure.web.servlet` | **`…boot.webmvc.test.autoconfigure`** | ② 모듈 세분화 |
| 빈 오버라이드 | `@MockBean` | **`@MockitoBean`** (Framework 모델) | ③ 벤더 중립 표준 |
| Testcontainers 좌표 | `org.testcontainers:postgresql` | **`…:testcontainers-postgresql`** | (Testcontainers 2.x) |
| `@SpringBootTest`의 웹 테스트 | 자동 구성 | **명시적 opt-in** | ① 명시성 |

마지막 줄은 이 장의 코드에는 안 나오지만(이 장은 슬라이스만 쓴다) **전체 컨텍스트 테스트로 넘어가는 순간 부딪힌다.**

## 축 5: 문제가 생겼을 때 어디를 먼저 보나

| 관찰된 증상 | 먼저 볼 곳 | 이유 |
|---|---|---|
| 컨트롤러 테스트가 401 | `@WithMockUser`가 있는가 | `@WebMvcTest`는 보안을 켠 채로 온다 |
| 컨트롤러 테스트가 빈 오류 | `@MockitoBean`으로 협력자를 채웠는가 | 슬라이스는 웹 계층만 켠다 |
| POST 테스트가 403 | `.with(csrf())`가 있는가 | 테스트에는 렌더된 토큰이 없다 |
| 커버리지는 초록인데 버그가 남음 | 그 테스트에 **단언이 있는가** | 커버리지는 실행만 센다 |
| Testcontainers인데 방언 문제를 못 잡음 | `@AutoConfigureTestDatabase(replace = NONE)` | 빼면 내장 DB로 조용히 대체된다 |
| 컨테이너는 뜨는데 접속 실패 | `@ServiceConnection`이 있는가 | 포트가 실행마다 달라진다 |
| 리포지토리 테스트에 표가 없음 | `ddl-auto=create-drop` | 실제 DB에는 스키마가 자동 생성되지 않는다 |
| 테스트 순서를 바꾸면 깨짐 | 결과 **순서**를 단언하고 있는가 | `ORDER BY` 없이는 순서가 보장되지 않는다 |
| 보안을 지웠는데 다 통과 | **부정 경로 테스트가 있는가** | 긍정 경로는 정책이 없어도 통과한다 |

## 이름으로 원리를 기억하기

| 이름 | 이름이 붙은 이유 | 기억할 경계 |
|---|---|---|
| MockMvc | mock + MVC | **컨트롤러가 아니라 서블릿 컨테이너를 mock한다** |
| 슬라이스(slice) | 계층을 **얇게 저민 한 조각** | 켜지지 않은 계층의 빈은 직접 채워야 한다 |
| stub | 잘라내고 남은 **몽당** | 최소한의 답만 준다. 진짜 동작은 없다 |
| 스모크 테스트 | 전원을 넣고 **연기가 나는지** 보던 관행 | 깊이가 아니라 "일단 켜지는가"를 본다 |
| `should` | 이름이 **명세 문장**이 되게 | 실패 목록만 보고 무엇이 깨졌는지 읽힌다 |
| given·when·then | BDD의 **주어진·할 때·그러면** | 단언이 여러 갈래면 쪼개라는 신호 |
| 401 Unauthorized | HTTP 초기 명세의 유산 | 실제로는 **미인증**. 권한 없음은 403 |
| `@ServiceConnection` | 서비스를 **연결해 준다** | 컨테이너 포트가 매번 달라지는 문제를 흡수 |

## 원문의 오류·불일치 세 가지

1. **조판 오류** — 책 p.182의 부정 경로 테스트가 `void () throws Exception {`으로 인쇄되어 **메서드 이름이 비어 있다.** 바로 다음 문단이 `unauthUserShouldNotAccessHomePage`라고 밝힌다 — [[08-testing-security-policies]].
2. **절 제목 불일치** — 책 pp.165–169의 제목은 *Testing data repositories with mocks*지만 **테스트 대상은 `VideoService`**이고 리포지토리는 모킹되는 쪽이다 — [[04-testing-services-with-mocks]].
3. **지키지 않은 예고** — 책 p.174가 `delete()` 테스트를 보안 절에서 다루겠다고 예고하지만, 그 절에 **`delete()` 테스트가 없다.** `delete`는 `SecurityConfig` 규칙 목록에만 등장한다 — [[08-testing-security-policies]].

또 하나, **`VideoEntity`가 Chapter 3판과 다르다.** 이 장의 것은 `username` 필드와 3-인자 생성자를 갖는다(Chapter 4의 소유권 도입 결과). Figure 5.4의 커버리지 화면에서 그 모양을 직접 확인할 수 있다 — [[02-testing-domain-objects]].

## 나의 취약 엣지

- 아직 Chapter 5 인출 연습을 시작하지 않았으므로 실제 stall 기반 취약 엣지는 기록하지 않았다.
- 이후 막힘은 [[../../_global/gaps|전역 gaps]]에 `chapter-5-testing-with-spring-boot` 카테고리로 추가한다.
- 우선 확인 후보(현재 "약점"이 아니라 읽을 때 구분해야 할 경계): 단위 vs 통합, 목 vs 스텁, 상태 검증 vs 행위 검증, AssertJ vs Hamcrest, `@WebMvcTest` vs `@DataJpaTest`, 인메모리 vs 컨테이너, 401 vs 403, 긍정 경로 vs 부정 경로, 커버리지 vs 검증.

## 관련 Chapter

- [[../chapter-2-creating-web-and-api-applications-with-spring-boot/_map|Chapter 2 · Web and API]] — 여기서 테스트하는 `HomeController`·`VideoService`가 그 Chapter에서 만들어졌다. 생성자 주입이 [[04-testing-services-with-mocks]]의 `new VideoService(목)`를 가능하게 한다.
- [[../chapter-3-querying-for-data-with-spring-boot/_map|Chapter 3 · Querying for Data]] — [[05-testing-repositories-with-embedded-databases]]와 [[07-testing-repositories-with-testcontainers]]가 검증하는 커스텀 finder들이 그쪽에서 만들어졌다. 긴 메서드 이름이 Query by Example을 부른다는 자평도 그 Chapter로 이어진다.
- [[../chapter-4-securing-an-application-with-spring-boot/01-spring-security-filter-chain-foundations|Chapter 4 · Security]] — [[08-testing-security-policies]]가 검증하는 `SecurityConfig`와 CSRF 설정이 그쪽에서 만들어졌다.
- [[../../part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/01-whats-new-in-spring-boot-4|Chapter 15 · Boot 4의 변화]] — 이 장의 애노테이션 변경(`@MockitoBean`, `@WebMvcTest` import, Testcontainers 좌표)이 어느 방향의 결과인지 보여 준다.

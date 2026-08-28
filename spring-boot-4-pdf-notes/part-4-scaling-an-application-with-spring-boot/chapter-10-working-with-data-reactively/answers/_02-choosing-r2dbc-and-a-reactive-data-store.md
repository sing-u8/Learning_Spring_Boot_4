# 모범답안 — 02 R2DBC와 리액티브 데이터 스토어 고르기

> **먼저 답하고 나서 열 것.** [[02-choosing-r2dbc-and-a-reactive-data-store]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `h2`와 `r2dbc-h2`가 둘 다 필요한 이유

| 좌표 | **무엇을 제공하나** |
|---|---|
| **`h2`** | **데이터베이스 자체** — 개발·테스트에 흔한 경량 임베더블 관계형 DB. **인메모리나 단순 파일 기반으로 돌아 외부 DB 서버 없이 빠르게 기동**한다 |
| **`r2dbc-h2`** | **애플리케이션과 H2 사이의 리액티브 논블로킹 통신** — H2용 R2DBC 드라이버 |

> **DB와 드라이버는 다른 것**이고, **JDBC 시절에는 H2 JAR 하나가 둘을 다 담고 있었기 때문에 더 헷갈린다.**

**`h2` 하나로는 안 된다**(§5) — **빼먹으면 "연결 팩토리를 찾을 수 없다"는 기동 실패가 난다.**

**네 좌표 전체**:
| 좌표 | 하는 일 |
|---|---|
| `spring-boot-starter-data-r2dbc` | **논블로킹 DB 연산의 핵심 인프라** — 리액티브 repository, DB 연결, **WebFlux 리액티브 모델과의 통합** |
| `h2` (`runtime`) | 데이터베이스 |
| `r2dbc-h2` (`runtime`) | 리액티브 드라이버 |
| `spring-boot-starter-data-r2dbc-test` (`test`) | **리액티브 repository와 DB 상호작용 테스트**를 쉽게 하는 유틸과 auto-configuration |

**둘 다 `runtime` scope인 것도 [[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/05-testing-repositories-with-embedded-databases|Ch5]]와 같은 이유다** — **애플리케이션 코드가 특정 DB 클래스를 직접 import하는 일을 막는다.**

---

## Q2. R2DBC가 "드라이버 작성자를 편하게" 설계된 결과

**애플리케이션이 R2DBC로 직접 말하는 것이 상당히 번거로워졌다.**

> **R2DBC는 매우 저수준이다.** 근본적으로 **드라이버 작성자가 구현하기 쉽게** 만드는 것을 겨냥한다. **JDBC의 드라이버 인터페이스 측면 일부가 애플리케이션이 소비하기 쉽도록 타협돼 있었는데, R2DBC는 그것을 바로잡으려 했다.**

```
JDBC:   드라이버 인터페이스를 애플리케이션 편의 쪽으로 타협
        → 애플리케이션은 편하고 드라이버 구현은 어렵다

R2DBC:  드라이버 구현을 최우선
        → 벤더들이 드라이버를 내놓기 쉬워졌다
        → 애플리케이션이 직접 쓰면 장황하다
```

> **이건 결함이 아니라 설계 선택의 결과다.** **"저수준이다"가 "나쁘다"는 뜻이 아니다** — **사용자 편의는 툴킷 층이 맡는 분업**이다.

**그래서 툴킷을 쓰는 것이 권장된다** — 이 책은 **Spring Data R2DBC**를 쓰지만, Spring Framework의 **`DatabaseClient`**(= 원시 SQL을 리액티브하게 실행하는 저수준 client)나 서드파티를 써도 된다.

**연혁이 이 판단을 뒷받침한다**: **2018년** Spring 팀이 착수, **2022년 4월 명세 1.0.** **R2DBC는 라이브러리가 아니라 명세**다 — **JDBC와 같은 층에 있는 대안이지 그 위에 얹은 래퍼가 아니다.** 그래서 **각 DB 벤더가 자기 리액티브 드라이버를 구현**한다.

---

## Q3. H2 Console을 넣으면 안 되는 이유

**그것이 servlet 기반이고 JDBC로 접속하기 때문이다.**

> **추가하면 servlet/JDBC 가정이 예제에 들어온다. 이 예제는 순수하게 리액티브로 남기려는 것이다.**
>
> **데이터베이스를 들여다보려면 DBeaver나 DataGrip 같은 외부 DB 클라이언트를 쓴다.**

**같은 이유로 배제되는 다른 예**: **[[../chapter-9-writing-reactive-web-controllers/06-building-reactive-hypermedia-apis|Ch9]]의 `spring-boot-starter-hateoas`** — **Spring MVC 전용으로 설계됐고 servlet 기반 웹 스택을 끌어온다.**

**일반화하면**:
> **리액티브 프로젝트에서는 "편의 도구"가 웹 스택이나 데이터 스택을 함께 결정하지 않는지 매번 확인해야 한다.**

**패턴이 같다**:
```
편의 도구를 넣는다  →  그것이 전제하는 스택이 딸려 온다  →  런타임이 바뀐다
```

**그리고 [[../chapter-9-writing-reactive-web-controllers/02-creating-a-webflux-application|Ch9]]에서 본 대로 겉으로 티가 안 난다** — **코드가 컴파일되고 돌아간다.** 성능만 안 나오거나, 엉뚱한 서버가 뜬다.

**확인 습관**: 의존성을 추가할 때 **전이 의존성 트리**를 본다(`mvn dependency:tree`). `spring-boot-starter-web`이나 `spring-jdbc`가 딸려 오면 신호다.

---

## Q4. R2DBC와 Spring Data R2DBC의 층 차이

> **앞의 것은 명세, 뒤의 것은 그 위의 툴킷이다.**

```
Spring Data R2DBC   ← repository 추상화, 매핑, 편의 API
        ↑
R2DBC (명세)        ← 드라이버가 구현해야 할 인터페이스
        ↑
r2dbc-h2 (드라이버) ← H2 와 실제로 말한다
        ↑
H2 (데이터베이스)
```

**JDBC 세계와 대응시키면**:
| R2DBC 세계 | JDBC 세계 |
|---|---|
| Spring Data R2DBC | Spring Data JPA |
| R2DBC (명세) | JDBC (명세) |
| `r2dbc-h2` | H2 JDBC 드라이버 |

**명세가 저수준이라 툴킷 없이 쓰면 코드가 장황해진다**(Q2).

**비유로 보면** 전기 규격 — **JDBC는 오래된 콘센트 규격**이라 새 기능을 넣을 수 없었고, **R2DBC는 새 규격**, **`r2dbc-h2` 같은 드라이버는 그 규격에 맞는 어댑터**, **Spring Data R2DBC는 그 위에 얹는 멀티탭**이다.

**깨지는 지점 둘**:
- **콘센트는 어댑터만 있으면 어느 기기든 꽂히지만 R2DBC 드라이버는 DB마다 따로 있어야 하고, 없는 DB도 있다** → [[01-what-reactive-data-access-requires]]의 **"드라이버 지원을 먼저 확인하라"**
- **멀티탭은 규격을 완전히 감추지만 Spring Data R2DBC는 스키마 정의만은 감춰 주지 않는다** → [[04-loading-data-with-r2dbcentitytemplate]]에서 **저수준 `DatabaseClient`로 다시 내려간다**

**§6의 나머지 경계**: **H2를 production DB로 쓰지 않는다**(이 장의 편의를 위한 대역) · **JPA의 기능을 그대로 기대하지 않는다** — **지연 로딩·연관관계 매핑·영속성 컨텍스트가 없다** → [[03-creating-reactive-repositories-and-r2dbc-access]].

---

## 재출제 문항

1. `h2`만 넣고 기동했다. 어떤 오류가 나는가?
2. R2DBC가 "저수준"인 것이 벤더에게는 왜 이득인가?
3. H2 Console을 쓰고 싶다. 대안은?
4. 새 의존성을 넣기 전에 무엇을 확인하는 습관을 들여야 하는가?
5. Spring Data R2DBC 없이 R2DBC만 쓰면 코드가 어떻게 되는가?
6. Spring Data R2DBC가 감춰 주지 않는 것 하나는?

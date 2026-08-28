# 모범답안 — 06 리액티브 하이퍼미디어 API

> **먼저 답하고 나서 열 것.** [[06-building-reactive-hypermedia-apis]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. 하이퍼미디어가 "장식용 링크가 아니다"

> **진짜 목적은 서버가 리소스의 현재 상태에 따라 클라이언트가 할 수 있는 동작을 안내하는 것이다.**

**`takePTO` 예**:
```
직원 데이터 + takePTO · fileExpenseReport · contactManager 동작
        ↓
모든 동작이 항상 유효한 것은 아니다
        ↓
남은 휴가를 다 쓴 직원에게 takePTO 는 적용돼서는 안 된다
        ↓
업무 규칙에 따라 링크가 나타나거나 사라진다
        ↓
클라이언트는 응답에 있는 링크를 따라가기만 하면 된다
```

> **클라이언트는 작업을 하드코딩하거나 어떤 동작이 적절한지 추론할 필요가 없다.**

**가능하게 하는 것 넷**:
- **런타임 주도 워크플로**
- **클라이언트와 서버 책임의 더 깔끔한 분리**
- **클라이언트를 깨뜨리지 않는 안전한 API 진화**
- **문맥 인식 UI 동작** (예: 버튼을 동적으로 활성화·비활성화)

> **요컨대 하이퍼미디어는 애플리케이션의 내비게이션 로직 일부를 클라이언트에서 API 안으로 옮긴다.**

**벌거벗은 API에 빠진 것이 controls다** — 클라이언트가 목록을 받아도 **개별 조회 URL, 수정, 삭제를 전부 하드코딩**해야 한다.

**사실 우리는 이걸 매일 본다** — **웹 페이지의 내비게이션 링크.** **Amazon에서 상품을 주문할 때 우리가 링크를 제공하지 않는다. 웹 페이지가 준다.**

**대가**(§6): **클라이언트가 링크를 따라가도록 만들어지지 않았다면 링크는 그냥 응답 크기만 늘린다.** **하이퍼미디어의 이득은 양쪽이 함께 구현해야 나온다.** 비유의 깨짐이 이것이다 — **사람은 안내판이 없어도 다른 길을 찾아보지만 하이퍼미디어 클라이언트는 링크가 없으면 그 동작이 불가능하다고 받아들여야** 하고, **대부분의 실제 클라이언트는 URL을 하드코딩한다.**

---

## Q2. `spring-boot-starter-hateoas`를 WebFlux 앱에 넣으면

**Servlet 기반 웹 스택을 끌어와 Reactor Netty에서 도는 리액티브 애플리케이션과 충돌한다.**

> **이 starter는 Spring MVC 전용으로 설계됐고 Spring WebFlux 애플리케이션에 쓰면 안 된다.**
>
> **Spring HATEOAS 자체는 WebFlux를 지원하지만, Boot의 HATEOAS starter가 의도적으로 MVC 스택에 정렬돼 있다.**

**해법**: **Boot starter 대신 `spring-hateoas` 의존성을 직접 추가한다.**

```xml
<dependency>
    <groupId>org.springframework.hateoas</groupId>
    <artifactId>spring-hateoas</artifactId>
</dependency>
```

**Boot의 의존성 관리 덕에 버전은 적지 않는다.**

> **[[02-creating-a-webflux-application]]에서 "웹 스택을 섞으면 안 된다"고 한 것의 구체적 사례다.** **starter가 편의를 주는 대신 웹 스택을 함께 결정한다**는 사실을 알아야 이런 함정을 피한다.

**대가 하나**: **수동으로 꽂았으니 HAL을 직접 켜야 한다** — `@EnableHypermediaSupport(type = HAL)`. **Boot starter를 썼다면 자동 활성화됐을 것**이다. **편의를 포기한 대가가 이 한 줄**이다.

> **`@EnableHypermediaSupport`는 한 번만 쓰면 된다.** 이 책은 간결함을 위해 하이퍼미디어 컨트롤러에 붙였지만, **실제 애플리케이션에서는 `@SpringBootApplication`이 붙은 클래스에 두는 편이 나을 수 있다.**

> **그대로 붙여 넣으면 컴파일되지 않는다**(§5) — `HAL`은 **`HypermediaType.HAL`의 static import를 전제**한다. **책이 import 목록을 보이지 않으므로** `import static org.springframework.hateoas.config.EnableHypermediaSupport.HypermediaType.HAL;`이 필요하다.

---

## Q3. `CollectionModel<EntityModel<T>>` 중첩이 필요한 이유

**단일 항목과 컬렉션은 서로 다른 링크 집합을 가질 수 있기 때문이다.**

```
CollectionModel  ← 컬렉션 전체의 링크 (집합 루트로 가는 self)
  └ EntityModel  ← 각 항목의 링크 (자기 self + 집합 루트로 돌아가는 employees)
      └ Employee ← 업무 데이터
```

> **컬렉션 전체는 하나의 링크 집합(예: 집합 루트로 가는 링크)을 갖고, 각 항목은 자기 단일 리소스 메서드를 가리키는 링크와 집합 루트로 돌아가는 링크를 갖는다.**

**컨테이너 타입 넷**:
| 타입 | 성격 |
|---|---|
| `RepresentationModel` | **핵심 타입.** **상속**해 업무 값과 합치는 방식 |
| **`EntityModel<T>`** | 제네릭 확장. 업무 객체를 static 생성 메서드에 **주입**해 **링크와 업무 로직을 분리** |
| **`CollectionModel<T>`** | `T` 하나가 아니라 **컬렉션**을 표현 |
| `PagedModel<T>` | `CollectionModel` 확장. **한 페이지** 분량 |

**`EntityModel`이 상속이 아니라 주입인 것이 설계 포인트다** — **업무 객체(`Employee` record)를 고치지 않고** 링크를 붙일 수 있다.

**`flatMap`이 집합 루트에서 두 번 나오는 이유도 이 중첩과 관련 있다**:
- **첫 번째** — `Mono<Link>` 안에서 **또 다른 `Mono`를 만들기** 때문
- **두 번째** — **`employee(key)`가 `Mono`를 반환**하기 때문

**[[04-consuming-data-with-reactive-post]]의 "함수 반환 타입이 리액티브면 `flatMap`" 규칙 그대로다.**

**집합 루트가 단일 항목 메서드를 재사용한다는 점도 중요하다** — `employee(key)`를 그대로 부르므로 **링크 생성 로직이 한 곳에** 있다. **웹 컨트롤러 메서드를 하이퍼미디어 렌더링에 직접 물리면, 나중에 메서드를 조정해도 링크가 알아서 따라온다.**

**그것을 가능하게 하는 것이 `methodOn`이다** — **메서드를 실제로 실행하지 않고 호출 기록만 남겨 URL을 역산한다.** 그래서 **`@GetMapping` 경로를 문자열로 중복해 쓰지 않아도 되고, 경로를 바꾸면 링크도 따라 바뀐다.** (**프록시가 호출을 가로채 경로만 기록하므로 그 안에 부수효과가 있는 코드를 두면 안 된다.**)

**§6의 경계**: **항목 수가 많은 컬렉션에서는 항목마다 링크를 만드는 비용이 실재한다.** **`PagedModel`로 나누는 것을 검토한다.**

---

## Q4. HAL 출력의 self 링크 셋 중 어느 것이 문서의 self인가

**맨 아래 것, 즉 `_embedded` 바깥의 최상위 `_links.self`다.**

```json
{
  "_embedded": {
    "employeeList": [
      { "name": "Frodo Baggins", ...,
        "_links": {
          "self":      { ... },   ← ① 이 레코드의 canonical link
          "employees": { ... } } }
    ]
  },
  "_links": { "self": { "href": ".../hypermedia/employees" } }   ← ② 이 문서의 self
}
```

> **하이퍼미디어에서 거의 모든 표현에 self 링크가 들어간다. 문맥이 중요하다.** 위 HAL 출력에는 self가 **세 개**인데, **마지막 것만 이 문서의 self**다. **나머지는 개별 레코드를 조회하는 canonical link**다.

**판단 근거: 위치(중첩 깊이).** `_embedded` **안**의 self는 그 항목의 것이고, **바깥**의 self가 문서 전체의 것이다.

> **링크는 본질적으로 불투명하므로 그것을 따라 해당 레코드로 이동할 수 있다.**

**HAL의 구조**:
- **`_links`가 HAL의 하이퍼미디어 링크 형식**이다. **link relation**(예: `self`)과 **href**를 담는다
- **컬렉션의 self 링크는 맨 아래**에 있고, **각 Employee는 자기를 가리키는 `self`와 집합 루트를 가리키는 `employees` 링크**를 갖는다

**self 링크가 여러 개인 것은 정상이다**(§5) — **컬렉션 응답에는 문서의 self와 각 항목의 self가 함께 있다.**

> **원문의 오타**(§5): 책 p.275의 집합 루트 설명에 **`InIn this case,`**가 있다. `In this case,`의 오타다.

**§6의 나머지 경계**: **내부 전용 API라면 과할 수 있다** — **클라이언트와 서버가 함께 배포된다면 링크의 이득이 작다.**

---

## 재출제 문항

1. 남은 휴가가 0인 직원의 응답에서 `takePTO` 링크가 사라졌다. 클라이언트는 무엇을 해야 하는가?
2. 클라이언트가 URL을 하드코딩하고 있다. 하이퍼미디어의 이득이 남는가?
3. WebFlux 앱에 HATEOAS starter를 넣었더니 Tomcat이 떴다. 왜인가?
4. starter를 안 쓰는 대신 무엇을 직접 해야 하는가?
5. `EntityModel`이 상속이 아니라 주입 방식인 것의 이득은?
6. `methodOn` 안에 부수효과가 있는 코드를 두면 왜 안 되는가?
7. HAL 응답에 self가 다섯 개다. 어느 것이 문서의 self인가?

# 모범답안 — 04b 템플릿에서 데이터를 리액티브하게 다루기

> **먼저 답하고 나서 열 것.** [[04b-reactively-dealing-with-data-in-a-template]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. Chapter 9에서는 한 `map`에 넣을 수 있었는데 여기서는 나눠야 하는 이유

**저장이 리액티브 타입을 반환하기 때문이다.**

**책의 대비**:
> 앞 장에서는 들어온 `Employee` 객체를 **그냥 redirect 요청으로 매핑**했다. **가짜 데이터베이스가 비리액티브라 데이터를 저장하는 데 명령형 호출 하나면 됐기 때문**이다.
>
> 이 장의 `EmployeeRepository`는 리액티브이므로, **`save()`에 집중하는 연산 하나와 그 결과를 redirect 요청으로 바꾸는 다음 연산으로 나눠야** 한다.

```
Ch9:   map(e -> { DATABASE.put(...); return "redirect:/"; })
             └─ 부수효과. 반환 타입은 String → 한 map 으로 끝
Ch10:  flatMap(e -> repository.save(...))    ← Mono<Employee> 반환 → flatMap
       .map(employee -> "redirect:/")        ← String 반환 → map
```

| 단계 | **람다의 반환 타입** | **연산자** |
|---|---|---|
| 저장 | `Mono<Employee>` — **리액티브** | **`flatMap`** |
| redirect 변환 | `String` — 리액티브 아님 | **`map`** |

> **데이터 계층이 리액티브가 되자 그 둘이 자연스럽게 갈라진 것이다.**

**Ch9에서 한 `map`에 넣을 수 있었던 것은 `DATABASE.put(...)`이 명령형 부수효과였기 때문**이고, [[../chapter-9-writing-reactive-web-controllers/04-consuming-data-with-reactive-post|Ch9]]가 그것을 **예제의 단순화**라고 이미 짚었다.

---

## Q2. `repository.save()`에 `map`을 쓰면

**`Mono<Mono<Employee>>`가 되고, 그다음 `map`의 람다가 안쪽 `Mono`를 받게 되어 타입이 어긋난다.**

```
newEmployee                      : Mono<Employee>
  .map(e -> repository.save(e))  : Mono<Mono<Employee>>     ← 중첩
  .map(employee -> "redirect:/") : 이 employee 가 Mono<Employee> 다
                                   → e.name() 같은 호출이 안 된다
```

> **그 뒤의 `map(employee -> ...)`은 바깥 `Mono`의 값인 안쪽 `Mono`를 받게 되어 타입이 어긋난다.**

**`flatMap`이 그 중첩을 걷어낸다** — **map한 결과가 다시 컨테이너일 때 한 단계로 평탄화**한다.

**책이 이 판단 기준을 명시적으로 말한다**:
> **`save()`의 응답이 Reactor `Mono` 클래스에 감싸여 있어 `flatMap`을 써야 했다.** employee를 `"redirect:/"`로 바꾸는 데는 **Reactor 타입이 관여하지 않으므로 단순 `map`이면 충분**하다.

**조회 쪽은 반대로 한 줄이 줄었다** — `repository.findAll()`이 **이미 `Flux`를 주므로** [[../chapter-9-writing-reactive-web-controllers/05a-creating-a-reactive-web-controller|Ch9]]의 `fromIterable` 한 줄만 사라졌다. **나머지(`collectList`, `Rendering` builder, 두 모델 속성)는 전부 동일하다.**

---

## Q3. `index.html`이 그대로인 것이 뜻하는 것

**계층 분리가 제대로 되어 있으면 저장소 교체가 화면에 닿지 않는다.**

> **데이터 계층을 리액티브로 바꿨는데 뷰는 한 글자도 바뀌지 않았다.**

```
데이터 계층:  Map → R2DBC repository        (통째로 교체)
컨트롤러:     fromIterable 한 줄 삭제, map → flatMap 분리
템플릿:       변경 없음
```

**왜 그런가**: 템플릿이 받는 것은 **`List<Employee>`라는 모델 속성**이고, 그것은 **데이터가 어디서 왔는지 모른다.** 리액티브 타입은 **컨트롤러 경계에서 `collectList`로 풀리므로** 뷰까지 내려가지 않는다.

**이것이 계층 분리의 값이다** — **변경의 파급 범위가 계층 하나에 머문다.**

**다만 무조건 좋기만 한 것은 아니다** — `collectList`가 **스트리밍을 끊는다**([[../chapter-9-writing-reactive-web-controllers/05a-creating-a-reactive-web-controller|Ch9]]). 뷰가 리액티브를 모르는 대가로 **점진적 렌더링을 포기**한 것이다.

---

## Q4. `e.getName()`과 `e.name()`

**`e.name()`이 맞다. `Employee`가 record이기 때문이다.**

> **원문의 접근자 불일치**(§5): 책 p.293의 이 메서드는 **`e.getName()`·`e.getRole()`**을 호출한다. 그런데 **`Employee`는 record이므로 접근자는 `e.name()`·`e.role()`**이다.
>
> **같은 장 p.290의 API용 POST([[04a-returning-data-reactively-to-an-api-controller]])는 올바르게 `e.name()`을 쓴다.** **즉 같은 타입에 두 가지 접근자 문법이 섞여 있고, 그대로 따라 쓰면 컴파일되지 않는다.**

**근거**: [[03-creating-reactive-repositories-and-r2dbc-access]]에서 정의한 `Employee`가 **record**다. **record는 `getX()`가 아니라 컴포넌트 이름 그대로의 접근자를 생성**한다.

> **그리고 p.294가 "템플릿은 변경 없이 복사하라"고 끝난다** — 앞 장 템플릿의 **`th:field="*{name}"`은 record 접근자에 의존**한다. 위 오류와 합치면 **어느 쪽이 맞는지 독자가 스스로 판단해야 하는 상태**로 장이 마무리된다. **정답은 record 접근자(`name()`)다.**

**§6의 나머지 경계**:
- **저장 성공만으로 redirect하지 않는다** — **실패 경로(`onErrorResume`)를 두지 않으면 오류가 500으로 나간다**
- **`findAll()`을 화면에 그대로 걸지 않는다** — **행이 늘면 페이지가 무한정 길어진다**
- **엔티티를 폼 바인딩 대상으로 그대로 쓰지 않는다** — **`id`가 폼에 노출될 수 있다**

**그리고 저장 결과를 버리고 있다**(§5) — `map(employee -> "redirect:/")`는 **새로 생긴 `id`를 쓰지 않는다.** 상세 페이지로 보내려면 `map(e -> "redirect:/employees/" + e.id())`처럼 활용할 수 있다.

**비유의 깨짐도 여기 있다** — 주방 주문 처리에서 **접수증에는 주문 번호가 찍히지만 이 코드는 저장된 `Employee`를 받고도 버린다.** (다른 하나: **사람은 접수증을 기다리는 동안 가만히 서 있지만 리액티브에서는 그 스레드가 다른 일을 한다** — "기다린다"는 표현이 정확하지 않다.)

---

## 재출제 문항

1. `DATABASE.put(...)`과 `repository.save(...)`의 반환 타입 차이가 코드 구조를 어떻게 바꾸는가?
2. `map`으로 저장했더니 다음 `map`에서 `e.name()`이 안 된다. 왜인가?
3. 저장소를 MongoDB로 또 바꾸면 템플릿을 고쳐야 하는가?
4. 뷰가 리액티브를 모르는 대가로 무엇을 포기했는가?
5. 책을 그대로 따라 썼는데 컴파일이 안 된다. 어디인가?
6. 저장 후 상세 페이지로 보내려면 무엇을 활용해야 하는가?

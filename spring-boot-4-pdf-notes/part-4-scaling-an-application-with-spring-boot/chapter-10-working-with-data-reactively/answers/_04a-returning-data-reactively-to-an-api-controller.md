# 모범답안 — 04a API 컨트롤러에 리액티브하게 데이터 반환

> **먼저 답하고 나서 열 것.** [[04a-returning-data-reactively-to-an-api-controller]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. Chapter 9의 "손질"이 사라진 이유

**데이터 소스가 애초에 리액티브이기 때문이다.**

> **앞 장에는 단순한 Java `Map`이 있어서 리액티브하게 만들려면 손질(finagling)이 좀 필요했다.** `EmployeeRepository`가 `ReactiveCrudRepository`를 확장하므로 **메서드의 반환 타입에 리액티브 타입이 이미 구워져 있다 — 손질이 필요 없다!**

```java
// Ch9:  Flux.fromIterable(DATABASE.values()) ... collectList()  ← 감쌌다 푼다
// Ch10: repository.findAll()                                    ← 그대로
```

**[[../chapter-9-writing-reactive-web-controllers/05a-creating-a-reactive-web-controller|Ch9]]에서 "감쌌다 도로 푸는 것이 이상해 보인다"고 했던 그 이상함이 여기서 사라진다.**

> **이것이 "end-to-end 리액티브"의 실제 모습이다 — 경계마다 변환이 필요 없다.**

**일반화하면**: **경계에서 변환이 필요하다는 것은 그 너머가 다른 패러다임이라는 신호**다. 변환이 사라졌다는 것은 **패러다임이 끝까지 이어졌다**는 뜻이고, 그것이 [[01-what-reactive-data-access-requires]]가 요구한 것이다.

---

## Q2. `map`을 썼다면 / `flatMap`의 판단 기준

**`Mono<Mono<Employee>>`가 됐을 것이다.**

**책이 스스로 묻고 답한다**:
> 왜 `flatMap`하나? … **`save()`가 돌려준 것이 `Employee` 객체가 아니었기 때문이다. `Mono<Employee>`였다.** 그것 위를 `map`했다면 **`Mono<Mono<Employee>>`**가 됐을 것이다.

**판단 기준**:
> **람다의 반환 타입이 리액티브 타입이면 `flatMap`.**

**[[../chapter-9-writing-reactive-web-controllers/04-consuming-data-with-reactive-post|Ch9]]에서 본 규칙 그대로다.**

**책의 실무 팁**:
> **무엇을 해야 할지 모르겠거나 Reactor API가 나를 방해하는 것 같을 때, 비밀은 대개 `flatMap()`이다.** 모든 Reactor 타입이 `flatMap`을 지원하도록 심하게 오버로드돼 있어 **`Flux<Flux<?>>`, `Mono<Mono<?>>`와 그 모든 조합**이 `flatMap()`만 걸면 잘 풀린다.

---

## Q3. 들어온 `Employee`의 `id`를 버리는 것이 보안 판단인 이유

**클라이언트가 보낸 `id`를 그대로 쓰면 남의 행을 덮어쓸 수 있기 때문이다.**

```java
Employee employeeToLoad = new Employee(e.name(), e.role());   // id 를 버린다
return repository.save(employeeToLoad);
```

**[[03-creating-reactive-repositories-and-r2dbc-access]]에서 봤듯 repository는 기본 키로 insert인지 update인지 판단한다.**

```
클라이언트가 { "id": 1, "name": "해커", "role": "admin" } 을 POST
        ↓ id 를 그대로 쓰면
save() 가 UPDATE 로 판단
        ↓
id=1 인 기존 행이 덮어써진다
```

> **여기서 새로 만드는 것이 그 방어다.**

**"예제 단순화가 아니다"**(§5) — **이것은 보안 판단이다.** **실제 API에서는 여기서 더 나아가 요청 DTO와 엔티티를 아예 분리한다.**

**§6의 관련 지침**: **클라이언트가 보낸 `id`를 신뢰하지 않는다** · **엔티티를 그대로 API 응답으로 내보내지 않는다** — **DB 컬럼 변경이 API 계약을 깨뜨린다.**

> **원문의 오타**(§5): 책 p.291 POST 메서드 코드의 닫는 중괄호 앞에 **`});f`**로 `f` 한 글자가 붙어 있다. **그대로 복사하면 컴파일되지 않는다.** 올바른 형태는 `});`다.

---

## Q4. `then()` 앞에 `flatMap()`을 두라는 조언이 가리키는 문제

**"조립만 되고 실행되지 않는 단계"다.**

> **`then()` 앞에 `flatMap()`을 쓰면 대개 이전 단계가 수행됨을 보장한다.**

**`then()`은 앞 단계의 값을 버린다** — 완료 시그널만 받아 넘어간다. **앞 단계가 아직 조립만 된 상태면 실행 자체가 건너뛰어질 수 있다.**

```
someFlux.then(next)          ← 앞의 값이 필요 없다고 표현했을 뿐
                               앞이 제대로 이어져 있지 않으면 건너뛴 것처럼 보인다
someFlux.flatMap(x -> op(x)) ← 명시적으로 이어 둔다
        .then(next)
```

> **`flatMap`으로 명시적으로 이어 두면 그 위험이 준다.**

**이것이 리액티브의 일반 함정과 같은 뿌리다** — [[../chapter-9-writing-reactive-web-controllers/01b-reactive-streams-details|Ch9]]의 **"구독하기 전에는 아무 일도 없다"**, [[04-loading-data-with-r2dbcentitytemplate]]의 **"`subscribe()`를 빼면 아무것도 안 한다"**. **조립과 실행의 분리가 매번 다른 얼굴로 나타난다.**

**함께 기억할 경계들**:
- **`findAll()`의 위험**(§5): **타입은 `Flux<Employee>`로 같지만 행이 백만 개면 백만 개가 흐른다.** **배압이 있어 메모리는 터지지 않지만 응답이 끝나지 않는다.** **실제로는 페이징을 건다.**
- **`block()`을 부르지 않는다** — **repository가 리액티브인 이유가 사라진다.**

**비유의 깨짐도 함께**: 택배 대행 — **repository는 이미 컨베이어에 실려 오는 상자**라 그대로 흘려보내면 된다. **깨지는 지점 둘** —
- **컨베이어의 상자는 눈으로 세어 볼 수 있지만 `Flux`는 몇 개인지 미리 알 수 없다**
- **택배는 받은 상자를 그대로 전달할 수 있지만 저장은 새 상자를 돌려준다**(`id`가 채워진) — 그래서 **`map`이 아니라 `flatMap`**이다

---

## 재출제 문항

1. 경계에서 변환이 필요하다는 것은 무엇의 신호인가?
2. `repository.save()`에 `map`을 걸었다. 타입이 어떻게 되는가?
3. 클라이언트가 `id`를 포함해 POST했다. 그대로 저장하면 무슨 일이 생기는가?
4. 요청 DTO와 엔티티를 분리하는 것이 왜 더 나은가?
5. `then()` 앞 단계가 실행되지 않은 것 같다. 무엇을 확인하는가?
6. `findAll()`이 백만 행을 반환한다. 메모리는 안 터지는데 무엇이 문제인가?

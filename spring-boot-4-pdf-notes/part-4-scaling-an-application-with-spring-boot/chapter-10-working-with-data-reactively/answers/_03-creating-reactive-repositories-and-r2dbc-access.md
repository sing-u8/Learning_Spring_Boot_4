# 모범답안 — 03 리액티브 repository와 R2DBC 접근

> **먼저 답하고 나서 열 것.** [[03-creating-reactive-repositories-and-r2dbc-access]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `JpaRepository`와 `ReactiveCrudRepository`의 근본 차이

**반환 타입이다.**

> **블로킹 값이 아니라 리액티브 타입을 반환한다.** `findAll()`이 `List<Employee>`가 아니라 **`Flux<Employee>`**를, `save()`가 `Employee`가 아니라 **`Mono<Employee>`**를 준다.

```java
public interface EmployeeRepository extends ReactiveCrudRepository<Employee, Long> {}
//                                          └────────┬─────────┘   └───┬──┘ └─┬─┘
//                                          리액티브 CRUD          도메인  기본 키
```

> **이것이 데이터 스토어와의 논블로킹 상호작용을 가능하게 한다.**

**[[01-what-reactive-data-access-requires]]의 요구가 여기서 충족된다** — 반환 타입이 값이면 **그 값이 있어야 반환**할 수 있고, 그것이 블로킹을 강제했다. `Flux`/`Mono`는 **아직 없는 것을 반환**할 수 있다.

**두 번째 성질도 중요하다**: **R2DBC 전용이 아니다.** 이 인터페이스는 **Spring Data Commons에 있고 여러 리액티브 Spring Data 모듈이 공유**한다. **MongoDB 리액티브 repository도 같은 인터페이스를 쓴다.** **데이터 스토어를 바꿔도 이 선언은 그대로다.**

**그 밖의 구조는 Ch3와 거의 같다** — **Spring Data가 런타임에 구현을 자동 생성**하고, **도메인 타입과 기본 키 타입**을 제네릭으로 준다.

---

## Q2. Ch9의 record로는 왜 부족한가

**식별자가 없어서 repository가 아무것도 판단할 수 없다.**

```java
public record Employee(String name, String role) {}   // Ch9
```

**단순한 데이터 운반자로만 쓰일 때는 충분했다** — `Flux.just(...)`나 `Map`에 넣는 용도라면 식별자가 필요 없다.

**판단되지 않는 것 둘**:
| repository의 일 | 필요한 것 |
|---|---|
| **`findById(id)`** | **무엇으로 찾을지** |
| **`save()`** | **이것이 새 행인지 기존 행의 갱신인지** |

> **그 판단의 근거가 식별자다.**

**확장된 record**:
```java
public record Employee(@Id Long id, String name, String role) {
    public Employee(String name, String role) { this(null, name, role); }
}
```

| 요소 | **왜** |
|---|---|
| `id` | **repository가 행을 식별하려면 필요** |
| **`@Id`** | **어느 필드가 키인지 알려 줘야 한다** |
| 보조 생성자 | **새 레코드를 넣을 때는 DB가 식별자를 생성**하므로 `null`로 초기화 |

> **`@Id`가 JPA의 것이 아니라는 점이 중요하다** — `jakarta.persistence.Id`가 아니라 **`org.springframework.data.annotation.Id`**(Spring Data Commons)다.

**실무에서 물리는 이유**: **IDE 자동 완성이 JPA 쪽을 먼저 제안한다.** **프로젝트에 JPA와 R2DBC가 함께 있으면 잘못된 `@Id`를 import하고도 컴파일은 통과한다.**

---

## Q3. R2DBC에서 record를 엔티티로 쓸 수 있는 이유

**영속성 컨텍스트가 없기 때문이다.**

| | **JPA** | **R2DBC** |
|---|---|---|
| 영속성 컨텍스트 | **있다** | **없다** |
| 엔티티 | **가변 객체여야** 한다 | **불변 record가 통한다** |
| 이유 | **영속성 컨텍스트가 생명주기를 관리**하고 **dirty checking**으로 변경을 감지 | 변경 감지가 없으므로 **객체를 고칠 필요가 없다** |

> **JPA 엔티티는 영속성 컨텍스트가 생명주기를 관리하는 가변 객체여야 해서 record를 쓸 수 없었다. R2DBC는 영속성 컨텍스트가 없으므로 불변 record가 그대로 통한다.**

**얻는 것**: **`equals`·`hashCode`·`toString`과 접근자를 Java record가 자동 생성**하므로 **도메인 타입이 간결하게 유지되면서도 Spring Data의 매핑 인프라와 완전히 호환**된다.

**잃는 것도 같은 데서 온다**(§5): **지연 로딩, 연관관계 매핑, 영속성 컨텍스트, dirty checking이 R2DBC에는 없다.**

> **그래서 record가 가능해진 것이기도 하고, 동시에 JPA 습관대로 쓰면 기대가 어긋난다.**

**즉 하나의 사실의 양면이다** — **JPA의 편의가 없어진 대가로 불변성이 가능해졌다.** [[../../part-0-jpa-foundations/chapter-j1-persistence-context/01-persistence-context-and-first-level-cache|영속성 컨텍스트]]가 주던 것 전부가 함께 사라진다.

**§6의 경계**: **JPA의 연관관계가 필요하면 R2DBC로 그대로 옮길 수 없다.** **조인과 매핑을 직접 다뤄야 한다.**

---

## Q4. `id` 없는 보조 생성자가 문법 편의 이상인 이유

**`id`를 `null`로 두는 것이 "이건 새 행"이라는 신호이고, `save()`의 insert/update 판단이 여기 달려 있다.**

```java
public Employee(String name, String role) { this(null, name, role); }
//                                               ↑ 이것이 신호다
```

```
id == null  →  save() 가 INSERT
id != null  →  save() 가 UPDATE
```

**틀리면 무슨 일이 생기나**: **클라이언트가 보낸 `id`를 그대로 저장하면 새 행이어야 할 것이 갱신이 된다.** 그 키의 행이 없으면 **아무것도 저장되지 않거나 예외**가 나고, **있으면 남의 행을 덮어쓴다.**

**그래서 §6의 지침이 나온다** — **`id`를 클라이언트 입력으로 받지 않는다** → [[04a-returning-data-reactively-to-an-api-controller]]에서 **들어온 `id`를 의도적으로 버린다.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/02-testing-domain-objects|Ch5]]의 `assertThat(entity.getId()).isNull()` 테스트가 검증한 것이 정확히 이 계약이다** — JPA에서도 R2DBC에서도 **같은 규칙**이 작동한다.

**비유로 보면** 도서관 장서 등록 — **Ch9의 `Employee`는 메모지에 적은 책 제목**이고 **DB에 넣으려면 청구기호가 있어야** 한다. **새 책을 등록할 때는 청구기호를 사서(DB)가 붙여 주므로 우리는 비워 둔다.**

**깨지는 지점 둘**:
- **도서관 사서는 같은 책이 이미 있는지 제목으로 확인하지만 repository는 오직 `id`로만 판단한다** — **`id`가 `null`이면 무조건 새 행**이다
- **청구기호는 붙이고 나서도 고칠 수 있지만 record의 `id`는 불변**이라, **저장 후에는 새 인스턴스를 받아야 한다** — **`save()`가 `Mono<Employee>`를 돌려주는 이유**다

**마지막 항목이 중요하다** — 불변 record에서는 `save()`가 **생성된 `id`를 원래 객체에 채워 줄 수 없다.** 그래서 **반환값을 받아 써야** 한다.

**§6의 나머지**: **`@Id`를 두 종류 섞어 쓰지 않는다** · **스키마는 여전히 우리 몫이다** — **repository가 있다고 테이블이 생기지 않는다** → [[04-loading-data-with-r2dbcentitytemplate]].

---

## 재출제 문항

1. `ReactiveCrudRepository`의 반환 타입이 왜 논블로킹을 가능하게 하는가?
2. MongoDB로 데이터 스토어를 바꾸면 repository 선언을 고쳐야 하는가?
3. JPA와 R2DBC가 한 프로젝트에 있다. `@Id`를 쓸 때 무엇을 확인하는가?
4. R2DBC에서 record가 되는데 JPA에서 안 되는 이유를 한 단어로 말하면?
5. 클라이언트가 `id: 5`를 보냈고 그대로 저장했다. 무슨 일이 생기는가?
6. `save()`의 반환값을 버리면 무엇을 잃는가?

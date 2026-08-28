---
category: chapter-c1-container-lifecycle
concept: eager-singletons-and-circular-references
title: "순환 참조 — 왜 생성자 주입에서만 시작이 실패하는가"
source: "Spring Framework Reference — Core/IoC Container · Dependencies (Dependency Resolution Process · Circular dependencies) · Bean Scopes / Spring Boot Reference — SpringApplication (Lazy Initialization) · SpringApplication.setAllowCircularReferences (since 2.6.0) / 대조: Learning Spring Boot 4, Ch. 1, 책 pp. 6-8"
terms: [순환-참조, 조기-노출, 프로토타입-스코프]
related: [01-beandefinition-and-metadata-phase, 02-two-postprocessor-extension-points, 03-bean-creation-and-lifecycle-callbacks]
status: prepared
---

# 순환 참조 — 왜 생성자 주입에서만 시작이 실패하는가

## 한눈에 보기

| 질문 | 핵심 답 |
|---|---|
| 생성자 주입으로 A↔B를 엮으면? | 시작 자체가 실패한다. `BeanCurrentlyInCreationException`. |
| setter 주입으로 바꾸면 왜 되나? | **인스턴스화와 주입 사이에 틈**이 생겨, 미완성 객체를 먼저 건네줄 수 있기 때문이다. |
| Spring Boot 기본값은? | **순환 참조 금지**(`spring.main.allow-circular-references=false`, 2.6.0부터). |
| 그럼 setter로 바꾸면 되나? | 켜야 동작하고, 공식 문서가 권하지 않는다. **설계를 고치라는 신호**로 읽는 게 맞다. |
| 왜 시작 시점에 터지나? | 싱글턴을 [[사전-인스턴스화]]하기 때문이다. 이건 손해가 아니라 이득이다. |
| prototype 빈을 싱글턴에 주입하면? | 주입은 **딱 한 번**만 일어난다. 매번 새 인스턴스를 원하면 `ObjectProvider`를 쓴다. |

## 1. 왜 이게 필요한가

### 출발 장면: 메서드 하나 옮겼더니 애플리케이션이 안 뜬다

원료 서비스에서 성분 이름을 포맷하는 일이 필요해져, 이미 있는 `SubstanceService`를 주입받았다.

```java
@Service
public class MaterialService {
    private final SubstanceService substanceService;

    public MaterialService(SubstanceService substanceService) {   // ← 이 줄을 추가했다
        this.substanceService = substanceService;
    }
}

@Service
public class SubstanceService {
    private final MaterialService materialService;                // ← 원래 있던 줄

    public SubstanceService(MaterialService materialService) {
        this.materialService = materialService;
    }
}
```

한 줄 추가했을 뿐인데 애플리케이션이 아예 뜨지 않는다.

```text
***************************
APPLICATION FAILED TO START
***************************

Description:

The dependencies of some of the beans in the application context form a cycle:

┌─────┐
|  materialService defined in file [.../MaterialService.class]
↑     ↓
|  substanceService defined in file [.../SubstanceService.class]
└─────┘

Action:

Relying upon circular references is discouraged and they are prohibited by
default. Update your application to remove the dependency cycle between beans.
As a last resort, it may be possible to break the cycle automatically by
setting spring.main.allow-circular-references to true.
```

주목할 것은 **컴파일은 통과했다**는 점이다. Java 문법으로는 아무 문제가 없다. 문제는 "이 두 객체를 만들 수 있는 순서가 존재하지 않는다"는 것이고, 그건 컴파일러가 볼 수 없는 영역이다.

### 여기서 뭐가 무너지나

생성자 주입의 계약을 그대로 읽어 보면 답이 나온다. **"생성자를 부르려면 인자가 이미 준비돼 있어야 한다."**

- `MaterialService`를 만들려면 → 완성된 `SubstanceService`가 필요하다.
- `SubstanceService`를 만들려면 → 완성된 `MaterialService`가 필요하다.

어느 쪽을 먼저 시작해도 상대를 요구받고, 상대는 다시 나를 요구한다. 공식 문서의 표현대로 **"고전적인 닭과 달걀"**이다. 컨테이너는 이 상태를 런타임에 감지하고 **[[순환-참조]]**(= 두 개 이상의 빈이 서로를 의존해 생성 순서를 정할 수 없는 상태)로 판정해 `BeanCurrentlyInCreationException`을 던진다.

예외 이름이 상황을 그대로 말한다 — "이 빈은 **지금 생성 중**입니다". 만들어 달라고 요청받은 빈이 이미 자기 생성 스택에 올라와 있다는 뜻이다.

비유하자면 **서로에게 먼저 서명하라고 요구하는 두 계약서**다. A 문서는 "B가 서명된 뒤에만 유효", B 문서는 "A가 서명된 뒤에만 유효". 둘 다 규칙을 어기지 않았지만 아무도 첫 서명을 할 수 없다.

→ 비유가 깨지는 지점: 계약서는 사람이 합의하면 "동시에 서명"이라는 편법이 통한다. 객체 생성에는 그런 동시성이 없다 — JVM에서 생성자 호출은 반드시 한 번에 하나씩, 순서대로 일어난다. Spring이 뒤에서 쓰는 우회로([[조기-노출]])도 "동시에"가 아니라 **"미완성인 채로 먼저 넘긴다"**는 전혀 다른 타협이다.

### 그래서 나온 생각

주입 방식을 바꾸면 순서에 틈이 생긴다. **객체를 만드는 일과 의존성을 채우는 일을 분리하면**, 미완성 상태의 객체를 상대에게 먼저 건네줄 수 있다. 그 틈이 있느냐 없느냐가 생성자 주입과 setter 주입을 가른다.

## 2. 어떻게 동작하는가

### 2.1 setter 주입에는 왜 틈이 있는가

두 방식에서 [[03-bean-creation-and-lifecycle-callbacks]]의 1·2단계가 어떻게 달라지는지 보면 명확하다.

```text
[생성자 주입]
  1. 인스턴스화 ─── 이 안에서 의존성이 필요하다
     new MaterialService(substanceService)
                        └── 없으면 이 줄을 실행조차 못 한다
  → 1단계와 2단계가 한 덩어리다. 틈이 없다.

[setter 주입]
  1. 인스턴스화        new MaterialService()        ← 의존성 없이 성공
       ▼  ◀── 여기가 틈이다. 미완성 객체가 이미 존재한다
  2. 프로퍼티 주입     setSubstanceService(...)
  → 1단계가 2단계 없이 먼저 끝난다.
```

setter 주입에서 컨테이너는 이 틈을 이용한다. `MaterialService`를 인스턴스화한 직후, 아직 의존성이 안 채워진 그 객체를 내부 캐시에 등록해 둔다. 이것이 **[[조기-노출]]**(= 아직 초기화가 끝나지 않은 싱글턴을 다른 빈에게 미리 참조로 내주는 것)이다. 그다음 `SubstanceService`를 만들면서 그 미완성 참조를 넣어 주고, 완성된 `SubstanceService`를 다시 `MaterialService`에 채운다.

공식 문서는 이 타협의 대가를 숨기지 않는다 — 순환 의존이 있으면 *"두 빈 중 하나는 자신이 완전히 초기화되기 전에 다른 빈에 주입되도록 강요된다."* 즉 `SubstanceService`가 잠시 들고 있는 `MaterialService`는 **필드가 아직 비어 있는 객체**다. 그 시점에 메서드를 부르면 `NullPointerException`이 난다.

Spring Boot는 이 동작을 기본으로 켜 두지 않는다. `SpringApplication.setAllowCircularReferences`의 기본값은 `false`이며(2.6.0부터), 이 값이 컨텍스트 refresh 전에 빈 팩터리에 설정되어 **프레임워크가 조기 노출로 사이클을 깨려는 시도 자체를 할지**를 결정한다.

### 2.2 왜 하필 "시작 시점"에 터지는가

이 실패가 런타임 한참 뒤가 아니라 기동 중에 나는 것은 [[01-beandefinition-and-metadata-phase]]의 [[사전-인스턴스화]] 덕분이다.

1. **컨테이너가 [[빈-정의]]를 전부 모은다.** — 전체를 봐야 의존 그래프를 그릴 수 있기 때문이다.
2. **싱글턴을 하나씩 실제로 만들어 본다.** — 정의 검증만으로는 생성 시점의 문제를 못 잡기 때문이다.
3. **생성 스택에 이미 올라온 빈을 다시 요구받으면 사이클로 판정한다.** — 그대로 두면 무한 재귀로 스택이 터지기 때문이다.
4. **Boot의 실패 분석기가 사이클을 사람이 읽을 수 있는 그림으로 바꾼다.** — 예외 스택만으로는 어느 빈들이 고리를 이루는지 알 수 없기 때문이다.

**이 실패는 손해가 아니라 이득이다.** 사전 인스턴스화가 없었다면 이 설계 결함은 첫 요청이 들어오는 순간, 운이 나쁘면 운영 환경에서 드러났을 것이다.

같은 이유로 `spring.main.lazy-initialization=true`는 이 안전망을 약화시킨다. 빈을 나중에 만들면 사이클도 나중에 발견된다.

### 2.3 왜 "켜서 해결"하지 않는가

`spring.main.allow-circular-references=true`를 넣으면 대개 애플리케이션은 뜬다. 그런데도 Boot의 실패 메시지가 이것을 **"최후의 수단(as a last resort)"**이라고 표현하는 데는 이유가 있다.

- **미완성 객체가 돌아다닌다.** 2.1에서 본 대로 한쪽은 필드가 빈 상태로 주입된다. 그 시점에 상대 메서드를 부르는 코드(예: 생성자나 `@PostConstruct`)가 있으면 `NullPointerException`이 난다.
- **프록시와 충돌할 수 있다.** [[02-two-postprocessor-extension-points]]에서 봤듯 프록시는 초기화가 끝난 뒤 씌워진다. 그런데 조기 노출은 그 전에 참조를 내준다. 그래서 "원본을 이미 남에게 넘겼는데 나중에 프록시로 감싸졌다"는 상태가 생길 수 있고, 이때 Spring은 시작을 실패시킨다. `@Transactional`이 붙은 빈이 사이클에 끼면 켜도 안 뜨는 경우가 여기서 나온다.
- **사이클은 대개 책임 분리가 잘못됐다는 신호다.** A와 B가 서로를 필요로 한다면, 둘이 공유하는 무언가가 제3의 클래스로 나와야 할 가능성이 높다.

공식 문서의 입장도 분명하다. Spring 팀은 생성자 주입을 권하는데, 그 근거로 **불변 객체로 만들 수 있다는 점, 필수 의존성이 `null`이 아님이 보장된다는 점, 그리고 완전히 초기화된 상태로 호출자에게 반환된다는 점**을 든다. 순환 참조를 setter로 푸는 것은 이 세 가지를 전부 포기하는 것이다.

**해결의 정석은 셋 중 하나다.**

| 방법 | 언제 | 대가 |
|---|---|---|
| 공통 로직을 제3의 빈으로 추출 | 대부분의 경우 — **정석** | 클래스가 하나 는다 |
| 한쪽을 `ObjectProvider`로 지연 조회 | 한쪽이 상대를 가끔만 쓸 때 | 호출부가 `getObject()`로 지저분해진다 |
| 이벤트로 방향을 끊는다 | 한쪽이 "알리기만" 하면 될 때 | 흐름 추적이 어려워진다 |

### 2.4 스코프가 만드는 또 하나의 순서 함정

**[[프로토타입-스코프]]**(= 요청할 때마다 새 인스턴스를 만들어 주고 이후는 관리하지 않는 스코프)를 싱글턴에 주입할 때도 "언제 주입되는가"가 문제가 된다.

공식 문서가 명확히 경고한다 — *"prototype 스코프 빈을 싱글턴 스코프 빈에 의존성 주입하면, 새 prototype 빈이 하나 인스턴스화되어 싱글턴 빈에 주입된다. **그 prototype 인스턴스가 싱글턴 빈에 공급되는 유일한 인스턴스다.**"*

즉 `@Scope("prototype")`을 붙였는데도 싱글턴이 들고 있는 것은 **영원히 같은 객체 하나**다. 주입이 싱글턴 생성 시점에 딱 한 번 일어나기 때문이다. 문서는 이유를 이렇게 정리한다 — 그 주입은 컨테이너가 싱글턴 빈을 인스턴스화하며 의존성을 해석하고 주입할 때 **단 한 번만** 일어난다.

매번 새 인스턴스가 필요하면 주입 지점을 `ObjectProvider<T>`로 선언하고 필요한 순간 `getObject()`를 부른다. 문서의 표현으로, 인스턴스를 붙들고 있거나 따로 저장하지 않고 필요할 때마다 현재 인스턴스를 가져오는 방식이다.

prototype에는 [[03-bean-creation-and-lifecycle-callbacks]]에서 본 함정이 하나 더 있다 — **[[소멸-콜백]]이 불리지 않는다.** 컨테이너가 건네준 뒤로는 기록을 갖지 않기 때문이다.

## 3. 그림으로 보기

### 틈의 유무가 사이클의 성패를 가른다

```mermaid
%%{init: {'theme': 'dark'}}%%
flowchart TD
    subgraph CTOR["생성자 주입 — 틈이 없다"]
        A1["MaterialService 생성 시작"] --> A2["인자로 SubstanceService 요구"]
        A2 --> A3["SubstanceService 생성 시작"]
        A3 --> A4["인자로 MaterialService 요구"]
        A4 --> A5["이미 생성 스택에 있음<br/>BeanCurrentlyInCreationException"]
    end
    subgraph SETTER["setter 주입 — 틈이 있다"]
        B1["MaterialService 인스턴스화<br/>(의존성 없이 성공)"] --> B2["미완성 객체를 캐시에 조기 노출"]
        B2 --> B3["SubstanceService 생성<br/>미완성 참조를 주입받음"]
        B3 --> B4["완성된 SubstanceService 를<br/>MaterialService 에 주입"]
        B4 --> B5["둘 다 완성"]
    end
```

### 조기 노출이 감수하는 위험

```text
   시간 ──────────────────────────────────────────────▶

   MaterialService 인스턴스화
        │  substanceService = null
        ▼
   ┌──── 이 구간의 MaterialService 는 반쪽짜리다 ────┐
   │                                                  │
   │   SubstanceService 생성                          │
   │     materialService ← (필드가 빈 객체)            │
   │                                                  │
   │   ⚠ 이 구간에서 materialService 의 메서드를        │
   │     호출하면 NullPointerException                 │
   │     (생성자·@PostConstruct 안이 특히 위험)         │
   │                                                  │
   └──────────────────────────────────────────────────┘
        │
        ▼  setSubstanceService(완성본)
   MaterialService 완성

   → "순환(circular)"은 의존 그래프에 고리가 있다는 뜻이다.
     그래프에 고리가 있으면 위상 정렬(순서 세우기)이 불가능하고,
     "만들 순서가 없다"는 것이 곧 이 예외의 정체다.
     Spring 이 setter 로 이를 우회하는 방식은 고리를 없앤 것이 아니라
     "반쪽짜리 노드를 먼저 인정하고 나중에 채운다"는 타협이다.
```

## 4. 이 노트에 나온 용어

| 용어 | 한 줄 풀이 | 자세히 |
|---|---|---|
| 순환 참조 | 두 개 이상의 빈이 서로를 의존해 생성 순서를 정할 수 없는 상태 | [[_glossary#순환-참조]] |
| 조기 노출 | 초기화가 끝나지 않은 싱글턴을 다른 빈에게 미리 참조로 내주는 것 | [[_glossary#조기-노출]] |
| 프로토타입 스코프 | 요청할 때마다 새 인스턴스를 만들고 이후는 관리하지 않는 스코프 | [[_glossary#프로토타입-스코프]] |

## 5. 자주 헷갈리는 것

### 생성자 주입이 "더 엄격해서 불편한" 것이 아니다

순환 참조를 만나면 "생성자 주입 때문에 안 되네, setter로 바꾸자"는 생각이 들기 쉽다. 방향이 거꾸로다.

| | 생성자 주입 | setter 주입 |
|---|---|---|
| 사이클을 만나면 | **시작 실패** | 조용히 동작 |
| 그 결과 | 설계 문제를 즉시 안다 | 설계 문제가 숨는다 |
| 완성 보장 | 항상 완전히 초기화된 상태로 반환 | 미완성 상태가 존재하는 구간이 있다 |
| `final` 필드 | 가능 | 불가능 |

생성자 주입이 사이클에서 실패하는 것은 **결함이 아니라 기능**이다. 공식 문서가 생성자 주입을 권하는 근거(불변성·`null` 아님·완전 초기화)가 정확히 이 실패를 만들어 내는 성질이다.

### `@Lazy`로 뚫는 것과 설계로 푸는 것

한쪽에 `@Lazy`를 붙이면 프록시가 대신 주입되어 사이클이 뚫린다. 동작은 한다. 하지만 그건 **문제를 숨긴 것**이지 푼 것이 아니다 — 여전히 두 클래스는 서로를 안다. 임시방편으로 쓰되, 왜 서로가 필요한지 다시 보는 것이 순서다.

### 사이클 vs 단순한 양방향 참조

도메인 엔티티끼리 서로를 참조하는 것(예: `Material` ↔ `Substance` 연관)은 여기서 말하는 순환 참조가 **아니다.** 그건 컨테이너가 만드는 빈이 아니라 JPA가 만드는 엔티티이고, 생성 순서 문제가 아니다. 이 노트의 주제는 **컨테이너가 빈을 만드는 순서**에 국한된다.

### `@Scope("prototype")`인데 항상 같은 객체인 이유

싱글턴에 주입했기 때문이다. 스코프는 "새로 만들 수 있다"를 뜻할 뿐, "주입 지점이 매번 다시 조회한다"를 뜻하지 않는다. 주입은 싱글턴이 만들어질 때 한 번뿐이다.

## 6. 언제 안 쓰나 / 경계

- **`spring.main.allow-circular-references=true`를 상시 설정으로 두지 않는다.** Boot 메시지 자체가 최후의 수단이라고 적는다. 켜야만 뜨는 상태는 설계 부채가 남아 있다는 표시다.
- **`@Lazy`를 사이클 해결의 기본 도구로 쓰지 않는다.** 프록시가 하나 더 끼고 문제는 그대로다.
- **prototype 빈을 싱글턴에 그냥 주입하지 않는다.** 매번 새 인스턴스를 기대한다면 `ObjectProvider`가 필요하다.
- **prototype 빈에 자원 반납을 맡기지 않는다.** [[소멸-콜백]]이 불리지 않는다.
- **`lazy-initialization`으로 사이클 실패를 회피하지 않는다.** 시작은 성공하지만 같은 문제가 첫 요청 시점으로 옮겨질 뿐이다.

## 7. 연결

- [[01-beandefinition-and-metadata-phase]] — [[사전-인스턴스화]]가 기본값이기 때문에 이 실패가 시작 시점에 드러난다. 그 설계 결정의 값어치가 여기서 실제 사례로 확인된다.
- [[03-bean-creation-and-lifecycle-callbacks]] — 1단계(인스턴스화)와 2단계(프로퍼티 주입) 사이에 틈이 있느냐가 사이클의 성패를 가른다. 이 노트는 그 두 단계를 여러 빈 사이로 확장한 것이다.
- [[02-two-postprocessor-extension-points]] — [[조기-노출]]이 위험한 이유 중 하나가 프록시 씌우기 시점과 어긋나기 때문이다. 후처리기의 동작 시점을 알아야 이 충돌이 이해된다.

## 8. 스스로 확인

1. 생성자 주입 순환 참조에서 시작이 실패하는 이유를, 생성자 호출의 계약으로 설명할 수 있는가?
2. `BeanCurrentlyInCreationException`이라는 이름이 상황의 무엇을 말하고 있는가?
3. setter 주입에는 있고 생성자 주입에는 없는 "틈"은 정확히 어디인가?
4. 조기 노출이 감수하는 대가는 무엇인가? 어떤 코드가 특히 위험한가?
5. 이 실패가 런타임이 아니라 시작 시점에 나는 것이 왜 이득인가?
6. Boot가 `allow-circular-references=true`를 "최후의 수단"이라고 부르는 이유 세 가지는?
7. `@Transactional`이 붙은 빈이 사이클에 끼면 왜 켜도 안 뜰 수 있는가?
8. 사이클을 푸는 정석 세 가지와 각각의 대가는?
9. `@Scope("prototype")` 빈을 싱글턴에 주입했는데 항상 같은 객체인 이유는? 해법은?
10. 도메인 엔티티끼리의 양방향 연관이 이 노트의 순환 참조와 다른 이유는?


> 열 문항을 스스로 답한 **뒤에** [[_04-eager-singletons-and-circular-references]]에서 모범답안과 대조한다. 먼저 열면 이 문항들은 다시 인출 문제로 쓸 수 없다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력

# 모범답안 — 03 빈 생성과 생명주기 콜백

> **먼저 답하고 나서 열 것.** [[03-bean-creation-and-lifecycle-callbacks]]의 `## 8. 스스로 확인` 아홉 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **9문항 모두 답이 충분**했다.

---

## Q1. `@PostConstruct`의 `@Transactional`이 무효인 이유 — 몇 번과 몇 번의 차이

**5번과 6번의 차이다.**

```text
1  인스턴스화                      생성자 호출
2  프로퍼티 주입                   setter · 필드
3  컨테이너가 직접 부르는 Aware     BeanName · BeanClassLoader · BeanFactory
4  postProcessBeforeInitialization  나머지 Aware 도 여기서 처리된다
5  초기화 콜백                     ← @PostConstruct 가 여기
6  postProcessAfterInitialization  ← 프록시가 여기서 씌워진다
7  사용                            주입되는 것은 6번의 반환값 = 프록시
8  소멸 콜백
```

**`@PostConstruct`는 5번이고 프록시는 6번이다. 한 칸 차이로 애노테이션이 무효가 된다.**

**왜 순서가 이래야 하는가** — **프록시는 다 만들어진 빈을 받아서 감싸는 것**이므로 **아직 완성되지 않은 빈을 감쌀 수 없다.** 초기화 콜백은 "완성 과정의 일부"라 그 전에 실행된다.

**그래서 `@PostConstruct` 안의 `this`는 원본 객체다 — 프록시가 아니다.** 프록시가 아닌 객체에서 `@Transactional`은 종잇조각이다.

**증상이 특히 나쁘다**: 두 `save` 사이에서 예외가 나도 **첫 번째 저장이 롤백되지 않는다.** JPA를 쓰면 `TransactionRequiredException`이 나거나 **저장이 즉시 반영되지 않고 조용히 사라진다.**

**비유와 그 한계 — 집들이**: 인테리어 업자가 **다 꾸미고 나간 뒤에야** 손님을 부를 수 있다. `@PostConstruct`는 **업자가 아직 안에서 일하는 중**에 스스로 뭔가를 하는 것이고, 그 시점의 집에는 **아직 보안 시스템(프록시)이 설치돼 있지 않다.**

→ **깨지는 지점**: 집은 **나중에라도** 보안 시스템을 달 수 있다. 빈은 못 한다 — **초기화 시점에 이미 지나간 코드는 영원히 프록시 없이 실행된 것으로 끝난다.** 나중에 프록시가 씌워져도 **소급되지 않는다.**

---

## Q2. 같은 메서드가 컨트롤러에서 부를 때는 동작하는 이유

**그때는 이미 프록시가 씌워졌고, 컨트롤러가 주입받은 것이 프록시이기 때문이다.**

```text
[@PostConstruct 안에서]
  5단계 — 아직 6단계를 안 지났다
  this = 원본 객체
  this.seedDefaults() → 프록시를 안 거친다 → @Transactional 무효 ❌

[컨트롤러에서]
  7단계 — 6단계에서 만들어진 프록시가 주입됐다
  bootstrapService = 프록시
  bootstrapService.seedDefaults() → 프록시가 가로챈다 → 트랜잭션 열림 ✅
```

> **호출자가 누구냐에 따라 애노테이션이 켜지고 꺼진다.**

**이것이 c2의 자기 호출 문제와 같은 뿌리다** — **프록시를 거치느냐**가 전부다. `@PostConstruct`는 **자기 자신이 자기를 부르는** 형태이므로 자기 호출과 정확히 같은 상황이다.

**그래서 진단이 특히 어렵다**:

- 애노테이션은 **소스에 그대로** 있다
- 같은 메서드가 **다른 경로에서는 동작한다**
- **에러도 경고도 없다**
- 테스트에서 서비스를 주입받아 부르면 **통과한다** (프록시를 받으니까)

**§5의 진단 도구**:

| 축 | `@PostConstruct` | `ApplicationRunner` |
|---|---|---|
| 시점 | 그 빈 하나가 만들어지는 중 | **모든 빈이 완성된 뒤** |
| 다른 빈의 상태 | 아직 안 만들어졌을 수 있다 | **전부 준비됨** |
| 프록시 | **자기 자신은 아직 없음** | **전부 씌워짐** |
| `@Transactional` | **자기 메서드엔 무효** | **정상 동작** |

---

## Q3. 초기화 콜백 세 가지의 순서와 선택 기준

| 순서 | 방식 | 형태 | 성격 |
|---|---|---|---|
| **1** | **`@PostConstruct`** | 애노테이션 | **표준(Jakarta). Spring에 의존하지 않는다** |
| **2** | **`InitializingBean`** | 인터페이스 구현 | `afterPropertiesSet()`. **Spring API에 결합된다** |
| **3** | **커스텀 init 메서드** | `@Bean(initMethod=...)` | **남의 코드(라이브러리 클래스)에도 붙일 수 있다** |

**언제 무엇을 고르나**:

- **`@PostConstruct`가 기본 선택이다** — **표준 애노테이션이라 클래스가 Spring 타입을 import하지 않아도 된다.** 도메인 클래스를 프레임워크에서 떼어 놓을 수 있다.
- **`InitializingBean`** — Spring에 결합되므로 **프레임워크성 코드**가 아니면 고를 이유가 적다. 애노테이션 스캔 없이 확실히 불려야 하는 경우 정도.
- **커스텀 init 메서드** — **내가 수정할 수 없는 클래스**에 초기화를 걸어야 할 때. 서드파티 라이브러리를 `@Bean`으로 등록하면서 `initMethod`를 지정한다. **애노테이션을 붙일 수 없는 상황의 유일한 답이다.**

**§6의 규칙**: **세 가지 초기화 방식을 한 빈에 섞지 않는다.** **순서를 알아야만 읽히는 코드**가 된다. **하나로 통일한다.**

**소멸 콜백도 대칭이다**:

| 순서 | 방식 |
|---|---|
| 1 | `@PreDestroy` |
| 2 | `DisposableBean.destroy()` |
| 3 | 커스텀 destroy 메서드 |

---

## Q4. `afterPropertiesSet`이라는 이름이 알려주는 사실

**"프로퍼티가 세팅된 뒤"** — **2번 단계가 끝났다는 것을 이름이 선언하고 있다.**

```text
1  인스턴스화       ← 생성자. setter 주입은 아직 안 들어왔다
2  프로퍼티 주입    ← setter · 필드 주입이 채워진다
                      ↑ afterPropertiesSet 의 "after" 가 가리키는 지점
5  초기화 콜백      ← afterPropertiesSet() 이 여기서 불린다
```

**왜 생성자로는 그 일을 못 하는가**:

> **생성자는 setter·필드 주입이 채워지기 전에 끝나므로, 그 의존성을 써야 하는 준비 작업은 생성자에 넣을 수 없다.**

```java
@Component
public class CacheWarmer {
    private final Repository repo;          // 생성자 주입 — 1단계에 들어온다
    @Autowired private Config config;       // 필드 주입 — 2단계에 들어온다

    public CacheWarmer(Repository repo) {
        this.repo = repo;
        // config 는 아직 null 이다 ← 여기서 쓸 수 없다
    }

    @PostConstruct
    void warm() {
        // config 가 채워진 뒤다 ← 여기서는 쓸 수 있다
    }
}
```

**이름이 계약을 담고 있는 좋은 예다** — 무엇을 보장하는지가 메서드 이름에 적혀 있다. **`init()`이었다면 "무엇의 뒤인지"를 문서로 찾아야 한다.**

**뒤집어 말하면 — 생성자 주입만 쓰면 이 콜백이 덜 필요해진다.** 모든 의존성이 1단계에 들어오면 생성자 안에서 준비 작업을 할 수 있다. **초기화 콜백의 존재 이유 절반이 setter/필드 주입에 있다.**

---

## Q5. `Aware` 인터페이스가 두 무리로 갈리는 기준

**"그 정보를 누가 아는가"다.**

| 인터페이스 | 받는 것 | 누가 부르나 | **단계** |
|---|---|---|:---:|
| `BeanNameAware` | 이 빈의 이름 | **컨테이너가 직접** | **3** |
| `BeanClassLoaderAware` | 클래스로더 | **컨테이너가 직접** | **3** |
| `BeanFactoryAware` | 자기를 만든 `BeanFactory` | **컨테이너가 직접** | **3** |
| `ApplicationContextAware` | `ApplicationContext` | `ApplicationContextAwareProcessor` | **4** |
| `ApplicationEventPublisherAware` | 이벤트 발행기 | 같음 | **4** |
| `ResourceLoaderAware` | 리소스 로더 | 같음 | **4** |
| `MessageSourceAware` | 메시지 해석 전략 | 같음 | **4** |
| `ServletContextAware` | `ServletContext` | `ServletContextAwareProcessor` | **4** |

**갈리는 기준**:

- **`BeanName`·`BeanClassLoader`·`BeanFactory`는 `BeanFactory` 수준의 정보**라 **컨테이너가 후처리기 없이도 줄 수 있다.** → **3단계**
- **나머지는 `ApplicationContext` 수준의 정보**라 **그 컨텍스트를 아는 후처리기가 필요하다.** → **4단계**, [[02-two-postprocessor-extension-points]]의 빈 후처리기 메커니즘 위에 올라가 있다.

**`Aware` javadoc이 못박는다**: *"`Aware`를 구현하는 것만으로는 아무 기본 기능도 제공되지 않는다. 처리는 **예를 들어 `BeanPostProcessor`에서 명시적으로 이뤄져야 한다.**"*

**실무에서 이 차이가 드러나는 지점**:

> **`BeanPostProcessor`를 직접 만들면서 `ApplicationContextAware`를 구현하면 위험하다** — 그 후처리기는 **특수 시작 단계**에 만들어지는데, **자기에게 컨텍스트를 넣어 줄 `ApplicationContextAwareProcessor`가 아직 등록되기 전일 수 있다.** **`BeanFactoryAware`는 같은 상황에서 안전하다.**

**근거의 층을 구분해 둘 것**(노트가 명시): 공식 레퍼런스가 시점을 **문장으로 명시한 것은 `BeanNameAware` 하나뿐**이다 — *"보통의 빈 프로퍼티가 채워진 뒤, 그러나 초기화 콜백보다는 앞"*. **4단계 행들은 javadoc 서술(처리 주체가 `BeanPostProcessor`라는 것)에서 따라 나온 것**이지 레퍼런스가 단계 번호를 적어 준 것이 아니다.

---

## Q6. prototype 빈에서 초기화는 불리는데 소멸은 안 불리는 이유

**컨테이너가 prototype 인스턴스를 기억하지 않기 때문이다.**

공식 문서: *"다른 스코프와 달리 Spring은 prototype 빈의 완전한 생명주기를 관리하지 않는다. 컨테이너는 prototype 객체를 인스턴스화하고 설정해 클라이언트에게 건네줄 뿐, **그 prototype 인스턴스에 대한 이후 기록을 갖지 않는다.**"*

```text
[초기화 콜백]
  만드는 시점 = 컨테이너가 그 객체를 손에 쥐고 있는 시점
  → 부를 수 있다 ✅

[소멸 콜백]
  컨테이너가 닫힐 때 = 그 객체가 어디 있는지 모르는 시점
  → 부를 대상 목록에 없다 ❌
```

**"만들어 주기는 하지만 뒤는 안 봐준다"가 prototype의 계약이다**(§5).

**왜 기억하지 않는가** — 기억하면 **참조를 계속 들고 있어야** 하고, 그러면 **GC가 절대 회수하지 못한다.** prototype이 수천 개 만들어지는 상황에서 그건 메모리 누수다. **기억하지 않는 것이 prototype의 존재 이유와 맞는다.**

**§6의 결과**: **prototype 빈에 `@PreDestroy`를 걸고 자원 반납을 기대하지 않는다. 안 불린다.**

**자원을 쥔 prototype 빈은 누수가 난다** — 파일 핸들이나 커넥션을 들고 있으면 **닫아 줄 사람이 아무도 없다.**

**대응**: **클라이언트가 직접 닫거나 try-with-resources를 쓴다.** 즉 **자원 관리 책임이 컨테이너에서 사용자로 넘어온다.** 그 사실을 모르고 `@PreDestroy`를 걸어 두면 **"처리했다"고 믿는 상태로 누수가 쌓인다.**

---

## Q7. "생성자가 이르니 `@PostConstruct`로 옮기면 프록시 문제가 풀린다"가 틀린 이유

**둘 다 프록시 이전이기 때문이다. 한 칸 옮겼을 뿐 여전히 프록시 앞이다.**

| 축 | **생성자** | **`@PostConstruct`** |
|---|---|---|
| 시점 | **1단계** | **5단계** |
| 쓸 수 있는 의존성 | 생성자 주입분만 | **생성자 + setter/필드 전부** |
| **`this`의 정체** | **원본** | **원본 (아직 프록시 아님)** |
| 실패하면 | 빈 생성 실패 | 빈 생성 실패 |

**프록시는 6단계다.** 1단계에서 5단계로 옮겨도 **경계를 넘지 못한다.**

```text
1 ─── 2 ─── 3 ─── 4 ─── 5 ─── │ ─── 6 ─── 7
생성자        @PostConstruct   │  프록시   사용
      ↑ 이 구간 전체가 프록시 이전 ↑
```

**옮겨서 풀리는 문제는 따로 있다** — **"setter/필드 주입분을 쓸 수 있느냐"**(Q4)다. 그건 생성자 → `@PostConstruct` 이동으로 해결된다. **프록시는 아니다.**

**두 문제를 구별해야 한다**:

| 문제 | 해법 |
|---|---|
| "생성자에서 필드 주입 의존성이 `null`이다" | **`@PostConstruct`로 옮긴다** ✅ |
| "`@Transactional`이 안 먹는다" | **`ApplicationRunner`로 옮긴다** (Q8) |

**§5**: **"생성자는 너무 이르니 `@PostConstruct`로 옮기자"는 것은 프록시 문제의 해법이 아니다.**

---

## Q8. 시작 시 1회 작업을 `ApplicationRunner`에 두는 것이 나은 이유 — 세 축

| 축 | **`@PostConstruct`** | **`ApplicationRunner`** |
|---|---|---|
| **① 시점** | 그 빈 하나가 만들어지는 중 | **모든 빈이 완성된 뒤** |
| **② 다른 빈의 상태** | **아직 안 만들어졌을 수 있다** | **전부 준비됨** |
| **③ 프록시** | **자기 자신은 아직 없음** | **전부 씌워짐** → `@Transactional` 정상 |

**세 축이 각각 무엇을 막아 주나**:

**① 시점** — `@PostConstruct`는 **자기 빈이 만들어지는 시점**에 실행된다. 그 시점이 언제인지는 **의존성 그래프가 결정**하므로 예측하기 어렵다. `ApplicationRunner`는 **컨테이너가 완성된 뒤**라는 명확한 한 지점이다.

**② 다른 빈의 상태** — `@PostConstruct`에서 다른 빈을 호출하면 **그 빈이 아직 완성되지 않았을 수 있다**(§6). 순서 의존은 [[04-eager-singletons-and-circular-references]]의 순환 참조 문제와 이어진다. `ApplicationRunner`에는 그 위험이 없다.

**③ 프록시** — Q1의 문제 그 자체다. `ApplicationRunner`에서는 **주입받은 모든 빈이 프록시**이므로 `@Transactional`·`@Async`·`@Cacheable`이 전부 정상 동작한다.

> **"시작할 때 한 번 실행"이 목적이라면 거의 항상 오른쪽이 정답이다.**

**§6의 정리**: **`@PostConstruct`에 `@Transactional`·`@Async`·`@Cacheable`을 붙이지 않는다.** 프록시 이전이라 전부 무효이고, **조용히 실패하므로 더 위험하다.**

**`@EventListener(ApplicationReadyEvent.class)`도 같은 자리다** — 어느 쪽을 고르든 **컨테이너 완성 이후**라는 점이 핵심이다.

**그럼 `@PostConstruct`는 언제 쓰나** — **그 빈 자신의 내부 준비**에만. 주입된 값으로 캐시를 계산하거나, 검증하거나, 파생 필드를 채우는 일. **다른 빈을 부르거나 AOP가 필요한 일은 아니다.**

---

## Q9. `ApplicationContextAware` 대신 생성자 주입을 권하는 이유

**클래스가 Spring에 결합되기 때문이다.**

> **`ApplicationContextAware`를 구현한 클래스는 Spring 없이는 컴파일도 안 된다.**

**대안이 거의 항상 있다**:

```java
// Aware — Spring 타입을 구현한다
@Component
class Notifier implements ApplicationEventPublisherAware {
    private ApplicationEventPublisher publisher;
    public void setApplicationEventPublisher(ApplicationEventPublisher p) {
        this.publisher = p;
    }
}

// 주입 — 그냥 받는다
@Component
class Notifier {
    private final ApplicationEventPublisher publisher;
    Notifier(ApplicationEventPublisher publisher) { this.publisher = publisher; }
}
```

> **이벤트를 쏘고 싶으면 `ApplicationEventPublisher`를 생성자로 받으면 되고, `ApplicationEventPublisherAware`를 구현할 이유가 없다.**

**주입이 나은 점**:

| | Aware | 생성자 주입 |
|---|---|---|
| 클래스의 결합 | **인터페이스를 구현한다** | 타입 하나를 참조한다 |
| 필드를 `final`로 | **못 한다** (setter로 들어온다) | **된다** |
| 테스트 | 컨테이너나 수동 setter 호출 필요 | **생성자에 mock을 넣으면 끝** |
| 의존성이 보이나 | **메서드 시그니처에 숨는다** | **생성자에 다 드러난다** |

**§6**: **`ApplicationContextAware`를 습관적으로 구현하지 않는다.** **클래스가 Spring에 결합되고 테스트가 무거워진다.**

**Aware가 정당한 자리**:

> **주입으로는 얻을 수 없는 것(자기 빈 이름)이나 프레임워크성 코드를 쓸 때.**

`BeanNameAware`가 대표적이다 — **자기가 컨테이너에서 어떤 이름인지는 주입으로 알 수 없다.**

**그리고 `ApplicationContext` 자체를 받는 것은 대개 신호다** — 컨텍스트에서 `getBean()`을 부르려는 것이라면, **그건 필요한 협력자를 명시하지 않고 있다**는 뜻이다. Q5의 위험(후처리기에서 `ApplicationContextAware`를 구현하면 타이밍 문제)까지 겹친다.

---

## 재출제 문항

1. `@PostConstruct`의 `@Transactional`이 무효인 이유를 단계 번호 두 개로 말하라.
2. 같은 메서드가 컨트롤러에서는 동작한다. 무엇이 다른가? c2의 어느 개념과 같은 뿌리인가?
3. 서드파티 클래스에 초기화 작업을 걸어야 한다. 세 방식 중 무엇인가?
4. `afterPropertiesSet`이라는 이름이 보장하는 것은? 생성자 주입만 쓰면 이 콜백이 왜 덜 필요해지는가?
5. `BeanFactoryAware`는 3단계, `ApplicationContextAware`는 4단계다. 기준은?
6. prototype 빈에 `@PreDestroy`를 걸었다. 자원이 반납되는가? 왜 컨테이너는 기억하지 않는가?
7. 생성자에서 `@Transactional`이 안 먹어서 `@PostConstruct`로 옮겼다. 풀렸는가?
8. 시작 시 1회 작업을 `ApplicationRunner`에 두는 이유 셋은?
9. `ApplicationContext`를 주입받아 `getBean()`을 부르는 코드를 봤다. 무엇을 의심하는가?

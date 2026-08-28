# chapter-c1 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다. 근거는 `CLAUDE.md`의 「보조 소스 트랙」 규칙과 deep-tutor `book-mode.md` §12에 있다.
>
> 이 챕터가 존재하는 이유: *Learning Spring Boot 4* Ch. 1은 "자동 구성이 빈을 application context에 등록한다"까지만 말하고 **그 등록이 어떤 순서로 일어나는지**는 다루지 않는다. `BeanPostProcessor`·`BeanFactoryPostProcessor`는 책 전체에 한 번도 나오지 않는다. 그런데 `@Transactional`이 조용히 무효가 되는 실무 사고는 전부 그 순서에서 나온다.

## 1. 1차 소스

> 아래 URL은 이 챕터를 쓰면서 **실제로 열어 대조한 페이지**다. 내 설명을 믿지 말고 이 주소에서 직접 확인할 수 있게 남긴다.

| 소스 | 정확한 위치 | 역할 |
|---|---|---|
| Framework Ref — Bean Overview | `https://docs.spring.io/spring-framework/reference/core/beans/definition.html` | 빈 정의 메타데이터 9항목 표, 런타임 등록 비지원 경고 |
| Framework Ref — Dependency Resolution Process | `https://docs.spring.io/spring-framework/reference/core/beans/dependencies/factory-collaborators.html` | 의존성 해석 4단계, 사전 인스턴스화 목적, 생성자 vs setter 권고, 순환 참조와 `BeanCurrentlyInCreationException` |
| Framework Ref — Container Extension Points | `https://docs.spring.io/spring-framework/reference/core/beans/factory-extension.html` | 빈 후처리기·빈 팩터리 후처리기 계약, **AOP 자동 프록시가 BPP라는 명시**, 특수 시작 단계, not-eligible 경고 원문, `Ordered` 예외 |
| Framework Ref — Customizing the Nature of a Bean | `https://docs.spring.io/spring-framework/reference/core/beans/factory-nature.html` | 초기화·소멸 콜백 3종 순서, `BeanNameAware` 시점, Aware 인터페이스 목록 |
| Framework Ref — Bean Scopes | `https://docs.spring.io/spring-framework/reference/core/beans/factory-scopes.html` | prototype 소멸 콜백 미호출, 싱글턴 주입 1회성, `ObjectProvider` |
| **Javadoc — `Aware`** | `https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/beans/factory/Aware.html` | **Aware 처리가 `BeanPostProcessor`에서 이뤄진다는 규정** (2026-08-28 정정 근거) |
| Boot Ref — SpringApplication | `https://docs.spring.io/spring-boot/reference/features/spring-application.html` | `spring.main.lazy-initialization`의 효과와 대가 |
| Boot 소스 — `SpringApplication` | Context7 `/spring-projects/spring-boot/v4.0.3` | `setAllowCircularReferences` 기본값 `false`(2.6.0~) |
| Boot 소스 — `BeanCurrentlyInCreationFailureAnalyzer` | Context7 같음 | 기동 실패 메시지 원문("as a last resort…") |

## 2. 책 트랙과의 관계

| 책의 서술 | 이 챕터가 채우는 것 |
|---|---|
| Ch. 1 「Autoconfiguring Spring beans」 — 컨텍스트가 빈을 등록하고 연결한다 | 그 등록이 **정의 단계와 인스턴스 단계로 나뉜다**는 사실과, 그 틈에서만 가능한 일들 |
| Ch. 1 — 사용자가 빈을 만들면 자동 구성이 back-off 한다 | back-off 판정이 **왜 정의가 전부 모인 뒤에만** 가능한지 |
| Ch. 1 — `@ConditionalOnProperty` 등 조건부 구성 | 조건 평가가 인스턴스화보다 앞선다는 순서상의 위치 (상세는 c4) |
| 책 전체 — `@Transactional`을 붙여 트랜잭션을 건다 | 그 애노테이션이 **프록시로 구현되며 프록시는 특정 시점에만 씌워진다**는 것, 그래서 언제 무효가 되는지 |
| 책에 없음 — `BeanPostProcessor`·`BeanFactoryPostProcessor` | 이 챕터의 핵심. 책에 한 번도 등장하지 않는다 |

## 3. 주제 → 노트 매핑

| 주제 | 출처 | 정리 노트 | 상태 |
|---|---|---|---|
| 빈 정의와 인스턴스가 다른 층이라는 것 | Framework Ref · Bean Overview | [[01-beandefinition-and-metadata-phase]] | 반영 — 1절·2.1 |
| 빈 정의가 담는 메타데이터 9항목 | Framework Ref · Bean Overview (표) | [[01-beandefinition-and-metadata-phase]] | 반영 — 2.2 |
| 같은 클래스를 다른 스코프의 빈 둘로 등록 가능 | 위 표에서 도출 | [[01-beandefinition-and-metadata-phase]] | 반영 — 3절 |
| 컨테이너가 설정을 검증하되 프로퍼티는 생성 시점에 설정 | Framework Ref · Dependency Resolution | [[01-beandefinition-and-metadata-phase]] | 반영 — 2.4 |
| 사전 인스턴스화가 기본인 이유 | Framework Ref · Dependency Resolution | [[01-beandefinition-and-metadata-phase]] | 반영 — 2.4 |
| `lazy-initialization`의 효과와 대가 | Boot Ref · SpringApplication | [[01-beandefinition-and-metadata-phase]] | 반영 — 2.4·6절 |
| 런타임 빈 등록이 비공식 지원이라는 경고 | Framework Ref · Bean Overview | [[01-beandefinition-and-metadata-phase]] | 반영 — 6절 |
| BFPP가 정의를, BPP가 인스턴스를 고친다 | Framework Ref · Container Extension Points | [[02-two-postprocessor-extension-points]] | 반영 — 1절·2.1·2.2 |
| BFPP는 BFPP 외 어떤 빈보다 먼저 실행된다 | 같음 | [[02-two-postprocessor-extension-points]] | 반영 — 2.1 |
| BFPP 안의 `getBean()`이 생명주기 위반이라는 명시 | 같음 | [[02-two-postprocessor-extension-points]] | 반영 — 2.1·6절 |
| BPP 두 콜백의 Before/After 기준점 | 같음 | [[02-two-postprocessor-extension-points]] | 반영 — 2.2·5절 |
| 반환 타입이 `Object`라서 바꿔치기가 가능하다 | 같음 | [[02-two-postprocessor-extension-points]] | 반영 — 2.2 |
| **AOP 자동 프록시가 BeanPostProcessor로 구현됐다** | 같음 (원문 명시) | [[02-two-postprocessor-extension-points]] | 반영 — 1절·2.2 |
| BPP와 그 참조 빈이 특수 시작 단계에 만들어진다 | 같음 (원문 명시) | [[02-two-postprocessor-extension-points]] | 반영 — 1절·2.3 |
| not-eligible-for-auto-proxying 경고의 의미 | 같음 (원문 인용) | [[02-two-postprocessor-extension-points]] | 반영 — 1절·2.3 |
| `Ordered`가 프로그래밍 등록에서 무시된다 | 같음 | [[02-two-postprocessor-extension-points]] | 반영 — 2.4 |
| `ObjectProvider`·`@Lazy`로 함정을 피하는 법 | Framework Ref · Bean Scopes | [[02-two-postprocessor-extension-points]] | 반영 — 2.5 |
| 빈 생성 8단계 전체 순서 | Framework Ref · Customizing the Nature of a Bean + Extension Points 종합 | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.1·3절 |
| 초기화 콜백 3종의 실행 순서 | Framework Ref · Lifecycle Callbacks (원문 순서 목록) | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.2 |
| 소멸 콜백 3종의 실행 순서 | 같음 | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.3 |
| Aware 호출 시점("프로퍼티 채워진 뒤, 초기화 콜백 앞") | Framework Ref · BeanNameAware | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.1·2.4 |
| Aware 인터페이스 목록 | Framework Ref · Other Aware Interfaces (표) | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.4 |
| `@PostConstruct`의 `@Transactional`이 무효인 이유 | 위 순서에서 도출 + Extension Points | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 1절·3절 |
| prototype에서 초기화는 불리고 소멸은 안 불린다 | Framework Ref · Bean Scopes (원문 명시) | [[03-bean-creation-and-lifecycle-callbacks]] | 반영 — 2.3·5절 |
| 생성자 순환 참조와 `BeanCurrentlyInCreationException` | Framework Ref · Circular dependencies | [[04-eager-singletons-and-circular-references]] | 반영 — 1절 |
| setter 주입이 사이클을 푸는 원리(틈의 유무) | 같음 + Lifecycle 단계 구분에서 도출 | [[04-eager-singletons-and-circular-references]] | 반영 — 2.1·3절 |
| 조기 노출의 대가("완전히 초기화되기 전에 주입") | Framework Ref · Circular dependencies (원문) | [[04-eager-singletons-and-circular-references]] | 반영 — 2.1·2.3·3절 |
| Boot 기본값 `allow-circular-references=false` | Boot 소스 · `SpringApplication` javadoc | [[04-eager-singletons-and-circular-references]] | 반영 — 1절·2.1 |
| 기동 실패 메시지와 "최후의 수단" 표현 | Boot 소스 · `BeanCurrentlyInCreationFailureAnalyzer` | [[04-eager-singletons-and-circular-references]] | 반영 — 1절·2.3 |
| 생성자 주입 권고의 세 근거 | Framework Ref · Dependency Resolution | [[04-eager-singletons-and-circular-references]] | 반영 — 2.3·5절 |
| prototype을 싱글턴에 주입하면 1회성이라는 것 | Framework Ref · Bean Scopes (원문 명시) | [[04-eager-singletons-and-circular-references]] | 반영 — 2.4·5절 |
| `ObjectProvider`로 매번 새 인스턴스 얻기 | 같음 | [[04-eager-singletons-and-circular-references]] | 반영 — 2.4 |
| 3단계 싱글턴 캐시의 내부 자료구조 이름 | 공식 레퍼런스에 없음(구현 세부) | — | 미반영 — 공식 문서가 기술하지 않는 구현 내부라 근거를 댈 수 없다. 대신 "조기 노출"이라는 문서화된 개념으로 같은 메커니즘을 설명했다 |
| `@Configuration` 클래스의 CGLIB 강화 | Framework Ref · Java-based Configuration | — | 미반영 — c2에서 다룬다. 프록시 생성 방식이 선행 지식이라 이 챕터에 두면 설명 순서가 뒤집힌다 |

## 4. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "`@Component`를 붙이면 객체가 만들어진다" | 먼저 **빈 정의**가 등록되고, 인스턴스화는 별도 단계다 | 01 — 1절 |
| "애플리케이션이 떴으니 설정이 맞다" | 싱글턴을 만들어 봤다는 뜻일 뿐. `@Lazy`·prototype·값의 옳고 그름은 별개 | 01 — 5절 |
| "`@Transactional`을 붙였으니 적용된다" | 프록시가 씌워진 뒤의 호출에만 적용된다 | 02 — 1절 · 03 — 1절 |
| "프록시는 Spring이 알아서 해 주는 마법" | **빈 후처리기**가 원본 대신 감싼 객체를 반환한 결과일 뿐 | 02 — 2.2 |
| "`postProcessBeforeInitialization`은 빈 생성 전" | 빈은 이미 만들어졌고 의존성도 주입된 상태다. 기준점은 초기화 콜백 | 02 — 5절 |
| "시작 작업은 `@PostConstruct`에 넣는다" | 프록시 이전이라 `@Transactional`·`@Async`가 무효. `ApplicationRunner`가 맞다 | 03 — 1절·5절 |
| "`@PreDestroy`를 붙였으니 정리된다" | prototype 빈에서는 불리지 않는다 | 03 — 2.3 |
| "순환 참조는 setter로 바꾸면 해결된다" | Boot 기본이 금지이고, 켜도 미완성 객체가 돌아다닌다 | 04 — 2.3 |
| "생성자 주입은 까다로워서 불편하다" | 사이클에서 실패하는 것이 기능이다. 불변·non-null·완전 초기화의 대가 | 04 — 5절 |
| "`@Scope("prototype")`이면 매번 새 객체" | 싱글턴에 주입하면 주입은 1회뿐 | 04 — 2.4 |

## 5. 아직 다루지 않은 것

| 주제 | 왜 보류인가 |
|---|---|
| 프록시 생성 방식(JDK vs CGLIB) | c2의 주제다. 이 챕터는 "프록시가 언제 씌워지는가"까지만 다룬다 |
| `@Configuration` 클래스의 CGLIB 강화 | 같은 이유로 c2 |
| 자동 구성의 조건 평가 순서 | c4의 주제다 |
| `web`·`session` 스코프와 스코프 프록시 | 웹 요청 수명이 전제라 c3 이후가 맞는 자리다 |
| `SmartLifecycle`·`Lifecycle`과 시작/종료 단계 | 컨테이너 전체의 시작·종료 신호이지 빈 하나의 생성 순서가 아니다. 이 챕터의 축과 다르다 |
| `@DependsOn`과 명시적 순서 지정 | 순환 참조의 해법이 아니고, 실무 사용 빈도가 낮다 |

## 6. 정정 이력

작성 직후 자체 검증에서는 못 잡고, **2026-08-28 사후 대조에서 찾아 고친 것**이다. 근거 URL을 함께 남긴다.

| # | 위치 | 처음에 쓴 것 | 실제 | 근거 |
|---|---|---|---|---|
| 1 | `03` §2.1 3단계 · §2.4 표 · §3 도표 | **Aware 인터페이스 8개를 전부 3단계**(빈 후처리기보다 앞)에 뒀다 | **두 무리로 갈린다.** `BeanNameAware`·`BeanClassLoaderAware`·`BeanFactoryAware`만 컨테이너가 직접 부르고(3단계), `ApplicationContextAware`·`ApplicationEventPublisherAware`·`ResourceLoaderAware`·`MessageSourceAware`·`ServletContextAware`는 **`BeanPostProcessor`가 처리**한다(4단계) | Javadoc `Aware` — *"처리는 예를 들어 `BeanPostProcessor`에서 명시적으로 이뤄져야 한다. …`ApplicationContextAwareProcessor`를 참고하라"* · `https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/beans/factory/Aware.html` |

**왜 자체 검증에서 안 잡혔나.** 레퍼런스의 「Other Aware Interfaces」 표가 8개를 한 표에 나열하고, 바로 앞 절이 `BeanNameAware`의 시점을 문장으로 설명한다. **표와 시점 서술이 붙어 있어 "이 표 전체의 시점"으로 읽었다.** 레퍼런스는 나머지 7개의 시점을 어디에도 적지 않으며, 그 정보는 javadoc 쪽에 있다. 기계 검사로는 잡을 수 없고, 같은 문서를 다시 읽어도 같은 오독이 재생된다.

**이 정정이 바꾸는 것.** `BeanPostProcessor`를 직접 만들면서 `ApplicationContextAware`를 구현하면 위험하다는 사실이 여기서 따라 나온다 — 그 후처리기는 특수 시작 단계에 만들어지는데, 컨텍스트를 넣어 줄 `ApplicationContextAwareProcessor`가 아직 등록되기 전일 수 있다. 정정 전 노트로는 이 결론에 닿을 수 없었다.

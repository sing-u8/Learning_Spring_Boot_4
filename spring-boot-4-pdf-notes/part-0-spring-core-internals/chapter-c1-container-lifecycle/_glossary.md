# chapter-c1 용어집

> 컨테이너 생명주기 층에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.
>
> 빈·컨테이너·의존성 주입처럼 책 트랙 Chapter 1에서 이미 정의한 기초 용어는 여기서 다시 정의하지 않는다. 이 챕터는 그 위층 — "컨테이너가 빈을 만드는 과정 자체" — 의 용어만 다룬다.

## 빈-정의 (BeanDefinition)

빈 하나를 **어떻게 만들지** 적어 둔 메타데이터 객체. 아직 객체가 아니다.

`@Component`·`@Bean`·XML·자동 구성 클래스에서 읽어낸 정보가 전부 이 형태로 바뀌어 컨테이너 내부에 보관된다. 담고 있는 항목은 클래스, 이름, 스코프, 생성자 인자, 프로퍼티, 오토와이어 모드, 지연 초기화 모드, 초기화 메서드, 소멸 메서드다.

핵심은 **정의와 인스턴스가 다른 층**이라는 것이다. prototype 빈이 100개 만들어져도 빈 정의는 하나다. 스코프처럼 클래스 코드에 없는 정보가 여기 있어서, 같은 클래스를 성격이 다른 빈 여럿으로 등록할 수 있다.

- 처음 나온 곳: [[01-beandefinition-and-metadata-phase]]
- 섞이는 말: [[설정-메타데이터]], [[빈-정의-등록기]]

## 설정-메타데이터 (configuration metadata)

"어떤 빈을 어떻게 만들고 어떻게 엮을지"를 기술한 것. 애노테이션, Java 코드(`@Configuration`), XML 중 어느 형태로도 표현할 수 있다.

[[빈-정의]]와의 관계는 **원본과 파싱 결과**다. 설정 메타데이터가 개발자가 쓰는 표현 형식이고, 컨테이너가 그것을 읽어 [[빈-정의]] 객체로 바꾼다. 형식이 셋이어도 파싱 뒤에는 하나의 형태로 통일되기 때문에, XML로 정의한 빈과 애노테이션으로 정의한 빈이 서로를 주입받을 수 있다.

- 처음 나온 곳: [[01-beandefinition-and-metadata-phase]]
- 섞이는 말: [[빈-정의]]

## 사전-인스턴스화 (pre-instantiation)

싱글턴 빈을 **컨테이너 생성 시점에 미리 전부** 만들어 두는 기본 동작.

공식 문서는 그 목적을 명시한다 — 미리 만드는 시간과 메모리를 지불하는 대신 설정 문제를 나중이 아니라 `ApplicationContext`가 만들어지는 시점에 발견하기 위해서다. 정의 단계의 검증만으로는 부족하기 때문이다. 문서의 표현대로 "빈 프로퍼티 자체는 빈이 실제로 만들어지기 전까지 설정되지 않는다."

그래서 **"애플리케이션이 기동했다"는 "싱글턴 빈을 전부 실제로 만들어 봤고 하나도 안 터졌다"는 뜻**이다. `spring.main.lazy-initialization=true`는 이 보증을 포기하는 대신 시작 시간을 줄인다.

- 처음 나온 곳: [[01-beandefinition-and-metadata-phase]]
- 섞이는 말: [[특수-시작-단계]]

## 빈-정의-등록기 (BeanDefinitionRegistry)

[[빈-정의]]를 이름으로 보관하는 컨테이너 내부의 레지스트리. 실제 구현체는 `DefaultListableBeanFactory`다.

"정의를 모아 두는 곳"이자 "정의를 고칠 수 있는 접점"이다. [[빈-팩터리-후처리기]]가 정의를 고칠 때 손대는 대상이 이 레지스트리에 담긴 내용이다.

- 처음 나온 곳: [[01-beandefinition-and-metadata-phase]]
- 섞이는 말: [[빈-정의]]

## 빈-팩터리-후처리기 (BeanFactoryPostProcessor)

빈이 만들어지기 **전에** [[빈-정의]] 자체를 읽고 고치는 확장점.

공식 문서의 규정은 이렇다 — 컨테이너가 `BeanFactoryPostProcessor` 인스턴스 외의 어떤 빈도 인스턴스화하기 전에, 설정 메타데이터를 읽고 잠재적으로 변경할 수 있게 해 준다. 컨테이너당 한 번 실행되며 정의 **전체**를 받는다.

대표 구현이 `PropertySourcesPlaceholderConfigurer`다. `${jdbc.url}` 같은 자리를 실제 값으로 바꾸는 일이 여기서 일어난다 — 그 값이 생성자 인자로 쓰이기 전에 확정돼야 하기 때문이다.

공식 문서는 이 안에서 `getBean()`을 부르는 것을 금한다. 기술적으로 가능하지만 이른 빈 인스턴스화를 유발해 표준 컨테이너 생명주기를 위반한다.

- 처음 나온 곳: [[02-two-postprocessor-extension-points]]
- 섞이는 말: [[빈-후처리기]], [[빈-정의]]

## 빈-후처리기 (BeanPostProcessor)

만들어진 빈 하나하나를 가로채 검사하거나 **다른 객체로 바꿔치기**하는 확장점.

메서드가 둘이다. `postProcessBeforeInitialization`과 `postProcessAfterInitialization`이며, 이름의 Before/After는 빈 생성이 아니라 **초기화 콜백**(`@PostConstruct`·`afterPropertiesSet()`·init 메서드) 기준의 앞뒤다. 둘 다 빈이 이미 만들어지고 의존성까지 주입된 뒤에 불린다.

반환 타입이 `void`가 아니라 `Object`인 것이 결정적이다. 받은 빈과 다른 객체를 돌려주면 컨테이너는 그때부터 그것을 해당 이름의 빈으로 취급한다. [[자동-프록시-생성기]]가 존재할 수 있는 이유가 이 반환값이다.

- 처음 나온 곳: [[02-two-postprocessor-extension-points]]
- 섞이는 말: [[빈-팩터리-후처리기]], [[자동-프록시-생성기]]

## 특수-시작-단계 (special startup phase)

일반 빈보다 먼저 후처리기와 **그 후처리기가 직접 참조하는 빈**을 만드는 `ApplicationContext`의 별도 시작 구간.

공식 문서의 표현으로, 모든 `BeanPostProcessor` 인스턴스와 그것이 직접 참조하는 빈들은 이 단계에서 인스턴스화된다. 그리고 그 결과를 문서가 일반화해 경고한다 — 이 이른 단계에서 인스턴스화되는 어떤 빈이든 모든 `BeanPostProcessor`에 의한 완전한 후처리 대상이 되지 못한다.

실무에서 이 단계의 존재는 로그 한 줄로 드러난다: `Bean 'x' of type [...] is not eligible for getting processed by all BeanPostProcessors (for example: not eligible for auto-proxying)`. `INFO` 레벨이라 지나치기 쉽지만, 그 빈의 `@Transactional`·`@Async`·`@Cacheable`이 조용히 무효라는 뜻이다.

- 처음 나온 곳: [[02-two-postprocessor-extension-points]]
- 섞이는 말: [[사전-인스턴스화]], [[빈-후처리기]]

## 자동-프록시-생성기 (auto-proxy creator)

AOP 대상 빈을 찾아 **프록시로 바꿔치기하는** [[빈-후처리기]].

공식 문서가 명시한다 — AOP 자동 프록시 생성 자체가 `BeanPostProcessor`로 구현돼 있다. `@Transactional`·`@Async`·`@Cacheable`이 전부 이 경로로 동작한다. 프록시는 별도의 마법이 아니라 후처리기가 원본 대신 감싼 객체를 반환한 결과다.

이 사실에서 두 가지가 따라온다. 첫째, 후처리기보다 먼저 만들어진 빈은 프록시를 못 받는다([[특수-시작-단계]]). 둘째, 프록시가 씌워지는 시점이 "빈 생성 직후"이므로 그 이후에 주입되는 모든 참조는 원본이 아니라 프록시를 받는다.

- 처음 나온 곳: [[02-two-postprocessor-extension-points]]
- 섞이는 말: [[빈-후처리기]], [[특수-시작-단계]]

## 초기화-콜백 (initialization callback)

의존성이 모두 주입된 뒤, 빈이 스스로 준비 작업을 하도록 컨테이너가 불러 주는 메서드.

세 가지 방식이 있고 공식 문서가 실행 순서를 명시한다: `@PostConstruct` → `InitializingBean.afterPropertiesSet()` → 커스텀 init 메서드.

`afterPropertiesSet`이라는 이름이 존재 이유를 그대로 담고 있다 — "프로퍼티가 세팅된 **뒤**". 생성자는 setter·필드 주입이 채워지기 전에 끝나므로, 그 의존성을 써야 하는 준비 작업은 생성자에 넣을 수 없다.

**프록시보다 앞이라는 점이 실무에서 가장 중요하다.** 초기화 콜백은 `postProcessAfterInitialization`보다 먼저 실행되므로, 그 안의 `this`는 원본 객체이고 `@Transactional`·`@Async`·`@Cacheable`이 전부 무효다.

- 처음 나온 곳: [[03-bean-creation-and-lifecycle-callbacks]]
- 섞이는 말: [[소멸-콜백]], [[자동-프록시-생성기]]

## 소멸-콜백 (destruction callback)

컨테이너가 닫힐 때 빈이 자원을 반납하도록 불러 주는 메서드. 순서는 초기화와 대칭이다 — `@PreDestroy` → `DisposableBean.destroy()` → 커스텀 destroy 메서드.

**prototype 스코프에서는 불리지 않는다.** 공식 문서의 표현으로, Spring은 prototype 빈의 완전한 생명주기를 관리하지 않는다 — 인스턴스화하고 설정해 클라이언트에게 건네줄 뿐 그 인스턴스에 대한 이후 기록을 갖지 않는다. 그래서 초기화 콜백은 스코프와 무관하게 불려도 소멸 콜백만은 빠진다. prototype 빈이 파일 핸들이나 커넥션을 쥐고 있으면 닫아 줄 사람이 없어 누수가 된다.

- 처음 나온 곳: [[03-bean-creation-and-lifecycle-callbacks]]
- 섞이는 말: [[초기화-콜백]], [[프로토타입-스코프]]

## Aware-인터페이스 (Aware interfaces)

컨테이너가 자기 내부 정보를 빈에게 건네주기 위한 콜백 인터페이스 묶음. `BeanNameAware`(자기 빈 이름), `BeanFactoryAware`, `ApplicationContextAware`, `ApplicationEventPublisherAware`, `ResourceLoaderAware` 등이 있다.

호출 시점을 공식 문서가 못박는다 — 보통의 빈 프로퍼티가 채워진 뒤, 그러나 초기화 콜백보다는 앞이다.

구현하면 **클래스가 Spring에 결합된다**는 대가가 있다. 이벤트를 쏘고 싶으면 `ApplicationEventPublisher`를 생성자로 주입받으면 되고 `ApplicationEventPublisherAware`를 구현할 이유가 없다. Aware가 정당한 자리는 주입으로 얻을 수 없는 것(자기 빈 이름)이거나 프레임워크성 코드다.

- 처음 나온 곳: [[03-bean-creation-and-lifecycle-callbacks]]
- 섞이는 말: [[초기화-콜백]]

## 순환-참조 (circular dependency)

두 개 이상의 빈이 서로를 의존해 **생성 순서를 정할 수 없는** 상태.

의존 그래프에 고리가 생기면 위상 정렬(순서 세우기)이 불가능하다. "만들 순서가 없다"는 것이 이 문제의 정체다. 생성자 주입에서는 컨테이너가 런타임에 이를 감지해 `BeanCurrentlyInCreationException`을 던진다 — 예외 이름이 상황을 그대로 말한다. 만들어 달라고 요청받은 빈이 이미 자기 생성 스택에 올라와 있다는 뜻이다.

공식 문서는 이 상황을 "고전적인 닭과 달걀"이라 부르고, setter 주입으로 우회할 수 있지만 권장하지 않는다고 적는다. Spring Boot는 2.6.0부터 기본 금지다(`spring.main.allow-circular-references=false`).

컴파일은 통과한다는 점이 중요하다. Java 문법으로는 아무 문제가 없고, 오직 "만들 수 있는 순서가 존재하는가"만 걸린다.

- 처음 나온 곳: [[04-eager-singletons-and-circular-references]]
- 섞이는 말: [[조기-노출]], [[사전-인스턴스화]]

## 조기-노출 (early exposure of singletons)

아직 초기화가 끝나지 않은 싱글턴을 다른 빈에게 **미리 참조로 내주는 것**. Spring이 setter 주입 [[순환-참조]]를 깨는 데 쓰는 우회로다.

setter 주입에는 "인스턴스화는 끝났지만 프로퍼티는 아직 안 채워진" 틈이 있다. 컨테이너는 그 틈에서 미완성 객체를 내부 캐시에 등록해 상대 빈에게 건네준다. 생성자 주입에는 이 틈이 없다 — 인스턴스화 자체가 상대를 요구하기 때문이다.

대가를 공식 문서가 명시한다 — 두 빈 중 하나는 자신이 완전히 초기화되기 전에 다른 빈에 주입되도록 강요된다. 그 구간에서 미완성 객체의 메서드를 부르면 `NullPointerException`이 난다. 프록시 씌우기([[자동-프록시-생성기]])보다 앞선 시점이라 프록시와 충돌할 수도 있다.

- 처음 나온 곳: [[04-eager-singletons-and-circular-references]]
- 섞이는 말: [[순환-참조]], [[자동-프록시-생성기]]

## 프로토타입-스코프 (prototype scope)

요청할 때마다 **새 인스턴스**를 만들어 주고, 그 이후로는 관리하지 않는 스코프.

두 가지 함정이 따라온다.

첫째, **[[소멸-콜백]]이 불리지 않는다.** 컨테이너가 건네준 뒤로 그 인스턴스의 기록을 갖지 않기 때문이다. 자원을 쥔 객체라면 클라이언트가 직접 닫아야 한다.

둘째, **싱글턴에 주입하면 주입은 한 번뿐이다.** 공식 문서의 표현대로 그때 만들어진 prototype 인스턴스가 싱글턴에 공급되는 유일한 인스턴스다. `@Scope("prototype")`을 붙였는데 항상 같은 객체인 이유가 이것이다. 매번 새것이 필요하면 주입 지점을 `ObjectProvider<T>`로 선언하고 필요한 순간 `getObject()`를 부른다.

- 처음 나온 곳: [[04-eager-singletons-and-circular-references]]
- 섞이는 말: [[소멸-콜백]]

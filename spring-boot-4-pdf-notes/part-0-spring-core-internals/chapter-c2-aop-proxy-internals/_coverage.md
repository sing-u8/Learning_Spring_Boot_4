# chapter-c2 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다.
>
> 이 챕터가 존재하는 이유: c1이 "프록시가 **언제** 씌워지는가"까지 답했다. 그런데 `@Transactional`이 안 먹는 실무 사고의 대부분은 그다음 질문 — "프록시가 **무엇으로 어떻게** 만들어지는가" — 에서 갈린다. *Learning Spring Boot 4*는 `@Transactional`을 쓰지만 그것이 프록시로 구현된다는 사실 자체를 다루지 않는다.

## 1. 1차 소스

> 아래 URL은 이 챕터를 쓰면서 **실제로 열어 대조한 페이지**다. 내 설명을 믿지 말고 이 주소에서 직접 확인할 수 있게 남긴다.

| 소스 | 정확한 위치 | 역할 |
|---|---|---|
| Framework Ref — Proxying Mechanisms | `https://docs.spring.io/spring-framework/reference/core/aop/proxying.html` | JDK vs CGLIB 선택 규칙, CGLIB 제약 6항목, Objenesis 생성자 우회와 **JVM 단서**, 자기 호출 서술, `AopContext` 평가 |
| Framework Ref — AOP Concepts | `https://docs.spring.io/spring-framework/reference/core/aop/introduction-defn.html` | 조인 포인트·어드바이스·포인트컷·타깃 객체·위빙 정의, **Spring AOP 조인 포인트는 메서드 실행뿐** |
| Framework Ref — Autoproxying | `https://docs.spring.io/spring-framework/reference/core/aop-api/autoproxy.html` | 자동 프록시가 BPP 기반, `BeanNameAutoProxyCreator`·`DefaultAdvisorAutoProxyCreator`, **매칭 없으면 프록시 안 함**, 어드바이저여야 하는 이유 |
| Framework Ref — Basic Concepts: @Bean and @Configuration | `https://docs.spring.io/spring-framework/reference/core/beans/java/basic-concepts.html` | full vs lite 모드, 인터-빈 참조 가로채기, `proxyBeanMethods`, lite 모드 작성 방침 |
| Boot Ref — Aspect-Oriented Programming | `https://docs.spring.io/spring-boot/reference/features/aop.html` | **Boot 기본이 CGLIB**이며 `spring.aop.proxy-target-class=false`로 JDK 전환 |
| Boot Ref — Native Image | `https://docs.spring.io/spring-boot/reference/packaging/native-image/introducing-graalvm-native-images.html` | CGLIB 프록시가 빌드 시점에 생성돼야 한다는 제약 |
| Boot 테스트 — `AopAutoConfigurationTests` | Context7 `/spring-projects/spring-boot/v4.0.3` | AspectJ 부재 시에도 클래스 프록시가 기본이라는 회귀 테스트 |

## 2. 책 트랙과의 관계

| 책의 서술 | 이 챕터가 채우는 것 |
|---|---|
| 책 전체 — `@Transactional`을 붙여 트랜잭션을 건다 | 그 애노테이션이 **프록시로 구현된다**는 사실과, 프록시가 무엇으로 만들어지는지 |
| Ch. 1 — `@Bean` 메서드로 빈을 등록한다 | 그 메서드가 **평범한 자바 메서드가 아니라 가로채진다**는 것(full 모드) |
| Ch. 1 — `@Configuration` 클래스 예제 | 그 클래스 자신이 CGLIB 하위 클래스로 교체된다는 것 |
| 책에 없음 — JDK 동적 프록시·CGLIB·Advisor·Pointcut·`proxyBeanMethods` | 이 챕터의 핵심. 책에 한 번도 등장하지 않는다 |

## 3. 주제 → 노트 매핑

| 주제 | 출처 | 정리 노트 | 상태 |
|---|---|---|---|
| 프록시가 런타임 생성 클래스라는 사실 | Framework Ref · AOP Proxies | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 1절·2.1 |
| JDK vs CGLIB 선택 규칙(인터페이스 유무) | Framework Ref · Proxying Mechanisms (원문) | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 2.2 |
| `ClassCastException`이 나는 타입 관계 | 위 규칙에서 도출 | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 1절·2.1 |
| JDK 프록시에 인터페이스 밖 메서드가 없다는 것 | Framework Ref · Proxying Mechanisms | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 1절·2.1 |
| 전역 기본 프록시 타입이 설정마다 다르다는 단서 | Framework Ref · Proxying Mechanisms (원문) | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 2.3 |
| **Spring Boot 기본이 CGLIB라는 사실** | Boot Ref · AOP (원문) | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 2.3·5절 |
| `proxyTargetClass`를 켜는 경로들 | Framework Ref · Proxying Mechanisms | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 2.4 |
| XML에서 한 곳 설정이 셋 모두에 적용된다는 경고 | Framework Ref · Proxying Mechanisms (원문) | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 2.4 |
| 프록시 타입 판별 방법 | Boot 테스트의 `AopUtils` 사용에서 도출 | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 5절 |
| 네이티브 이미지에서 프록시가 빌드 시점 생성 | Boot Ref · Native Image | [[01-jdk-dynamic-proxy-vs-cglib]] | 반영 — 6절 |
| AOP 7개 용어의 공식 정의 | Framework Ref · AOP Concepts (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.1 |
| Spring AOP의 조인 포인트는 메서드 실행뿐 | Framework Ref · AOP Concepts (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.1·5절 |
| 어드바이스를 인터셉터 체인으로 모델링 | Framework Ref · AOP Concepts (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.1·3절 |
| 자동 프록시가 빈 후처리기 인프라 기반 | Framework Ref · Autoproxying (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.3 |
| **매칭이 없으면 프록시하지 않는다** | Framework Ref · Autoproxying (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 1절·2.3·3절 |
| 어드바이저여야 하는 이유(평가할 포인트컷 필요) | Framework Ref · Autoproxying (원문) | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.2 |
| 두 자동 프록시 생성기의 판정 기준 차이 | Framework Ref · Autoproxying | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.4 |
| 포인트컷 평가가 메서드 단위라는 것 | 위 규칙에서 도출 | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 2.3·3절 |
| 애스펙트와 어드바이저의 층위 차이 | Framework Ref · AOP Concepts + Autoproxying 종합 | [[02-advisor-pointcut-and-auto-proxy-creation]] | 반영 — 5절 |
| CGLIB 제약 6항목 | Framework Ref · Proxying Mechanisms (원문 목록) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.1 |
| 제약 전체가 상속·오버라이드에서 유도된다는 정리 | 위 목록에서 도출 | [[03-why-final-private-and-self-invocation-break]] | 반영 — 1절·3절 |
| Objenesis 생성자 우회와 이중 호출 회피 | Framework Ref · Proxying Mechanisms (원문) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.1·3절 |
| 프록시 필드가 초기화되지 않는다는 귀결 | 위 사실에서 도출 | [[03-why-final-private-and-self-invocation-break]] | 반영 — 1절·3절 |
| 자기 호출이 `this` 참조에 대해 실행된다는 서술 | Framework Ref · Understanding AOP Proxies (원문) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.3 |
| 권장 해법이 리팩터링이라는 문서의 표현 | 같음 (원문) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.3 |
| `AopContext.currentProxy()`에 대한 부정적 평가 | 같음 (원문) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.3·6절 |
| AspectJ 위빙에는 자기 호출 문제가 없다는 명시 | 같음 (원문) | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.3·6절 |
| `this.` 생략이 동일하다는 점 | Java 언어 규칙 | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.4·5절 |
| Kotlin의 기본 `final`과 `kotlin-spring` 플러그인 | Framework Ref 제약 + Kotlin 언어 규칙에서 도출 | [[03-why-final-private-and-self-invocation-break]] | 반영 — 2.5 |
| full 모드와 lite 모드의 경계 조건 | Framework Ref · Basic Concepts (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.1 |
| 인터-빈 참조가 가로채여 싱글턴이 반환된다 | 같음 (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 1절·2.2 |
| 가로채는 목적("미묘한 버그를 줄인다") | 같음 (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 1절 |
| lite 모드에서 매번 새 인스턴스가 된다는 서술 | 같음 (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 1절·3절 |
| `@Component`의 `@Bean`도 lite 모드라는 것 | 같음 | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.1·5절 |
| lite 모드의 작성 방침(인자 주입) | 같음 (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.3 |
| CGLIB 미생성의 오버헤드·메모리 이득 | 같음 (원문) | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.4 |
| `@AutoConfiguration`이 lite 모드를 쓰는 이유 | Boot 문서 + Native Image 항목 종합 | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.4 |
| 설정 클래스 강화도 `final` 제약을 받는다 | Proxying Mechanisms 제약을 적용 | [[04-configuration-class-cglib-enhancement]] | 반영 — 2.2·6절 |
| `@AspectJ` 포인트컷 표현식 문법 전체 | Framework Ref · Declaring a Pointcut | — | 미반영 — 문법 레퍼런스이지 메커니즘이 아니다. 필요할 때 공식 문서를 찾는 편이 낫고, 이 챕터의 축(왜 그렇게 동작하는가)과 다르다 |
| 어드바이스 5종(`@Before`·`@Around` 등)의 사용법 | Framework Ref · Declaring Advice | — | 미반영 — 같은 이유. 이 챕터는 어드바이스가 **언제 어디에 적용될지 판정되는 과정**만 다룬다 |
| `ProxyFactoryBean`을 이용한 수동 프록시 구성 | Framework Ref · Using the ProxyFactoryBean | — | 미반영 — 자동 프록시가 표준인 현재 실무에서 쓸 일이 거의 없다. 자동 프록시의 판정 원리를 아는 것으로 충분하다 |
| AspectJ 로드타임 위빙 설정 절차 | Framework Ref · Using AspectJ with Spring | — | 미반영 — 대안의 존재와 트레이드오프만 언급했다. 설정 절차는 실제 도입을 결정한 뒤 필요한 정보다 |

## 4. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "인터페이스가 있으면 JDK 프록시가 쓰인다" | Framework 기본은 맞지만 **Boot 기본은 CGLIB**다 | 01 — 2.3·5절 |
| "Spring이 모든 빈을 프록시로 감싼다" | 매칭되는 포인트컷이 없으면 감싸지 않는다 | 02 — 1절 |
| "프록시면 모든 메서드에 어드바이스가 붙는다" | 판정은 메서드 단위다 | 02 — 2.3·3절 |
| "`@Transactional`이 안 먹으면 CGLIB로 바꾼다" | 자기 호출은 프록시 종류와 무관하다 | 01 — 5절 · 03 — 5절 |
| "`private` 메서드의 `@Transactional`은 실패한다" | 실패가 아니라 **후보에서 빠진다.** 아무 일도 안 일어난다 | 03 — 2.2·5절 |
| "프록시는 원본과 같은 객체다" | 별개 인스턴스다. 필드는 초기화되지 않는다 | 03 — 1절·3절 |
| "자기 호출 문제는 Spring의 한계다" | Java의 규칙이며, 프록시 방식을 택한 대가다. AspectJ에는 없다 | 03 — 2.3 |
| "`@Bean` 메서드 호출은 평범한 자바 호출이다" | full 모드에서는 가로채여 싱글턴이 반환된다 | 04 — 1절 |
| "`proxyBeanMethods=false`는 성능 최적화일 뿐이다" | 인터-빈 참조의 의미가 바뀐다. 작성 규칙도 함께 바꿔야 한다 | 04 — 2.3 |
| "`@Component`에 `@Bean`을 써도 똑같다" | 그것만으로 이미 lite 모드다 | 04 — 5절 |

## 5. 아직 다루지 않은 것

| 주제 | 왜 보류인가 |
|---|---|
| 포인트컷 표현식 문법 | 레퍼런스 성격이라 필요할 때 찾는 편이 낫다 |
| 어드바이스 5종의 작성법 | 같은 이유. 이 챕터는 판정 메커니즘이 축이다 |
| `ProxyFactoryBean` 수동 구성 | 자동 프록시가 표준이라 실무 사용 빈도가 낮다 |
| AspectJ 위빙 설정 절차 | 대안의 존재와 트레이드오프만 언급했다 |
| 스코프 프록시(`@Scope(proxyMode=…)`) | 웹 요청·세션 수명이 전제라 c3 이후가 맞는 자리다 |
| `@Async` 프록시와 스레드 경계 | 같은 프록시 메커니즘이지만 비동기 실행 모델이 별도 전제다 |

## 6. 정정 이력

| # | 위치 | 처음에 쓴 것 | 보강 | 근거 |
|---|---|---|---|---|
| 1 | `02` §2.4 | `DefaultAdvisorAutoProxyCreator`를 판정 주체로 설명하고 끝냈다 | **Boot 애플리케이션에는 그 이름이 등록되지 않는다**는 사실을 추가. 실제로는 `AnnotationAwareAspectJAutoProxyCreator`·`InfrastructureAdvisorAutoProxyCreator` 등이며, 전부 `AbstractAutoProxyCreator`를 공유해 판정 규칙만 동일하다 | `https://docs.spring.io/spring-framework/reference/core/aop-api/autoproxy.html` (문서가 드는 예가 그 클래스일 뿐임을 확인) |
| 2 | `03` §1 | 프록시 필드가 `0`으로 읽힌다고 **단정**했다 | **JVM에 달렸다**는 단서를 §1에 직접 붙였다. 생성자 우회가 안 되는 JVM에서는 `40`이 들어가 재현되지 않는다. 값이 환경마다 갈린다는 것 자체가 "필드를 프록시 너머로 읽지 말라"의 근거다 | `https://docs.spring.io/spring-framework/reference/core/aop/proxying.html` — *"JVM이 생성자 우회를 허용하지 않으면 이중 호출을 볼 수 있다"* |

**둘 다 "틀렸다"기보다 "불완전했다"에 가깝다.** 1번은 독자가 코드베이스에서 그 클래스 이름을 찾다 못 찾는 상황을, 2번은 예제를 따라 했는데 재현이 안 되는 상황을 만든다.

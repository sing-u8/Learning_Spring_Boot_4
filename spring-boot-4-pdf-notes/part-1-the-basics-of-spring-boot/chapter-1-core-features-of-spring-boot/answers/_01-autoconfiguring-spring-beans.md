# 모범답안 — 01 Application Context, 의존성 주입, Spring Boot 자동 구성

> **먼저 답하고 나서 열 것.** 이 파일은 [[01-autoconfiguring-spring-beans]]의 `## 8. 스스로 확인` 여덟 문항과 2026-08-28 인출 세션에서 나온 꼬리질문 네 개에 대한 답안이다. 답을 읽는 것은 인출이 아니다. 여기를 먼저 열면 그 문항들은 다시 시험 문제로 쓸 수 없다.

- 대상 노트: [[01-autoconfiguring-spring-beans]] · 챕터 지도: [[_map]] · 용어: [[_glossary]]
- 작성: 2026-08-28, 첫 인출 세션의 후속
- **✅ 표시**는 Context7로 `/spring-projects/spring-boot/v4.0.3` 공식 문서·소스와 대조해 확인한 항목이다. 표시가 없는 곳은 널리 확립된 동작이며 이 세션에서 원문 대조를 하지 않았다.
- 아래 내용의 대부분은 노트 §2와 §6에 이미 있다. 이 파일은 그것을 문항 순서로 다시 묶고, 공식 문서 대조에서 새로 확인한 것을 덧붙인 것이다.

---

## Q1. `BookRepository`가 `DataSource`를 직접 만들지 않으면 테스트와 클라우드 배포가 각각 어떻게 쉬워지는가

**한 줄**: 의존성 주입이 만든 것은 자동 교체가 아니라 **교체 지점 하나**이고, 그 지점 하나가 성격이 다른 두 종류의 변동을 흡수한다.

`BookRepository`는 `DataSource`라는 **계약**만 요구하고, 어느 구현을 넣을지는 구성 코드 한곳이 정한다. 두 상황에서 바뀌는 것이 서로 다르다는 점이 핵심이다.

**테스트 — 구현 자체를 바꾼다**

- 저장소 코드를 한 줄도 고치지 않고 임베디드 H2, Testcontainers가 띄운 컨테이너 데이터소스, mock 중 무엇이든 넣을 수 있다.
- 더 중요한 효과는 **실패 원인의 범위가 좁아진다**는 것이다. 테스트가 깨지면 남는 용의자가 저장소 로직뿐이다.
- ✅ `@JdbcTest` 같은 슬라이스 테스트가 성립하는 이유가 이것이다. `spring-boot-jdbc-test` 모듈이 제공하며 기본으로 인메모리 임베디드 데이터베이스를 자동 구성한다. 슬라이스가 `DataSource`를 갈아끼울 수 있어야 슬라이스라는 개념이 성립한다.

**클라우드 — 같은 구현에 다른 값을 준다**

- 연결 정보가 빌드 산출물이 아니라 **런타임 환경**에서 온다.
- 같은 jar를 dev·stage·prod에 그대로 올리고 프로퍼티나 환경 변수만 바꾼다. 재빌드가 없으므로 “테스트한 그 아티팩트”와 “배포한 아티팩트”가 같다.

**경계**: 자동으로 되는 것이 아니다. 누군가는 여전히 어느 구현을 등록할지 결정해야 한다. DI는 그 결정을 없앤 것이 아니라 저장소 밖 한곳으로 모았을 뿐이다.

---

## Q2. `@Bean` 메서드의 매개변수와 반환값은 각각 어떤 의미인가

**매개변수 = 요구 선언.** “주입 대상”보다 **주입 요청**이 정확하다. 컨텍스트에 “이 타입의 빈이 필요하다”고 말하는 것이고, 결과가 셋으로 갈린다.

1. 컨텍스트가 **타입으로** 후보를 찾아 주입한다.
2. 아직 만들어지지 않았으면 **먼저 만든다.** 여기서 **생성 순서가 파생된다.** 순서를 직접 코딩하는 것이 아니라 의존 관계 선언에서 유도된다.
3. 후보가 없으면 실패하고, 둘 이상이면 `@Primary`나 `@Qualifier` 없이는 `NoUniqueBeanDefinitionException`이 난다.

**반환값 = 등록될 빈 그 자체이자, 그 빈을 찾을 때 쓰는 타입.**

- 반환 **타입**이 컨텍스트의 조회 키다. `DataSource`로 선언하느냐 `HikariDataSource`로 선언하느냐가 실제 동작을 바꾼다.
- ✅ 자동 구성의 `@ConditionalOnMissingBean`도 인자를 주지 않으면 **그 메서드의 반환 타입**을 대상으로 검사한다. 공식 문서 표현으로 *the target type for the condition defaults to the return type of the method.* Q5와 여기서 이어진다.
- **빈 이름은 기본적으로 메서드 이름**이다. `bookRepository(...)` → `bookRepository`.

**한 문장으로**: `@Bean` 메서드는 팩터리다. 매개변수는 그 팩터리의 **입력 명세**, 반환 타입은 **출력 계약**, 메서드 이름은 **출력의 식별자**다. 호출 시점과 횟수는 컨텍스트가 통제하므로 기본 싱글턴에서는 여러 곳에 주입돼도 한 번만 호출된다.

---

## Q3. Spring bean과 JavaBean을 같은 말로 쓰면 어떤 오해가 생기는가

두 기준은 **직교**한다. Spring bean은 “누가 관리하는가”, JavaBean은 “어떤 모양인가”. 어느 쪽도 다른 쪽의 필요조건이 아니다. 뭉치면 네 방향으로 틀린다.

1. **“빈으로 등록하려면 기본 생성자와 setter가 있어야 한다.”** 아니다. 생성자 하나만 있고 필드가 전부 `final`인 불변 객체도 Spring bean이며 오히려 그쪽이 권장된다.
2. **“JavaBean이면 Spring이 관리한다.”** 아니다. `new Video()`로 만든 것은 그냥 객체다. 등록되지 않았으면 주입도, 생명주기 콜백도, AOP 프록시도 없다.
3. **“Spring bean은 가변이어야 한다.”** 2번의 반대 방향 오해다.
4. **진짜로 JavaBean 관례를 요구하는 자리가 따로 있다.** `@ConfigurationProperties`의 setter 바인딩, Jackson 역직렬화, JPA 엔티티의 기본 생성자. 여기서 “Spring이 관리하니까 되겠지”라고 생각하면 조용히 깨진다.

**실제 피해**: 필요 없는 곳에 getter/setter를 다 뚫어 캡슐화를 잃고, 정작 필요한 곳에서는 빠뜨린다.

---

## Q4. H2가 클래스패스에 있을 때 `DataSourceAutoConfiguration`이 검토되는 과정

**먼저 흔한 오답 하나.** 사용자 정의 빈이 있을 때 자동 구성이 “그 빈을 등록”하는 것이 아니다. 그 빈은 이미 **사용자 구성이** 등록했다. 자동 구성의 출력은 사용자 빈이 아니라 **아무것도 없음**이다. 자동 구성은 등록 주체를 바꾸는 것이 아니라 자기 일을 하지 않는다.

| # | 단계 | 왜 그 단계가 필요한가 |
|---:|---|---|
| 0 | ✅ `@SpringBootApplication`(→ `@EnableAutoConfiguration`)이 `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports`에서 후보 목록을 읽는다 | 어떤 라이브러리가 어떤 자동 구성을 제공하는지 규약으로 알아야 하기 때문이다 |
| 1 | ✅ **필터 단계** — 사전 계산된 자동 구성 메타데이터로 필요한 클래스가 없는 후보를 통째로 걷어낸다 | 수백 개 후보를 전부 클래스 로딩하면 시작이 느려지기 때문이다 |
| 2 | `@ConditionalOnClass(DataSource.class)` 통과 확인 | JDBC를 선택하지 않은 애플리케이션에 데이터베이스 구성을 억지로 적용하지 않기 위해서다 |
| 3 | **등록 단계** — 임베디드 데이터베이스(H2)인가, 풀 구현(HikariCP)이 있는가, `spring.datasource.*`가 주어졌는가로 분기한다 | 같은 `DataSource` 계약도 가용한 구현에 따라 만드는 방식이 다르기 때문이다 |
| 4 | ✅ `@ConditionalOnMissingBean` — 사용자 `DataSource` 빈이 이미 있는가 | 사용자의 명시적 선택과 기본값이 충돌하지 않게 하기 위해서다 |
| 5 | 조건을 모두 만족한 **정의만** 등록한다 | 필요한 인프라만 제공하고 불필요한 객체와 부작용을 만들지 않기 위해서다 |
| 6 | `@AutoConfiguration(before = ..., after = ...)` 또는 `@AutoConfigureBefore`·`@AutoConfigureAfter`로 자동 구성 사이의 순서를 적용한다 | `DataSource`를 **소비하는** JPA 자동 구성이 그것보다 먼저 돌면 안 되기 때문이다 |

**6번이 빠지기 쉽다.** 그리고 노트가 이미 경고한 대로 `DataSource` 인터페이스의 존재만으로 데이터베이스가 완성되지는 않는다. 실제로는 드라이버, 풀 구현, R2DBC 구성 여부까지 함께 평가한다.

✅ Boot 4에서 이 클래스는 `spring-boot-autoconfigure`가 아니라 **`spring-boot-jdbc` 모듈**의 `org.springframework.boot.jdbc.autoconfigure` 패키지에 있다. Q8의 직접적 증거다.

---

## Q5 · 꼬리질문 A. 사용자 `DataSource` 빈이 있으면 자동 구성이 물러나는 이유와 메커니즘

`조건부 구성이라서`, `백오프 메커니즘 때문에`는 **이름을 다시 말한 것이지 메커니즘이 아니다.** “왜 물러나나 → 물러나는 정책이 있어서”는 순환이다. 답은 이유 한 칸과 메커니즘 세 칸으로 나뉜다.

### 이유 (정책)

프레임워크는 편의를 제공하되 사용자의 명시적 선택을 이기면 안 된다. ✅ 공식 문서도 `@ConditionalOnMissingBean`의 존재 이유를 그렇게 적는다 — *to allow developers to override auto-configuration if they are not happy with your defaults.*

### 메커니즘 세 칸

**① 무엇을 — 타입.** 자동 구성의 `@Bean` 메서드에 붙은 `@ConditionalOnMissingBean`이 “이 타입의 빈 정의가 이미 있는가”를 본다. ✅ 인자를 주지 않으면 대상은 그 메서드의 **반환 타입**이다. ✅ Boot 4의 실제 코드 모양:

```java
@Bean
@ConditionalOnMissingBean
MultipartConfigElement multipartConfigElement() {
    return this.multipartProperties.createMultipartConfig();
}
```

**② 언제 — 사용자 빈 정의가 전부 등록된 뒤.** 이것이 백오프의 **전제**이고 가장 자주 빠지는 칸이다. ✅ 자동 구성 클래스는 사용자 정의 빈 정의가 모두 추가된 **후에** 로드되도록 보장된다. 공식 문서가 `@ConditionalOnBean`·`@ConditionalOnMissingBean`을 **자동 구성 클래스에서만** 쓰라고 권하는 이유가 정확히 이것이다. 평범한 `@Configuration`에 붙이면 처리 순서에 따라 결과가 달라져 예측할 수 없다. 순서 보장이 없으면 이 조건은 동전 던지기다.

**③ 누가 — `OnBeanCondition`, 두 단계로.** ✅ filter 단계에서 클래스패스 기준으로 빠르게 쳐내고, **`REGISTER_BEAN`** 단계에서 실제 빈 조회를 한다. `@ConditionalOnMissingBean`은 `REGISTER_BEAN` 단계에서만 평가된다. 빈 정의가 다 모이기 전에는 “없다”를 판정할 수 없으니 당연하다. 평가 순서도 `@ConditionalOnBean` → `@ConditionalOnSingleCandidate` → `@ConditionalOnMissingBean`으로 고정돼 있다.

### “우선순위”가 아닌 이유 — 실제로 드러나는 지점

두 개의 `DataSource` 빈이 등록된 뒤 순위로 하나가 이기는 것이 **아니다.** 조건이 거짓이면 자동 구성의 빈 정의는 **애초에 만들어지지 않는다.** 결과적으로 컨텍스트의 `DataSource` 빈은 하나뿐이다.

| | 우선순위 모델이었다면 | 실제 백오프 모델 |
|---|---|---|
| 컨텍스트의 `DataSource` 빈 수 | 2 | **1** |
| `@Primary`가 없을 때 | `NoUniqueBeanDefinitionException` | 아무 일도 없음 |
| 사용자가 할 일 | 충돌을 풀어 줘야 함 | 없음 |

**아무 일도 일어나지 않는 것이 정상 동작이다.** 그리고 그 조용함이 백오프의 진짜 위험이기도 하다 → 꼬리질문 B.

---

## 꼬리질문 B. 자동 구성이 물러날 때 같이 잃는 것 (Level 3 · 경계)

핵심: **백오프의 단위는 설정값 하나가 아니라 빈 정의 하나다.** `DataSource` 빈을 손으로 만들면 Boot가 그 빈을 만들면서 *같이 해 주던 일*이 통째로 사라진다.

**잃는 것**

- **`spring.datasource.*` 프로퍼티 바인딩.** 내 `@Bean`은 그 프로퍼티를 읽지 않는다. `application.yml`에 URL을 적어 두어도 **조용히 무시된다.** 오류가 나지 않으므로 가장 늦게 발견된다.
- 드라이버 클래스 추론, 임베디드 데이터베이스 자동 결정, 커넥션 풀 기본값.
- Actuator의 데이터소스 헬스 인디케이터, 커넥션 풀 지표가 내 빈에 붙지 않을 수 있다.
- **연쇄 효과.** 같은 타입에 조건을 건 **다른** 자동 구성들이 내 빈을 보고 판단을 바꾼다. 빈 하나를 손으로 등록하는 순간, 그 타입에 의존하던 후속 자동 구성 전체의 조건 평가 결과가 함께 움직인다.

**그래서 오버라이드는 3단계로 나눠 판단한다**

| 단계 | 방법 | 자동 구성 | 언제 |
|---|---|---|---|
| 1 | `spring.datasource.*` 프로퍼티만 바꾼다 | 유지 | 대부분 여기서 끝난다 |
| 2 | customizer 성격의 빈을 더한다 | 유지 | 일부만 조정하고 싶을 때 |
| 3 | 빈을 직접 제공한다 | **포기** | 마지막 수단 |

**진단**: `--debug`로 띄우면 조건 평가 리포트가 찍히고, Actuator의 conditions 엔드포인트에서도 볼 수 있다. “Negative matches”에 무엇이 왜 물러났는지가 이유와 함께 나온다. 백오프가 조용하다는 문제의 해독제다.

---

## 꼬리질문 C. 어떤 이름으로 등록되고, 그 이름이 언제 필요한가

**기본 이름 = `@Bean` 메서드 이름.** `bookRepository(...)` → `bookRepository`. `@Bean("myRepo")`로 바꿀 수 있다. 컴포넌트 스캔은 규칙이 다르다 — 클래스명 첫 글자를 내린 이름을 쓴다.

**이름이 필요해지는 순간**

1. **같은 타입 빈이 둘 이상일 때.** 타입만으로 못 고르니 `@Qualifier("primaryDataSource")`가 필요하다. 없으면 `NoUniqueBeanDefinitionException`. 주입 지점의 파라미터 이름이 빈 이름과 일치하면 그것으로 해소되기도 하지만, 리팩터링에 약하므로 의존하지 않는 편이 좋다.
2. `@Primary`로 기본값을 정하고 **나머지는 이름으로** 집을 때.
3. 자동 구성이 관례적 이름으로 특정 빈을 찾을 때.
4. `context.getBean("bookRepository")`, `@DependsOn(...)`, 테스트에서 `@MockitoBean`으로 특정 빈만 교체할 때.
5. **충돌 감지의 키.** 같은 이름의 빈 정의가 두 번 나오면 Boot는 기본적으로 실패시킨다(`spring.main.allow-bean-definition-overriding` 기본 `false`). 조용한 덮어쓰기를 막기 위한 선택이다.

**Q5와 이어지는 대비**: 백오프는 **이름이 아니라 타입**으로 판단한다. 이름을 `myDataSource`로 지어도 반환 타입이 `DataSource`면 자동 구성은 물러난다. 반대로 이름을 Boot 쪽과 똑같이 맞춰도 타입이 다르면 물러나지 않는다. **이름은 주입 시 선택의 축, 타입은 백오프 판정의 축이다.**

---

## Q6 · 꼬리질문 D 앞부분. 빌드 시점 → 시작 시점 → 실행 객체

**빌드 시점 — 스타터**: 스타터는 코드가 아니라 버전이 정렬된(BOM) **의존성 묶음**이다. `spring-boot-starter-data-jpa` 하나가 Hibernate, spring-orm, JDBC 관련 모듈을 끌고 온다. 스타터는 빈을 **하나도 만들지 않는다.** 스타터가 바꾸는 것은 오직 **클래스패스**다.

**시작 시점 — 자동 구성**: `@EnableAutoConfiguration`이 `AutoConfiguration.imports`에서 후보를 읽고, 각 후보의 조건이 ① 방금 그 클래스패스 ② 이미 등록된 사용자 빈 ③ 프로퍼티를 검사한다.

**확정해야 할 지점 — “만든다”가 아니라 “정의를 보탠다”**: ✅ `@AutoConfiguration`은 메타 애노테이션으로 `@Configuration`이다. 공식 문서 표현으로 *annotated with `@AutoConfiguration`, which is itself meta-annotated with `@Configuration`, making auto-configurations standard `Configuration` classes.* 즉 자동 구성이 하는 일은 **빈 정의를 컨텍스트에 보태는 것**이고, 실제 인스턴스화·주입·생명주기 관리는 **애플리케이션 컨텍스트**가 한다. 자동 구성 클래스는 “조건이 붙은 `@Configuration`”일 뿐 특별한 런타임이 아니다.

**실행 객체**: 최종 산출물에 “자동 구성된 빈”이라는 별종은 없다. 그냥 Spring bean이다.

**한 줄 사슬**

> 스타터가 **클래스패스**를 바꾼다 → 자동 구성이 그 클래스패스를 **조건**으로 읽어 **빈 정의**를 보탠다 → 컨텍스트가 그 정의로 **객체**를 만들고 와이어링한다.

---

## Q7. Spring Boot가 Spring Framework를 대체하지 않는다는 말

| | Spring Framework | Spring Boot |
|---|---|---|
| 역할 | **메커니즘** | **정책 + 실행 편의** |
| 담당 | 컨테이너, 빈 생명주기, DI, AOP, 트랜잭션 추상화 | 컨테이너에 무엇을 기본으로 넣을지 조건부 결정, 내장 서버, 실행 가능 jar, Actuator |
| 산출물 | Spring bean | **역시 Spring bean** |

**결정적 근거는 세 번째 줄이다.** 산출물의 종류가 바뀌지 않는다. Boot는 별도 런타임을 두지 않고, 자동 구성이 만드는 것도 Framework 컨텍스트에 등록된 평범한 빈이다.

**반대 방향으로 확인하면 더 선명하다.** `@Bean`, `@Autowired`, `@Configuration`, `@Transactional`, `ApplicationContext`는 전부 Framework 것이다. Boot를 빼면 이것들은 **남고**, 사라지는 것은 “알아서 등록되던 기본값”과 실행 편의뿐이다. 반대는 성립하지 않는다. Framework 없이 Boot만으로는 아무것도 되지 않는다. 의존이 **한 방향**이다.

**실무적 귀결**: 자동 구성이 이상하게 동작할 때 디버깅의 종착점은 결국 “컨텍스트에 어떤 빈 정의가 들어갔나”다. 조건 평가 리포트가 답을 주는 이유이고, 이 사실 자체가 “Boot는 Framework 위의 얇은 결정층”이라는 명제의 증거다.

---

## Q8 · 꼬리질문 D 뒷부분. Boot 4의 기술 중심 모듈이 빌드 파일의 의도를 드러내는 이유

### 369 KB는 사라진 것이 아니라 나간 것이다

예전에는 `spring-boot-autoconfigure` **하나**가 수백 개 기술의 자동 구성을 전부 담았다(약 2.1 MB). Boot 4는 이를 기술별 모듈로 쪼갰다. ✅ 확인된 실제 위치:

| 자동 구성 | Boot 4의 모듈 / 패키지 |
|---|---|
| `DataSourceAutoConfiguration` | `spring-boot-jdbc` / `org.springframework.boot.jdbc.autoconfigure` |
| `MultipartAutoConfiguration` | `spring-boot-servlet` / `org.springframework.boot.servlet.autoconfigure` |
| `FlywayProperties` | `spring-boot-flyway` / `org.springframework.boot.flyway.autoconfigure` |

패키지 이름의 순서가 뒤집힌 데 주목할 만하다. `boot.autoconfigure.jdbc` → `boot.jdbc.autoconfigure`. **기술이 상위, 자동 구성이 하위**가 되었다. 모듈화의 문법적 흔적이다.

### 인과 사슬

1. **옛 방식**: `spring-boot-autoconfigure`가 클래스패스에 있으면 **모든 기술의 후보가 목록에 오른다.** 실제 적용은 `@ConditionalOnClass`가 막아 주지만, 그 판단이 **전이 의존성**에 좌우된다. 내가 넣은 A가 끌고 온 B가 우연히 어떤 클래스를 포함하면 선언한 적 없는 기능이 켜진다.
2. **Boot 4**: 자동 구성 **코드 자체**가 기술 모듈 안에 있으므로 그 모듈이 없으면 **후보가 존재하지 않는다.** 조건 평가 이전에 잘린다.
3. **결과**: 빌드 파일에 적힌 것과 켜지는 동작의 대응이 1:1에 가까워진다. “선언하지 않은 것이 켜지는” 경로가 줄어든다.

### “이 애플리케이션이 Kafka를 쓰는가”를 빌드 파일만 보고 답할 수 있는가

- **옛 방식 — 확답 불가.** 빌드 파일에 `spring-kafka`가 없어도 전이 의존성 가능성이 있고, 자동 구성 후보는 어차피 `spring-boot-autoconfigure`에 다 들어 있다. 확인하려면 의존성 트리를 파거나 조건 평가 리포트를 봐야 한다. **빌드 파일이 답을 주지 못한다.**
- **Boot 4 — 훨씬 직접적.** Kafka 자동 구성이 자기 모듈에 있으니 그 모듈이 없으면 후보가 없다. 빌드 파일이 곧 **“이 애플리케이션이 참여하기로 한 기술 목록”**에 가깝다. 이것이 “아키텍처 의도를 드러낸다”의 정확한 의미다 — 문서가 아니라 **빌드 파일이 아키텍처 선언이 된다.**

### 부수 효과와 대가

**부수 효과**: 클래스패스가 작아지면 평가할 조건도 줄어 시작 시간과 AOT·네이티브 이미지에 유리하고, 취약점 점검 대상도 줄어든다.

**대가**: ✅ 자동 구성 클래스의 패키지가 바뀌었기 때문에 Boot 4는 호환 레이어를 따로 둔다. `META-INF/spring/{애노테이션 이름}.replacements` 파일이 옛 클래스명을 새 이름에 매핑하고, `AutoConfigurationReplacements`가 이를 읽어 `@AutoConfigureBefore`·`@AutoConfigureAfter` 참조와 자동 구성 제외 설정에 적용한다. **호환 레이어가 필요할 만큼의 변화였다**는 사실 자체가, 이 분할이 내부 정리가 아니라 공개 표면을 건드린 변경임을 말해 준다.

**마지막으로 파일 크기.** 369 KB는 **결과의 지표이지 원인이 아니다.** 작아서 빨라지는 것이 아니라 명시성이 올라간 것의 흔적이다. “2.1 MB가 369 KB가 됐다”만 말하면 곧바로 “그래서 그게 왜 좋은가”가 따라온다. 답은 위의 인과 사슬이다.

---

## 이 답안을 읽은 뒤의 재출제 문항

읽는 것은 인출이 아니다. 위 네 개 gap은 `**gaps**`에서 `open`으로 남아 있고, 다음 세션에는 **같은 문장을 반복하지 않고** 엣지 형태로 다시 묻는다.

1. 빈 이름을 `myDataSource`로 지었는데도 자동 구성이 물러났다. 왜인가?
2. `application.yml`의 `spring.datasource.url`이 **아무 오류 없이 무시되는** 상황을 하나 만들어 보라.
3. `@ConditionalOnMissingBean`을 평범한 `@Configuration`에 붙이면 왜 위험한가?
4. 어떤 프로젝트가 Kafka를 쓰는지 확인하라는 요청을 받았다. Boot 3 프로젝트와 Boot 4 프로젝트에서 각각 어떻게 확인하겠는가?
5. 자동 구성을 전부 끄면 애플리케이션에서 무엇이 남고 무엇이 사라지는가?

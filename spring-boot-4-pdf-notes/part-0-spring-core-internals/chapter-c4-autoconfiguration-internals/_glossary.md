# chapter-c4 용어집

> 자동 구성이 "알아서 되는" 것처럼 보이게 만드는 장치들의 이름. 정의는 여기 한 곳에만 둔다.
>
> `빈 정의`·`빈 후처리기`·`사전 인스턴스화`는 `chapter-c1-container-lifecycle`, `설정 클래스 강화`·`라이트 모드`는 `chapter-c2-aop-proxy-internals`의 용어집이 원본이다. 여기서 다시 정의하지 않는다.

## 자동-구성-후보 (auto-configuration candidate)

`@EnableAutoConfiguration`이 켜졌을 때 컨테이너가 **평가 대상으로 올리는** 설정 클래스.

"후보"라는 말이 정확하다 — 목록에 올랐다고 적용되는 것이 아니라, 조건([[조건-애노테이션]])을 통과해야 실제로 빈이 등록된다. 애플리케이션 하나가 수백 개의 후보를 평가하고 그중 수십 개만 적용한다.

후보는 `@AutoConfiguration`이 붙은 클래스이며, 이 애노테이션은 `@Configuration(proxyBeanMethods = false)`를 메타 애노테이션으로 갖는다(c2의 라이트 모드). 후보가 수백 개인데 전부 CGLIB로 강화하면 시작 비용이 누적되기 때문이다.

- 처음 나온 곳: [[01-enableautoconfiguration-and-imports-file]]
- 섞이는 말: [[임포트-파일]], [[조건-애노테이션]]

## 임포트-파일 (AutoConfiguration.imports)

[[자동-구성-후보]] 목록이 적힌 JAR 안의 텍스트 파일. 정확한 경로는 `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports`이며, 한 줄에 클래스 이름 하나씩 적는다.

공식 문서는 이 파일이 **유일한 등록 경로**임을 못박는다 — 자동 구성은 임포트 파일에 이름이 적히는 것으로**만** 로드되어야 하고, 특정 패키지 공간에 두어 **컴포넌트 스캔의 대상이 되지 않도록** 해야 하며, 자동 구성 클래스 자신이 추가 컴포넌트를 찾기 위해 컴포넌트 스캔을 켜서도 안 된다.

왜 스캔이 아니라 파일인지가 핵심이다. 스캔은 "내 패키지 아래"를 훑는데, 자동 구성은 **남의 JAR 안**에 있다. 스캔 범위를 라이브러리까지 넓히면 의도치 않은 빈이 딸려 오고 시작이 느려진다. 명시적 목록 파일이 그 경계를 만든다.

- 처음 나온 곳: [[01-enableautoconfiguration-and-imports-file]]
- 섞이는 말: [[자동-구성-후보]]

## 조건-애노테이션 (conditional annotation)

[[자동-구성-후보]]가 실제로 적용될지를 판정하는 `@Conditional*` 계열 애노테이션.

주요 항목은 이렇다.

- 클래스 조건 — `@ConditionalOnClass`, `@ConditionalOnMissingClass`
- 빈 조건 — `@ConditionalOnBean`, `@ConditionalOnMissingBean`
- 프로퍼티 조건 — `@ConditionalOnProperty`, `@ConditionalOnBooleanProperty`
- 리소스 조건 — `@ConditionalOnResource`
- 웹 조건 — `@ConditionalOnWebApplication`, `@ConditionalOnNotWebApplication`, `@ConditionalOnWarDeployment`
- 표현식 조건 — `@ConditionalOnExpression`

빈 조건에 대해 공식 문서가 경고를 붙인다 — 이 조건들은 **지금까지 처리된 것을 기준으로** 평가되므로 빈 정의가 추가되는 순서에 매우 주의해야 하며, 그래서 `@ConditionalOnBean`·`@ConditionalOnMissingBean`은 **자동 구성 클래스에만** 쓰기를 권한다. 자동 구성은 사용자 정의 빈 정의가 모두 추가된 뒤에 로드되는 것이 보장되기 때문이다.

- 처음 나온 곳: [[02-conditional-evaluation-and-backoff]]
- 섞이는 말: [[백오프]], [[자동-구성-순서]]

## 백오프 (back-off)

사용자가 같은 역할의 빈을 직접 정의하면 자동 구성이 **물러나는** 동작.

공식 문서는 이것을 자동 구성의 성격으로 규정한다 — 자동 구성은 **비침습적(non-invasive)**이며, 어느 시점에든 자기 설정을 정의해 자동 구성의 특정 부분을 대체할 수 있다. 예를 들어 자기 `DataSource` 빈을 추가하면 기본 내장 데이터베이스 지원이 물러난다.

메커니즘은 `@ConditionalOnMissingBean`이다. "없으면 만든다"는 조건이 곧 "있으면 안 만든다"이므로, 별도의 우선순위 규칙 없이 사용자 빈이 이긴다.

**이 동작이 성립하려면 순서가 보장돼야 한다** — 사용자 빈 정의가 먼저 등록되고 자동 구성이 나중에 평가되어야 "이미 있다"는 판정이 가능하다([[자동-구성-순서]]).

- 처음 나온 곳: [[02-conditional-evaluation-and-backoff]]
- 섞이는 말: [[조건-애노테이션]], [[자동-구성-순서]]

## 자동-구성-순서 (auto-configuration ordering)

[[자동-구성-후보]]들이 평가·적용되는 순서. `@AutoConfiguration`의 `before`·`beforeName`·`after`·`afterName` 속성, 전용 애노테이션 `@AutoConfigureBefore`·`@AutoConfigureAfter`, 그리고 서로를 직접 알지 못하는 경우를 위한 `@AutoConfigureOrder`로 지정한다.

공식 문서가 `@AutoConfigureOrder`를 일반 `@Order`와 같은 의미이되 **자동 구성 클래스 전용 순서**를 제공하는 것이라 설명한다.

가장 중요한 사실은 이것이 무엇을 정하고 무엇을 정하지 않는가다 — 자동 구성 클래스가 적용되는 순서는 **그 빈들이 정의되는 순서에만** 영향을 주고, 그 빈들이 이후에 **생성되는 순서는 영향받지 않으며** 각 빈의 의존성과 `@DependsOn` 관계가 결정한다([[정의-순서]]).

- 처음 나온 곳: [[03-autoconfiguration-ordering-and-user-precedence]]
- 섞이는 말: [[정의-순서]], [[백오프]]

## 정의-순서 (bean definition order)

빈 **정의**가 레지스트리에 등록되는 순서. 빈 **인스턴스**가 만들어지는 순서와 다르다.

c1에서 본 정의 단계와 인스턴스 단계의 구분이 여기서 실무적 의미를 갖는다. [[자동-구성-순서]]는 정의 순서만 바꾸고, 생성 순서는 의존 관계가 정한다.

이 구분을 놓치면 `@AutoConfigureAfter`로 "이 빈이 나중에 만들어지게" 하려다 실패한다. 생성 순서를 강제하려면 의존성으로 표현하거나 `@DependsOn`을 써야 한다.

- 처음 나온 곳: [[03-autoconfiguration-ordering-and-user-precedence]]
- 섞이는 말: [[자동-구성-순서]]

## 조건-평가-보고서 (condition evaluation report)

각 [[자동-구성-후보]]의 조건이 어떻게 평가됐는지를 담은 보고서. 모든 Spring Boot `ApplicationContext`에 `ConditionEvaluationReport`로 존재한다.

보는 방법이 둘이다. `--debug` 스위치(또는 `-Ddebug`)로 시작하면 콘솔에 찍히고, Actuator를 쓰면 `/actuator/conditions`가 JSON으로 렌더링한다.

구성은 세 부분이다.

- `positiveMatches` — 조건이 맞아 **적용된** 것. 메시지에 이유가 붙는다(예: `@ConditionalOnClass found required class 'org.springframework.web.servlet.DispatcherServlet'`).
- `negativeMatches` — 조건이 안 맞아 **적용되지 않은** 것. **왜 안 됐는지가 여기 있다.**
- [[무조건-클래스]] — 조건이 없어 항상 적용되는 것.

"왜 이 빈이 없지?"라는 질문에 답하는 유일한 확실한 방법이다. 소스를 뒤지는 것보다 빠르다.

- 처음 나온 곳: [[04-condition-evaluation-report]]
- 섞이는 말: [[무조건-클래스]], [[조건-애노테이션]]

## 무조건-클래스 (unconditional classes)

`@Conditional*` 애노테이션이 하나도 붙어 있지 않아 **항상 적용되는** 자동 구성 클래스. [[조건-평가-보고서]]의 세 번째 절에 목록으로 나온다.

`ConfigurationPropertiesAutoConfiguration`처럼 어떤 환경에서도 필요한 기반 구성이 여기 속한다.

실무적 의미는 **진단 시 제외 대상**이라는 것이다. 무언가 안 되는 원인을 찾을 때 이 목록의 클래스들은 "조건 때문에 빠졌을 가능성"이 애초에 없으므로 후보에서 지워도 된다.

- 처음 나온 곳: [[04-condition-evaluation-report]]
- 섞이는 말: [[조건-평가-보고서]]

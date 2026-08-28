# 모범답안 — 04 조건 평가 보고서

> **먼저 답하고 나서 열 것.** [[04-condition-evaluation-report]]의 `## 8. 스스로 확인` 열 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **10문항 모두 답이 충분**했다.

---

## Q1. 소스를 읽어 추측하는 것이 나쁜 전략인 이유 셋

| 문제 | 내용 |
|---|---|
| **① 조건이 중첩돼 있으면 어느 것이 먼저 걸렸는지 모른다** | **클래스 조건에서 이미 탈락했는데 프로퍼티 이름을 몇 시간씩 들여다본다** |
| **② 다른 자동 구성의 결과에 의존하는 조건은 소스만으로 판정할 수 없다** | `@ConditionalOnBean`은 [[03-autoconfiguration-ordering-and-user-precedence]]에서 봤듯 **순서에 따라 결과가 달라진다** |
| **③ "적용됐는데 다른 이유로 안 되는 경우"와 구별할 수 없다** | 자동 구성은 **정상 적용됐고 빈 이름이 예상과 다른 것뿐**일 수도 있다 |

**그리고 조건 애노테이션은 메타 애노테이션으로 숨어 있기도 하다** — 소스에 `@ConditionalOnClass`가 안 보여도 상위 애노테이션에 있을 수 있다.

**무엇보다 추측이 맞았는지 확인할 방법이 없다.**

**공식 문서가 이 상황을 정확히 짚는다** — *"Spring Boot 자동 구성은 '옳은 일을 하려고' 최선을 다하지만, 때때로 실패하고 **왜 그런지 알기 어려울 수 있다.**"* 그리고 곧바로 도구를 알려 준다 — *"모든 Spring Boot `ApplicationContext`에 정말 유용한 **`ConditionEvaluationReport`**가 있다."*

**비유와 그 한계 — 비행 기록 장치**: 사고 원인을 **승무원의 기억에 의존해 재구성하는 대신**, **모든 계기값이 이미 기록돼 있으므로 그것을 읽으면 된다.** 추측할 필요가 없다.

→ **깨지는 지점**: **블랙박스는 사고가 나야 열어 본다.** 조건 평가 보고서는 **문제가 없을 때 읽는 것이 더 유용하다**(Q9). **"지금 무엇이 켜져 있는지"를 알면 애초에 사고가 줄고**, 의존성을 추가했을 때 **무엇이 따라 들어왔는지**도 보인다.

---

## Q2. 보고서를 보는 두 방법과 실행 중인 앱에 나은 쪽

**① `--debug` 스위치**

공식 문서: 현재 어떤 자동 구성이 적용되고 있고 **왜** 그런지 알고 싶으면 `--debug`로 시작한다. **선택된 코어 로거들의 디버그 로그가 켜지고 콘솔에 조건 보고서가 찍힌다.**

```bash
java -jar cosmoroute.jar --debug
./gradlew bootRun --args='--debug'
java -Ddebug -jar cosmoroute.jar
```

**② Actuator의 `conditions` 엔드포인트**

```bash
curl localhost:8080/actuator/conditions
```

공식 문서는 이 엔드포인트를 **"애플리케이션을 디버깅하고 Spring Boot가 런타임에 어떤 기능을 추가했는지(그리고 추가하지 않았는지) 보는 데" 쓰라**고 권한다.

**실행 중인 애플리케이션에는 ②가 낫다**:

| 이유 | 내용 |
|---|---|
| **재시작이 필요 없다** | 운영 중인 인스턴스를 그대로 조사한다 |
| **실제 프로파일이 적용된 상태** | 재시작하면 조건이 달라질 수 있다 |
| **JSON이라 기계 처리 가능** | `jq`로 걸러 읽는다 |

**§5의 주의**: **`conditions` 엔드포인트는 기본 노출이 아니다**:

```properties
management.endpoints.web.exposure.include=health,info,conditions
```

> **운영 환경에 무심코 노출하지 않는다. 애플리케이션의 내부 구성이 그대로 드러난다.**

**§5의 또 다른 구분**: **`--debug`는 로그 레벨 변경이 아니다.** **선택된 코어 로거들만** 디버그로 올리고 조건 보고서를 찍는다. **`--trace`나 `logging.level.root=DEBUG`와 다르다.**

---

## Q3. 보고서의 세 절과 각각이 답하는 질문

| 절 | 무엇이 있나 | **언제 보나** |
|---|---|---|
| **`positiveMatches`** | 조건이 맞아 **적용된** 것 + 그 이유 | **"이 기능이 왜 켜졌지?"** |
| **`negativeMatches`** | 조건이 안 맞아 **적용 안 된** 것 + **그 이유** | **"왜 이 빈이 없지?"** |
| ****무조건 클래스**** | **조건이 아예 없어** 항상 적용되는 것 | **진단 대상에서 제외** |

```json
{
  "positiveMatches": [
    { "condition": "OnClassCondition",
      "message": "@ConditionalOnClass found required class '...DispatcherServlet'" }
  ],
  "negativeMatches": [
    { "condition": "OnPropertyCondition",
      "message": "@ConditionalOnProperty (server.servlet.session.persistent) did not find property ..." }
  ],
  "unconditionalClasses": [ "...ConfigurationPropertiesAutoConfiguration" ]
}
```

> **`negativeMatches`가 진단의 핵심이다.** 메시지가 **`condition`**(어느 조건 종류가 판정했는지)과 **`message`**(무엇을 찾았고 못 찾았는지)로 이뤄져 있어, **추측 없이 원인을 짚을 수 있다.**

**세 번째 절의 값어치** — `unconditionalClasses`는 **조건이 없으므로 진단할 것이 없다.** "왜 이게 켜졌지?"를 물을 필요가 없는 목록이라, **찾는 범위를 좁혀 준다.**

---

## Q4. `condition` 값에 따라 고칠 자리가 달라지는 방식

| `condition` | 뜻 | **고칠 자리** |
|---|---|---|
| **`OnClassCondition`** | 필요한 클래스가 클래스패스에 없다 | **의존성** |
| **`OnPropertyCondition`** | 프로퍼티가 없거나 값이 다르다 | **설정 파일** |
| **`OnBeanCondition`** | 필요한 빈이 없거나, **이미 있어서 물러났다** | **다른 자동 구성의 상태** 또는 **내 빈** |
| **`OnWebApplicationCondition`** | 웹 애플리케이션 타입이 안 맞는다 | **스타터·애플리케이션 타입** |

**진단 순서**(§2.3):

```text
1. /actuator/conditions 호출 또는 --debug 재시작
2. negativeMatches 에서 RedisAutoConfiguration 을 찾는다
     없다면? → 후보 목록에 없었다는 뜻 → 의존성 문제 (Q6)
3. 그 항목의 condition 과 message 를 읽는다
4. 조건 종류에 따라 다음 행동을 정한다
```

> **3번에서 대부분 끝난다. 몇 시간짜리 추측이 한 줄 읽기로 바뀐다.**

**`OnBeanCondition`이 두 방향이라는 점을 놓치기 쉽다**:

```text
@ConditionalOnBean 불통과   → 필요한 빈이 없다      → 다른 자동 구성이 안 켜졌다
@ConditionalOnMissingBean 불통과 → 이미 있어서 물러났다 → 내 빈이 이미 있다 (정상!)
```

**후자는 문제가 아니다** — 백오프가 정상 작동한 것이다(c4-02). **`message`를 읽어야 어느 쪽인지 안다.**

**그리고 `OnBeanCondition`일 때만 순서를 의심한다**(c4-03 Q10) — 클래스·프로퍼티 조건에서 걸렸으면 순서는 원인이 아니다.

---

## Q5. `negativeMatches`가 길다는 것이 문제가 아닌 이유

**수백 개의 후보 중 대부분이 여기 들어오는 것이 정상이다.**

**§5**: **MongoDB를 안 쓰면 MongoDB 자동 구성이 `negativeMatches`에 있는 것이 당연하고 옳다. 목록이 길다고 문제가 아니다.**

**c4-01 Q6의 사실이 그대로다** — **후보는 수백 개이고 적용은 수십 개다.** Boot는 **어떤 조합의 라이브러리를 쓸지 미리 알 수 없어** 가능한 모든 조합을 후보로 두고 **실제 클래스패스를 보고 걸러낸다.**

> **찾는 것은 "내가 켜지길 기대했는데 여기 있는 항목" 하나다.**

**읽는 법**:

```bash
curl -s localhost:8080/actuator/conditions \
  | jq '.contexts.application.negativeMatches | keys[]' \
  | grep -i redis
```

**목록 전체를 읽는 것이 아니라 이름으로 찾는다.**

**이름의 유래도 이 오해를 막는다**(§2.6):

> **`positiveMatches`/`negativeMatches`의 "match"는 포인트컷 매칭과 같은 어법이다.** "조건식이 이 대상과 맞아떨어졌는가"라는 뜻이며, **`negative`가 "오류"를 뜻하지 않는다.**

**§6**: **`negativeMatches`의 길이를 문제로 보지 않는다. 대부분 정상이다.**

---

## Q6. 보고서에 자동 구성이 아예 안 나타나면

**후보 목록에 없었다는 뜻이다 — 의존성 문제다.**

```text
negativeMatches 에 있다  → 후보였고, 조건에서 걸렸다   → 조건을 본다
negativeMatches 에 없다  → 애초에 후보가 아니었다      → 의존성을 본다
positiveMatches 에 없다     (평가 자체가 안 됐다)
```

**§2.3의 2단계**: **없다면 애초에 후보 목록에 없었다는 뜻이고, 그건 의존성 문제다**([[01-enableautoconfiguration-and-imports-file]]).

**의심할 것들**:

| 원인 | 확인 |
|---|---|
| **의존성이 안 들어왔다** | `./gradlew dependencies`로 그 JAR이 있는지 |
| **JAR에 imports 파일이 없다** | 자작 스타터라면 `META-INF/spring/...imports` 경로 확인 |
| **`exclude`로 제외했다** | `@SpringBootApplication(exclude=...)`, `spring.autoconfigure.exclude` |
| **`spring.factories` 옛 방식을 썼다** | Boot 2.7 이후로는 안 읽는다(c4-01 Q3) |

**이 판정이 진단을 두 갈래로 나눠 준다**:

```text
보고서에 있나?
  ├ 있다 → 조건 문제 → message 를 읽는다 (Q4)
  └ 없다 → 후보 수집 문제 → 의존성·imports·exclude 를 본다
```

**추측을 두 번 줄인다** — 어느 쪽인지 먼저 확정하고, 그다음에 그쪽만 파고든다.

---

## Q7. `SpringBootCondition.matches()`가 `final`인 것이 강제하는 것

**기록하는 단계를 건너뛸 수 없다는 것이다.**

```java
public final boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
    ConditionOutcome outcome = getMatchOutcome(context, metadata);   // 하위 클래스가 판정
    logOutcome(classOrMethodName, outcome);                          // 로그에 남기고
    recordEvaluation(context, classOrMethodName, outcome);           // 보고서에 기록한다
    return outcome.isMatch();
}
```

> **`matches()`가 `final`이라는 점이 설계 의도를 말한다 — 판정 로직은 하위 클래스가 바꿀 수 있지만, 기록하는 단계는 건너뛸 수 없다. 그래서 모든 조건이 예외 없이 보고서에 남는다.**

**템플릿 메서드 패턴이다**:

```text
final matches()          ← 골격은 고정. 기록을 포함한다
  └ getMatchOutcome()    ← 하위 클래스가 채운다. 판정만.
```

**`final`이 아니었다면** — 커스텀 조건이 `matches()`를 오버라이드해 **기록 없이 판정만** 할 수 있다. 그러면 **보고서에 구멍이 생기고**, "보고서에 없으면 후보가 아니다"(Q6)라는 판정도 무너진다.

**즉 `final`이 보고서의 신뢰성을 보장한다** — **완전성이 도구의 값어치다.** 일부만 기록되는 로그는 "여기 없으니 안 일어났다"고 말할 수 없다.

**c2-03의 `final` 제약과 대비된다** — 거기서는 `final`이 **프록시를 막는 문제**였는데, 여기서는 **의도적으로 확장을 막아** 계약을 강제한다. **같은 키워드가 상황에 따라 제약이기도 하고 보증이기도 하다.**

---

## Q8. 반환 타입이 `boolean`이 아니라 `ConditionOutcome`인 이유

**`true`/`false`만으로는 "왜"를 기록할 수 없기 때문이다.**

> **판정 결과와 그 이유를 함께 나르는 객체가 있어야 보고서의 `message`가 만들어진다.**

```text
boolean 이었다면
  matches() → false
  → 보고서에 쓸 수 있는 것: "불통과"
  → 사용자가 아는 것: 아무것도 없다

ConditionOutcome
  matches() → { match: false,
                message: "@ConditionalOnProperty (server.servlet.session.persistent)
                          did not find property 'server.servlet.session.persistent'" }
  → 사용자가 아는 것: 어느 프로퍼티가 없어서인지
```

**메시지가 Q4의 진단표를 가능하게 한다** — **`condition`과 `message`가 있어야 "고칠 자리"를 짚을 수 있다.**

**설계 원칙으로 일반화하면**: **판정을 하는 쪽이 이유를 함께 내보내는 것**이 나중에 진단을 가능하게 한다. 판정 로직 안에서만 알 수 있는 정보이므로, **그 자리에서 안 담으면 영원히 잃는다.**

**같은 패턴이 다른 곳에도 있다**:

| | 결과만 | 결과 + 이유 |
|---|---|---|
| 조건 평가 | `boolean` | **`ConditionOutcome`** |
| 검증 | `boolean` | `BindingResult`(c3-03) |
| 예외 해석 | `boolean` | `ModelAndView`/`null`(c3-05 Q7) |

**세 번째도 같은 성격이다** — `null`이 "미해결"이라는 **정보를 담고** 있어서 체인이 성립한다.

---

## Q9. `positiveMatches`를 문제가 없을 때 읽을 이유 셋

| 이유 | 내용 |
|---|---|
| **① 의존성 하나를 추가했을 때 무엇이 따라 켜졌는지** | c3-04에서 본 **"XML 의존성을 추가했더니 응답 형식이 바뀐" 사고**가 이것으로 미리 잡힌다 |
| **② 내가 끈 줄 알았던 것이 여전히 켜져 있는지** | `exclude`가 실제로 먹었는지 |
| **③ 스타터를 만들 때 내 자동 구성이 의도한 조건에서 켜지는지** | 검증 |

**①이 가장 실용적이다** — **의존성 추가는 "그 라이브러리를 쓰는 것" 이상의 일을 한다.** 클래스패스가 바뀌면 **조건이 다시 평가되고, 예상 밖의 자동 구성이 켜질 수 있다.**

```text
의존성 추가 전후로 positiveMatches 를 비교한다
  → 새로 켜진 자동 구성 목록이 나온다
  → 그중 원하지 않는 것이 있으면 그 자리에서 잡는다
```

**Ch15의 "기본값이 바뀜" 범주와 같은 종류의 위험을 막는 도구다** — **조용히 달라지는 것을 눈에 보이게 만든다.**

**비유의 한계가 여기였다**(Q1):

> **블랙박스는 사고가 나야 열어 본다. 조건 평가 보고서는 문제가 없을 때 읽는 것이 더 유용하다.**

**②의 값어치** — `exclude`를 썼는데 **오타가 있거나 클래스 이름이 바뀌었으면** 조용히 안 먹는다. `positiveMatches`에 그것이 여전히 있으면 즉시 안다.

---

## Q10. 네 진단 엔드포인트가 각각 답하는 질문

| 엔드포인트 | 답하는 질문 |
|---|---|
| **`/actuator/conditions`** | 자동 구성이 **왜** 됐/안 됐나 |
| **`/actuator/beans`** | 실제로 **어떤 빈**이 있나 |
| **`/actuator/mappings`** | 어떤 **요청 경로**가 있나 |
| **`/actuator/configprops`** | 어떤 **설정 값**이 적용됐나 |

**증상별 첫 목적지**:

```text
"빈이 없다"           → conditions   (왜 안 만들어졌나)
"빈은 있는데 다른 것 같다" → beans      (어떤 게 있나)
"404 가 난다"          → mappings     (c3-02 와 이어진다)
"설정이 안 먹는다"      → configprops  (실제 적용된 값)
```

**§6의 경계가 이 구분을 강화한다**:

> **보고서로 빈의 상태를 확인하려 하지 않는다. 보고서는 정의 단계의 기록이다. 실제 빈 목록은 `/actuator/beans`, 설정 값은 `/actuator/configprops`가 답한다.**

**"정의 단계의 기록"이 핵심 제약이다** — 보고서는 **"어떤 빈 정의가 등록될 예정인가"**를 말할 뿐, **인스턴스가 어떤 상태인지는 모른다**(c1-01의 정의/인스턴스 구분).

**§6의 마지막 항목**:

> **조건이 통과했는데도 기능이 안 되면 보고서 밖을 본다.** 자동 구성은 정상이고 **프로퍼티 값이 틀렸거나**, 빈은 있는데 ****백오프**로 내 빈이 쓰이고 있을** 수 있다.

**즉 보고서는 만능이 아니라 첫 관문이다** — **"자동 구성이 켜졌는가"까지 답하고, 그 뒤는 다른 도구다.**

---

## 재출제 문항

1. 소스를 읽어 조건을 추측하면 무너지는 것 셋은? 확인할 방법이 있는가?
2. 보고서를 보는 두 방법 중 운영 인스턴스 진단에 나은 쪽과 그 이유는?
3. 보고서의 세 절 중 "진단 대상에서 제외"되는 것은?
4. `condition` 값이 `OnBeanCondition`이다. 두 방향 중 어느 쪽인지 어떻게 아는가?
5. `negativeMatches`가 300개다. 문제인가? 어떻게 읽는가?
6. 보고서에 그 자동 구성이 아예 없다. 무엇을 의심하는가?
7. `matches()`가 `final`인 것이 보장하는 것은? `final`이 아니었다면 무엇이 무너지는가?
8. 반환이 `boolean`이었다면 무엇을 잃었겠는가? 같은 패턴의 다른 예는?
9. 문제가 없을 때 `positiveMatches`를 읽을 이유 셋은? 그중 Ch15와 이어지는 것은?
10. "설정이 안 먹는다"는 어느 엔드포인트인가? 보고서로는 왜 안 되는가?

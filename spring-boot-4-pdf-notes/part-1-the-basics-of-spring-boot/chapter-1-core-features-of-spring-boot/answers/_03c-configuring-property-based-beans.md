# 모범답안 — 03c Property 값으로 생성할 Bean 선택하기

> **먼저 답하고 나서 열 것.** [[03c-configuring-property-based-beans]]의 `## 8. 스스로 확인` 일곱 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]]
- 작성: 2026-08-28
- 본문 점검: 7문항 모두 본문에 답이 있었다. **보강하지 않았다.** 특히 `§2.2`의 `false` 예외 표와 `§2.4`의 Profile 대비표가 질문을 정면으로 받는다.

---

## Q1. `@Bean`과 `@ConditionalOnProperty`의 책임

| 애노테이션 | 책임 | 답하는 질문 |
|---|---|---|
| `@Bean` | 메서드가 반환한 객체를 Spring bean으로 등록한다. 기본 이름은 메서드 이름(`youTubeService`) | **무엇을** 만들까 |
| `@ConditionalOnProperty` | 조합된 키의 최종값을 검사해 이 빈 정의를 적용할지 정한다 | **만들까 말까** |

**둘의 순서가 중요하다.** 조건이 먼저 평가되고, 참일 때만 `@Bean` 메서드가 호출된다. 조건이 거짓이면 **메서드 자체가 호출되지 않는다.** 객체를 만들었다가 버리는 것이 아니라 애초에 만들지 않는다.

그래서 사용하지 않는 구현의 초기화 비용과 그 구현이 요구하는 의존성까지 피할 수 있다. Vimeo를 쓰는 배포에서 YouTube 클라이언트가 인증을 시도하는 일이 없다.

이것은 [[01-autoconfiguring-spring-beans]]의 백오프와 **같은 조건부 구성 모델**이다. 거기서는 `@ConditionalOnMissingBean`이 타입을 봤고, 여기서는 `@ConditionalOnProperty`가 프로퍼티 값을 본다. 검사 대상만 다르고 구조는 같다 — **조건이 거짓이면 빈 정의가 애초에 만들어지지 않는다.**

---

## Q2. `prefix`와 `name`이 결합되는 키

```java
@ConditionalOnProperty(prefix = "my.app", name = "video")
```

```text
prefix "my.app"  +  name "video"  →  my.app.video
```

점 하나로 이어 붙인다. 이렇게 나눠 둔 이유는 같은 접두사를 쓰는 조건을 여러 개 만들 때 접두사를 한 곳에서 관리하기 위해서다.

**중요한 것은 이 키가 "파일에서 읽는 값"이 아니라는 점이다.** 평가 1단계가 이것이다 — *Boot가 모든 프로퍼티 소스를 합쳐 `my.app.video`의 **최종값**을 구한다.* 파일·환경 변수·명령행 중 [[03b-externalizing-application-configuration]]의 우선순위로 결정된 **승자 값**이 조건의 입력이다.

그래서 `application.properties`에 `youtube`라고 적어 두어도 환경 변수 `MY_APP_VIDEO=vimeo`가 있으면 Vimeo가 만들어진다.

---

## Q3. `havingValue`가 없을 때 값별 결과

**책은 "어떤 값이든 있으면 생성된다"고 설명하지만 그것은 학습용 단순화다.** 공식 동작은 *키가 존재하면서 문자열 값이 `false`가 아닐 때* 일치다.

| `my.app.video` | 결과 | 이유 |
|---|---|---|
| **키 없음** | **불일치** | `matchIfMissing` 기본값이 `false` |
| **`false`** | **불일치** | 기본 조건이 명시적 false를 비활성으로 해석 |
| `true` | 일치 | 존재하며 false가 아님 |
| **`youtube`** | **일치** | 존재하며 false가 아님 |
| `vimeo` | 일치 | 존재하며 false가 아님 |
| 빈 문자열 | 일반적으로 일치 | 존재하며 false 문자열이 아님 |

**세 값만 답하면**: 누락 → 안 만듦, `false` → 안 만듦, `youtube` → 만듦.

**왜 `false`가 예외인가.** 이 애노테이션이 **Boolean 기능 플래그**로 가장 많이 쓰이기 때문이다. `my.feature.enabled=false`라고 껐는데 "값이 있으니까 켠다"가 되면 아무도 기능을 끌 수 없다. 그래서 `false`만 특별 취급한다.

이 예외를 모르면 기능 플래그를 껐다고 생각했는데 켜져 있는 상황을 만든다.

---

## Q4. `havingValue`와 `matchIfMissing`이 답하는 두 질문

**서로 다른 두 질문이라 함께 쓸 수 있다.**

| 속성 | 답하는 질문 |
|---|---|
| `havingValue` | 키가 **있을 때** 어떤 값과 일치해야 하나 |
| `matchIfMissing` | 키가 **아예 없을 때** 조건을 참으로 볼까 |

```java
@ConditionalOnProperty(
    prefix = "my.app", name = "video",
    havingValue = "youtube",
    matchIfMissing = true
)
```

읽는 법: **"키가 없으면 YouTube를 기본으로 택하고, 키가 있으면 값이 `youtube`일 때만 택한다."**

두 질문이 겹치지 않는 영역을 다루므로 조합이 성립한다. `havingValue`는 "존재하는 값"의 세계를, `matchIfMissing`은 "부재"의 세계를 각각 담당한다. 기본은 **누락 시 불일치**다.

**경계**: `matchIfMissing=true`는 기본값이 안전하고 의도가 분명할 때만 쓴다. [[03a-creating-custom-properties]]의 기본값 논의와 같은 함정이다 — 설정 누락을 조용히 감춘다.

---

## Q5. `youtube`와 `vimeo` 조건이 배타적이어야 하는 이유

**둘 다 참이 되면 같은 역할의 빈이 두 개 등록되고, 주입이 모호해진다.**

`havingValue`가 `youtube`와 `vimeo`로 서로 다르므로 최종값 하나로는 **둘 중 하나만** 참이 될 수 있다. 이게 배타성을 보장하는 장치다.

| `my.app.video` | 결과 |
|---|---|
| `youtube` | 첫 조건만 참 → YouTube만 등록 |
| `vimeo` | 둘째 조건만 참 → Vimeo만 등록 |
| `other` 또는 누락 | **둘 다 거짓 → 아무것도 등록 안 됨** |

**배타성의 이득**: 소비자가 공통 역할을 주입받을 때 후보가 항상 하나다. `@Primary`나 `@Qualifier`가 필요 없다.

**하지만 세 번째 행이 위험하다.** 오타(`youtub`)나 예상 못 한 값이 들어오면 **아무 빈도 생기지 않고**, 애플리케이션은 그 빈을 주입받는 곳에서야 실패한다. 조건 평가 시점이 아니라 훨씬 뒤에서 터진다.

**대응**: 허용값을 검증하거나, `matchIfMissing`으로 명확한 기본 정책을 두거나, 시작 시 확인하는 장치를 둔다.

---

## Q6. 프로파일과 `@ConditionalOnProperty`가 함께 동작하는 예

**둘은 경쟁 관계가 아니라 층이 다르다.**

| 질문 | Profile | `@ConditionalOnProperty` |
|---|---|---|
| 무엇을 기준으로 | 활성 **프로파일 이름** | 특정 **프로퍼티의 존재·값** |
| 범위 | 환경별 여러 설정·빈 묶음 | 한 기능·구현의 세밀한 선택 |
| 예 | `test`에서 테스트 DB·메일·캐시 | `my.app.video=youtube` |

**연결 예**: 프로파일 파일이 프로퍼티 값을 **공급**하고, 조건부 빈이 그 최종값을 **읽는다.**

```properties
# application-test.properties
my.app.video=vimeo
```

```bash
java -Dspring.profiles.active=test -jar app.jar
```

→ `test` 프로파일이 활성 → `application-test.properties`가 `my.app.video=vimeo`를 제공 → 최종값이 `vimeo` → `VimeoService`만 등록.

**연결 고리는 [[03b-externalizing-application-configuration]]의 최종값 결정이다.** 프로파일은 값을 만들고, 조건은 값을 소비한다. 사이에 우선순위 병합이 있다.

**왜 프로파일만으로 하지 않나.** 영상 공급자 하나를 바꾸려고 `youtube`, `vimeo` 프로파일을 만들면 프로파일 이름이 **환경과 기능 선택을 동시에** 표현하게 된다. `prod` × `youtube` 조합이 필요해지는 순간 프로파일 수가 곱으로 늘어난다.

---

## Q7. 요청마다 구현을 바꾸는 요구에 부족한 이유

**조건부 빈은 시작 시점에 객체 그래프를 확정한다.** 요청마다 바꾸는 것은 런타임 관심사다. 두 시점이 다르다.

| | 조건부 빈 | 요청별 라우팅 |
|---|---|---|
| 결정 시점 | 컨텍스트 **시작 시 한 번** | **요청마다** |
| 결정 입력 | 프로퍼티 최종값 | 요청 내용, 사용자, 테넌트 |
| 결과 | 빈 하나만 존재 | 여러 빈이 다 존재하고 그중 고른다 |

**비유가 깨지는 지점**: 조건부 빈을 철도 분기기 레버에 비유하면, 실제 분기기는 열차 사이에 바꿀 수 있지만 조건부 빈은 그렇지 않다. **실행 중 프로퍼티 값을 바꿔도 이미 만들어진 빈이 자동 교체되지 않는다.**

**요청별로 바꾸려면**: 두 구현을 **모두** 빈으로 등록하고, 요청 시점에 고르는 라우팅 정책을 별도로 설계한다. 예를 들어 공통 인터페이스의 구현 둘을 `Map<String, VideoService>`로 주입받고 요청의 테넌트로 조회하는 식이다. 이때는 배타성이 오히려 방해가 되므로 조건 설계 자체가 달라진다.

**판별 질문**: *이 선택이 배포마다 한 번인가, 요청마다인가?* 전자면 조건부 빈, 후자면 런타임 라우팅이다.

---

## 재출제 문항

1. `my.app.video=false`로 두고 기능이 켜지길 기대했다. 무슨 일이 일어나는가? 왜 그렇게 설계됐는가?
2. `my.app.video=youtub`로 오타를 냈다. 애플리케이션은 언제 어떤 모습으로 실패하는가?
3. `@ConditionalOnProperty`가 읽는 값과 `@ConfigurationProperties`가 바인딩하는 값은 같은 곳에서 오는가?
4. YouTube와 Vimeo 조건을 둘 다 참으로 만들려면 어떻게 해야 하며, 그러면 무엇이 깨지는가?
5. 프로파일 다섯 개와 기능 플래그 세 개를 전부 프로파일로 표현하면 몇 개가 필요한가? 그것이 말해 주는 것은?
6. 운영 중에 `my.app.video`를 바꾸고 설정을 다시 읽게 했다. YouTube 빈이 Vimeo로 바뀌는가?

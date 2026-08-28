# 모범답안 — 02 ChatClient로 LLM 통합

> **먼저 답하고 나서 열 것.** [[02-building-llm-integrations-with-chatclient]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. 세 응답 형태를 고르는 상황

| 형태 | 호출 | 반환 | **쓰는 자리** |
|---|---|---|---|
| **text** | `.call().content()` | `String` | **화면에 그대로 뿌리는 챗 응답** |
| **전체 응답** | `.call().chatResponse()` | `ChatResponse` | **token 사용량·model 이름·종료 사유가 필요할 때** |
| **구조화** | `.call().entity(AiAnswer.class)` | 내 record | **응답을 business logic에 넘길 때** |

**각각의 상황 예**:
- **`.content()`** — 사용자에게 마크다운 답변을 그대로 보여 주는 Q&A 화면. **"이 응답이 얼마짜리였는지는 알 수 없다"**는 대가를 받아들인다
- **`.chatResponse()`** — **비용을 집계하거나 rate limit을 모니터링**할 때. `metadata.usage.totalTokens`가 필요하다([[07c-reducing-api-costs]])
- **`.entity(AiAnswer.class)`** — 응답의 `title`·`explanation`·`example`을 **각각 다른 화면 요소에 배치**하거나 **DB에 저장**할 때

**주의**(§6): **`ChatResponse`를 그대로 REST 응답으로 내보내지 않는다** — **provider 내부 필드·rate limit 정보가 client에 새어 나간다.** **서버에서 metadata를 소비하고 client에는 필요한 것만** 준다.

**그리고 `.entity(...)`를 신뢰 경계로 삼지 않는다** — **매핑이 성공했다는 것이 값이 맞다는 뜻은 아니다.** **숫자·식별자 같은 값은 매핑 후 검증**한다.

---

## Q2. `defaultSystem`과 `system`을 나누는 기준

| | **`defaultSystem(...)`** | **`system(...)`** |
|---|---|---|
| 걸리는 곳 | **builder — 모든 요청** | **그 호출에만** |
| 넣을 것 | **공통 persona** | **형식 지시처럼 endpoint별로 다른 것** |

> **둘 다 있으면 호출 단위 `system(...)`이 그 요청의 시스템 메시지가 된다.**

**`defaultSystem`의 이득**: **controller마다 "너는 Java 전문가야"를 반복해 쓰지 않아도 되고, 문구를 고칠 때 한 곳만 고치면 된다.** **persona가 코드에 흩어지지 않는다.**

**`system`을 쓰는 예**: [[02-building-llm-integrations-with-chatclient]]의 구조화 응답 endpoint가 **응답 형식까지 지시**한다 — **필드 이름을 record와 맞춰 적는다.** 이것은 **그 endpoint에만** 필요하다.

**판단 요령**: **"이 지시가 이 애플리케이션의 모든 AI 응답에 해당하는가?"** — 그렇다면 `defaultSystem`, 아니면 `system`.

**property 이름의 층도 같은 종류의 구분이다**(§5) — **`spring.ai.openai.api-key`는 인증**, **`spring.ai.openai.chat.options.*`는 model 호출 옵션**이고, **후자는 요청마다 코드에서 덮어쓸 수도** 있다.

---

## Q3. `entity(List.class)`가 안 되고 `ParameterizedTypeReference`가 필요한 이유

**제네릭 소거 때문이다.**

> **`List.class`만으로는 원소 타입을 알릴 수 없다 — 제네릭 소거 때문에 `List<AiAnswer>`와 `List<String>`이 런타임에 같은 `List.class`다.**

**`ParameterizedTypeReference`**: **제네릭 타입 정보를 런타임까지 보존하는 타입 토큰.**

```java
.entity(new ParameterizedTypeReference<List<AiAnswer>>() {})
//      익명 하위 클래스를 만들어 타입 인자를 클래스 파일에 남긴다
```

**[[../../part-3-releasing-an-application-with-spring-boot/chapter-6-configuring-an-application-with-spring-boot/01-creating-custom-properties|Ch6]]의 `GrantedAuthorityCnv`와 정확히 같은 기법**이다 — **타입 인자를 선언에 박아 두면 소거를 피한다.**

**더 복잡한 경우**: **중첩 구조·검증·custom 매핑이 필요하면 `StructuredOutputConverter`**(= 응답 형식과 파싱을 세밀히 제어하는 구성 요소)를 쓴다.

**구조화 응답의 성질도 함께**: **`.entity(...)`는 타입 안전 파싱이지 타입 안전 생성이 아니다.** **Spring AI가 형식 지시를 prompt에 넣고 파싱을 도와주지만, model이 필드를 빠뜨리거나 JSON을 어기면 그때 실패**한다. 그래서 [[07a-evaluating-llm-response-quality]]가 별도로 필요하다.

---

## Q4. API key를 `application.properties`에 직접 적으면

**파일에 값이 남고, 그 파일이 버전 관리·빌드 산출물·로그로 퍼진다.**

> **API key를 소스 파일에 절대 하드코딩하지 않는다.**

**구체적으로 위험해지는 것**:
- **git 이력에 영구히 남는다** — 나중에 지워도 **이전 커밋에 살아 있다**
- **JAR에 포함된다** — [[../../part-3-releasing-an-application-with-spring-boot/chapter-6-configuring-an-application-with-spring-boot/02-creating-profile-based-property-files|Ch6]]가 경고한 그대로. **컨테이너 이미지가 공개되면 함께 공개**([[../../part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/03-publishing-an-image-to-docker-hub|Ch7]])
- **키가 유출되면 과금이 남의 것**이 된다 — 다른 자격 증명과 달리 **직접 돈이 나간다**

**대안**: **환경 변수**(`spring.ai.openai.api-key=${OPENAI_API_KEY}`), **버전 관리에서 제외한 `.env`**, 또는 **시크릿 매니저**(AWS Secrets Manager·HashiCorp Vault) — **자격 증명을 코드 밖에서 암호화 보관·통제하는 전용 시스템.**

**이 주제는 [[07d-security-best-practices-for-ai-applications]]에서 rotation·환경별 분리까지 이어진다.**

**비용 관련 실용 조언도 함께**: **이 장의 예제를 전부 돌리는 데 $5면 충분**하고, **automatic recharge를 끄고 usage limit을 설정**해 두면 **예상 밖 과금**을 막을 수 있다.

**설정 세 줄의 나머지**: **`model=gpt-4o-mini`**(이름만 바꾸면 model이 바뀐다), **`temperature=0.2`** — **재현 가능한 정확한 답이 필요한 용도에는 0.2–0.3, 브레인스토밍·창작에는 높은 값**.

---

## 재출제 문항

1. 응답의 token 사용량을 집계하려 한다. 어느 형태를 쓰는가?
2. `ChatResponse`를 그대로 반환했다. 무엇이 새어 나가는가?
3. 모든 endpoint에 "한국어로 답하라"를 넣고 싶다. 어디에 쓰는가?
4. `entity(List.class)`를 썼더니 원소가 `LinkedHashMap`이다. 왜인가?
5. `.entity(...)`가 성공했다. 값이 맞다고 믿어도 되는가?
6. API key를 커밋했다가 다음 커밋에서 지웠다. 안전한가?

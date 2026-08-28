# 모범답안 — 04a Spring Native에서 주류로

> **먼저 답하고 나서 열 것.** [[04a-from-spring-native-to-mainstream]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. 검색으로 찾은 네이티브 글이 낡았는지 판별하는 단서

**① `org.springframework.experimental` 그룹 ID**

```xml
<dependency>
    <groupId>org.springframework.experimental</groupId>
    <artifactId>spring-native</artifactId>
    <version>0.12.1</version>
</dependency>
```

**② `@NativeHint`, `spring-aot-maven-plugin` 같은 이름**

> **이걸 그대로 따라 하면 Boot 4에서 동작하지 않는다. 의존성 자체가 없기 때문이다.**

**둘 다 Boot 2.x 시대 글의 표지다.**

**세 번째 단서 — 날짜**: **네이티브 관련 자료는 3년이면 낡는다.** 2020~2022년 글이 검색 상위에 계속 노출된다.

**왜 이 판별이 실무 지식인가**: **그것들은 문법적으로는 멀쩡해 보인다.** 오타나 명백한 오류가 아니라 **한 시대 전의 올바른 답**이라, 읽는 동안에는 이상한 점을 못 느낀다. **의존성 해석이 실패하고 나서야** 알게 된다.

**비유의 깨짐이 여기 있다** — 비계는 철거하면 흔적이 없지만 **인터넷의 글은 남는다.** 그래서 **"언제 쓰인 글인가"를 먼저 보는 습관**이 필요하다.

---

## Q2. GraalVM Native Support가 넣는 것과 넣지 않는 것

| | |
|---|---|
| **넣는다** | **빌드 툴링** — Maven·Gradle의 네이티브 지원(`native-maven-plugin`과 그것을 켜는 profile), **AOT 훅** |
| **넣지 않는다** | **외부 프레임워크**, 런타임 라이브러리 |

> **런타임 라이브러리가 아니라 빌드 파이프라인이 바뀐다.**

**그 툴링이 하는 일은 GraalVM이 요구하는 metadata를 생산하는 것이다.**

**[[02-adapting-an-application-for-native-image]]에서 "이 장의 코드는 앞 장 코드의 복사본이고 빌드 파일만 다르다"고 한 것이 정확히 이 뜻이다.** 애플리케이션 소스는 **한 줄도 바뀌지 않는다.**

**"따로 껴안을 Spring Native 프로젝트는 없다"**는 것이 핵심 문장이다.

**지금 본류에 들어와 있는 셋**:
| 들어온 것 | 무엇인가 |
|---|---|
| **Spring AOT 엔진** | **bean 정의를 코드로 펼치고 metadata를 만든다** |
| **reachability metadata** | **"여기에 리플렉션이 쓰인다"를 GraalVM에 알린다** |
| **빌드 통합** | Maven·Gradle profile, AOT 훅 |

**그리고 이것들은 Spring Boot 4와 Spring Framework 7에서 계속 개선되고 있다** — **정체된 기능이 아니라 본류의 일부**다.

---

## Q3. "본류로 들어왔다"에도 여전히 손이 가는 지점

**JPA/Hibernate다.**

> **lazy loading과 프록시가 네이티브에서 제대로 돌게 하려고 빌드 시점 바이트코드 강화를 켜야 할 수 있다.**

**왜 하필 여기인가**: Hibernate가 **lazy loading을 런타임 바이트코드 조작과 프록시로 구현**하는데, **그 둘이 네이티브에서 가장 제약되는 기능**이다([[02-adapting-an-application-for-native-image]]).

> **"본류로 들어왔다"가 "아무것도 안 해도 된다"는 뜻은 아니다. 기본 경로는 자동이고, 동적 기능에 깊이 기대는 지점에서만 명시적 설정이 남는다.**

**다른 두 지점도 있다**:
- **커스텀 리플렉션·직렬화·resource 접근**은 여전히 손으로 등록해야 한다 → [[05-configuring-reflection-and-runtime-hints]]
- **서드파티 라이브러리**는 별개 문제다 → [[04b-graalvm-and-third-party-libraries]]

**패턴을 보면**: 자동화되는 것은 **Spring이 통제하는 영역**이고, 손이 가는 것은 **Spring 밖**(서드파티)이거나 **Spring이 감싸고 있지만 근본적으로 동적인 것**(Hibernate)이다.

---

## Q4. Spring AOT와 Java AOT Cache의 층 차이

> **Spring AOT는 빌드 시점에 애플리케이션 구조를 준비하고, Java AOT Cache는 JVM 수준에서 런타임 성능을 겨냥한다.**

| | **Spring AOT** | **Java AOT Cache** |
|---|---|---|
| 층 | **애플리케이션 구조** | **JVM 수준** |
| 하는 일 | **bean 정의를 코드로 펼치고 metadata 생성** | **클래스 로딩·링크 결과를 캐싱** |
| 대상 | Spring 컨텍스트 | **JVM 시작 과정** |
| 관련 노트 | 이 장 전반 | [[07-using-java-25-aot-cache]] |

> **이름만 겹칠 뿐 다른 층이다. 책도 이 구분을 따로 강조한다.**

**왜 헷갈리나**: 둘 다 **"AOT"**이고 둘 다 **startup을 줄인다.** 그런데
- **Spring AOT는 네이티브 이미지의 전제**다 — 없으면 도달성 분석이 Spring 구조를 못 본다
- **Java AOT Cache는 네이티브의 대안**이다 — **JVM에 남으면서** startup을 줄인다

**즉 하나는 네이티브로 가는 길의 일부이고, 다른 하나는 가지 않는 길이다.** [[07b-comparing-four-execution-strategies]]가 그 넷을 나란히 놓는다.

**Spring AOT는 네이티브 없이도 쓸 수 있다**는 점도 기억할 것 — `-Pnative`를 붙인 `package`가 **JAR을 만들되 AOT 처리를 돌린다**([[03-building-and-running-a-native-application]]). 그 산출물이 [[07a-enabling-aot-cache-for-spring-boot]]에서 쓰인다.

---

## 재출제 문항

1. StackOverflow 답변에 `@NativeHint`가 있다. 무엇을 알 수 있는가?
2. GraalVM Native Support를 체크했다. 애플리케이션 소스가 바뀌는가?
3. 자동화되는 영역과 손이 가는 영역의 경계는 무엇으로 갈리는가?
4. Hibernate가 하필 문제가 되는 이유를 그 구현 방식으로 설명하라.
5. Spring AOT와 Java AOT Cache 중 네이티브의 "전제"인 것과 "대안"인 것은?
6. `-Pnative`를 붙였는데 JAR이 나왔다. 잘못된 것인가?

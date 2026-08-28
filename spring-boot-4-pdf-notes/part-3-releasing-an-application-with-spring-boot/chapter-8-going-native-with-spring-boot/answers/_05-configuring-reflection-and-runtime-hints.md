# 모범답안 — 05 리플렉션과 런타임 힌트 설정

> **먼저 답하고 나서 열 것.** [[05-configuring-reflection-and-runtime-hints]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `@RequestBody VideoEntity` 한 줄이 문제가 되는 이유

**그 한 줄이 Jackson의 리플렉션을 부르는데, 도달성 분석은 그 화살표를 볼 수 없기 때문이다.**

```java
// Jackson이 JSON을 VideoEntity로 되돌릴 때 내부적으로 하는 일
Constructor<?> ctor = VideoEntity.class.getDeclaredConstructor();
Object obj = ctor.newInstance();
Method setter = VideoEntity.class.getMethod("setName", String.class);
setter.invoke(obj, "Spring Boot 4");
```

> **우리가 이런 코드를 쓴 적은 없다. 하지만 `@RequestBody VideoEntity video` 한 줄을 쓰는 순간 Jackson이 이걸 한다.**

**도달성 분석의 눈에 `VideoEntity`의 생성자와 setter로 가는 화살표는 어디에도 없다. 그래서 잘려 나가고, 배포 후 첫 POST 요청에서 터진다.**

**이것이 [[04b-graalvm-and-third-party-libraries]]의 문제가 내 코드에서 나타나는 모습이다** — **리플렉션을 하는 것은 라이브러리이고, 그 대상은 내 클래스**다.

**Spring Boot가 예측하지 못하는 셋**:
- 애플리케이션이 **커스텀한 방식으로** 리플렉션을 쓸 때
- 클래스를 **직렬화용으로** 등록할 때
- AOT 분석이 발견하기 어려운 **resource에 접근**할 때

> **닫힌 세계 가정이 성립하지 않는 구간이 실재한다는 뜻이다. 그 구간을 위해 런타임 힌트가 있다.**

---

## Q2. `@RegisterReflectionForBinding`과 `RuntimeHintsRegistrar` 중 무엇을 쓸까

**기준: 바인딩이면 애노테이션, 세밀한 제어가 필요하면 코드.**

| | **`@RegisterReflectionForBinding`** | **`RuntimeHintsRegistrar`** |
|---|---|---|
| 쓰는 법 | **애노테이션 한 줄** | **`registerHints` 구현** |
| 여는 범위 | **바인딩에 필요한 것을 한 묶음으로** | **`MemberCategory`로 직접 고름** |
| 조건·반복 | 불가 | **가능** — 애노테이션으로는 못 하는 일 |
| 맞는 경우 | **Jackson·폼 바인딩·`@ConfigurationProperties`** | 그보다 세밀한 제어 |

**`for Binding`이라는 이름이 중요하다** — **바인딩에 필요한 것(생성자와 접근자)을 한 묶음으로 열어 주므로 무엇을 열지 하나하나 고를 필요가 없다.** **"객체를 만들고 필드를 채우는" 전형적인 경우**에 맞는다.

**복잡한 경우는 두 조각을 쓴다**:
| 조각 | 하는 일 | **왜 나뉘어 있나** |
|---|---|---|
| **`@ImportRuntimeHints`** | "이 클래스가 힌트를 기여한다"고 알린다 | **힌트 등록을 configuration의 관심사로 유지**하기 위해 |
| **`RuntimeHintsRegistrar`** | 실제 힌트를 **코드로** 만든다 | **조건문·반복문을 쓸 수 있다** |

> **패키지 주의** — `@RegisterReflectionForBinding`은 `org.springframework.aot.hint.annotation`, `MemberCategory`·`RuntimeHintsRegistrar`는 `org.springframework.aot.hint`, 그런데 **`@ImportRuntimeHints`만 `org.springframework.context.annotation`**이다. **책은 패키지를 적지 않아 IDE 자동 완성이 엉뚱한 것을 집어 올 수 있다.**

---

## Q3. `INVOKE_DECLARED_CONSTRUCTORS`와 `INVOKE_PUBLIC_METHODS`가 짝인 이유

**만들고(생성자) 채우는(setter) 것이 바인딩의 전부이기 때문이다.**

| 값 | **여는 것** | **왜 필요한가** |
|---|---|---|
| `INVOKE_DECLARED_CONSTRUCTORS` | **객체 생성** | **역직렬화가 먼저 인스턴스를 만들어야 한다** |
| `INVOKE_PUBLIC_METHODS` | public 메서드의 리플렉티브 호출 | **getter와 setter가 여기 포함된다** |

**Q1의 Jackson 코드와 정확히 대응한다**:
```java
ctor.newInstance()            ← INVOKE_DECLARED_CONSTRUCTORS
setter.invoke(obj, "...")     ← INVOKE_PUBLIC_METHODS
```

**그래서 `@RegisterReflectionForBinding`이 이 둘을 묶어 주는 것이다**(Q2) — **바인딩에 필요한 최소 집합**이 정확히 이 둘이다.

**하나만 열면 어떻게 되나**: 생성자만 열면 **객체는 만들어지고 필드가 비어 있다.** 메서드만 열면 **인스턴스를 못 만든다.** 둘 다 있어야 한 사이클이 완성된다.

**`INTROSPECT_*`와의 구분도 함께**: **앞의 것은 "이런 멤버가 있다"를 조회하게만 해 주고, 뒤의 것은 실제 호출까지 연다.** 리스트만 훑는다면 **`INTROSPECT_*`가 싸다.** **무조건 `INVOKE_*`를 쓰면 이미지가 불필요하게 커진다** → Q4.

> **필드 카테고리는 이름이 바뀌었다** — Spring Framework 7에서 `PUBLIC_FIELDS`·`DECLARED_FIELDS`는 **deprecated for removal**이고 **`ACCESS_PUBLIC_FIELDS`·`ACCESS_DECLARED_FIELDS`**가 자리를 이어받았다. 책 예제의 두 값은 **그대로 유효**하다.

---

## Q4. 힌트를 넉넉히 넣는 것이 공짜가 아닌 이유

**리플렉션 힌트는 이미지 힙에 실제 자리를 차지한다.**

**확인하는 곳**: [[03-building-and-running-a-native-application]]의 **빌드 출력** —

```
1.65MB byte[] for reflection metadata
```

> **모든 클래스에 모든 카테고리를 열면 이미지가 부풀고, [[01-why-graalvm-native-image]]에서 얻으려던 이득이 줄어든다.**

**범위를 고르게 해 둔 이유가 바로 이 비용 때문이다.**

**"escape hatch"라는 표현이 정확한 두 이유**:
1. **평소에 쓰는 문이 아니다** — 대부분의 경우 **Spring AOT가 알아서** 한다
2. **쓸수록 이미지가 무거워진다** — **비상구를 벽 전체에 뚫으면 벽이 아니게 된다**

**§6의 지침이 그래서 나온다**:
- **먼저 자동 처리를 믿는다.** **힌트를 예방적으로 뿌리면 이미지만 커진다. 실제로 실패한 지점에만 쓴다**
- **모든 카테고리를 여는 습관을 만들지 않는다**
- **테스트로 검증한다** — **네이티브 이미지를 실제로 실행해 그 경로를 밟아야** 안다. **JVM 테스트는 통과한다**
- **내가 못 고치는 라이브러리라면 힌트가 임시방편이다** → [[04b-graalvm-and-third-party-libraries]]

**힌트를 썼는데도 안 될 때**: **대상이 인터페이스면 프록시 힌트(`hints.proxies()`)가, 파일이면 resource 힌트(`hints.resources()`)가 따로 필요하다.** **`hints.reflection()`은 힌트 API의 일부일 뿐이다.**

**비유로 보면** 공항 반입 금지 물품 — **정당한 사유가 있는 물건은 진단서를 내면 통과된다.** **깨지는 지점 셋**:
- **진단서는 압수당한 뒤에 낼 수 있지만 힌트는 빌드 전에 내야 한다** — **사후 복구가 없다**
- **진단서는 종이 한 장이지만 힌트는 이미지에 무게로 남는다**
- **여행자는 자기 짐을 알지만 우리는 라이브러리가 무엇을 리플렉션으로 쓰는지 모른다**

---

## 재출제 문항

1. `@RequestBody`를 쓴 적 없는 클래스인데 네이티브에서 깨졌다. 어디를 의심하는가?
2. 조건에 따라 다른 클래스를 등록해야 한다. 어느 방법을 쓰는가?
3. 생성자만 열고 메서드를 안 열면 어떤 증상이 나는가?
4. 클래스 목록을 훑기만 한다. 어떤 `MemberCategory`가 맞는가?
5. 힌트를 예방적으로 100개 등록했다. 빌드 출력의 어느 줄이 달라지는가?
6. 힌트를 넣었는데도 프록시 생성이 실패한다. 무엇이 빠졌는가?

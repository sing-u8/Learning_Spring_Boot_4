# 모범답안 — 06 Testcontainers 추가하기

> **먼저 답하고 나서 열 것.** [[06-adding-testcontainers]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 로컬에 PostgreSQL을 직접 깔면 무너지는 세 지점

1. **환경마다 다르다.** 내 노트북의 PostgreSQL 16, 동료의 15, **CI의 없음**이 각각 다른 결과를 낸다.
2. **상태가 남는다.** 앞 테스트가 넣은 데이터가 다음 테스트에 새어 든다. **테스트 순서에 따라 결과가 달라진다.**
3. **사람이 해야 한다.** 책의 표현대로 **"테스트를 돌리고 싶을 때마다 로컬 데이터베이스를 수동으로 띄우는 일은 영 아니다."**

> **결정적인 것은 세 번째다.**

**이유**: **사람이 해야 하는 단계가 하나라도 있으면 CI에서 못 돌리고, CI에서 안 도는 테스트는 결국 안 도는 테스트다.**

1번과 2번은 **결과가 틀릴 수 있다**는 문제지만, 3번은 **테스트가 아예 실행되지 않게 된다**는 문제다. [[02-testing-domain-objects]]의 49밀리초 논지와 같다 — **안 돌리는 테스트의 가치는 0**이다.

**책이 이 절을 잡은 지점**: *"각 데이터베이스 엔진이 SQL 구현에 조금씩 차이가 있다는 사실은, **운영에서 쓰려는 것과 같은 버전을 상대로** 데이터베이스 연산을 테스트할 것을 요구한다."* — [[05-testing-repositories-with-embedded-databases]]가 끝에서 남긴 질문의 답이다.

---

## Q2. 일회용 실험실 비유가 깨지는 두 지점

**① 실제 실험실은 짓는 데 몇 달이 걸려서 그렇게 할 수가 없다.**

컨테이너는 **초 단위**로 뜬다 — **하지만 공짜는 아니다.** [[07-testing-repositories-with-testcontainers]]의 실행 결과를 보면 **첫 테스트 하나가 401밀리초**를 먹는다. [[02-testing-domain-objects]]의 49밀리초와 **한 자릿수 차이**다.

**② 실험실 비유에 없는 전제가 하나 더 있다 — 그 머신에 Docker가 떠 있어야 한다.**

> **실험실은 땅만 있으면 되지만 Testcontainers는 런타임 의존성이 있고, 그것이 CI 설정에서 흔한 걸림돌이 된다.**

**"Docker와 Testcontainers"의 구분이 여기서 나온다**:
- **Docker** = 컨테이너를 **실행하는 런타임**
- **Testcontainers** = 그것을 **테스트 생명주기에 묶는 Java 라이브러리**

**Testcontainers를 넣어도 Docker가 없으면 아무것도 안 된다.** Q1에서 "사람이 해야 하는 단계를 없앴다"고 했지만, **Docker를 설치하고 띄우는 단계는 남는다.** 다만 그것은 **한 번**이고, 테스트마다가 아니다.

**추가 전제**: 이미지를 **처음 받을 때는 네트워크**가 필요하다. 폐쇄망에서는 **사내 레지스트리 미러**가 있어야 한다.

---

## Q3. 네 의존성 중 하나만 `runtime`인 이유

**PostgreSQL 드라이버만 운영에서도 필요하기 때문이다.**

| 의존성 | scope | 왜 |
|---|---|---|
| `org.postgresql:postgresql` | **`runtime`** | **운영에서 PostgreSQL을 쓰니까 필요**하지만, **우리 코드 중 이것을 상대로 컴파일해야 하는 것이 없다** |
| `spring-boot-testcontainers` | `test` | 테스트에만 존재해야 한다 |
| `testcontainers-postgresql` | `test` | 〃 |
| `testcontainers-junit-jupiter` | `test` | 〃 |

> **운영 산출물에 컨테이너 제어 코드가 들어갈 이유가 없다.**

**드라이버에 `runtime`을 주는 것의 효과**는 [[05-testing-repositories-with-embedded-databases]]의 HSQLDB와 같다 — **컴파일 경로에서 밀어내면 애플리케이션 코드가 `org.postgresql.*`를 직접 import하는 일이 원천적으로 막힌다.**

**주의할 오해**: **`runtime` scope는 테스트 실행 시에도 클래스패스에 있다.** 빠지는 것은 **컴파일 경로**뿐이다. 그래서 테스트가 실제로 PostgreSQL에 접속할 수 있다.

---

## Q4. `spring-boot-testcontainers`와 `testcontainers-postgresql`이 둘 다 필요한 이유

**소속이 다르다 — 다리와 본체가 따로 필요하다.**

```
Spring Boot 쪽                    Testcontainers 프로젝트 쪽
─────────────                     ────────────────────────
spring-boot-testcontainers   ←→   testcontainers-postgresql
"컨테이너를 Spring 컨텍스트에         "PostgreSQL 컨테이너를
 매끄럽게 연결한다"                   코드로 정의한다"
"컨테이너 생명주기 자동 관리"
```

- **`spring-boot-testcontainers`** — Spring Boot의 **Testcontainers 통합 모듈**. Boot의 테스트 인프라와 긴밀히 엮여 **컨테이너 생명주기 자동 관리**와 **컨테이너를 Spring 컨텍스트에 연결**하는 기능을 준다. → 이것이 [[07-testing-repositories-with-testcontainers]]의 `@ServiceConnection`을 가능하게 한다.
- **`testcontainers-postgresql`** — PostgreSQL 컨테이너에 대한 **일급 지원**. → `PostgreSQLContainer` 클래스 자체.

**하나만 있으면**:
- 본체만 → 컨테이너는 뜨지만 **접속 정보를 손으로 Spring에 넘겨야 한다**(`@DynamicPropertySource`)
- 다리만 → **연결할 컨테이너 클래스가 없다**

**네 번째 의존성도 같은 논리다** — `testcontainers-junit-jupiter`가 **JUnit 생명주기에 기동·종료를 연결**한다. 셋이 각각 다른 층을 맡는다.

---

## Q5. Testcontainers가 BOM을 릴리스하는 이유

**모듈들이 독립적으로 릴리스되지만 함께 동작해야 하기 때문이다.**

> **Testcontainers가 여러 모듈로 구성되어 있고, 각 모듈이 독립적으로 릴리스되지만 함께 동작하도록 설계되었다는 점을 이해하는 것이 중요하다. 그렇게 하기 위해 Maven BOM을 릴리스한다.**

**"독립 릴리스인데 함께 동작해야 한다"는 조건이 정확히 BOM이 푸는 문제다.**

```
독립 릴리스   → 모듈이 각자 버전을 올린다
함께 동작     → 어떤 조합이 검증됐는지 누군가 관리해야 한다
                 ↓
              그것이 BOM
```

**BOM이 없으면 무슨 일이 생기나**: `testcontainers-postgresql:2.0.3`과 `testcontainers-junit-jupiter:1.19.0`을 섞어 쓰는 일이 가능해진다. **컴파일은 되고 실행 시점에 깨진다** — 가장 찾기 어려운 종류의 실패다.

**BOM이 하는 일**: *"지원되는 각 모듈에 대한 핵심 정보를 전부 담고 있다. **여기서 버전을 지정하면 다른 모든 Testcontainers 의존성은 버전 설정을 건너뛸 수 있다.**"*

**그래서 `<properties>`에 한 줄이 필요했던 것이다** — `<testcontainers.version>2.0.3</testcontainers.version>`. **버전을 한 곳에서만 관리**한다.

---

## Q6. `<type>pom</type>`과 `<scope>import</scope>`

- **`<type>pom</type>`** — 이 아티팩트에 **코드가 없고 Maven 빌드 정보만** 있음을 나타내는 의존성 타입이다. **클래스 파일이 하나도 없는 jar가 아니라 pom 파일 자체**를 가져온다는 뜻.
- **`<scope>import</scope>`** — 이 의존성이 **이 BOM이 담고 있는 내용으로 사실상 대체됨**을 나타내는 scope다. **선언된 버전 무더기를 추가하는 지름길.**

```text
  <dependencyManagement>   ← "버전을 정해 두는 곳"
      testcontainers-bom
        + <type>pom</type>       ← "이 아티팩트에는 클래스 파일이 없다. 빌드 정보뿐"
        + <scope>import</scope>  ← "이 자리에 그 BOM의 내용을 펼쳐 넣어라"
                │
                ▼
        testcontainers-core          : 2.0.3
        testcontainers-postgresql    : 2.0.3
        testcontainers-junit-jupiter : 2.0.3
        ... (지원되는 모든 모듈)
```

> **`import`는 다른 scope들과 종류가 다르다.** `compile`·`runtime`·`test`는 **"언제 필요한가"**를 말하지만, `import`는 **"이 자리에 그 BOM 내용을 펼쳐 넣어라"**는 완전히 다른 지시다. **`<type>pom</type>`과 항상 함께 쓴다.**

---

## Q7. BOM을 넣었는데도 `<dependencies>` 선언이 필요한 이유

**`<dependencyManagement>`는 버전만 정하고 의존성을 추가하지 않기 때문이다.**

```
<dependencyManagement>  →  "만약 이걸 쓴다면 버전은 이것"   (추가 없음)
<dependencies>          →  "실제로 이걸 쓴다"              (추가함)
```

**그래서 §2.2의 네 개를 여전히 적어야 하고, 다만 그중 `testcontainers-*` 둘은 `<version>`을 생략할 수 있다.**

> **이것을 혼동하면 "BOM을 넣었는데 클래스를 못 찾는다"가 된다.**

**같은 원리를 이미 쓰고 있었다** — [[../chapter-2-creating-web-and-api-applications-with-spring-boot/01-using-start-spring-io-to-build-apps|Ch2]]에서 Boot 스타터에 `<version>`을 안 썼던 것이 그것이다.

**차이 하나**: **Boot BOM은 부모 POM을 통해 자동으로 적용되고, Testcontainers BOM은 우리가 직접 import해야 한다.** 부모가 하나뿐이라 Boot 것만 상속되므로, **다른 프로젝트의 BOM은 `import` scope로 끌어와야** 한다. 이것이 `import`가 존재하는 이유 자체다.

---

## Q8. Testcontainers 2.x의 좌표 변경이 이 절의 코드에 드러나는 곳

**`testcontainers-` 접두어다.**

| Boot 3 시절 (Testcontainers 1.x) | **이 절 (Testcontainers 2.x)** |
|---|---|
| `org.testcontainers:junit-jupiter` | `org.testcontainers:testcontainers-junit-jupiter` |
| `org.testcontainers:postgresql` | `org.testcontainers:testcontainers-postgresql` |

> **Java 클래스 이름은 대부분 그대로**이므로 마이그레이션은 **대개 좌표만 고치는 일**이다.

**즉 `PostgreSQLContainer`라는 클래스 이름은 안 바뀌었고, `pom.xml`의 `<artifactId>`만 바뀌었다.**

**실무적 함정**: **Boot 3 시절 예제를 그대로 복사하면 좌표가 안 맞는다.** 그리고 이 실패는 **의존성 해석 실패**로 나오므로 비교적 빨리 드러난다 — Q5의 "버전 조합이 어긋나 실행 시점에 깨지는" 경우보다는 낫다.

**[[../../part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/01-whats-new-in-spring-boot-4|Ch15]]가 이 변경을 정리한다.** Boot 4의 모듈 세분화와 방향이 같다 — **artifact id에 프로젝트 이름을 명시**해 다른 그룹의 아티팩트와 섞였을 때도 출처가 드러나게 한 것이다.

---

## 재출제 문항

1. 팀원 전원이 로컬 PostgreSQL을 깔았다. 그래도 남는 문제는?
2. Testcontainers를 의존성에 넣었는데 테스트가 안 뜬다. 가장 먼저 볼 것은?
3. 드라이버를 `test` scope로 바꾸면 무엇이 깨지는가?
4. `testcontainers-postgresql`만 넣고 `spring-boot-testcontainers`를 빼면 무엇을 손으로 해야 하는가?
5. BOM 없이 모듈 버전을 각자 적었다. 어떤 종류의 실패가 나는가?
6. `<scope>import</scope>`는 `compile`·`test`와 무엇이 다른가?
7. "BOM을 넣었는데 클래스를 못 찾는다"의 원인은?
8. Boot 3 예제를 복사해 왔더니 의존성이 해석되지 않는다. 무엇을 고치는가?

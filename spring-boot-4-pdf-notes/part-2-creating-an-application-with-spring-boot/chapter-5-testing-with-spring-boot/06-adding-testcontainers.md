---
category: chapter-5-testing-with-spring-boot
concept: adding-testcontainers-dependencies
title: "Testcontainers 넣기 — 일회용 데이터베이스를 빌드에 묶기"
source: "Learning Spring Boot 4, Ch. 5, 책 pp. 174-177 / PDF pp. 199-202"
terms: [Testcontainers, 컨테이너, BOM, 의존성-scope, SQL-방언, 모킹, 통합-테스트, 인메모리-데이터베이스]
related: [05-testing-repositories-with-embedded-databases, 07-testing-repositories-with-testcontainers, 04-testing-services-with-mocks]
status: prepared
---

# Testcontainers 넣기 — 일회용 데이터베이스를 빌드에 묶기

## 한눈에 보기

| 질문 | 핵심 답 |
|---|---|
| 왜 필요한가 | 엔진마다 SQL이 미묘하게 달라 **운영과 같은 버전**으로 검증해야 한다 |
| Docker만으로는? | 테스트할 때마다 **손으로 띄우는 것**이 문제다 |
| Testcontainers가 하는 일 | 컨테이너 기동 → 테스트 실행 → 종료를 **사람 손 없이** |
| 넣는 것 | 드라이버 1 + Boot 통합 1 + Testcontainers 모듈 2 |
| 버전은 어떻게 | `testcontainers.version` 프로퍼티 + **BOM import** |
| BOM이 필요한 이유 | 모듈이 **독립 릴리스**되지만 함께 동작하도록 설계됐다 |
| `pom` type / `import` scope | "코드 없이 빌드 정보만" / "이 BOM의 내용으로 대체" |

## 1. 왜 이게 필요한가

### 출발 장면: HSQLDB가 통과시켜 준 것들

[[05-testing-repositories-with-embedded-databases]]의 테스트는 진짜 SQL을 실행한다. 그런데 그 절이 끝에서 던진 질문이 남아 있다 — **운영 데이터베이스가 PostgreSQL이라면?**

책이 이 절을 그 지점에서 다시 잡는다.

> **[[모킹]]**(= 협력자를 가짜로 바꾸고 호출을 검증하는 방식)으로 진짜 서비스를 가짜로 바꿀 수 있다는 것을 봤다. 그런데 **진짜 서비스를 검증해야 한다면**, 즉 진짜 데이터베이스와 대화해야 한다면 어떻게 하는가?
>
> 각 데이터베이스 엔진이 SQL 구현에 조금씩 차이가 있다는 사실은, **운영에서 쓰려는 것과 같은 버전을 상대로** 데이터베이스 연산을 테스트할 것을 요구한다.

### 여기서 뭐가 무너지나

"그러면 로컬에 PostgreSQL을 깔고 테스트하면 되지 않나?" 여기서 세 가지가 무너진다.

1. **환경마다 다르다.** 내 노트북의 PostgreSQL 16과 동료의 15와 CI의 없음이 각각 다른 결과를 낸다.
2. **상태가 남는다.** 앞 테스트가 넣은 데이터가 다음 테스트에 새어 든다. 테스트 순서에 따라 결과가 달라진다.
3. **사람이 해야 한다.** 책의 표현대로 **"테스트를 돌리고 싶을 때마다 로컬 데이터베이스를 수동으로 띄우는 일은 영 아니다."**

세 번째가 결정적이다. 사람이 해야 하는 단계가 하나라도 있으면 **CI에서 못 돌리고**, CI에서 안 도는 테스트는 결국 안 도는 테스트다.

### 그래서 나온 생각

책이 배경을 짧게 정리한다.

> **2013년 Docker의 등장**과 여러 도구·애플리케이션을 컨테이너에 넣는 흐름이 커지면서, 우리가 찾는 데이터베이스의 컨테이너를 찾는 것이 가능해졌다. 오픈소스가 이를 더 키워, 우리가 찾을 수 있는 거의 모든 데이터베이스에 컨테이너화된 버전이 있다.
>
> …그러나 테스트를 돌리고 싶을 때마다 로컬 데이터베이스를 수동으로 띄우는 일은 영 아니다.
>
> 여기서 **[[Testcontainers]]**(= 테스트 실행 중 컨테이너로 실제 서비스를 띄우고 끝나면 내려 주는 라이브러리)가 등장한다. **2015년 첫 릴리스**와 함께, Testcontainers는 데이터베이스 컨테이너를 띄우고, 일련의 테스트 케이스를 실행하고, 그다음 컨테이너를 내리는 것을 **여러분이나 나의 수동 조작 없이** 해내는 메커니즘을 제공한다.

비유하자면 Testcontainers는 **일회용 실험실**이다. 실험할 때마다 새 실험실을 짓고, 끝나면 철거한다. 늘 깨끗한 상태에서 시작한다.

→ 비유가 깨지는 지점: 실제 실험실은 짓는 데 몇 달이 걸려서 그렇게 할 수가 없다. 컨테이너는 초 단위로 뜬다 — 하지만 **공짜는 아니다.** [[07-testing-repositories-with-testcontainers]]의 실행 결과를 보면 첫 테스트 하나가 401밀리초를 먹는다. 그리고 실험실 비유에 없는 전제가 하나 더 있다 — **그 머신에 Docker가 떠 있어야 한다.** 실험실은 땅만 있으면 되지만 Testcontainers는 런타임 의존성이 있고, 그것이 CI 설정에서 흔한 걸림돌이 된다.

## 2. 어떻게 동작하는가

### 2.1 Initializr에서 고르기

책의 절차는 앞 Chapter들과 같다 — start.spring.io에서 **Testcontainers**와 **PostgreSQL Driver**를 고른다.

먼저 `pom.xml`의 `<properties/>` 절, 기존 `java.version` 프로퍼티가 있는 자리에 버전을 하나 둔다.

```xml
<testcontainers.version>2.0.3</testcontainers.version>
```

이 한 줄이 왜 별도로 필요한지가 §2.3의 내용이다.

### 2.2 의존성 네 개

```xml
<dependency>
   <groupId>org.postgresql</groupId>
   <artifactId>postgresql</artifactId>
   <scope>runtime</scope>
</dependency>

<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-testcontainers</artifactId>
   <scope>test</scope>
</dependency>

<dependency>
   <groupId>org.testcontainers</groupId>
   <artifactId>testcontainers-junit-jupiter</artifactId>
   <scope>test</scope>
</dependency>

<dependency>
   <groupId>org.testcontainers</groupId>
   <artifactId>testcontainers-postgresql</artifactId>
   <scope>test</scope>
</dependency>
```

책의 항목별 설명이다.

| 의존성 | 무엇을 하나 | scope와 그 이유 |
|---|---|---|
| `org.postgresql:postgresql` | PostgreSQL에 접속하는 **드라이버**. Spring Boot가 관리하는 서드파티 라이브러리 | **`runtime`** — 우리 코드 중 이것을 상대로 컴파일해야 하는 것이 없다 |
| `spring-boot-testcontainers` | Spring Boot의 **Testcontainers 통합 모듈**. Boot의 테스트 인프라와 긴밀히 엮여 **컨테이너 생명주기 자동 관리**와 컨테이너를 Spring 컨텍스트에 매끄럽게 연결하는 기능을 제공 | `test` |
| `testcontainers-postgresql` | PostgreSQL 컨테이너에 대한 **일급 지원**을 가져오는 Testcontainers 라이브러리 | `test` |
| `testcontainers-junit-jupiter` | **JUnit(Jupiter)과의 깊은 통합**을 가져오는 Testcontainers 라이브러리 | `test` |

**[[의존성-scope]]**(= 의존성이 어느 단계에 필요한지 표시하는 Maven 값)이 첫 줄만 `runtime`이고 나머지가 `test`인 것이 의미가 있다. 드라이버는 **운영에서도 필요**하지만(운영에서 PostgreSQL을 쓰니까) 컴파일 경로에는 없어야 하고, 나머지 셋은 **테스트에만** 존재해야 한다. 운영 산출물에 컨테이너 제어 코드가 들어갈 이유가 없다.

두 번째와 나머지 둘의 **소속이 다르다**는 점도 눈여겨볼 만하다. `spring-boot-testcontainers`는 Spring Boot 쪽이 만든 다리이고, `testcontainers-*`는 Testcontainers 프로젝트 자신의 모듈이다. 다리와 본체가 따로 필요하다.

> **Chapter 15 기준 보강**: 이 좌표들은 Spring Boot 4가 관리하는 **Testcontainers 2.x** 기준이다. [[../../part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/01-whats-new-in-spring-boot-4|Chapter 15]]가 밝히듯 Testcontainers 2에서 여러 모듈의 artifact id가 바뀌었다 — `org.testcontainers:junit-jupiter`가 `org.testcontainers:testcontainers-junit-jupiter`로, `org.testcontainers:postgresql`이 `org.testcontainers:testcontainers-postgresql`로. **Java 클래스 이름은 대부분 그대로**이므로 마이그레이션은 대개 좌표만 고치는 일이다. 이 절의 좌표에 `testcontainers-` 접두어가 붙어 있는 것이 그 결과다.

### 2.3 왜 BOM이 필요한가

책이 이유를 밝힌다.

> Testcontainers가 **여러 모듈로 구성**되어 있고, 각 모듈이 **독립적으로 릴리스되지만 함께 동작하도록 설계**되었다는 점을 이해하는 것이 중요하다. 그렇게 하기 위해 Maven **[[BOM]]**(= 서로 맞물려 동작하는 아티팩트들의 검증된 버전 조합을 모아 둔 Maven 아티팩트)을 릴리스한다.

"독립 릴리스인데 함께 동작해야 한다"는 조건이 정확히 BOM이 푸는 문제다. 모듈이 각자 버전을 올리므로 **어떤 조합이 검증됐는지**를 누군가 관리해야 한다.

```xml
<dependencyManagement>
     <dependencies>
         <dependency>
             <groupId>org.testcontainers</groupId>
             <artifactId>testcontainers-bom</artifactId>
             <version>${testcontainers.version}</version>
             <type>pom</type>
             <scope>import</scope>
         </dependency>
     </dependencies>
</dependencyManagement>
```

책의 항목별 설명이다.

- **`testcontainers-bom`** — 지원되는 각 모듈에 대한 핵심 정보를 전부 담고 있다. **여기서 버전을 지정하면 다른 모든 Testcontainers 의존성은 버전 설정을 건너뛸 수 있다.**
- **`pom`** — 이 아티팩트에 **코드가 없고 Maven 빌드 정보만** 있음을 나타내는 의존성 타입이다.
- **`import`** — 이 의존성이 **이 BOM이 담고 있는 내용으로 사실상 대체됨**을 나타내는 scope다. 선언된 버전 무더기를 추가하는 **지름길**이다.

세 요소가 각각 무엇을 위한 것인지 그림으로 보면 이렇다.

```text
  <dependencyManagement>   ← "버전을 정해 두는 곳" (실제로 의존성을 추가하지는 않는다)
      testcontainers-bom
        + <type>pom</type>       ← "이 아티팩트에는 클래스 파일이 없다. 빌드 정보뿐"
        + <scope>import</scope>  ← "이 자리에 그 BOM의 내용을 펼쳐 넣어라"
                │
                ▼
        testcontainers-core        : 2.0.3
        testcontainers-postgresql  : 2.0.3
        testcontainers-junit-jupiter : 2.0.3
        testcontainers-kafka       : 2.0.3
        ... (지원되는 모든 모듈)
                │
                ▼
  <dependencies> 에서 <version> 을 안 써도 위 표의 값이 적용된다
```

`<dependencyManagement>`와 `<dependencies>`의 차이가 여기서 중요하다. **전자는 버전만 정하고 의존성을 추가하지 않는다.** 실제로 무엇을 쓸지는 `<dependencies>`에서 따로 선언해야 한다. 그래서 §2.2의 네 개를 여전히 적어야 하고, 다만 그중 `testcontainers-*` 둘은 `<version>`을 생략할 수 있다.

이 구조는 [[../chapter-2-creating-web-and-api-applications-with-spring-boot/01-using-start-spring-io-to-build-apps|Chapter 2]]에서 Boot 스타터에 버전을 안 쓰던 것과 같은 원리다. 차이는 Boot BOM은 부모 POM을 통해 자동으로 적용되고, Testcontainers BOM은 **우리가 직접 import해야** 한다는 점이다.

### 2.4 이것으로 무엇이 가능해졌나

정리하면 이 절이 만든 상태는 이렇다.

| 준비된 것 | 무엇을 가능하게 하나 |
|---|---|
| PostgreSQL 드라이버 | JDBC로 실제 PostgreSQL에 접속 |
| `testcontainers-postgresql` | PostgreSQL **[[컨테이너]]**(= 애플리케이션과 실행 환경을 묶어 어디서나 같게 실행되게 한 격리 단위)를 코드로 정의 |
| `testcontainers-junit-jupiter` | JUnit 생명주기에 컨테이너 기동·종료를 연결 |
| `spring-boot-testcontainers` | 컨테이너 접속 정보를 Spring 컨텍스트에 자동 연결 |
| BOM | 위 셋의 버전이 서로 맞물리도록 고정 |

**[[통합-테스트]]**(= 협력자의 실제·시뮬레이션 버전을 함께 띄우는 테스트)를 **[[인메모리-데이터베이스]]**(= 애플리케이션과 같은 메모리 공간에서 도는 데이터베이스)보다 한 단계 더 진짜에 가깝게 만들 재료가 다 모였다. 실제 테스트 코드는 [[07-testing-repositories-with-testcontainers]]에서 쓴다.

## 3. 그림으로 보기

### 손으로 하던 일이 사라지는 지점

```mermaid
%%{init: {'theme': 'dark'}}%%
flowchart TD
    subgraph MANUAL["수동 로컬 DB"]
        M1["사람이 DB를 띄운다"] --> M2["테스트 실행"]
        M2 --> M3["데이터가 남는다"]
        M3 --> M4["다음 테스트가 영향받는다"]
        M1 -.->|"CI에는 사람이 없다"| M5["CI에서 못 돈다"]
    end
    subgraph TC["Testcontainers"]
        T1["JUnit 생명주기가 컨테이너 기동"] --> T2["Spring 컨텍스트에 접속 정보 자동 연결"]
        T2 --> T3["테스트 실행"]
        T3 --> T4["컨테이너 종료 · 상태 소멸"]
        T1 -.->|"전제"| T5["머신에 Docker 가 떠 있어야 한다"]
    end
```

### 세 가지 데이터베이스 전략

| | 목 ([[04-testing-services-with-mocks]]) | HSQLDB ([[05-testing-repositories-with-embedded-databases]]) | Testcontainers |
|---|---|---|---|
| SQL 실행 | 없음 | 있음 | 있음 |
| 엔진 | — | HSQLDB | **운영과 같은 PostgreSQL** |
| **[[SQL-방언]]**(= 제품마다 다른 SQL 동작 차이) 검증 | 불가 | 불가 | **가능** |
| 기동 비용 | 0 | 작음 | 초 단위 |
| 외부 전제 | 없음 | 없음 | **Docker** |
| 상태 격리 | 자동 | 트랜잭션 롤백 | 컨테이너 소멸 |

### BOM이 하는 일

```text
[BOM 없이]

  <dependency> testcontainers-postgresql   <version>2.0.3</version> </dependency>
  <dependency> testcontainers-junit-jupiter <version>2.0.2</version> </dependency>   ← 실수
  <dependency> testcontainers-kafka         <version>1.19.8</version> </dependency>  ← 더 큰 실수
  ▶ 독립 릴리스라 버전이 제각각 될 수 있고, 검증되지 않은 조합이 만들어진다


[BOM 으로]

  <properties> testcontainers.version = 2.0.3 </properties>
                        │
  <dependencyManagement> testcontainers-bom (pom, import)
                        │
                        ▼  펼쳐진 버전 표가 적용된다
  <dependency> testcontainers-postgresql    </dependency>   ← version 없음
  <dependency> testcontainers-junit-jupiter </dependency>   ← version 없음
  ▶ 버전을 고칠 곳이 한 군데뿐이고, 조합은 항상 검증된 것이다
```

## 4. 이 노트에 나온 용어

| 용어 | 한 줄 풀이 | 자세히 |
|---|---|---|
| Testcontainers | 테스트 중 컨테이너로 실제 서비스를 띄우고 내려 주는 라이브러리 | [[_glossary#Testcontainers]] |
| 컨테이너 | 애플리케이션과 실행 환경을 묶은 격리 실행 단위 | [[_glossary#컨테이너]] |
| BOM | 아티팩트들의 검증된 버전 조합을 모아 둔 Maven 아티팩트 | [[_glossary#BOM]] |
| 의존성 scope | 의존성이 어느 단계에 필요한지 표시하는 값 | [[_glossary#의존성-scope]] |
| SQL 방언 | 제품마다 다른 SQL 문법·동작의 차이 | [[_glossary#SQL-방언]] |
| 모킹 | 협력자를 가짜로 바꾸고 호출을 검증하는 방식 | [[_glossary#모킹]] |
| 통합 테스트 | 협력자의 실제·시뮬레이션 버전을 함께 띄우는 테스트 | [[_glossary#통합-테스트]] |
| 인메모리 데이터베이스 | 애플리케이션과 같은 메모리 공간에서 도는 DB | [[_glossary#인메모리-데이터베이스]] |

## 5. 자주 헷갈리는 것

### Docker와 Testcontainers

**Docker는 컨테이너를 실행하는 런타임**이고, **Testcontainers는 그것을 테스트 생명주기에 묶는 Java 라이브러리**다. Testcontainers를 넣어도 Docker가 없으면 아무것도 안 된다.

### `spring-boot-testcontainers`와 `testcontainers-*`

**소속이 다르다.** 앞은 Spring Boot 팀이 만든 다리(컨텍스트 연결·생명주기 관리), 뒤는 Testcontainers 프로젝트의 본체다. 둘 다 필요하다.

### `<dependencyManagement>`가 의존성을 추가한다

**추가하지 않는다.** 버전만 정한다. 실제로 쓰려면 `<dependencies>`에 따로 선언해야 한다. 이것을 혼동하면 "BOM을 넣었는데 클래스를 못 찾는다"가 된다.

### `<scope>import</scope>`와 다른 scope들

`compile`·`runtime`·`test`는 **"언제 필요한가"**를 말하지만, `import`는 **"이 자리에 그 BOM 내용을 펼쳐 넣어라"**는 완전히 다른 종류의 지시다. `<type>pom</type>`과 항상 함께 쓴다.

### 드라이버가 `runtime`인데 테스트에서 쓰인다

`runtime` scope는 **테스트 실행 시에도 클래스패스에 있다.** 빠지는 것은 **컴파일 경로**뿐이다. 그래서 테스트가 실제로 PostgreSQL에 접속할 수 있다.

## 6. 언제 안 쓰나 / 경계

- **Docker가 전제다.** 개발자 머신과 CI 양쪽에 Docker(또는 호환 런타임)가 있어야 한다. 이것이 안 되는 환경에서는 이 전략 자체가 성립하지 않는다.
- 컨테이너 기동은 공짜가 아니다. 밀리초가 아니라 **초 단위**이며, 테스트 클래스가 많아질수록 누적된다. [[07-testing-repositories-with-testcontainers]]의 실행 결과가 그 비용을 숫자로 보여 준다.
- 이미지를 처음 받을 때는 네트워크가 필요하다. 폐쇄망에서는 사내 레지스트리 미러가 있어야 한다.
- Testcontainers 2.x로 올라오면서 artifact id가 바뀌었다. Boot 3 시절 예제를 그대로 복사하면 좌표가 안 맞는다.
- 이 절은 **의존성만** 넣는다. 실제로 컨테이너를 어떻게 선언하고 Spring에 연결하는지는 다음 절의 내용이다.

## 7. 연결

- [[05-testing-repositories-with-embedded-databases]] — 그 절이 끝에서 던진 "운영 DB가 내장형이 아니라면?"에 대한 답이 이 절이다.
- [[07-testing-repositories-with-testcontainers]] — 여기서 갖춘 네 개의 의존성으로 실제 테스트 클래스를 쓴다.
- [[04-testing-services-with-mocks]] — 목·인메모리·컨테이너 세 전략의 양 끝을 대조하면 이 장의 전체 지형이 보인다.

## 8. 스스로 확인

1. 로컬에 PostgreSQL을 직접 깔아 테스트하면 무너지는 세 지점은 무엇인가? 그중 결정적인 것과 이유는?
2. 일회용 실험실 비유가 깨지는 지점을 두 가지 말할 수 있는가?
3. 네 개의 의존성 중 하나만 `runtime`인 이유는?
4. `spring-boot-testcontainers`와 `testcontainers-postgresql`이 둘 다 필요한 이유는?
5. Testcontainers가 BOM을 릴리스하는 이유를 "독립 릴리스"라는 성질로 설명할 수 있는가?
6. `<type>pom</type>`과 `<scope>import</scope>`가 각각 무엇을 뜻하는가?
7. `<dependencyManagement>`에 BOM을 넣었는데도 `<dependencies>`에 선언이 필요한 이유는?
8. Testcontainers 2.x에서 좌표가 바뀐 사실이 이 절의 코드에 어떻게 드러나는가?


> 여덟 문항을 스스로 답한 **뒤에** [[_06-adding-testcontainers]]에서 모범답안과 대조한다. 먼저 열면 이 문항들은 다시 인출 문제로 쓸 수 없다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력

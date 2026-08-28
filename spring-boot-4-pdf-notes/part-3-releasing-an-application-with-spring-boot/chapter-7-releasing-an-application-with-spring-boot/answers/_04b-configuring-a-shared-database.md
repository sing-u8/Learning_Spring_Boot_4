# 모범답안 — 04b 공유 데이터베이스 구성

> **먼저 답하고 나서 열 것.** [[04b-configuring-a-shared-database]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 세 인스턴스가 인메모리 DB를 쓸 때의 증상

| 사용자 행동 | **결과** |
|---|---|
| 인스턴스 1에 등록 | **인스턴스 1의 메모리에만 저장** |
| 새로고침 → 인스턴스 2 | **안 보인다** |
| 다시 새로고침 → 인스턴스 3 | **역시 안 보인다** |
| 인스턴스 1 재시작 | **데이터가 통째로 사라진다** |

**무상태 인스턴스가 되려면 상태를 밖으로 빼야 한다.** 그러면 무엇을 쓸 것인가.

**책의 답이 실용적이다** — *"이미 Testcontainers로 PostgreSQL을 상대로 통합 테스트를 해 뒀으니, **설정만 조정하면 운영 인스턴스를 가리킬 수 있다.**"*

**이 연결이 이 절의 핵심 논거다** → Q2.

---

## Q2. 책이 PostgreSQL을 고른 실용적 근거

**[[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/07-testing-repositories-with-testcontainers|Ch5]]에서 이미 실제 PostgreSQL 컨테이너로 리포지토리를 검증했기 때문이다.**

> **테스트한 것과 운영에서 쓰는 것이 같은 종류가 된다.**

```
Ch5 테스트:   postgres:17-alpine 컨테이너로 findByNameContainsIgnoreCase 검증
Ch7 운영:     postgres:16 컨테이너를 가리키도록 설정
              └─ 같은 엔진, 같은 방언
```

**H2로 테스트하고 PostgreSQL로 배포할 때 생기는 방언 차이 문제가 없다.**

**[[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/05-testing-repositories-with-embedded-databases|Ch5의 인메모리 절]]이 끝에서 던진 경고가 여기서 회수된다** — *"방언의 특이점, 인덱싱 동작, 대소문자 민감성, 트랜잭션 처리가 내장 데이터베이스에서는 되던 코드를 PostgreSQL에서 실패하게 만들 수 있다."* **Testcontainers를 쓴 투자가 배포 단계에서 값을 낸다.**

**띄우는 방법도 같다** — *"**Testcontainers가 길을 보여 줬다 — Docker를 쓰면 된다.**"*

```bash
% docker run -d -p 5432:5432 --name my-postgres -e POSTGRES_PASSWORD=mysecretpassword postgres:16
```

---

## Q3. `--name my-postgres`가 주는 부수 효과

**고정 이름이라 여러 개를 동시에 띄울 수 없다.**

> **실수로 두 번째를 띄우려 하면 이름 충돌로 거부된다. 데이터베이스는 하나여야 하므로 이것이 오히려 안전장치다.**

**[[02a-building-the-right-type-of-container]]의 임의 이름 문제를 뒤집은 것**:

| | 임의 이름 (`angry_cray`) | **`--name my-postgres`** |
|---|---|---|
| 스크립트에서 참조 | **불가능** | **가능** |
| 중복 실행 | 얼마든지 된다 | **거부된다** |
| 다른 컨테이너가 이름으로 찾기 | 불가능 | **가능** → [[04c-running-the-setup-with-docker-compose]] |

**세 번째가 다음 절의 전제가 된다** — Compose에서 애플리케이션 컨테이너가 데이터베이스를 **이름으로** 찾는다.

**나머지 옵션들**:
| 옵션 | 하는 일 | 왜 |
|---|---|---|
| `-d` | 백그라운드 데몬 | **터미널을 붙잡지 않는다** |
| `-p 5432:5432` | 포트 매핑 | 호스트에서 접속할 수 있게 |
| `-e POSTGRES_PASSWORD=…` | 환경 변수로 비밀번호 | **Postgres 이미지가 요구하는 방식** |
| `postgres:16` | 이미지와 태그 | **Ch5 테스트와 같은 좌표** |

> **원문 표현의 과장**: 책은 `-p 5432:5432`를 "표준 5432 포트가 **public에 export된다**"고 설명한다. 실제로는 **호스트 인터페이스에 바인딩**되는 것이고, **외부 공개 여부는 호스트의 방화벽과 네트워크 설정**에 달렸다.

---

## Q4. JDBC 세 줄과 JPA 세 줄이 대응하는 층

| 묶음 | **무엇을 정하나** | **누가 소비하나** |
|---|---|---|
| **JDBC** | **어디에 어떻게 접속하나** | **Spring Boot가 `DataSource` 빈을 조립** |
| **JPA** | **스키마와 SQL을 어떻게 다루나** | **Hibernate** |

```properties
# JDBC — 연결 좌표
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=mysecretpassword
# JPA — ORM 동작
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true          ← 책의 코드 블록은 이 키를 틀리게 적었다 (Q7)
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
```

**층이 나뉜 이유**: **JDBC는 데이터베이스가 무엇이든 같은 모양**이고(URL·사용자·비밀번호), **JPA는 ORM을 쓸 때만 필요**하다. JDBC만 쓰는 애플리케이션은 아래 세 줄이 없다.

**접두사가 그 구조를 그대로 보여 준다** — `spring.datasource.*` vs `spring.jpa.*`.

**JPA 세 줄의 뜻**:
| 프로퍼티 | 뜻 |
|---|---|
| `ddl-auto=update` | **필요하면 스키마를 갱신하되 아무것도 drop하거나 삭제하지 않는다** |
| `show-sql` | Hibernate가 만든 SQL을 로그로 출력 |
| `hibernate.dialect` | **SQL 방언**이 PostgreSQL임을 알린다 |

---

## Q5. 드라이버 클래스를 적지 않아도 되는 이유

**URL의 `jdbc:postgresql:` 접두사에서 Spring Boot가 추론하고, classpath에 있는 드라이버를 찾는다.**

```
spring.datasource.url=jdbc:postgresql://localhost:5432/postgres
                          └────┬────┘
                        이 접두사가 드라이버를 결정한다
```

**책의 정리**: *"**Spring Boot가 JDBC `DataSource` 빈을 조립하는 데 필요한 전부다.**"* — 세 줄이면 된다.

**전제 조건**: **드라이버가 classpath에 있어야** 한다. [[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/06-adding-testcontainers|Ch5]]에서 `org.postgresql:postgresql`을 **`runtime` scope**로 넣은 것이 여기서 쓰인다 — **컴파일에는 없고 실행에는 있다.**

**같은 자동 구성 원리다** — [[../../part-1-the-basics-of-spring-boot/chapter-1-core-features-of-spring-boot/01-autoconfiguring-spring-beans|Ch1]]의 조건부 구성: **클래스패스에 무엇이 있는가**가 입력이 된다.

**`localhost`를 기억해 둘 것** — [[04c-running-the-setup-with-docker-compose]]에서 **이 값이 바뀐다.**

---

## Q6. `ddl-auto`가 테스트와 운영에서 다른 이유

| | **테스트** ([[../../part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/07-testing-repositories-with-testcontainers|Ch5]]) | **운영** (이 절) |
|---|---|---|
| 값 | **`create-drop`** | **`update`** |
| 원하는 것 | **매번 깨끗한 스키마** | **데이터를 잃지 않는 것** |
| 데이터 | 테스트가 매번 넣는다 | **사용자의 진짜 데이터** |

> **`update`는 필요하면 스키마를 업데이트하지만 아무것도 drop하거나 삭제하지 않는다.**

**정반대 방향인 것이 맞다** — **테스트의 최우선은 격리와 재현성**이고, **운영의 최우선은 데이터 보존**이다. 같은 설정이 양쪽에 맞을 수 없다.

**`create-drop`을 운영에 쓰면**: **재기동할 때마다 표를 지우고 다시 만든다.** 모든 데이터가 사라진다.

**`update`도 운영 표준은 아니다**(§6): **지우지는 않지만 자동으로 스키마를 바꾼다.**
- 엔티티를 잘못 고치면 **운영 스키마가 따라 바뀐다**
- **컬럼 삭제·타입 변경은 처리하지 못해** 스키마가 어긋난 채 남는다
- **변경 이력이 남지 않는다**

> **운영에서는 마이그레이션 도구가 더 안전하며, [[04c-running-the-setup-with-docker-compose]]의 Note가 그 이야기를 한다.**

---

## Q7. `spring.jpa.hibernate.show-sql`의 무엇이 잘못됐는가

**존재하지 않는 키다.**

> **Spring Boot 4.1.0 배포물의 설정 메타데이터를 확인하면 `spring.jpa.hibernate` 아래에는 `ddl-auto`·`naming.*`·`use-new-id-generator-mappings`만 있고, SQL 출력 키는 `spring.jpa.show-sql`(`spring-boot-jpa` 모듈)이다.**

```
잘못:  spring.jpa.hibernate.show-sql
맞음:  spring.jpa.show-sql
```

**책 안에서 모순이 드러난다** — **바로 아래 항목 설명은 `spring.jpa.show-sql`이라고 올바르게 쓰고 있어, 코드 블록과 설명이 어긋난다.**

**증상**: 이 키를 그대로 적으면 **오류 없이 무시된다.** [[../chapter-6-configuring-an-application-with-spring-boot/01-creating-custom-properties|Ch6]]의 `@ConfigurationProperties`는 알 수 없는 키를 **기본적으로 무시**하므로 **SQL이 안 찍힐 뿐** 아무 말도 안 해 준다. 조용한 실패다.

**같은 블록의 또 다른 문제**: **`spring.jpa.properties.hibernate.dialect` 명시는 Hibernate 6 이후로는 대개 불필요하다.** **JDBC 메타데이터에서 방언을 자동 판별**하기 때문이다. Spring Boot 자체 키로 지정하려면 **`spring.jpa.database-platform`**이 있다.

**잡는 방법**: [[../chapter-6-configuring-an-application-with-spring-boot/03-switching-to-yaml-and-metadata|Ch6]]의 **IDE 코드 완성**이 이런 오타를 잡는다 — 메타데이터에 없는 키는 **완성 목록에 안 뜬다.**

---

## Q8. 창구와 장부 비유가 깨지는 지점

**비유**: 공유 데이터베이스는 **"여러 창구가 같은 장부를 본다"**다. **어느 창구에서 처리하든 기록이 하나로 남는다.**

**깨지는 지점**: **장부에 동시에 손대는 상황을 담지 못한다.**

> **실제로는 여러 인스턴스가 같은 행을 동시에 고칠 수 있어 트랜잭션과 잠금이 필요해지고, 그 문제는 인스턴스가 하나였을 때는 드러나지 않던 것이다.**

```
창구:  한 명씩 장부를 들고 쓴다 (물리적으로 직렬)
DB:    세 인스턴스가 같은 행에 동시에 UPDATE (진짜 동시)
```

**인스턴스가 하나였을 때 숨어 있던 문제**:
- **경쟁 조건** — 읽고-수정하고-쓰기 사이에 남이 끼어든다
- **잃어버린 갱신** — 나중 쓰기가 앞 쓰기를 덮는다
- **교착 상태** — 서로 다른 순서로 잠그면 멈춘다

**단일 인스턴스에서는 애플리케이션 수준 동기화로 덮이던 것이, 인스턴스가 늘면 통하지 않는다** — `synchronized`는 **한 JVM 안에서만** 유효하다.

**[[04a-scaling-with-spring-boot]]에서 이 비유를 예고했다** — 무대 비유를 고치며 "같은 은행의 창구 여러 개"가 낫다고 했는데, **그 비유도 여기서 한 겹 깨진다.** 비유를 갈아 끼워도 남는 문제가 있다.

**§6의 다른 경계도 함께**: **공유 DB가 새 병목이 된다.** **인스턴스를 늘려도 DB 하나가 감당하지 못하면 확장이 멈춘다.** 상태를 밖으로 뺀 대가로 **밖에 있는 그것이 단일 지점**이 된다.

**그리고 비밀번호가 프로퍼티 파일에 평문이다** — 예제라 그렇고, **실제로는 환경 변수나 비밀 관리 도구에서 주입**해야 한다.

---

## 재출제 문항

1. Ch5에서 Testcontainers에 들인 비용이 이 절에서 어떻게 회수되는가?
2. `--name`을 안 주면 다음 절의 무엇이 불가능해지는가?
3. `spring.datasource.*`와 `spring.jpa.*` 중 JDBC만 쓰는 앱에 필요한 것은?
4. 드라이버 클래스를 안 적어도 되는 근거와 그 전제 조건은?
5. 운영에 `ddl-auto=create-drop`을 두면 무슨 일이 생기는가?
6. `ddl-auto=update`도 운영 표준이 아닌 이유 세 가지는?
7. `spring.jpa.hibernate.show-sql`을 적었더니 SQL이 안 찍힌다. 오류는 왜 안 나는가?
8. 인스턴스가 하나에서 셋이 되면서 새로 생기는 데이터 문제는?

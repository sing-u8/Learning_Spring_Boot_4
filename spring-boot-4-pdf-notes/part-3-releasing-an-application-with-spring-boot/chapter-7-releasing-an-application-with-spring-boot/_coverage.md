# Chapter 7 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 7 *Releasing an Application with Spring Boot*, 책 pp. 207–227 / PDF pp. 232–252. PDF를 `pdftotext -layout -f 232 -l 252`로 새로 추출해 925줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

상위 절 4개 아래에 **실제 하위 제목 4개**가 있다. 책에 인쇄된 하위 제목을 그대로 분할선으로 삼아 8개 노트로 나눴다.

**기존 초안 4개의 파일 이름은 하나도 바꾸지 않았다.** Ch8 `04-building-native-container-images`와 Ch10 `03-creating-reactive-repositories-and-r2dbc-access`가 이 Chapter의 파일을 직접 참조한다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-creating-an-uber-jar]] | Creating an uber JAR | 208–211 | 233–236 |
| [[02-building-a-docker-container]] | Baking a Docker container | 212–213 | 237–238 |
| [[02a-building-the-right-type-of-container]] | └ Building the "right" type of container | 213–216 | 238–241 |
| [[03-publishing-an-image-to-docker-hub]] | Releasing your application to Docker Hub | 216–219 | 241–244 |
| [[04-tuning-and-scaling-in-production]] | Tweaking your application in production | 219–220 | 244–245 |
| [[04a-scaling-with-spring-boot]] | └ Scaling with Spring Boot | 220–222 | 245–247 |
| [[04b-configuring-a-shared-database]] | └ Configuring a shared database | 222–223 | 247–248 |
| [[04c-running-the-setup-with-docker-compose]] | └ Running the setup with Docker Compose | 223–227 | 248–252 |

`02`·`03`·`04`의 파일 이름은 원문 제목과 표현이 다르지만(예: *Baking a Docker container* vs `02-building-a-docker-container`) 다루는 범위가 같고, rename하면 대상 Chapter 밖 파일을 고쳐야 해서 유지했다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 207 | 232 | 장 도입: 모든 설정은 결국 **운영 준비**를 위한 것, 운영은 가치가 생기는 곳이자 복잡도와 위험이 커지는 곳, 다룰 4개 주제 | [[_map]] | 반영 |
| 207 | 232 | Note: 이 장에는 새 코드가 거의 없다. Chapter 6의 코드를 `ch7` 폴더로 복사했다 | [[01-creating-an-uber-jar]] | 반영 |
| 208 | 233 | 옛날 릴리스 이야기(ZIP·CD·테이프), 개발하는 곳과 운영하는 곳은 **언제나 달랐다**, 그 사이 단계를 최소화하는 것이 핵심 | [[01-creating-an-uber-jar]] | 반영 |
| 208 | 233 | 2014년 Spring Boot 팀이 도입한 uber JAR의 정의 — 코드·의존성·내장 서버를 한 아카이브에 | [[01-creating-an-uber-jar]] | 반영 |
| 208 | 233 | `./mvnw clean package`의 두 부분(clean·package)과 package가 앞 단계를 부른다는 설명 | [[01-creating-an-uber-jar]] | 반영 |
| 209 | 234 | Note: `mvnw`는 POSIX 셸 스크립트, Windows는 `mvnw.cmd`, Initializr가 둘 다 준다 | [[01-creating-an-uber-jar]] | 반영 |
| 209 | 234 | `spring-boot-maven-plugin` pom 조각, package 단계에 훅해 수행하는 **7단계** | [[01-creating-an-uber-jar]] | 반영 |
| 210 | 235 | `java -jar`로 실행, 배너 출력, JVM만 있으면 된다 | [[01-creating-an-uber-jar]] | 반영 |
| 210 | 235 | 무엇이 달라졌나 3가지 — 내장 Tomcat(Boot 4.x는 **Tomcat 11**, Jakarta Servlet 6.x), WAR/EAR 절차 불필요, 클라우드에 1만 개 복제 가능 | [[01-creating-an-uber-jar]] | 반영 |
| 211 | 236 | Note: 1997년 릴리스 일화 — 부서장 서명, CD 굽기, 17쪽 절차, 이틀 소요 | [[01-creating-an-uber-jar]] | 반영 |
| 211 | 236 | uber JAR은 Spring Boot의 발명이 아니다 — 2007년 Maven Shade 플러그인, **shaded JAR**과의 차이 | [[01-creating-an-uber-jar]] | 반영 |
| 211 | 236 | 섞어 담는 방식의 문제 3가지(비클래스 파일 위치·서드파티 동작·라이선스 위반)와 지원 거부 위험 | [[01-creating-an-uber-jar]] | 반영 |
| 212 | 237 | Docker는 경량 가상 머신에 가깝다, **컨테이너선 패러다임**, 내부적으로 Linux namespace·cgroups·containerd·runc | [[02-building-a-docker-container]] | 반영 |
| 212 | 237 | Note: Docker는 업계 표준 — 모든 주요 클라우드·CI/CD가 지원, 2023년 AtomicJar 인수로 Testcontainers 보유, 설치 요구가 부담이 아니다 | [[02-building-a-docker-container]] | 반영 |
| 212 | 237 | `./mvnw spring-boot:build-image` — package와 달리 **커스텀 goal**이다 | [[02-building-a-docker-container]] | 반영 |
| 213 | 238 | "baking"의 뜻 — 이미지를 한 번 만들어 여러 인스턴스로 재사용, build-image가 먼저 package를 돌린다(단위 테스트 포함) | [[02-building-a-docker-container]] | 반영 |
| 213 | 238 | 컨테이너를 조립하는 방식이 성능·재빌드 시간·효율에 직접 영향을 준다는 전환 | [[02-building-a-docker-container]] | 반영 |
| 213 | 238 | Docker의 **레이어 캐싱**, 바뀌면 캐시가 무효화된다 | [[02a-building-the-right-type-of-container]] | 반영 |
| 213 | 238 | 커스텀 코드와 서드파티 의존성을 **섞으면 안 되는** 이유 — 자바 파일 하나 바뀌면 전체를 다시 받는다 | [[02a-building-the-right-type-of-container]] | 반영 |
| 213–214 | 238–239 | 예전에는 수동 작업이었지만 Spring Boot 팀이 **layered 방식을 기본값으로** 만들었다, build-image 로그 발췌 | [[02a-building-the-right-type-of-container]] | 반영 |
| 214 | 239 | Paketo Buildpacks의 역할 — 앱 종류 자동 감지, 베이스 이미지 선택, 런타임 설치, **캐싱 효율을 위한 레이어 구성** | [[02a-building-the-right-type-of-container]] | 반영 |
| 214 | 239 | 로그가 드러내는 3가지 — 이미지 이름이 pom의 module·version에서 온다, Paketo builder·run 컨테이너를 받는다, 성공 메시지 | [[02a-building-the-right-type-of-container]] | 반영 |
| 214 | 239 | Note: Paketo Buildpacks는 소스 코드를 컨테이너 이미지로 바꾸는 프로젝트, Spring Boot는 **위임**한다 | [[02a-building-the-right-type-of-container]] | 반영 |
| 215 | 240 | `docker run -p 8080:8080 ...`과 출력, Paketo의 JVM 메모리 계산기 | [[02a-building-the-right-type-of-container]] | 반영 |
| 215 | 240 | 항목별 3개 설명(`docker run`, `-p`, 이미지 이름과 `docker.io/library/` 기본 접두사) | [[02a-building-the-right-type-of-container]] | 반영 |
| 215–216 | 240–241 | `docker ps` 출력과 항목별 6개 설명(해시 ID, 이미지 이름, `/cnb/process/web`, 가동 시간, 포트 매핑, 사람 친화적 이름) | [[02a-building-the-right-type-of-container]] | 반영 |
| 216 | 241 | `docker stop angry_cray`와 중지 확인 | [[02a-building-the-right-type-of-container]] | 반영 |
| 216 | 241 | Note: Docker가 임의의 사람 친화적 이름을 붙인다, 해시·이름·Docker Desktop 중 아무거나로 제어 | [[02a-building-the-right-type-of-container]] | 반영 |
| 216 | 241 | 만드는 것과 **릴리스하는 것**은 다르다, "Production is the happiest place on Earth" | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 217 | 242 | Note: Docker Hub 요금제, 무료 계정도 가능 | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 217 | 242 | `docker login -u <your_id>` | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 217 | 242 | `docker tag` + `docker push` 두 명령, **태깅의 정의**와 `namespace/name:tag` 형식, Docker Hub가 계정 ID 접두사를 요구한다 | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 217–218 | 242–243 | Note: `latest` 태그는 **관례일 뿐** 태그는 동적으로 옮길 수 있다, 어떤 컨테이너든 태깅 전략을 확인하라 | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 218 | 243 | Figure 7.1 Docker Hub에 올라간 컨테이너 | [[03-publishing-an-image-to-docker-hub]] | 반영 (미추출 — 아래 4절) |
| 218 | 243 | Note: 스크린샷은 저자 저장소, 자기 ID를 쓸 것 | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 218–219 | 243–244 | Docker 심화는 별도 책의 몫(*Docker Deep Dive*, *Docker: Up & Running*), 이 장의 목표는 Spring Boot가 얼마나 단순하게 만드는지 | [[03-publishing-an-image-to-docker-hub]] | 반영 |
| 219 | 244 | "**손대기 시작해야 진짜 운영이다**", 배포 후 조정할 것들 — 포트·DB 연결·로그 레벨·프로파일 | [[04-tuning-and-scaling-in-production]] | 반영 |
| 219 | 244 | `java -jar`로 기본 실행(8080), `SERVER_PORT=9000 java -jar ...`로 포트 변경과 Tomcat 로그 확인 | [[04-tuning-and-scaling-in-production]] | 반영 |
| 219–220 | 244–245 | 매번 파라미터를 치는 건 번거롭다 → 로컬 폴더에 `application.properties`를 만든다, JAR 안 설정을 **덮어쓴다** | [[04-tuning-and-scaling-in-production]] | 반영 |
| 220 | 245 | 오버라이드는 작은 조정에 그치지 않는다 — 여러 인스턴스를 지원하는 서로 다른 설정으로 확장된다 | [[04-tuning-and-scaling-in-production]] | 반영 |
| 220 | 245 | 여러 인스턴스를 9000·9001·9002로, 로드 밸런서 설정에 맞춘다, `instance1~3` 이름 부여 | [[04a-scaling-with-spring-boot]] | 반영 |
| 220–221 | 245–246 | `application-instance1~3.properties` 만들기와 `server.port` 값 지정 | [[04a-scaling-with-spring-boot]] | 반영 |
| 221 | 246 | `SPRING_PROFILES_ACTIVE=instance1~3 java -jar ...` 세 번과 각각의 Tomcat 포트 로그 | [[04a-scaling-with-spring-boot]] | 반영 |
| 221–222 | 246–247 | "The following 1 profile is active: instance1" 로그, 프로파일은 단일 앱을 여러 인스턴스로 돌리는 강력한 방법 | [[04a-scaling-with-spring-boot]] | 반영 |
| 222 | 247 | 그런데 기본 설정이 **인메모리 HSQL**이라 세 인스턴스가 DB를 공유하지 않는다 | [[04a-scaling-with-spring-boot]] | 반영 |
| 222 | 247 | Testcontainers로 PostgreSQL 통합 테스트를 이미 했으니 운영 인스턴스를 가리킬 수 있다 | [[04b-configuring-a-shared-database]] | 반영 |
| 222 | 247 | `docker run -d -p 5432:5432 --name my-postgres -e POSTGRES_PASSWORD=... postgres:16`과 항목별 5개 설명 | [[04b-configuring-a-shared-database]] | 반영 |
| 222–223 | 247–248 | `application-instance1.properties`에 더할 JDBC 3줄 + JPA 3줄 | [[04b-configuring-a-shared-database]] | 반영 (프로퍼티 오류 명시) |
| 223 | 248 | JDBC 3개와 JPA 3개의 항목별 설명, JDBC `DataSource` 빈 조립에 필요한 전부 | [[04b-configuring-a-shared-database]] | 반영 |
| 223 | 248 | 수동 실행은 프로파일 동작을 보여 주지만 실무에서는 **Docker Compose로 환경 전체를 정의**한다 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 223–224 | 248–249 | 세 프로퍼티 파일의 `spring.datasource.url`을 `localhost` → **`postgres`(서비스 이름)** 로 교체, Docker가 이름을 해석한다 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 224 | 249 | `./mvnw spring-boot:build-image`로 이미지 재생성 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 224–225 | 249–250 | `compose.yml` 전체 — postgres + instance1~3 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 225–226 | 250–251 | 항목별 9개 설명(이미지·컨테이너 이름·환경 변수·포트 매핑·`depends_on`), 같은 기본 네트워크라 서비스 이름으로 통신 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 226 | 251 | `docker compose up -d` 한 번, 9000·9001·9002로 접근 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 226 | 251 | Note: **운영 데이터 경고** — 세 인스턴스가 같은 사전 적재 데이터를 만들면 안 된다, Flyway·Liquibase나 DBA 프로세스가 맡을 일, `@Profile("setup")`과 `application-setup.properties` | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 226–227 | 251–252 | 열 개 이상은 이렇게 하고 싶지 않다 → 오케스트레이션 도구 4종(Kubernetes·Argo CD/Flux·Spinnaker·VMware Tanzu)과 각각의 트레이드오프 | [[04c-running-the-setup-with-docker-compose]] | 반영 |
| 227 | 252 | Summary: uber JAR → 컨테이너 → Docker Hub → 다중 인스턴스와 공유 DB, 다음 장 예고(GraalVM native) | [[_map]] | 반영 |

## 2. 코드·명령 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 |
|---:|---|---:|---|
| 1 | `./mvnw clean package` | 208 | [[01-creating-an-uber-jar]] |
| 2 | `spring-boot-maven-plugin` pom 조각 | 209 | [[01-creating-an-uber-jar]] |
| 3 | `java -jar target/ch7-0.0.1-SNAPSHOT.jar` + 배너 | 210 | [[01-creating-an-uber-jar]] |
| 4 | `./mvnw spring-boot:build-image` | 212 | [[02-building-a-docker-container]] |
| 5 | build-image 콘솔 로그 발췌 | 213–214 | [[02a-building-the-right-type-of-container]] |
| 6 | `docker run -p 8080:8080 ...` + 출력 | 215 | [[02a-building-the-right-type-of-container]] |
| 7 | `docker ps` + 출력 | 215–216 | [[02a-building-the-right-type-of-container]] |
| 8 | `docker stop angry_cray` | 216 | [[02a-building-the-right-type-of-container]] |
| 9 | `docker login -u <your_id>` | 217 | [[03-publishing-an-image-to-docker-hub]] |
| 10 | `docker tag` + `docker push` | 217 | [[03-publishing-an-image-to-docker-hub]] |
| 11 | `SERVER_PORT=9000 java -jar ...` + Tomcat 로그 | 219 | [[04-tuning-and-scaling-in-production]] |
| 12 | 로컬 `application.properties`의 `server.port=9000` | 220 | [[04-tuning-and-scaling-in-production]] |
| 13 | 오버라이드가 적용된 `java -jar` 재실행 | 220 | [[04-tuning-and-scaling-in-production]] |
| 14 | `SPRING_PROFILES_ACTIVE=instance1~3 java -jar ...` 3회 | 221 | [[04a-scaling-with-spring-boot]] |
| 15 | "The following 1 profile is active" 로그 | 221 | [[04a-scaling-with-spring-boot]] |
| 16 | `docker run -d ... postgres:16` | 222 | [[04b-configuring-a-shared-database]] |
| 17 | JDBC 3줄 + JPA 3줄 프로퍼티 | 222–223 | [[04b-configuring-a-shared-database]] |
| 18 | `spring.datasource.url`의 호스트를 `postgres`로 교체 | 223–224 | [[04c-running-the-setup-with-docker-compose]] |
| 19 | `compose.yml` 전체 | 224–225 | [[04c-running-the-setup-with-docker-compose]] |
| 20 | `docker compose up -d` | 226 | [[04c-running-the-setup-with-docker-compose]] |

## 3. Tip / Note 블록 → 노트 매핑

| # | 종류 | 요지 | 책 쪽 | 노트 |
|---:|---|---|---:|---|
| 1 | Note | 이 장에는 새 코드가 거의 없다, `ch7` 폴더 | 207 | [[01-creating-an-uber-jar]] |
| 2 | Note | `mvnw`는 POSIX 셸 스크립트, Windows는 `mvnw.cmd` | 209 | [[01-creating-an-uber-jar]] |
| 3 | Note | 1997년 릴리스 일화 — 서명·CD·17쪽 절차·이틀 | 211 | [[01-creating-an-uber-jar]] |
| 4 | Note | Docker는 업계 표준, AtomicJar 인수와 Testcontainers | 212 | [[02-building-a-docker-container]] |
| 5 | Note | Paketo Buildpacks 소개와 위임 구조 | 214 | [[02a-building-the-right-type-of-container]] |
| 6 | Note | Docker가 붙이는 사람 친화적 임의 이름 | 216 | [[02a-building-the-right-type-of-container]] |
| 7 | Note | Docker Hub 요금제 | 217 | [[03-publishing-an-image-to-docker-hub]] |
| 8 | Note | `latest`는 관례일 뿐, 태깅 전략을 확인하라 | 217–218 | [[03-publishing-an-image-to-docker-hub]] |
| 9 | Note | 스크린샷은 저자 저장소, 자기 ID를 쓸 것 | 218 | [[03-publishing-an-image-to-docker-hub]] |
| 10 | Note | **운영 데이터 경고** — `@Profile("setup")`, Flyway·Liquibase | 226 | [[04c-running-the-setup-with-docker-compose]] |

## 4. Figure 처리 판단

`pdfimages -f 232 -l 252 -list` 결과 raster 이미지가 **1개**뿐이다(Figure 7.1). PNG로 뽑아 육안 대조한 뒤 **추출하지 않았다.**

| Figure | 책 쪽 / PDF 쪽 | 판단 | 근거 |
|---|---:|---|---|
| 7.1 Docker Hub에 올라간 컨테이너 | 218 / 243 | 미추출 | Docker Hub의 Repositories 목록 화면이고, 한 행(`wxesquevixos/learning-spring-boot-4th-edition-ch7`, Public, 5분 전)이 전부다. 그 행이 보여 주는 정보(`namespace/name` 형식, 공개 여부)는 본문이 `docker tag` 설명과 Note에서 그대로 서술한다. 학습 대상은 화면이 아니라 **두 명령**이다. 파일 크기도 9.4MB로 얻는 것에 비해 과하다. 대신 노트에 공개 여부와 이름 형식을 표로 정리했다 |

## 5. 원문의 오류·공백 (노트에 명시)

| # | 위치 | 내용 |
|---:|---|---|
| 1 | 책 pp. 222–223 | 프로퍼티 블록에 **`spring.jpa.hibernate.show-sql=true`**를 적는다. Spring Boot 4.1.0 배포물의 설정 메타데이터에 이 키는 **없다** — `spring.jpa.hibernate` 아래에는 `ddl-auto`·`naming.*`·`use-new-id-generator-mappings`만 있고, SQL 출력 키는 `spring.jpa.show-sql`이다. 바로 아래 항목 설명은 **`spring.jpa.show-sql`이라고 올바르게** 쓰고 있어 코드와 설명이 어긋난다 |
| 2 | 책 pp. 223–224 vs 224–225 | Docker Compose 절이 `application-instance*.properties`의 **위치를 밝히지 않는다.** 앞 절(p.220)은 그 파일을 "로컬 폴더", 즉 JAR **옆**에 만들라고 했는데, `compose.yml`은 `image: ch7:0.0.1-SNAPSHOT`을 그대로 띄운다. 호스트의 파일은 이미지 안에 없으므로 그대로 따르면 컨테이너가 프로파일 설정을 찾지 못한다. 이미지에 담으려면 `src/main/resources`에 두고 다시 빌드해야 한다 |
| 3 | 책 p. 213 (로그) vs p. 215 (로그) | build-image 로그에는 `spring-boot-maven-plugin:**4.0.0**:build-image`, 컨테이너 실행 로그의 배너에는 `Spring Boot (v**4.1.0**)`이 찍혀 있다. 같은 프로젝트의 두 출력이 서로 다른 버전을 가리킨다 |
| 4 | 책 p. 226 | `depends_on: postgres`를 "데이터베이스 컨테이너가 애플리케이션 인스턴스보다 먼저 시작되도록 **보장한다**"고 설명한다. `depends_on`은 **기동 순서만** 보장하고 준비 완료는 보장하지 않는다. 초기 몇 초간 인스턴스의 DB 연결이 실패할 수 있다 |
| 5 | 책 p. 222 | `-p 5432:5432`를 "표준 5432 포트가 **public에 export된다**"고 설명한다. 실제로는 호스트 인터페이스에 바인딩되는 것이고, 공개 여부는 호스트의 네트워크 설정에 달렸다 |
| 6 | 책 p. 223 | `spring.jpa.properties.hibernate.dialect`를 명시적으로 지정한다. Hibernate 6 이후로는 JDBC 메타데이터에서 방언을 자동 판별하므로 대개 필요 없다. Spring Boot 자체 키로 지정하려면 `spring.jpa.database-platform`이 있다 |

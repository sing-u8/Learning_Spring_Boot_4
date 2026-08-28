# Chapter 7 용어집

> *Learning Spring Boot 4*, Ch. 7 *Releasing an Application with Spring Boot* (책 pp. 207–227 / PDF pp. 232–252)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## uber-JAR (uber JAR)

애플리케이션 코드, 모든 서드파티 의존성, 내장 서버를 한 파일에 담아 `java -jar` 하나로 실행되는 아카이브. "fat JAR"이라고도 한다.

## 내장-서버 (embedded server)

별도로 설치·운영하는 애플리케이션 서버 대신, 애플리케이션 아카이브 안에 함께 담겨 프로세스 내부에서 뜨는 서블릿 컨테이너. Spring Boot 4의 기본은 Tomcat 11이다.

## spring-boot-maven-plugin (spring-boot-maven-plugin)

Spring Boot가 제공하는 Maven 플러그인. Maven의 `package` 단계에 훅해 uber JAR을 만들고, `build-image` 같은 별도 goal로 컨테이너 이미지도 만든다.

## repackage (repackage)

표준 Maven이 만든 평범한 JAR을 풀어 새 JAR로 다시 조립하는 작업. 원본은 `.jar.original`로 옆에 남기고, 새 JAR에 로더 코드와 의존성을 넣는다.

## Spring-Boot-로더 (Spring Boot loader)

JAR 안에 들어 있는 JAR을 읽을 수 있게 해 주는 접착 코드. 표준 JVM은 중첩된 JAR을 클래스패스로 인식하지 못하므로 이 코드가 필요하다.

## BOOT-INF (BOOT-INF)

uber JAR 안에서 애플리케이션 코드(`BOOT-INF/classes`)와 서드파티 의존성(`BOOT-INF/lib`)이 놓이는 자리.

## layers.idx (layers.idx)

uber JAR 안의 파일들을 어떤 컨테이너 레이어에 넣을지 적어 둔 목록. `classpath.idx`와 함께 `BOOT-INF` 아래에 놓인다.

## shaded-JAR (shaded JAR)

들어오는 JAR들을 **전부 풀어 하나로 섞어** 만든 JAR. Maven Shade 플러그인이 만드는 형태이며, uber JAR과 달리 원래 JAR의 경계가 사라진다.

## Maven-goal (Maven goal)

플러그인이 제공하는 실행 단위 하나. `package` 같은 표준 생명주기 단계와 달리 `spring-boot:build-image`처럼 직접 지정해 부른다.

## 컨테이너 (container)

호스트 커널을 공유하면서 프로세스 트리·메모리·네트워크를 격리한 실행 단위. 가상 머신보다 가볍고 기동이 빠르다.

## 컨테이너-이미지 (container image)

컨테이너를 만들어 내는 읽기 전용 템플릿. 한 번 구우면(bake) 같은 이미지로 인스턴스를 몇 개든 띄울 수 있다.

## 레이어-캐싱 (layer caching)

컨테이너 이미지를 쌓인 레이어들의 합으로 보고, 바뀌지 않은 레이어는 다시 만들지 않고 재사용하는 Docker의 최적화.

## 계층형-이미지 (layered image)

자주 바뀌는 것과 잘 안 바뀌는 것을 서로 다른 레이어로 분리해 만든 이미지. 애플리케이션 코드 한 줄이 바뀌어도 의존성 레이어는 그대로 재사용된다.

## Paketo-Buildpacks (Paketo Buildpacks)

소스나 아티팩트를 받아 애플리케이션 종류를 자동으로 감지하고 컨테이너 이미지를 조립해 주는 재사용 가능한 컴포넌트 모음. Spring Boot는 이미지 생성을 여기에 위임한다.

## 빌더-이미지 (builder image)

이미지를 **만드는 과정**에서만 쓰이는 컨테이너. 컴파일러·도구가 들어 있고 최종 산출물에는 포함되지 않는다.

## 런-이미지 (run image)

최종 컨테이너가 **실행될 때** 바탕이 되는 이미지. 런타임에 필요한 것만 담아 크기를 줄인다.

## 포트-매핑 (port mapping)

컨테이너 내부 포트를 호스트의 포트에 연결하는 것. `-p 9000:8080`은 호스트 9000을 컨테이너 8080에 잇는다.

## 이미지-태그 (image tag)

이미지의 특정 버전을 가리키는 이름표. `namespace/name:tag` 형식으로 쓰며, **가리키는 대상을 나중에 옮길 수 있다.**

## 컨테이너-레지스트리 (container registry)

이미지를 보관하고 배포하는 저장소 서비스. Docker Hub가 대표적이다.

## latest-태그 (latest tag)

"가장 최근 릴리스"를 뜻하는 것으로 널리 쓰이는 태그 이름. 다만 **강제되는 규칙이 아니라 관례**이므로 실제로 무엇을 가리키는지는 발행자의 전략에 달렸다.

## 불변-아티팩트 (immutable artifact)

한 번 빌드한 뒤로는 내용을 고치지 않는 배포물. 같은 이미지가 모든 환경에서 그대로 돌고, 달라지는 것은 밖에서 주입하는 설정뿐이다.

## 환경-변수-오버라이드 (environment variable override)

`SERVER_PORT=9000` 처럼 실행 시점에 환경 변수로 설정 값을 덮어쓰는 것. 아티팩트를 건드리지 않고 동작을 바꾼다.

## 프로파일 (profile)

"이 설정 묶음은 이 상황에서만 쓴다"고 이름 붙이는 Spring의 장치. 활성화된 프로파일에 따라 추가로 읽히는 설정 파일이 달라진다.

## 외부-설정-파일 (external configuration file)

실행 가능한 JAR **옆에** 두는 설정 파일. JAR 안의 같은 이름 파일보다 우선순위가 높아 오버라이드로 쓸 수 있다.

## 수평-확장 (horizontal scaling)

인스턴스 수를 늘려 처리량을 키우는 방식. 인스턴스 하나를 더 크게 만드는 수직 확장과 대비된다.

## 로드-밸런서 (load balancer)

들어오는 요청을 여러 인스턴스에 나눠 보내는 장치. 인스턴스들이 서로 다른 포트나 주소로 떠 있어야 대상 목록을 구성할 수 있다.

## 무상태-인스턴스 (stateless instance)

자기 안에 지속 상태를 두지 않는 인스턴스. 어느 인스턴스가 요청을 받아도 결과가 같아야 수평 확장이 성립한다.

## 인메모리-데이터베이스 (in-memory database)

프로세스 메모리 안에서만 사는 데이터베이스. 기동이 빠르고 설정이 없지만 **인스턴스마다 별개**이고 종료하면 사라진다.

## 공유-데이터베이스 (shared database)

여러 인스턴스가 함께 바라보는 하나의 데이터베이스. 수평 확장한 인스턴스들이 같은 데이터를 보게 하는 가장 단순한 방법이다.

## JDBC-URL (JDBC URL)

데이터베이스 접속 좌표를 담은 문자열. `jdbc:postgresql://host:5432/dbname` 형태로 드라이버·호스트·포트·데이터베이스를 지정한다.

## DataSource (DataSource)

커넥션을 만들고 관리하는 자바 표준 추상. Spring Boot는 접속 정보 프로퍼티만 있으면 이 빈을 자동으로 조립한다.

## ddl-auto (spring.jpa.hibernate.ddl-auto)

엔티티 매핑을 기준으로 스키마를 어떻게 다룰지 정하는 설정. `update`는 필요한 것만 더하고 **아무것도 지우지 않는다.**

## SQL-방언 (SQL dialect)

같은 SQL 표준이라도 데이터베이스마다 다른 문법·함수를 흡수하기 위한 Hibernate의 추상. Hibernate 6 이후로는 대개 자동 판별된다.

## Docker-Compose (Docker Compose)

여러 컨테이너와 그 관계를 한 파일에 선언해 명령 하나로 함께 띄우는 도구.

## 서비스-이름-해석 (service name resolution)

같은 Compose 네트워크 안의 컨테이너들이 서로를 **서비스 이름**으로 찾을 수 있게 해 주는 내장 DNS. `localhost` 대신 `postgres`를 쓰는 이유다.

## depends_on (depends_on)

Compose에서 컨테이너 기동 **순서**를 지정하는 항목. 대상이 요청을 받을 준비가 됐는지까지는 보장하지 않는다.

## 데이터베이스-마이그레이션 (database migration)

스키마 변경과 기준 데이터 적재를 버전 관리된 절차로 다루는 것. Flyway나 Liquibase 같은 전용 도구가 맡는다.

## 오케스트레이션 (orchestration)

여러 컨테이너의 배치·확장·네트워킹·롤링 업데이트를 자동으로 관리하는 것. 인스턴스가 늘어나면 Compose로는 감당하기 어려워진다.

## Kubernetes (Kubernetes)

지배적인 컨테이너 오케스트레이션 플랫폼. 워크로드·네트워킹·서비스 디스커버리·확장·롤링 업데이트를 관리한다.

## GitOps (GitOps)

Git 저장소에 적힌 상태를 **원하는 상태**로 삼고, 도구가 실제 클러스터를 거기에 맞춰 조정하게 하는 배포 방식. Argo CD와 Flux가 대표적이다.

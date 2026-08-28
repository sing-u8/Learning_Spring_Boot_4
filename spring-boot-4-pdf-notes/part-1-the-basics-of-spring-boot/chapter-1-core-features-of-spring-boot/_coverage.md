# Chapter 1 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, 책 pp. 3–21 / PDF pp. 28–46. PDF를 `pdftotext -layout`으로 새로 추출한 뒤 제목, 하위 절, 코드, Tip/Note를 노트와 대조했다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 3–4 | 28–29 | 장 도입: Java 복잡성 감소, 2013년 Spring Boot 공개, Boot 4의 모듈·starter·test 의존성 명시성 | [[00-technical-requirements]], [[_map]] | 반영 |
| 4 | 29 | Technical requirements 전체 목록 | [[00-technical-requirements]] | 반영 |
| 4–5 | 29–30 | Installing Java 25: Boot 4.0/Framework 7.0, Java 25·17, SDKMAN, Temurin, Windows, 상용 지원 Tip | [[00-technical-requirements]] | 반영 |
| 5–6 | 30–31 | Installing a modern IDE: IntelliJ, Spring Tools Eclipse/VS Code, 에디션·선택 기준 | [[00-technical-requirements]] | 반영 |
| 6 | 31 | Creating a GitHub account와 책의 코드 저장소 | [[00-technical-requirements]] | 반영 |
| 6 | 31 | Autoconfiguring Spring beans 개요 | [[01-autoconfiguring-spring-beans]] | 반영 |
| 6–8 | 31–33 | Understanding application context: context, Spring bean, JavaBean Tip, DI, wiring, 교체 가능성 | [[01-autoconfiguring-spring-beans]] | 반영 |
| 8–10 | 33–35 | Exploring autoconfiguration policies: 조건부 구성, DataSource/H2/HikariCP, 순서, Boot 4 모듈화 | [[01-autoconfiguring-spring-beans]] | 반영 |
| 9 | 34 | 자동 구성 JAR 크기 비교 Note | [[01-autoconfiguring-spring-beans]] | 반영 |
| 9 | 34 | 사용자 DataSource가 있을 때 back-off | [[01-autoconfiguring-spring-beans]] | 반영 |
| 9–10 | 34–35 | AMQP부터 WebSocket까지 자동 구성 적용 범위 목록 | [[01-autoconfiguring-spring-beans]] | 기능군 표로 반영 |
| 11–12 | 36–37 | Adding portfolio components using Spring Boot starters | [[02-adding-portfolio-components-using-spring-boot-starters]] | 반영 |
| 11 | 36 | `starter-webmvc`, `starter-data-jpa` Maven 예제 | [[02-adding-portfolio-components-using-spring-boot-starters]] | 반영 |
| 11–12 | 36–37 | MVC/WebFlux/Web 구분과 명시적 아키텍처 | [[02-adding-portfolio-components-using-spring-boot-starters]] | 반영 |
| 12 | 37 | MVC starter가 제공하는 6개 기능과 템플릿 엔진 제외 | [[02-adding-portfolio-components-using-spring-boot-starters]] | 반영 |
| 12 | 37 | Jakarta EE Note와 기술별 test starter | [[02-adding-portfolio-components-using-spring-boot-starters]] | 반영 |
| 12–14 | 37–39 | Customizing setup: Tomcat 기본 가정, `server.port`, properties/YAML | [[03-customizing-the-setup-with-configuration-properties]] | 반영 |
| 14 | 39 | Jetty 선택, Servlet 6.1, Undertow 제거 Note, 공통·전용 서버 프로퍼티 | [[03-customizing-the-setup-with-configuration-properties]] | 반영 |
| 14–16 | 39–41 | Creating custom properties: `MyCustomProperties`, header/footer, JavaBean binding | [[03a-creating-custom-properties]] | 반영 |
| 15 | 40 | record 등록 방식 Tip | [[03a-creating-custom-properties]] | 반영 |
| 15–16 | 40–41 | `ApplicationSecuritySettings`, GitHub API code, 하드코딩 문제 | [[03a-creating-custom-properties]] | 반영 |
| 16–17 | 41–42 | Externalizing application configuration: JAR 내부·외부 파일, config location | [[03b-externalizing-application-configuration]] | 반영 |
| 16–18 | 41–43 | profile 정의, 파일 이름, DB URL 예제, 활성화, production 관련 Note | [[03b-externalizing-application-configuration]] | 반영 |
| 17–18 | 42–43 | 전체 property source 우선순위와 config file 내부 순서 | [[03b-externalizing-application-configuration]] | 반영 |
| 18–20 | 43–45 | Configuring property-based beans: 존재 조건, `havingValue`, YouTube/Vimeo | [[03c-configuring-property-based-beans]] | 반영 |
| 20 | 45 | 환경·클라우드별 조건 구성과 IDE 자동완성 | [[03c-configuring-property-based-beans]] | 반영 |
| 20–21 | 45–46 | Managing application dependencies: 업그레이드 충돌 문제, 정렬된 의존성 | [[04-managing-application-dependencies]] | 반영 |
| 21 | 46 | `spring-boot-dependencies` BOM, Maven/Gradle Note, CVE 패치 흐름 | [[04-managing-application-dependencies]] | 반영 |
| 21 | 46 | 재료와 pre-baked cake 비유, 장 요약 | [[04-managing-application-dependencies]], [[_map]] | 반영 |

## 2. 코드·명령 예제 커버리지

| 원문 예제 | 노트 | 설명 보강 |
|---|---|---|
| `sdk install java 25.0.1-tem`, `java --version` | [[00-technical-requirements]] | SDKMAN 역할, Temurin, 셸·IDE·빌드 JVM 불일치 |
| `@Bean BookRepository(DataSource)` | [[01-autoconfiguring-spring-beans]] | 빈 이름, 생성 순서, `new`가 `@Bean` 메서드에는 남는 이유 |
| `@ConditionalOnClass(DataSource.class)` | [[01-autoconfiguring-spring-beans]] | 후보 로드, 추가 조건, missing-bean back-off와 순서 |
| Maven `starter-webmvc` | [[02-adding-portfolio-components-using-spring-boot-starters]] | artifact 이름, 전이 의존성, 자동 구성까지의 단계 |
| Maven `starter-data-jpa` | [[02-adding-portfolio-components-using-spring-boot-starters]] | starter와 BOM 책임 분리 |
| `server.port=9000` | [[03-customizing-the-setup-with-configuration-properties]] | 표준 위치, 기본 8080, 공통 서버 추상화 |
| `MyCustomProperties` | [[03a-creating-custom-properties]] | 애노테이션별 책임, JavaBean·record 방식, binding과 DI 구분 |
| `my.app.header`, `my.app.footer` | [[03a-creating-custom-properties]] | 접두사·필드 매핑과 기본값 |
| `ApplicationSecuritySettings` | [[03a-creating-custom-properties]] | 재빌드 문제와 외부화·비밀 관리 경계 |
| 외부 `application.properties`와 config location | [[03b-externalizing-application-configuration]] | 내부/외부 검색과 location/additional-location 구분 |
| `application-test.properties`, `spring.profiles.active=test` | [[03b-externalizing-application-configuration]] | 기본+profile 병합, last-wins, production 예시의 한계 |
| `@ConditionalOnProperty` 존재 조건 | [[03c-configuring-property-based-beans]] | 누락·`false`·기타 값의 정확한 진리표 |
| YouTube/Vimeo `havingValue` | [[03c-configuring-property-based-beans]] | 상호 배타적 빈 선택, unknown 값, 시작 시점 경계 |
| Maven BOM import | [[04-managing-application-dependencies]] | 공식 문서 보강: dependencyManagement와 dependencies 구분 |

## 3. 공식 문서 교차 확인에서 보강한 점

PDF가 서술의 기준이고, Spring Boot 4.0.3 공식 문서는 버전 민감한 동작을 확인하는 보조 근거로만 사용했다.

| 항목 | PDF의 학습용 표현 | 노트의 보강 |
|---|---|---|
| 자동 구성 후보 | 기술별 정책 클래스가 조건에 따라 적용 | `AutoConfiguration.imports`, `@EnableAutoConfiguration`/`@SpringBootApplication`의 역할을 추가 |
| back-off | 사용자 빈을 만들면 자동 구성이 물러남 | `@ConditionalOnMissingBean`이 대표 메커니즘임을 추가 |
| property source 목록 | 테스트 sources 중 `@DynamicPropertySource` 미기재 | Spring Boot 4.0.3 공식 순서에 맞춰 별도 행 추가 |
| `@ConditionalOnProperty` | 키에 어떤 값이든 있으면 생성 | 기본 조건은 값이 `false`가 아닐 때 일치하며, 누락은 기본 불일치임을 진리표로 정정 |
| BOM | Maven·Gradle 모두 소비 가능 | Maven import 예와 Gradle 적용 원리, override 책임을 보강 |

## 4. 이미지·도표 판단

- PDF pp. 28–46에 대해 `pdfimages -list`를 확인한 결과 Chapter 1에는 추출할 raster 이미지가 없었다.
- Chapter 1의 시각 자료는 코드, 목록, Tip/Note 박스로 구성되어 있어 원본 페이지 캡처보다 밝은 배경의 Mermaid와 비교표가 학습에 더 적합했다.
- 따라서 이 Chapter에서는 책 페이지 이미지를 삽입하지 않았고, 객체 조립·자동 구성·프로퍼티 우선순위·BOM 관계를 재구성한 Mermaid를 각 노트에 넣었다.

## 5. 완료 기준

- [x] 책의 모든 본문 제목과 하위 제목이 최소 한 노트에 매핑됨
- [x] 모든 Java/XML/properties/명령 예제가 노트에 포함되거나 의미가 보존된 형태로 재구성됨
- [x] Tip/Note의 기술적 내용이 관련 노트에 반영됨
- [x] 책의 장 요약 네 축: 자동 구성, starter, configuration properties, dependency management가 `_map.md`에 연결됨
- [x] 버전 민감한 동작을 Spring Boot 4.0.3 공식 문서와 교차 확인함
- [x] PDF 내 이미지 존재 여부를 실제 검사함

## 공식 문서 대조 검증 (2026-08-29)

> `part-0-spring-core-internals` c1(컨테이너 생명주기)·c4(자동 구성 내부)와 주제가 겹친다. 그 트랙은 공식 문서를 1차 소스로 쓰고 대조 검증을 마쳤으므로, **두 트랙이 같은 것을 다르게 말하는 곳**을 찾는 방식으로 확인했다.

### 결과 — 정정 0건. 오히려 이쪽이 더 정밀한 곳이 있었다

| 확인한 것 | 결과 |
|---|---|
| 백오프가 우선순위가 아니라는 것 | `01` §2.5가 *"두 개의 `DataSource` 빈이 등록된 뒤 순위로 하나가 이기는 것이 아니라, 자동 구성 쪽 빈 정의가 **애초에 만들어지지 않는다**"*로 정확히 적고, **`@Primary` 없이 `NoUniqueBeanDefinitionException`이 났을 것**이라는 반증까지 든다. c4 `02`와 동일한 논증 |
| 빈 정의 vs 인스턴스 | `01`이 *"자동 구성이 실제로 만들어 내는 것은 객체가 아니라 **빈 정의**"*로 c1의 핵심 축을 이미 담고 있다 |
| 자동 구성 후보의 등록 경로 | `01`이 `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports`를 정확히 적는다 |
| `@ConditionalOnProperty`의 기본 조건 | `03c` §2가 **책의 "아무 값이나 있으면 생성된다"를 정정**하고, 키 없음·`false`·`true`·임의 문자열·빈 문자열의 5행 진리표를 제시한다 |
| 컴포넌트 스캔 vs 자동 구성 | `01` §5가 두 발견 경로를 구분한다 |

**이 챕터가 c4보다 정밀했던 지점.** `01` §2.4가 조건 평가를 **두 국면**으로 나누고 *"`@ConditionalOnMissingBean`은 `REGISTER_BEAN` 단계에서만 평가된다"*고 이름으로 짚는다. c4 `02`는 "지금까지 처리된 것 기준"까지만 적고 있었다. **이 대조 결과로 c4 쪽을 보강했다** — 검증이 한 방향이 아니라는 사례다.

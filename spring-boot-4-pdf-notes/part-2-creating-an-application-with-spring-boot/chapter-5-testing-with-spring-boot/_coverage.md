# Chapter 5 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 5 *Testing with Spring Boot*, 책 pp. 153–185 / PDF pp. 178–210. PDF를 `pdftotext -layout -f 178 -l 210`으로 새로 추출해 1,437줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

이 Chapter의 상위 절은 8개이고 **하위 제목이 하나도 없다.** 그래서 절 하나당 노트 하나로 두고 쪼개지 않았다. 기존 8개 초안의 파일 이름도 실제 절과 1:1로 맞아 그대로 유지했다.

| 노트 | 원문 절 | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-junit-6-and-focused-test-starters]] | Adding JUnit 6 to the application | 154–155 | 179–180 |
| [[02-testing-domain-objects]] | Creating tests for your domain objects | 155–161 | 180–186 |
| [[03-testing-web-controllers-with-mockmvc]] | Testing web controllers with MockMvc | 161–165 | 186–190 |
| [[04-testing-services-with-mocks]] | Testing data repositories with mocks | 165–169 | 190–194 |
| [[05-testing-repositories-with-embedded-databases]] | Testing data repositories with embedded databases | 169–174 | 194–199 |
| [[06-adding-testcontainers]] | Adding Testcontainers to the application | 174–177 | 199–202 |
| [[07-testing-repositories-with-testcontainers]] | Testing data repositories with Testcontainers | 177–181 | 202–206 |
| [[08-testing-security-policies]] | Testing security policies with Spring Security Test | 181–185 | 206–210 |

**`04`의 파일 이름은 원문 제목과 다르다.** 원문 제목은 *Testing data repositories with mocks*지만 그 절이 실제로 테스트하는 대상은 리포지토리가 아니라 **`VideoService`**이고, 모킹되는 쪽이 리포지토리다. 기존 초안의 이름(`04-testing-services-with-mocks`)이 내용에 더 맞아 유지했고, 이 불일치는 노트 본문에도 명시했다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 153 | 178 | 장 도입: 테스트는 끝나지 않는 다면적 작업이라는 관점, 신뢰를 쌓는 철학, 다룰 7개 주제 | [[_map]] | 반영 |
| 154 | 179 | Note: 이 장의 소스는 저장소 `ch5` 폴더 | [[01-junit-6-and-focused-test-starters]] | 반영 |
| 154 | 179 | JUnit 6이 Boot 4의 기본 테스트 프레임워크, "무엇을 해야 하나? 아무것도" | [[01-junit-6-and-focused-test-starters]] | 반영 |
| 154 | 179 | 단일 거대 test starter → **집중형 test starter 집합**으로 전환 (웹·데이터·보안·템플릿) | [[01-junit-6-and-focused-test-starters]] | 반영 |
| 154–155 | 179–180 | 제공되는 도구 9종: Spring Boot Test, Spring Test, JUnit 6, JSONPath, AssertJ, Hamcrest, JSONassert, XMLUnit, Mockito. 모킹의 정의 | [[01-junit-6-and-focused-test-starters]] | 반영 |
| 155 | 180 | Tip: JUnit 5용 테스트는 대부분 그대로 동작, JUnit 4는 레거시로 기본 미포함 | [[01-junit-6-and-focused-test-starters]] | 반영 |
| 155–156 | 180–181 | 도메인 모델을 먼저 테스트하는 이유, `CoreDomainTest`와 `newVideoEntityShouldHaveNullId`, 항목별 7개 설명 | [[02-testing-domain-objects]] | 반영 |
| 157 | 182 | IntelliJ에서 우클릭 실행(Figure 5.1)과 결과(Figure 5.2), 49밀리초 | [[02-testing-domain-objects]] | 반영 |
| 158 | 183 | `toStringShouldAlsoBeTested()`, 테스트 이름에 `should`를 넣는 이유 | [[02-testing-domain-objects]] | 반영 |
| 159 | 184 | Note: 왜 단언을 앞 테스트에 합치지 않고 나누는가 — 한 실패가 다른 실패를 가리지 않게 | [[02-testing-domain-objects]] | 반영 |
| 159–160 | 184–185 | `settersShouldMutateState()`와 항목별 설명 | [[02-testing-domain-objects]] | 반영 |
| 160–161 | 185–186 | 커버리지 실행(Figure 5.3), 초록·빨강 하이라이팅, `VideoEntity`가 protected 무인자 생성자만 빼고 전부 커버됨(Figure 5.4), 연습 과제 | [[02-testing-domain-objects]] | 반영 |
| 161–162 | 186–187 | 컨트롤러를 직접 인스턴스화하면 투박한 이유, Spring MVC 기계를 통과해야 한다는 요구 | [[03-testing-web-controllers-with-mockmvc]] | 반영 |
| 162–163 | 187–188 | `HomeControllerTest`: `@WebMvcTest(controllers=…)`, `@Autowired MockMvc`, `@MockitoBean`, `@WithMockUser`, `mvc.perform(get("/"))`, 항목별 8개 설명 | [[03-testing-web-controllers-with-mockmvc]] | 반영 |
| 163 | 188 | Tip: Boot 4에서 `@WebMvcTest` import 경로 변경(`org.springframework.boot.webmvc.test.autoconfigure`), `@MockBean` → `@MockitoBean` 개명 이유 | [[03-testing-web-controllers-with-mockmvc]] | 반영 |
| 163–164 | 188–189 | `postNewVideoShouldWork()`: `post()`, `.param()`, `.with(csrf())`, `redirectedUrl("/")`, `verify(videoService)` | [[03-testing-web-controllers-with-mockmvc]] | 반영 |
| 164 | 189 | 테스트 결과(Figure 5.5), 남은 컨트롤러 메서드는 연습 과제 | [[03-testing-web-controllers-with-mockmvc]] | 반영 |
| 165 | 190 | 협력자(collaborator) 식별, `VideoService`의 유일한 협력자가 `VideoRepository` | [[04-testing-services-with-mocks]] | 반영 |
| 165 | 190 | Note: 단위 테스트 vs 통합 테스트의 이득과 비용, 실제 앱은 둘을 섞는다 | [[04-testing-services-with-mocks]] | 반영 |
| 165–166 | 190–191 | `@ExtendWith(MockitoExtension.class)`, `@Mock`, `@BeforeEach setUp()`, 정적 `mock()`보다 나은 이유 | [[04-testing-services-with-mocks]] | 반영 |
| 166–167 | 191–192 | `getVideosShouldReturnAll()`, `when().thenReturn()`, given·when·then 주석과 BDD | [[04-testing-services-with-mocks]] | 반영 |
| 167 | 192 | Tip: 주석은 필수가 아니지만 읽기를 돕는다. 단언이 너무 많으면 쪼개라는 신호 | [[04-testing-services-with-mocks]] | 반영 |
| 167–168 | 192–193 | `creatingANewVideoShouldReturnTheSameData()`, `BDDMockito.given`, `any(VideoEntity.class)` | [[04-testing-services-with-mocks]] | 반영 |
| 168 | 193 | Note: 상태 검증(stub + 단언) vs 행위 검증(`verify()`), 둘 중 하나만 고를 필요 없음 | [[04-testing-services-with-mocks]] | 반영 |
| 169 | 194 | `deletingAVideoShouldWork()`와 `verify()` 두 번, 왜 여기서는 canned data가 안 되는지 | [[04-testing-services-with-mocks]] | 반영 |
| 169–170 | 194–195 | 실제 DB 테스트의 역사적 비용(테스트 엔지니어 팀·수동 문서·1주 대기), 자동화가 준 것 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 170 | 195 | Note: "모든 DB가 메모리에서 돌지 않나?" — 인메모리 DB는 **애플리케이션과 같은 메모리 공간**에서 도는 것 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 170 | 195 | H2·HSQLDB·Apache Derby 선택지, HSQLDB Maven 좌표와 `runtime` scope | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 170–171 | 195–196 | `@DataJpaTest`, `@Autowired VideoRepository`, `@BeforeEach`의 `saveAll()` 세 건 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 171 | 196 | 우리가 검증할 것은 Spring Data JPA가 아니라 **우리가 쓴 쿼리** | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 171–172 | 196–197 | `findAllShouldProduceAllVideos()`, `findByNameShouldRetrieveOneEntry()`와 `extracting()`·`containsExactlyInAnyOrder()` | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 172–173 | 197–198 | 왜 `VideoEntity` 객체로 단언하지 않는가 — `id`가 `saveAll()`에서 채워지기 때문 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 173 | 198 | `findByNameOrDescriptionShouldFindTwo()`, `ORDER BY` 없이는 순서를 보장하지 않으므로 순서를 확인하지 않음 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 173–174 | 198–199 | 필드 주입 vs 생성자 주입 — 테스트 클래스에서는 필드 주입이 괜찮은 이유(생명주기를 JUnit이 관리) | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 174 | 199 | `delete()` 테스트는 뒤 절로 미룸, 그리고 결정적 질문: **운영 DB가 내장형이 아니라면?** SQL 표준의 빈틈·방언·인덱싱·대소문자·트랜잭션 차이 | [[05-testing-repositories-with-embedded-databases]] | 반영 |
| 174–175 | 199–200 | Docker(2013)와 컨테이너화, Testcontainers(2015)가 하는 일: 컨테이너 기동→테스트→종료 자동화 | [[06-adding-testcontainers]] | 반영 |
| 175 | 200 | Initializr에서 Testcontainers·PostgreSQL Driver 선택, `testcontainers.version` 프로퍼티 `2.0.3` | [[06-adding-testcontainers]] | 반영 |
| 175–176 | 200–201 | 의존성 4개(`postgresql` runtime, `spring-boot-testcontainers` test, `testcontainers-junit-jupiter`, `testcontainers-postgresql`)와 각각의 역할 | [[06-adding-testcontainers]] | 반영 |
| 176–177 | 201–202 | Testcontainers가 여러 모듈로 나뉘어 독립 릴리스된다는 사실, `testcontainers-bom`과 `pom`·`import`의 의미 | [[06-adding-testcontainers]] | 반영 |
| 177–178 | 202–203 | `VideoRepositoryTestcontainersTest` 골격: `@Testcontainers`, `@DataJpaTest`, `@AutoConfigureTestDatabase(replace=NONE)`, `@TestPropertySource(ddl-auto=create-drop)`, `@Container`, `@ServiceConnection`, `static PostgreSQLContainer`, 항목별 8개 설명 | [[07-testing-repositories-with-testcontainers]] | 반영 |
| 178–179 | 203–204 | `@BeforeEach setUp()`으로 매 테스트마다 데이터 재적재, 다른 데이터 시나리오는 다른 테스트 클래스로 | [[07-testing-repositories-with-testcontainers]] | 반영 |
| 179 | 204 | `findAllShouldProduceAllVideos()`가 사실상 Spring Data JPA 테스트에 가깝다는 자평, **스모크 테스트** 개념 | [[07-testing-repositories-with-testcontainers]] | 반영 |
| 179–180 | 204–205 | `findByName()`, `findByNameOrDescription()` — 실제 PostgreSQL 대상 검증, 긴 메서드 이름이 Query by Example을 부른다는 자평 | [[07-testing-repositories-with-testcontainers]] | 반영 |
| 180 | 205 | 실행 결과(Figure 5.6), 이 전술이 RabbitMQ·Kafka·Redis·Hazelcast 등 어디에나 통한다는 확장 | [[07-testing-repositories-with-testcontainers]] | 반영 |
| 181 | 206 | 앞에서 `@WithMockUser`를 이미 썼는데 왜 또 하는가 — `@WebMvcTest`는 기본적으로 보안 정책이 적용되지만 **모든 경로를 덮지는 않았다** | [[08-testing-security-policies]] | 반영 |
| 181 | 206 | `SecurityBasedTest` 골격과 `SecurityConfig`의 규칙 목록 | [[08-testing-security-policies]] | 반영 |
| 182 | 207 | 미인증 사용자 거부 테스트, `status().isUnauthorized()`, 테스트 이름 `unauthUserShouldNotAccessHomePage` | [[08-testing-security-policies]] | 반영 |
| 182 | 207 | Note: 인증(authentication) vs 인가(authorization), 401 Unauthorized와 403 Forbidden 용어의 어긋남 | [[08-testing-security-policies]] | 반영 |
| 183 | 208 | 긍정 경로 테스트 `authUserShouldAccessHomePage()`, 역할별로 별도 테스트가 필요한 이유, `adminShouldAccessHomePage()` | [[08-testing-security-policies]] | 반영 |
| 184 | 209 | `newVideoFromUnauthUserShouldFail()`, `with(csrf())`를 넣고도 401이 나는 것이 정답 | [[08-testing-security-policies]] | 반영 |
| 184 | 209 | Note: 테스트에는 HTML로 렌더된 CSRF 토큰이 없으므로 `csrf()`로 공급해야 CSRF를 끄지 않고 검증할 수 있다 | [[08-testing-security-policies]] | 반영 |
| 185 | 210 | `newVideoFromUserShouldWork()`, `is3xxRedirection()`이 `isFound()`보다 덜 깨지는 이유, 보안 테스트의 요지 | [[08-testing-security-policies]] | 반영 |
| 185 | 210 | Summary: 도메인→서비스→컨트롤러→리포지토리→보안으로 올라간 순서와 트레이드오프 | [[_map]] | 반영 |

## 2. 코드 예제 커버리지

| # | 원문 예제 (책 쪽) | 노트 | 설명 보강 |
|---:|---|---|---|
| 1 | `CoreDomainTest.newVideoEntityShouldHaveNullId()` (155) | [[02-testing-domain-objects]] | 이름 규약, `assertThat` 유창한 API, `id == null`이 뜻하는 것 |
| 2 | `toStringShouldAlsoBeTested()` (158) | [[02-testing-domain-objects]] | 왜 별도 메서드로 쪼개는가 |
| 3 | `settersShouldMutateState()` (159) | [[02-testing-domain-objects]] | 상태 변경 검증과 엔티티 가변성의 연결 |
| 4 | `HomeControllerTest` + `indexPageHasSeveralHtmlForms()` (162) | [[03-testing-web-controllers-with-mockmvc]] | 슬라이스 범위 제한, 목 주입, 인증 시뮬레이션 |
| 5 | `postNewVideoShouldWork()` (163) | [[03-testing-web-controllers-with-mockmvc]] | CSRF 토큰 공급, 리다이렉트 단언, 행위 검증 |
| 6 | `SecurityConfig` 규칙 발췌 (181) | [[08-testing-security-policies]] | 규칙 한 줄이 테스트 세 개를 부르는 이유 |
| 7 | `VideoServiceTest` 골격 (165) | [[04-testing-services-with-mocks]] | `MockitoExtension`과 수동 생성자 조립 |
| 8 | `getVideosShouldReturnAll()` (166) | [[04-testing-services-with-mocks]] | given·when·then 3단 구조 |
| 9 | `creatingANewVideoShouldReturnTheSameData()` (167) | [[04-testing-services-with-mocks]] | `given()`·`any()` 매처 |
| 10 | `deletingAVideoShouldWork()` (169) | [[04-testing-services-with-mocks]] | 왜 여기서는 `verify()`여야 하는가 |
| 11 | HSQLDB Maven 좌표 (170) | [[05-testing-repositories-with-embedded-databases]] | `runtime` scope의 의미 |
| 12 | `VideoRepositoryHsqlTest` 골격 (170) | [[05-testing-repositories-with-embedded-databases]] | `@DataJpaTest`가 켜는 것과 안 켜는 것 |
| 13 | `findAllShouldProduceAllVideos()` (171) | [[05-testing-repositories-with-embedded-databases]] | 최소 단언의 한계 |
| 14 | `findByNameShouldRetrieveOneEntry()` (172) | [[05-testing-repositories-with-embedded-databases]] | `extracting()`과 순서 무관 단언 |
| 15 | `findByNameOrDescriptionShouldFindTwo()` (173) | [[05-testing-repositories-with-embedded-databases]] | 순서를 단언하지 않는 이유 |
| 16 | `testcontainers.version` 프로퍼티 (175) | [[06-adding-testcontainers]] | BOM 버전을 한곳에 두는 이유 |
| 17 | Testcontainers 의존성 4개 (175) | [[06-adding-testcontainers]] | 각 아티팩트의 역할과 scope |
| 18 | `testcontainers-bom` `dependencyManagement` (176) | [[06-adding-testcontainers]] | `pom` type과 `import` scope의 정확한 의미 |
| 19 | `VideoRepositoryTestcontainersTest` 골격 (177) | [[07-testing-repositories-with-testcontainers]] | 애노테이션 8개가 각각 무엇을 막고 여는지 |
| 20 | `@BeforeEach setUp()` (178) | [[07-testing-repositories-with-testcontainers]] | `static` 컨테이너 + 매 테스트 데이터 재적재의 조합 |
| 21 | `findAllShouldProduceAllVideos()` (179) | [[07-testing-repositories-with-testcontainers]] | 스모크 테스트의 자리 |
| 22 | `findByName()` / `findByNameOrDescription()` (179–180) | [[07-testing-repositories-with-testcontainers]] | HSQLDB판과 같은 시나리오를 실제 DB로 다시 검증하는 의미 |
| 23 | `SecurityBasedTest` 골격 (181) | [[08-testing-security-policies]] | `@WebMvcTest`가 보안 정책을 켠 채로 온다는 사실 |
| 24 | 미인증 거부 테스트 (182) | [[08-testing-security-policies]] | `@WithMockUser` **부재**가 곧 설정이라는 점 |
| 25 | `authUserShouldAccessHomePage()` / `adminShouldAccessHomePage()` (183) | [[08-testing-security-policies]] | 역할마다 테스트가 필요한 이유 |
| 26 | `newVideoFromUnauthUserShouldFail()` (184) | [[08-testing-security-policies]] | CSRF를 갖추고도 실패해야 정답인 이유 |
| 27 | `newVideoFromUserShouldWork()` (185) | [[08-testing-security-policies]] | `is3xxRedirection()`이 덜 깨지는 단언인 이유 |

## 3. Tip·Note 커버리지

원문 박스는 10개다.

| # | 종류 | 책 쪽 | 내용 | 노트 |
|---:|---|---:|---|---|
| 1 | Note | 154 | 이 장의 소스는 저장소 `ch5` 폴더 | [[01-junit-6-and-focused-test-starters]] |
| 2 | Tip | 155 | JUnit 6 기본, JUnit 5 테스트는 대부분 그대로, JUnit 4는 레거시 | [[01-junit-6-and-focused-test-starters]] |
| 3 | Note | 159 | 단언을 별도 테스트 메서드로 쪼개는 이유 | [[02-testing-domain-objects]] |
| 4 | Tip | 163 | Boot 4의 `@WebMvcTest` import 경로 변경과 `@MockBean` → `@MockitoBean` | [[03-testing-web-controllers-with-mockmvc]] |
| 5 | Note | 165 | 단위 테스트 vs 통합 테스트의 트레이드오프 | [[04-testing-services-with-mocks]] |
| 6 | Tip | 167 | given·when·then 주석 관례와 "단언이 많으면 쪼개라"는 신호 | [[04-testing-services-with-mocks]] |
| 7 | Note | 168 | 상태 검증과 행위 검증, 둘 다 쓸 수 있다 | [[04-testing-services-with-mocks]] |
| 8 | Note | 170 | 인메모리 DB는 "애플리케이션과 같은 메모리 공간"에서 도는 것 | [[05-testing-repositories-with-embedded-databases]] |
| 9 | Note | 182 | 인증 vs 인가, 401·403 용어의 어긋남 | [[08-testing-security-policies]] |
| 10 | Note | 184 | 테스트에서 CSRF 토큰을 공급해야 CSRF를 끄지 않고 검증할 수 있다 | [[08-testing-security-policies]] |

## 4. Figure 커버리지와 이미지 판단

`pdfimages -f 178 -l 210 -list` 결과 raster 이미지 6개가 있고 Figure 5.1–5.6과 정확히 일치한다.

| Figure | 책 쪽 | PDF 쪽 | 내용 | 처리 | 노트 |
|---|---:|---:|---|---|---|
| 5.1 | 157 | 182 | 테스트 클래스 우클릭 → 실행 | 미추출 — IDE 메뉴 스크린샷. 본문이 동작을 그대로 서술 | — |
| 5.2 | 157 | 182 | 테스트 결과(초록 체크) | 미추출 — 본문이 "49밀리초"를 언급하는데 **그 값은 그림에 잘려 없다**고 스스로 밝힌다 | — |
| 5.3 | 160 | 185 | 커버리지로 실행하기 | 미추출 — IDE 메뉴 스크린샷 | — |
| **5.4** | **161** | **186** | IntelliJ 커버리지 하이라이팅 | **추출** — 초록/빨강 gutter, Coverage 패널, `VideoEntity` 전체 소스가 함께 보인다. "protected 무인자 생성자만 미커버"라는 서술의 **증거**이자, 이 장의 `VideoEntity`가 Chapter 3판과 달리 `username` 필드를 갖는다는 사실도 드러난다 | [[02-testing-domain-objects]] |
| 5.5 | 164 | 189 | `HomeControllerTest` 결과 | 미추출 — Figure 5.6과 같은 결과 패널 장르이며 본문이 "sub-second"라고만 요약 | — |
| **5.6** | **180** | **205** | Testcontainers 테스트 결과 | **추출** — 460ms 총계 중 `findAllShouldProduceAllVideos()` 하나가 401ms를 차지한다. **컨테이너 기동 비용이 첫 테스트에 몰린다**는 사실을 숫자로 보여 준다 | [[07-testing-repositories-with-testcontainers]] |

추출한 2개는 `_assets/`에 두고 원본 페이지와 육안 대조했다. 나머지 4개를 뺀 기준은 CLAUDE.md의 "원본 화면 자체가 학습 대상일 때만 추출"이며, IDE 메뉴와 단순 통과 표시는 본문 서술로 충분하다고 판단했다.

## 5. 원문의 오류·불일치

| 구분 | 내용 | 노트의 처리 |
|---|---|---|
| **오류** | 책 p.182의 테스트 메서드 선언이 `void () throws Exception {` — **메서드 이름이 비어 있다.** 바로 뒤 본문이 "note the method name of the test: `unauthUserShouldNotAccessHomePage`"라고 밝히므로 조판 사고다 | [[08-testing-security-policies]]에서 올바른 이름으로 보완하고 사실을 명시 |
| **제목 불일치** | 절 제목은 *Testing data repositories with mocks*지만 실제 테스트 대상은 `VideoService`이고 리포지토리는 모킹되는 쪽이다 | [[04-testing-services-with-mocks]] 본문에서 명시 |
| **연속성** | 이 장의 `VideoEntity`는 `username` 필드와 3-인자 생성자를 갖고, `VideoService.create(NewVideo, String)` 시그니처를 쓴다. Chapter 3판(`id`·`name`·`description`)과 다르다 — Chapter 4의 소유권 도입 결과다 | [[02-testing-domain-objects]]에서 차이를 명시 |

## 6. 공식 문서 교차 확인에서 보강한 점

| 항목 | 책의 서술 | 노트의 보강 |
|---|---|---|
| `@WebMvcTest` import 경로 | Tip으로 변경 사실만 언급 | Chapter 15에서 정리한 "기술별 test starter" 재편의 일부임을 연결 |
| `@MockitoBean` | 개명 사실만 언급 | Chapter 15 기준으로 이것이 Spring Framework의 **빈 오버라이드 모델**로 통일된 결과이고 `@Configuration` 클래스에는 못 쓴다는 제약을 추가 |
| Testcontainers 2.x 좌표 | `testcontainers-junit-jupiter`·`testcontainers-postgresql`를 그대로 제시 | Chapter 15에서 확인한 artifact id 개명(`junit-jupiter`→`testcontainers-junit-jupiter`)의 결과임을 연결 |
| `@ServiceConnection` | "Boot 4 애노테이션"이라고만 서술 | 컨테이너의 접속 정보를 `DataSource` 설정으로 자동 연결하므로 `spring.datasource.*`를 손으로 쓸 필요가 없다는 동작을 명시 |

## 7. 완료 기준

- [x] 8개 상위 절이 전부 노트에 1:1 매핑됨 (하위 제목 없음을 확인)
- [x] 27개 코드 예제가 전부 반영되거나 의미가 보존된 형태로 재구성됨
- [x] Tip·Note 10건의 기술적 내용이 반영됨
- [x] Figure 6개 각각에 대해 추출·미추출 판단과 근거를 남김
- [x] 원문의 조판 오류 1건과 제목 불일치 1건을 노트에 명시

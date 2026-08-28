# Chapter 2 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 2 *Creating Web and API Applications with Spring Boot*, 책 pp. 25–69 / PDF pp. 50–94. PDF를 `pdftotext -layout -f 50 -l 94`로 새로 추출해 1,974줄 전체를 읽은 뒤, 실제 제목·하위 제목·코드·명령·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

책의 상위 절은 9개지만, `Leveraging templates to create content`와 `Hooking in Node.js to a Spring Boot web app`은 각각 독립적으로 설명해야 할 하위 절을 여러 개 가진다. Chapter 1에서 `03a/03b/03c`로 분리했던 것과 같은 기준으로 아래처럼 15개 노트로 나눴다.

| 노트 | 원문 절 | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-using-start-spring-io-to-build-apps]] | Using start.spring.io to build apps | 26–29 | 51–54 |
| [[02-creating-a-spring-mvc-web-controller]] | Creating a Spring MVC web controller | 30–31 | 55–56 |
| [[03-augmenting-an-existing-project-with-initializr]] | Using start.spring.io to augment an existing project | 31–33 | 56–58 |
| [[04-leveraging-templates-to-create-content]] | Leveraging templates to create content | 33–35 | 58–60 |
| [[04a-adding-demo-data-to-a-template]] | Adding demo data to a template | 35–37 | 60–62 |
| [[04b-building-our-app-with-a-better-design]] | Building our app with a better design | 37–39 | 62–64 |
| [[04c-injecting-dependencies-through-constructor-calls]] | Injecting dependencies through constructor calls | 39–40 | 64–65 |
| [[04d-changing-the-data-through-html-forms]] | Changing the data through HTML forms | 40–43 | 65–68 |
| [[05-creating-json-based-apis]] | Creating JSON-based APIs | 43–48 | 68–73 |
| [[06-integrating-nodejs-with-a-spring-boot-web-app]] | Hooking in Node.js to a Spring Boot web app | 48–50 | 73–75 |
| [[07-bundling-javascript-with-nodejs]] | Bundling JavaScript with Node.js | 50–52 | 75–77 |
| [[07a-creating-a-reactjs-app]] | Creating a React.js app | 52–58 | 77–83 |
| [[08-versioning-apis-with-spring-boot-4]] | Versioning API with Spring Boot 4 | 59–62 | 84–87 |
| [[09-calling-versioned-apis-with-http-service-clients]] | Calling versioned APIs with Spring Boot 4 | 62–65 | 87–90 |
| [[10-writing-null-safe-applications-with-jspecify]] | Writing null-safe applications with Spring Boot 4 | 65–69 | 90–94 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 25–26 | 50–51 | 장 도입: Chapter 1 복습, 이 장이 이후 장의 토대라는 선언, 다룰 9개 주제 목록, JSpecify 예고 | [[_map]] | 반영 |
| 26 | 51 | Spring Boot 이전 프로젝트 시작 방법 Option 1–4와 그 고통 | [[01-using-start-spring-io-to-build-apps]] | 반영 |
| 26–27 | 51–52 | Spring Initializr의 7가지 선택 항목 (Boot 버전·빌드 도구·좌표·Java 버전·모듈·Packaging·Properties/YAML) | [[01-using-start-spring-io-to-build-apps]] | 반영 |
| 27 | 52 | 빌드 도구 Maven/Gradle, 언어 Java/Kotlin/Groovy, Boot 4.1.0 선택 | [[01-using-start-spring-io-to-build-apps]] | 반영 |
| 28 | 53 | JAR vs WAR, "Make JAR not WAR" 인용, Java 25 선택과 Java 17 baseline | [[01-using-start-spring-io-to-build-apps]] | 반영 |
| 28–29 | 53–54 | Properties/YAML 선택 옵션, ADD DEPENDENCIES → Spring Web, GENERATE → ZIP | [[01-using-start-spring-io-to-build-apps]] | 반영 |
| 30 | 55 | web controller의 정의, Spring MVC와 servlet container, `spring-boot-starter-webmvc` | [[02-creating-a-spring-mvc-web-controller]] | 반영 |
| 30–31 | 55–56 | starter가 여는 것들, base package, `HomeController`와 `@Controller`/`@GetMapping`, logical view name | [[02-creating-a-spring-mvc-web-controller]] | 반영 |
| 31–32 | 56–57 | 6개월 된 기존 프로젝트에 기능을 더하는 문제, Initializr 재방문, Mustache 선택 | [[03-augmenting-an-existing-project-with-initializr]] | 반영 |
| 32–33 | 57–58 | EXPLORE 버튼과 GENERATE의 차이, `spring-boot-starter-mustache` 조각 복사 | [[03-augmenting-an-existing-project-with-initializr]] | 반영 |
| 33–34 | 58–59 | component scan이 컨트롤러를, 자동 구성이 Mustache 빈을 만든다. 템플릿 기본 위치 | [[04-leveraging-templates-to-create-content]] | 반영 |
| 34–35 | 59–60 | `index.mustache` 정적 HTML, IDE에서 실행, localhost:8080 확인 | [[04-leveraging-templates-to-create-content]] | 반영 |
| 35–36 | 60–61 | `record Video`, `List.of`, `Model` 파라미터, `model.addAttribute` | [[04a-adding-demo-data-to-a-template]] | 반영 |
| 36–37 | 61–62 | Mustache section `{{#videos}}`/`{{name}}`/`{{/videos}}`가 만드는 `<ul>` | [[04a-adding-demo-data-to-a-template]] | 반영 |
| 37–38 | 62–63 | 컨트롤러가 데이터 정의를 가지면 안 되는 두 가지 이유, `Video.java` 분리 | [[04b-building-our-app-with-a-better-design]] | 반영 |
| 38–39 | 63–64 | `VideoService`와 `@Service`, `getVideos()`, component scanning의 진가 | [[04b-building-our-app-with-a-better-design]] | 반영 |
| 39 | 64 | `HomeController`가 `VideoService`를 생성자로 받도록 전환 | [[04b-building-our-app-with-a-better-design]], [[04c-injecting-dependencies-through-constructor-calls]] | 반영 |
| 39–40 | 64–65 | constructor injection 정의, autowiring, Boot 이전의 `@Configuration`/`@Bean` 수동 배선, 주입 3가지 방법 | [[04c-injecting-dependencies-through-constructor-calls]] | 반영 |
| 40 | 65 | `index()`가 `videoService.getVideos()`를 호출하도록 변경 | [[04c-injecting-dependencies-through-constructor-calls]] | 반영 |
| 40–41 | 65–66 | HTML `<form>` 추가, `POST /new-video`, Mustache 문법이 필요 없는 이유 | [[04d-changing-the-data-through-html-forms]] | 반영 |
| 41 | 66 | `@PostMapping`, `@ModelAttribute`, `redirect:/`와 302 vs 301 | [[04d-changing-the-data-through-html-forms]] | 반영 |
| 41–42 | 66–67 | `List.of` 결과의 `add()`가 `UnsupportedOperationException`을 던지는 이유, copy-on-write식 `create()` | [[04d-changing-the-data-through-html-forms]] | 반영 |
| 43 | 68 | 폼 제출 → redirect → 재조회로 목록이 갱신되는 흐름 | [[04d-changing-the-data-through-html-forms]] | 반영 |
| 43–44 | 68–69 | Spring Web이 Jackson을 클래스패스에 올린다, `@RestController`가 바꾸는 한 가지 | [[05-creating-json-based-apis]] | 반영 |
| 44–45 | 69–70 | `ApiController`, `all()`, Jackson이 만든 JSON 배열 | [[05-creating-json-based-apis]] | 반영 |
| 45–46 | 70–71 | HTTP verb의 safe·idempotent 의미, `@PostMapping` + `@RequestBody` | [[05-creating-json-based-apis]] | 반영 |
| 46–48 | 71–73 | curl POST 명령의 옵션별 의미, verbose 응답 해석, 재조회로 검증, 사람용/기계용 이중 표현 | [[05-creating-json-based-apis]] | 반영 |
| 48–49 | 73–74 | Java와 JavaScript 도구 세계의 간극, `frontend-maven-plugin`, `src/main/resources/static` 자동 서빙 | [[06-integrating-nodejs-with-a-spring-boot-web-app]] | 반영 |
| 49–50 | 74–75 | plugin 설정, `install-node-and-npm` goal, `generate-resources` phase, 실제 콘솔 출력, `node` 폴더 | [[06-integrating-nodejs-with-a-spring-boot-web-app]] | 반영 |
| 50–51 | 75–76 | `npm install --save-dev parcel`, `npm install` execution 추가 | [[07-bundling-javascript-with-nodejs]] | 반영 |
| 51–52 | 76–77 | `package.json`의 `source`와 `targets.default.distDir`, npm vs npx, `npx parcel build` execution | [[07-bundling-javascript-with-nodejs]] | 반영 |
| 52–53 | 77–78 | `react`/`react-dom` 설치, `index.js` 엔트리, `createRoot`, top-down 렌더링, shadow DOM | [[07a-creating-a-reactjs-app]] | 반영 |
| 53–54 | 78–79 | `App.js`, JSX와 Parcel, JSX에 대한 Note | [[07a-creating-a-reactjs-app]] | 반영 |
| 54–55 | 79–80 | `ListOfVideos.js`, ES6 class, state, `componentDidMount`, `fetch`, `setState`, `render`의 `map` | [[07a-creating-a-reactjs-app]] | 반영 |
| 55–56 | 80–81 | state vs properties의 구분과 immutability | [[07a-creating-a-reactjs-app]] | 반영 |
| 56–57 | 81–82 | `NewVideo.js`, `bind`, `preventDefault`, `async`/`await`, `fetch` POST | [[07a-creating-a-reactjs-app]] | 반영 |
| 57–58 | 82–83 | `react.mustache`의 mount point와 `type="module"`, `@GetMapping("/react")`, React가 값을 하는 조건, static vs 생성 자산 | [[07a-creating-a-reactjs-app]] | 반영 |
| 59 | 84 | API를 계약으로 보는 관점, 버전 전략 4가지의 장단점 | [[08-versioning-apis-with-spring-boot-4]] | 반영 |
| 59–60 | 84–85 | Spring Boot 4 이전의 수동 처리, `version` 속성, path 버전 예제와 `use.path-segment` | [[08-versioning-apis-with-spring-boot-4]] | 반영 |
| 60–61 | 85–86 | header·query parameter·media type 전략의 property와 curl | [[08-versioning-apis-with-spring-boot-4]] | 반영 |
| 61 | 86 | `apiversion.required`, `apiversion.detect-supported`, 전략 하나만 고르라는 Note | [[08-versioning-apis-with-spring-boot-4]] | 반영 |
| 62 | 87 | 소비자 관점의 버전, `spring-boot-starter-restclient`, RestClient vs WebClient | [[09-calling-versioned-apis-with-http-service-clients]] | 반영 |
| 63 | 88 | `VideoClient` 인터페이스, `@HttpExchange`, `@GetExchange(version=...)` | [[09-calling-versioned-apis-with-http-service-clients]] | 반영 |
| 63–64 | 88–89 | `@ImportHttpServices`, `RestClientHttpServiceGroupConfigurer`, `ApiVersionInserter` 4종 | [[09-calling-versioned-apis-with-http-service-clients]] | 반영 |
| 64–65 | 89–90 | `ApiClientController`, 같은 URI에 version으로 갈리는 두 handler, curl 검증 | [[09-calling-versioned-apis-with-http-service-clients]] | 반영 |
| 65–66 | 90–91 | nullability가 암묵적이던 과거, JSpecify 도입, 애노테이션 4종의 역할 | [[10-writing-null-safe-applications-with-jspecify]] | 반영 |
| 66–67 | 91–92 | `getFirstVideosByName`의 계약 위반, IDE 경고 2종 | [[10-writing-null-safe-applications-with-jspecify]] | 반영 |
| 67–68 | 92–93 | `package-info.java`의 `@NullMarked`, subpackage 비상속, generic 인자와 `List<@Nullable VideoV2>`, `record VideoV2` | [[10-writing-null-safe-applications-with-jspecify]] | 반영 |
| 69 | 94 | Summary: 이 장이 만든 것 정리와 Chapter 3 예고 | [[_map]] | 반영 |

## 2. 코드·명령·설정 예제 커버리지

| # | 원문 예제 (책 쪽) | 노트 | 설명 보강 |
|---:|---|---|---|
| 1 | `spring-boot-starter-webmvc` Maven 의존성 (30) | [[02-creating-a-spring-mvc-web-controller]] | Boot 4에서 `starter-web`이 아니라 `starter-webmvc`인 이유, 전이 의존성 구성 |
| 2 | `HomeController` + `@Controller` + `@GetMapping("/")` (31) | [[02-creating-a-spring-mvc-web-controller]] | 애노테이션별 책임, 반환 문자열이 뷰 이름으로 해석되는 경로 |
| 3 | `spring-boot-starter-mustache` Maven 의존성 (33) | [[03-augmenting-an-existing-project-with-initializr]] | EXPLORE로 얻는 것과 손으로 적을 때의 위험 차이 |
| 4 | `index.mustache` 정적 HTML5 (34) | [[04-leveraging-templates-to-create-content]] | 뷰 이름 → 파일 경로 변환 규칙과 확장자 |
| 5 | `record Video` + `List.of` + `Model` (35) | [[04a-adding-demo-data-to-a-template]] | record를 쓰는 이유, `Model`이 optional 파라미터인 이유 |
| 6 | Mustache `{{#videos}}` `{{name}}` `{{/videos}}` (36) | [[04a-adding-demo-data-to-a-template]] | section 문법이 반복으로 해석되는 조건, `.` 없는 이름 해석 |
| 7 | `record Video(String name) {}` 단독 파일 (37) | [[04b-building-our-app-with-a-better-design]] | package-private 기본 가시성의 의미 |
| 8 | `VideoService` + `@Service` + `getVideos()` (38) | [[04b-building-our-app-with-a-better-design]] | `@Service`가 `@Component`와 다른 점, 계층 분리의 이유 |
| 9 | `HomeController` 생성자 주입 (39) | [[04c-injecting-dependencies-through-constructor-calls]] | 단일 생성자 규칙, `final` 필드가 주는 보장 |
| 10 | `index()`가 `videoService.getVideos()` 호출 (40) | [[04c-injecting-dependencies-through-constructor-calls]] | 변경 지점이 한 줄로 줄어든 이유 |
| 11 | HTML `<form action="/new-video" method="post">` (40) | [[04d-changing-the-data-through-html-forms]] | 브라우저가 만드는 요청 형식과 `Content-Type` |
| 12 | `@PostMapping` + `@ModelAttribute` + `redirect:/` (41) | [[04d-changing-the-data-through-html-forms]] | PRG 흐름, 302와 301의 차이, 새로고침 재전송 문제 |
| 13 | `create()`의 `new ArrayList<>` → `add` → `List.copyOf` (42) | [[04d-changing-the-data-through-html-forms]] | 불변 컬렉션을 "바꾸는" 유일한 방법과 원자성 한계 |
| 14 | `ApiController` + `@RestController` + `all()` (44) | [[05-creating-json-based-apis]] | `@Controller`와 갈리는 지점이 정확히 어디인지 |
| 15 | curl로 받은 JSON 배열 3건 (45) | [[05-creating-json-based-apis]] | record 필드 하나가 JSON 키 하나가 되는 규칙 |
| 16 | `@PostMapping` + `@RequestBody` (46) | [[05-creating-json-based-apis]] | `@ModelAttribute`와의 결정적 차이 |
| 17 | `curl -v -X POST ... -d ... -H 'Content-type:application/json'` (46) | [[05-creating-json-based-apis]] | 옵션별 역할과 헤더가 없으면 생기는 일 |
| 18 | curl verbose 응답 (47) | [[05-creating-json-based-apis]] | 요청/응답 줄 읽는 법, 200과 Content-Type 확인 |
| 19 | 재조회 `curl localhost:8080/api/videos` 4건 (48) | [[05-creating-json-based-apis]] | 상태 변화가 실제로 반영됐는지 검증하는 절차 |
| 20 | `frontend-maven-plugin` `<plugin>` 블록 (49) | [[06-integrating-nodejs-with-a-spring-boot-web-app]] | goal·phase·nodeVersion의 역할과 프로젝트 로컬 설치의 의미 |
| 21 | `./mvnw generate-resources` 콘솔 출력 (49–50) | [[06-integrating-nodejs-with-a-spring-boot-web-app]] | 다운로드·압축 해제·복사 3단계를 로그에서 확인하는 법 |
| 22 | `node/npm install --save-dev parcel` (50) | [[07-bundling-javascript-with-nodejs]] | `node/npm` 경로의 의미, `--save-dev`가 가르는 것 |
| 23 | `npm install` execution 추가 (51) | [[07-bundling-javascript-with-nodejs]] | 손으로 친 명령을 빌드에 고정하는 이유 |
| 24 | `package.json`의 `source`·`targets.default.distDir` (51) | [[07-bundling-javascript-with-nodejs]] | `target/classes/static`이 정답인 이유와 clean 사이클 |
| 25 | `npx run` execution + `parcel build` (52) | [[07-bundling-javascript-with-nodejs]] | npm과 npx의 역할 분리, 실행 순서 |
| 26 | `node/npm install --save react react-dom` (52) | [[07a-creating-a-reactjs-app]] | `--save`와 `--save-dev`의 배포 의미 차이 |
| 27 | `index.js` 엔트리 (52–53) | [[07a-creating-a-reactjs-app]] | mount point 탐색과 `createRoot`의 역할 |
| 28 | `App.js` (53) | [[07a-creating-a-reactjs-app]] | JSX가 Parcel에게 주는 신호 |
| 29 | `ListOfVideos.js` (54–55) | [[07a-creating-a-reactjs-app]] | 생명주기 훅 → fetch → setState → 재렌더 루프 |
| 30 | `NewVideo.js` (56) | [[07a-creating-a-reactjs-app]] | `bind`가 필요한 이유, `preventDefault`가 막는 것 |
| 31 | `react.mustache` (57) | [[07a-creating-a-reactjs-app]] | 서버 템플릿이 SPA의 부트스트랩만 담당하는 구조 |
| 32 | `@GetMapping("/react")` (58) | [[07a-creating-a-reactjs-app]] | 같은 백엔드가 두 표현을 함께 서빙하는 경로 |
| 33 | `@GetMapping(value = "/api/{version}/videos", version = "1"/"2")` (59–60) | [[08-versioning-apis-with-spring-boot-4]] | `{version}` placeholder와 논리 버전의 관계 |
| 34 | `spring.mvc.apiversion.use.path-segment=1` (60) | [[08-versioning-apis-with-spring-boot-4]] | zero-based segment index 계산, 공식 문서의 타입 확인 |
| 35 | `curl .../api/v1/videos`, `/api/v2/videos` (60) | [[08-versioning-apis-with-spring-boot-4]] | URL만 보고 버전을 알 수 있다는 장단점 |
| 36 | `use.header=API-Version` + `apiversion.default=1` (60) | [[08-versioning-apis-with-spring-boot-4]] | default가 있을 때 없을 때의 라우팅 차이 |
| 37 | header 방식 curl 2종 (60–61) | [[08-versioning-apis-with-spring-boot-4]] | URL 불변이라는 성질이 캐시·링크에 주는 영향 |
| 38 | `use.query-parameter=version` + curl (61) | [[08-versioning-apis-with-spring-boot-4]] | 쓰기 쉬움과 공개 API 부적합의 이유 |
| 39 | `use.media-type-parameter[application/json]=version` + curl (61) | [[08-versioning-apis-with-spring-boot-4]] | Accept 파라미터 문법과 verbose함의 대가 |
| 40 | `spring-boot-starter-restclient` (62) | [[09-calling-versioned-apis-with-http-service-clients]] | RestClient가 Boot 4 동기 호출 기본인 이유 |
| 41 | `VideoClient` 인터페이스 (63) | [[09-calling-versioned-apis-with-http-service-clients]] | 선언만 있고 구현이 없는 코드가 동작하는 방식 |
| 42 | `VideoClientConfig` (63–64) | [[09-calling-versioned-apis-with-http-service-clients]] | proxy 생성 시점, group 개념, 공식 property 대안 추가 |
| 43 | `ApiVersionInserter` 4종 (64) | [[09-calling-versioned-apis-with-http-service-clients]] | 서버 전략과 클라이언트 전략이 짝을 이뤄야 하는 이유 |
| 44 | `ApiClientController` (64–65) | [[09-calling-versioned-apis-with-http-service-clients]] | 같은 URI가 version으로 갈리는 서버·클라이언트 이중 구조 |
| 45 | `curl .../client-test -H 'API-Version: 1'/'2'` (65) | [[09-calling-versioned-apis-with-http-service-clients]] | 버전 전파를 눈으로 확인하는 절차 |
| 46 | `@NonNull Video getFirstVideosByName(@NonNull String)` (66) | [[10-writing-null-safe-applications-with-jspecify]] | 계약 위반이 컴파일이 아니라 검사기에서 잡히는 이유 |
| 47 | `package-info.java`의 `@NullMarked` (67) | [[10-writing-null-safe-applications-with-jspecify]] | 기본값 뒤집기, subpackage 비상속의 실무 함정 |
| 48 | `List<VideoV2>` 기본 non-null (68) | [[10-writing-null-safe-applications-with-jspecify]] | `@NullMarked` 범위가 generic 인자까지 미치는 경로 |
| 49 | `List<@Nullable VideoV2>` (68) | [[10-writing-null-safe-applications-with-jspecify]] | 컨테이너와 원소의 nullability가 별개인 이유 |
| 50 | `record VideoV2(String name, @Nullable String description)` (68) | [[10-writing-null-safe-applications-with-jspecify]] | 원소 허용이 필드 허용으로 번지지 않음 |

## 3. Tip·Note·인용 커버리지

| # | 종류 | 책 쪽 | 내용 | 노트 |
|---:|---|---:|---|---|
| 1 | Note | 26 | 이 장의 코드는 저장소 `ch2` 폴더에 있다 | [[01-using-start-spring-io-to-build-apps]] |
| 2 | Note | 27 | start.spring.io는 새 Boot 릴리스에 맞춰 스스로 갱신된다 | [[01-using-start-spring-io-to-build-apps]] |
| 3 | 인용 | 28 | "Make JAR not WAR" — Josh Long (@starbuxman) | [[01-using-start-spring-io-to-build-apps]] |
| 4 | Tip | 29 | IDE는 무엇이든 좋다 (IntelliJ IDEA, VS Code, Spring Tool Suite) | [[01-using-start-spring-io-to-build-apps]] |
| 5 | Tip | 31 | 클래스·메서드 이름은 의미가 드러나게 짓는다 | [[02-creating-a-spring-mvc-web-controller]] |
| 6 | Tip | 33 | 웹 UI 외에 `spring init` CLI로도 같은 일을 스크립트로 할 수 있다 | [[03-augmenting-an-existing-project-with-initializr]] |
| 7 | Tip | 34 | 템플릿 기본 위치와 엔진별 확장자, 뷰 이름 → 파일 변환, 관례를 따르는 편이 낫다 | [[04-leveraging-templates-to-create-content]] |
| 8 | Tip | 35 | 값 하나에도 record를 쓰는 이유: 이름 있는 속성과 타입 안전성 | [[04a-adding-demo-data-to-a-template]] |
| 9 | Tip | 36–37 | Mustache는 getter를 쓰지만 record의 `name()`도 처리한다 | [[04a-adding-demo-data-to-a-template]] |
| 10 | Note | 38 | `Video` record가 public이 아닌 이유 — Java 기본 가시성은 package-private | [[04b-building-our-app-with-a-better-design]] |
| 11 | Tip | 38–39 | component scanning이 빛나는 지점: `@Component` 계열 → 인스턴스화 → 컨텍스트 등록 → autowire | [[04b-building-our-app-with-a-better-design]] |
| 12 | Note | 42 | 불변 리스트는 일관성은 주지만 thread-safe하지는 않다 | [[04d-changing-the-data-through-html-forms]] |
| 13 | Note | 43 | Dave Syer, *The Joy of Mustache: Server Side Templates for the JVM* | [[04d-changing-the-data-through-html-forms]] |
| 14 | Note | 45–46 | HTTP verb GET/POST/PUT/DELETE의 safe·idempotent 의미와 응답 관례 | [[05-creating-json-based-apis]] |
| 15 | Tip | 46 | curl은 웹 API를 다루는 표준 명령행 도구다 | [[05-creating-json-based-apis]] |
| 16 | Tip | 50 | `node`·`node_modules`는 중간 산출물이므로 `.gitignore`에 넣는다 | [[06-integrating-nodejs-with-a-spring-boot-web-app]] |
| 17 | Note | 54 | JSX는 HTML과 JavaScript를 섞는다는 과거의 금기를 뒤집은 설계다 | [[07a-creating-a-reactjs-app]] |
| 18 | Note | 61 | 애플리케이션당 버전 전략은 하나만. default는 path 방식에는 적용되지 않는다 | [[08-versioning-apis-with-spring-boot-4]] |
| 19 | Note | 66 | JSpecify는 `Optional`을 대체하지 않고 보완한다 | [[10-writing-null-safe-applications-with-jspecify]] |
| 20 | Note | 68 | IDE 검사는 즉시성만 준다. 빌드 강제는 NullAway + Error Prone | [[10-writing-null-safe-applications-with-jspecify]] |

## 4. Figure 커버리지와 이미지 판단

`pdfimages -f 50 -l 94 -list` 결과 Chapter 2의 PDF 페이지에는 raster 이미지 15개가 있었다. 이 중 13개가 Figure 2.1–2.13이고, PDF p.94의 2개는 Packt 혜택 안내용 QR·로고라 학습 대상이 아니다.

판단 기준은 deep-tutor `references/figures.md`의 Q3 — "원본이 그리는 대상이 아니라 찍는 대상인가". Chapter 2의 Figure는 전부 Initializr 웹 UI, 브라우저 렌더 결과, IDE 경고 팝업의 **스크린샷**이라 재현이라는 선택지가 없다. 다만 같은 UI 패턴이 반복되는 것은 하나만 남겼다.

| Figure | 책 쪽 | PDF 쪽 | 내용 | 처리 | 노트 |
|---|---:|---:|---|---|---|
| 2.1 | 27 | 52 | Initializr의 Project·Language·Spring Boot 선택 | 추출 | [[01-using-start-spring-io-to-build-apps]] |
| 2.2 | 28 | 53 | Project Metadata·Packaging·Configuration·Java | 추출 | [[01-using-start-spring-io-to-build-apps]] |
| 2.3 | 29 | 54 | ADD DEPENDENCIES 필터에서 Spring Web이 올라온 화면 | 추출 | [[01-using-start-spring-io-to-build-apps]] |
| 2.4 | 29 | 54 | GENERATE 버튼 | 추출 | [[01-using-start-spring-io-to-build-apps]] |
| 2.5 | 32 | 57 | ADD DEPENDENCIES 필터에서 Mustache 선택 | 미추출 — Figure 2.3과 같은 UI 패턴 | — |
| 2.6 | 32 | 57 | EXPLORE 버튼 | 추출 | [[03-augmenting-an-existing-project-with-initializr]] |
| 2.7 | 34 | 59 | 정적 Mustache 템플릿 렌더 결과 | 추출 (기존 `assets/` 파일을 PDF p.59와 SHA-1 대조해 동일함을 확인한 뒤 `_assets/`로 이동) | [[04-leveraging-templates-to-create-content]] |
| 2.8 | 37 | 62 | 비디오 목록 `<ul>`이 붙은 페이지 | 추출 | [[04a-adding-demo-data-to-a-template]] |
| 2.9 | 43 | 68 | 목록 + HTML 폼이 있는 페이지 | 추출 | [[04d-changing-the-data-through-html-forms]] |
| 2.10 | 62 | 87 | ADD DEPENDENCIES 필터에서 Http Client 선택 | 미추출 — Figure 2.3과 같은 UI 패턴 | — |
| 2.11 | 62 | 87 | EXPLORE 버튼 (재등장) | 미추출 — Figure 2.6과 동일 | — |
| 2.12 | 67 | 92 | `@NonNull` 반환 계약 위반에 대한 IDE 경고 | 추출 | [[10-writing-null-safe-applications-with-jspecify]] |
| 2.13 | 67 | 92 | `@NonNull` 파라미터에 null 가능 인자를 넘길 때의 IDE 경고 | 추출 | [[10-writing-null-safe-applications-with-jspecify]] |
| — | — | 94 | Packt QR 코드·로고 | 미추출 — 학습 본문이 아님 | — |

추출한 10개는 모두 `_assets/`에 두고 원본 페이지와 육안 대조했다. 잘림·해상도·대상 페이지 일치를 확인했으며, Figure 2.13에서는 책 본문 리스팅에 없는 `@GetMapping("/api/videos/get-first-by-name")` 컨트롤러 메서드가 함께 보여 노트에서 그 사실을 명시했다.

개념 관계 도표는 스크린샷으로 대체할 수 없으므로 밝은 배경 Mermaid와 비교표로 별도 재구성했다.

## 5. 공식 문서 교차 확인에서 보강한 점

PDF가 서술 순서의 1차 기준이고, Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)는 버전 민감한 동작을 확인하는 보조 근거로만 사용했다.

| 항목 | 책의 서술 | 노트의 보강 |
|---|---|---|
| `spring-boot-starter-webmvc` | 이름만 제시 | Boot 4에서 `spring-boot-starter-web`을 대체한 starter이며 `spring-boot-starter-jackson`·`spring-boot-starter-tomcat`·`spring-boot-http-converter`·`spring-boot-webmvc`를 묶는다는 구성 확인 |
| "Spring Web을 넣으면 Jackson이 딸려 온다" | 결과만 서술 | `spring-boot-starter-webmvc` → `spring-boot-starter-jackson` 전이 의존성이라는 경로를 명시 |
| `spring.mvc.apiversion.use.path-segment` | "두 번째 segment" | 공식 property 타입이 `Integer` index이고 zero-based임을 확인해 진리표로 정리 |
| 버전 관련 property 목록 | `required`, `detect-supported`만 언급 | 공식 `WebMvcProperties.Apiversion`에 `supported` 목록도 있어 `detect-supported=false`와 함께 쓰는 조합을 추가 |
| 버전 불일치 시 동작 | 언급 없음 | `required=true`인데 버전이 없으면 `MissingApiVersionException`, 지원 목록 밖이면 `InvalidApiVersionException`임을 추가 |
| HTTP Service Client 설정 | 프로그래밍 방식 configurer만 제시 | `spring.http.serviceclient.<group>.base-url` property 대안과 group 개념을 추가 |
| `@ImportHttpServices` | 클래스 나열 방식만 제시 | `group` 속성과 패키지 스캔 방식도 있음을 추가 |
| `src/main/resources/static` | 루트 경로에서 서빙된다고만 서술 | `spring.mvc.static-path-pattern`으로 경로 패턴을 바꿀 수 있고 `spring.web.resources.chain`으로 캐시 버스팅을 켤 수 있음을 경계로 추가 |

## 6. 완료 기준

- [x] 책의 모든 상위 절과 실제 하위 절이 최소 한 노트에 매핑됨
- [x] 50개 Java/HTML/JS/JSON/XML/properties/명령 예제가 전부 노트에 반영되거나 의미가 보존된 형태로 재구성됨
- [x] Tip·Note·인용 20건의 기술적 내용이 관련 노트에 반영됨
- [x] Figure 13개 각각에 대해 추출·미추출 판단과 근거를 남김
- [x] 버전 민감한 동작을 Spring Boot 4.1.0 공식 문서와 교차 확인함
- [x] PDF 내 raster 이미지 존재 여부를 `pdfimages -list`로 실제 검사함

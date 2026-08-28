# 검증 보고서와 현재 한계

검증일: 2026-08-27

## 결론

- **학습 대상인 Chapter 1–15 전부가 내용 상세 재작성과 검증을 마쳤다** (concept note **163개**).
- 압축 초안 상태로 남은 Chapter는 **없다.**

2026-08-27에 사용자가 지정한 순서(Ch3 → Ch15 → Ch5 → Ch4 → Ch6 → Ch13 → Ch7 → Ch11 → Ch14)를 끝냈고, 2026-08-28에 사용자의 추가 요청으로 마지막 네 Chapter(Ch8 → Ch9 → Ch10 → Ch12)를 같은 절차로 완료했다. Chapter 16은 출판사 혜택 안내라 학습 범위 밖이다.

과거의 “99개 노트 완료” 기록은 파일 구조와 자동 검사 통과를 내용 완결성으로 잘못 확대한 판단이었다. 현재는 Chapter별 PDF coverage와 설명 품질을 통과한 범위만 완료로 표시한다.

## Chapter 1 산출물

| 항목 | 결과 |
|---|---:|
| 원문 범위 | 책 pp. 3–21 / PDF pp. 28–46 |
| concept note | 8 |
| Chapter map | 1 |
| Chapter glossary | 1 |
| 원문 coverage | 1 |
| Mermaid | 17 |
| PDF raster image | 0 |

### Chapter 1 원문 대조

- PDF Chapter 1을 `pdftotext -layout -f 28 -l 46`으로 새로 추출해 전체 19쪽을 다시 읽었다.
- 제목, 하위 절, Java/XML/properties/명령 예제, Tip/Note를 [[../part-1-the-basics-of-spring-boot/chapter-1-core-features-of-spring-boot/_coverage|Chapter 1 coverage]]에 매핑했다.
- `pdfimages -f 28 -l 46 -list` 결과 Chapter 1에는 추출 가능한 raster 이미지가 없었다. 원문 화면을 억지로 캡처하지 않고 개념 관계를 Mermaid로 재구성했다.
- Spring Boot 4.0.3 공식 문서를 보조 대조해 자동 구성 후보와 back-off, property source 순서, `@ConditionalOnProperty`, BOM 동작을 확인했다.

### Chapter 1 기계 검사

| 검사 | 결과 |
|---|---|
| Deep-tutor `check-note.sh` | 8/8 PASS |
| 필수 frontmatter 6키 | 8/8 |
| 필수 섹션·사용자 영역 marker | 8/8 |
| frontmatter terms → glossary 등재 | PASS |
| Chapter 1 wiki link·glossary term target | unresolved 0 |
| Mermaid 밝은 theme init | 17/17 |
| Mermaid CLI + Chrome SVG render | 17/17 성공 |

### Chapter 1 공식 문서 대조로 수정·보강한 항목

| 항목 | 처리 |
|---|---|
| 책의 `@ConditionalOnProperty` “어떤 값이든” 표현 | 실제 기본 조건에서 문자열 `false`는 불일치임을 진리표로 명시 |
| 책의 property source 목록 | Spring Boot 4.0.3 공식 순서의 `@DynamicPropertySource` 추가 |
| DataSource 자동 구성 예제 | `DataSource` 클래스 하나만으로 완성되는 것이 아니라 여러 실제 조건을 평가한다는 경계 추가 |
| BOM 설명 | Maven import 예, Gradle 적용 원리, version override의 책임 보강 |

## Chapter 2 산출물

| 항목 | 결과 |
|---|---:|
| 원문 범위 | 책 pp. 25–69 / PDF pp. 50–94 |
| concept note | 15 |
| Chapter map | 1 |
| Chapter glossary | 1 (용어 79개) |
| 원문 coverage | 1 |
| Mermaid | 17 |
| PDF raster image 추출 | 10 |

### Chapter 2 노트 분할

원문 상위 절은 9개이지만, 실제 하위 절이 독립 개념인 두 곳을 분리해 15개 노트로 만들었다.

| 원문 상위 절 | 노트 |
|---|---|
| Leveraging templates to create content | `04`, `04a`, `04b`, `04c`, `04d` |
| Hooking in Node.js to a Spring Boot web app | `06`, `07`, `07a` |
| 나머지 7개 상위 절 | 각각 1개 |

`07-bundling-javascript-and-building-a-react-app.md`는 실제 절 이름과 어긋나 `07-bundling-javascript-with-nodejs.md`로 `git mv` 했다. 다른 Chapter에서의 inbound link가 없음을 사전에 읽기 전용으로 확인했다. 나머지 9개 파일명은 다른 Chapter가 참조하고 있으므로 그대로 유지했다.

### Chapter 2 원문 대조

- PDF Chapter 2를 `pdftotext -layout -f 50 -l 94`로 새로 추출해 1,974줄 전체를 읽었다.
- 본문 절, 코드·명령·설정 예제 **50개**, Tip/Note **19개**와 인용 **1개**, Figure **13개**를 [[../part-2-creating-an-application-with-spring-boot/chapter-2-creating-web-and-api-applications-with-spring-boot/_coverage|Chapter 2 coverage]]에 매핑했다.
- 원문 핵심 식별자 88개(artifact id, property key, 애노테이션, 메서드·명령·경로)를 노트 전문과 기계 대조해 누락 0건을 확인했다.
- `pdfimages -f 50 -l 94 -list`로 raster 이미지 15개를 확인했다. Figure 2.1–2.13 중 **10개를 추출**하고 육안 대조했다.
  - 미추출 근거: Figure 2.5·2.10은 Figure 2.3과 같은 `ADD DEPENDENCIES` UI 패턴, Figure 2.11은 Figure 2.6과 동일한 EXPLORE 버튼, PDF p.94의 2개는 Packt 혜택 안내 QR·로고라 학습 본문이 아니다.
  - 기존 `assets/learning-spring-boot-4-simplify-the-deve-p59-fig2-7.png`는 PDF p.59 추출본과 SHA-1이 일치함을 확인한 뒤 `_assets/`로 이름을 바꿔 이동했다. 검증 없이 삭제하거나 옮기지 않았다.
- Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)를 보조 대조해 starter 구성, API versioning property 모델, HTTP Service Client 등록 방식을 확인했다.

### Chapter 2 기계 검사

| 검사 | 결과 |
|---|---|
| Deep-tutor `check-note.sh` | 15/15 PASS |
| 필수 frontmatter 6키 | 15/15 |
| 필수 섹션·사용자 영역 marker | 15/15 |
| frontmatter terms → glossary 등재 | 미등재 0건 |
| glossary 항목 중 본문 미사용 | 0건 |
| Chapter 2 wiki link (746개) | unresolved 0 |
| image reference (10개) | missing 0 |
| Mermaid block | 17 |
| Mermaid 밝은 theme init | 17/17 |
| Mermaid CLI + Chrome SVG render | 17/17 성공 |
| `git diff --check` | PASS |

### Chapter 2 설명 품질 수동 검사

15개 concept note 각각에서 다음을 확인했다.

- 정의부터 시작하지 않고 빈 `pom.xml`, 404 화면, `UnsupportedOperationException`, 운영 NPE 같은 구체적 장면으로 문제를 연다.
- 순진한 해법을 먼저 제시하고 그것이 무너지는 지점을 3–4개로 나눠 보인 뒤 개념을 도입한다.
- 메커니즘의 각 단계에 “— 하기 위해서다” 형태로 그 단계가 필요한 이유를 적는다.
- 첫 전문 용어에 inline 풀이와 glossary 링크를 붙인다.
- 최소 한 개의 비유와 **그 비유가 깨지는 지점**을 함께 설명한다.
- Mermaid·ASCII·비교표 중 구조를 실제로 드러내는 도표를 제공한다.
- 혼동하기 쉬운 개념 쌍과 적용 경계를 구분한다.
- 관련 concept note를 세 개씩 연결한다.
- 책의 문장을 길게 복제하지 않고 예제와 논리를 한국어로 재구성한다.

### Chapter 2에서 정정·보강한 책의 오류와 단순화

| 구분 | 책의 서술 | 노트의 처리 | 위치 |
|---|---|---|---|
| **오류** | React의 갱신 메커니즘을 “shadow DOM”이라 부름 | Shadow DOM은 웹 컴포넌트 캡슐화용 별개 표준이고 책이 설명하는 동작은 **virtual DOM**임을 명시 | `07a` |
| **오류** | `await fetch("/api/videos").json()` | `fetch`는 `Promise<Response>`를 반환하므로 `.json()`이 없다. 응답을 먼저 `await`해야 함을 코드로 정정 | `07a` |
| **부정확** | `npm install`을 “번들을 빌드할 명령”으로 서술 | 의존성 설치와 번들 빌드는 별개 execution임을 구분 | `07` |
| **누락** | 버전 property를 `required`·`detect-supported` 둘만 언급 | 공식 `WebMvcProperties.Apiversion`의 `supported`와 `MissingApiVersionException`·`InvalidApiVersionException` 추가 | `08` |
| 단순화 | “Spring Web을 넣으면 Jackson이 온다” | `spring-boot-starter-webmvc` → `spring-boot-starter-jackson` 전이 의존성 경로를 명시 | `02`, `05` |
| 단순화 | `use.path-segment`를 “두 번째 세그먼트” | 공식 property 타입이 zero-based `Integer` index임을 확인해 그림으로 정리 | `08` |
| 단순화 | HTTP Service Client를 프로그래밍 configurer로만 설명 | `spring.http.serviceclient.<group>.base-url` property 대안과 `group`·패키지 스캔 추가 | `09` |
| 단순화 | `static` 폴더가 루트에서 서빙된다 | `spring.mvc.static-path-pattern`·`spring.web.resources.chain`으로 조정 가능함을 경계로 추가 | `06` |
| 표기 불일치 | 본문은 메인 클래스를 `Chapter2Application`이라 씀 | Figure 2.2의 Name이 `ch2`이므로 실제 생성 이름은 `Ch2Application`이며 Name 값에서 유도됨을 명시 | `04` |
| 리스팅 누락 | `ApiClientController` 코드에 닫는 중괄호 없음 | 보완했음을 노트에 표시 | `09` |
| 리스팅 밖 정보 | Figure 2.13에 본문에 없는 `@GetMapping("/api/videos/get-first-by-name")`이 보임 | 스크린샷이 호출 맥락을 보충한다는 사실을 명시 | `10` |

### Chapter 2 작업 중 발견하고 수정한 자체 결함

- sequence diagram 5개에서 participant alias와 메시지 텍스트의 따옴표가 화면에 그대로 렌더되는 것을 PNG 육안 확인으로 발견했다. Mermaid의 flowchart는 따옴표를 문법으로 처리해 제거하지만 sequenceDiagram은 리터럴로 출력한다. 5개 블록에서 따옴표를 제거하고 파서가 깨지지 않도록 문구를 조정한 뒤 다시 렌더해 확인했다.

## Chapter 3 산출물

| 항목 | 결과 |
|---|---:|
| 원문 범위 | 책 pp. 71–96 / PDF pp. 96–121 |
| concept note | 12 |
| Chapter map | 1 |
| Chapter glossary | 1 (용어 56개) |
| 원문 coverage | 1 |
| Mermaid | 15 |
| PDF raster image 추출 | **0** |

### Chapter 3 노트 분할

원문 상위 절은 6개이며, 그중 실제 하위 제목을 가진 세 곳을 분리해 12개 노트로 만들었다. **하위 제목이 없는 절은 쪼개지 않았다.**

| 원문 상위 절 | 실제 하위 제목 | 노트 |
|---|---|---|
| Adding Spring Data to an existing Spring Boot application | Using Spring Data to easily manage data / Adding Spring Data JPA to our project | `01`, `01a`, `01b` |
| DTOs, entities, and POJOs, oh my! | Entities / DTOs / POJOs | `02`, `02a`, `02b` |
| Using custom finders | Sorting the results / Limiting query results | `04`, `04a`, `04b` |
| 나머지 3개 절 | 없음 | 각각 1개 |

`04-using-custom-finders-sorting-and-limits.md`는 정렬·제한이 분리되어 이름이 맞지 않게 되어 `04-using-custom-finders.md`로 `git mv` 했다. 이 rename으로 깨지는 외부 링크 1건(`chapter-5-testing-with-spring-boot/07-testing-repositories-with-testcontainers.md:54`)을 같은 작업에서 수정했다.

### Chapter 3 원문 대조

- PDF Chapter 3을 `pdftotext -layout -f 96 -l 121`로 새로 추출해 1,219줄 전체를 읽었다.
- 본문 절, 코드·설정 예제 **27개**, Tip/Note **12개**를 [[../part-2-creating-an-application-with-spring-boot/chapter-3-querying-for-data-with-spring-boot/_coverage|Chapter 3 coverage]]에 매핑했다.
- `pdfimages -f 96 -l 121 -list` 결과 이 범위의 raster 이미지는 PDF p.121의 **246×246 QR 코드와 144×33 로고(각각 smask 포함) 4개뿐**이며 전부 Packt 혜택 안내다. **따라서 책 이미지를 하나도 추출하지 않았다.**
- Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)로 Boot 4 영속성 모듈 구성과 AOT 프로퍼티를 교차 확인했다.

### Chapter 3 기계 검사

| 검사 | 결과 |
|---|---|
| Deep-tutor `check-note.sh` | 12/12 PASS |
| frontmatter terms → glossary 등재 | 미등재 0건 |
| glossary 항목 중 본문 미사용 | 0건 |
| Chapter 3 wiki link (616개) | unresolved 0 |
| image reference | 0 (추출 이미지 없음) |
| Mermaid block | 15 |
| Mermaid 밝은 theme init | 15/15 |
| Mermaid CLI + Chrome SVG render | 15/15 성공 |
| `git diff --check` | PASS |

### Chapter 3에서 정정·보강한 책의 부정확·불일치

| 구분 | 책의 서술 | 노트의 처리 | 위치 |
|---|---|---|---|
| **부정확** | AOT repository는 `spring.aot.enabled=true`로 켠다 | 실제로는 **빌드 시점 AOT 처리**(`-Pnative` 또는 Gradle AOT 플러그인)가 먼저이고, 이 프로퍼티는 그렇게 만든 JAR을 **실행할 때** 주는 시스템 프로퍼티임을 명시 | `06` |
| **표기 차이** | `spring-boot-starter-data-jpa-test` | 공식 테스트 문서는 `@DataJpaTest`가 **`spring-boot-data-jpa-test` 모듈**에서 온다고 설명. 차이를 밝히고 Initializr 좌표를 그대로 쓰라고 안내 | `01b` |
| **불일치** | `TypedSort` 예제가 `Video`·`Video::getName` 사용 | 이 장의 엔티티는 `VideoEntity`이고 Chapter 2의 `Video`는 getter 없는 record라 그대로 컴파일되지 않음을 명시 | `04a` |
| **불일치** | 프로브 예제의 `probe.setTags(...)` | 이 장의 `VideoEntity`에 없는 필드. 더 풍부한 엔티티를 가정한 설명용 코드임을 명시 | `05` |
| **불일치** | 4-JOIN `@Query`의 `v.metrics`·`m.activity`·`v.engagement` | 같은 이유로 설명용 예시임을 명시하고, 연관 매핑 자체는 책의 범위 밖임을 연결 | `06` |
| 보강 | `spring-boot-h2console`을 이름만 제시 | 이 모듈이 이미 `com.h2database:h2`를 api 의존성으로 갖는다는 구성을 확인하고, 그럼에도 `h2`를 따로 넣는 두 가지 이유를 설명 | `01b` |
| 보강 | `spring-boot-persistence` 모듈의 이름과 성격만 서술 | `PersistenceExceptionTranslationAutoConfiguration`과 `spring.persistence.exceptiontranslation.enabled`라는 구체적 내용물 추가 | `01b` |
| 보강 | 스키마 생성 언급 없음 | 예제가 도는 것은 내장 DB의 자동 DDL 덕분이며 실제 DB에서는 성립하지 않는다는 경계 추가 | `01b`, `02a` |

### Chapter 3 작업 중 수정한 자체 결함

- `stateDiagram-v2` 하나가 self-transition 라벨과 출력 라벨이 겹쳐 읽기 어려웠다. PNG 육안 확인으로 발견해 flowchart로 교체하고 다시 렌더했다.
- Chapter 2 `_map.md`의 ASCII 도표 안에 코드펜스 때문에 렌더되지 않는 축약 위키링크 5건(`[[04b]]`, `[[04a]]`, `[[02]]`, `[[08]]`, `[[05]]`)이 있어 평문으로 고쳤다. Chapter 3의 같은 유형 1건도 함께 고쳤다.

## Chapter 15 산출물 — 챕터 단위 통합

| 항목 | 결과 |
|---|---:|
| 원문 범위 | 책 pp. 469–492 / PDF pp. 494–517 |
| concept note | **1** (챕터 단위 통합) |
| Chapter map | 1 |
| Chapter glossary | 1 (용어 34개) |
| 원문 coverage | 1 |
| Mermaid | 2 |
| PDF raster image 추출 | **0** (범위 내 raster 이미지 자체가 없음) |

### 왜 이 Chapter만 노트가 하나인가

사용자 지시("절 단위로 쪼개지 말고 챕터 단위로 통째로 정리한다")를 따랐고, 원문의 성격이 그 지시와 맞았다.

1. 원문이 개념 전개가 아니라 **변경 사항 카탈로그**다. 34개 하위 절 대부분이 5–20줄이며 같은 형식을 반복한다.
2. 설명 가능한 개념이 하나다 — **"Boot 4가 어느 방향으로 움직였는가."** 항목을 흩어 놓으면 이것이 보이지 않는다.
3. 원문 Note 15개가 밝히는 "이 변경은 Chapter N에서 다룬다"는 대응이 **1:1이 아니다.** 한 Chapter가 여러 영역과 얽히고, 대응 Chapter가 없는 항목도 있다. 표 하나로 두는 편이 정확하다.

기존 9개 절 단위 초안은 사용자 영역이 비어 있음을 확인한 뒤 제거하고 통합했다.

### Chapter 15 원문 대조

- PDF를 `pdftotext -layout -f 494 -l 517`로 새로 추출해 1,130줄 전체를 읽었다.
- 9개 영역·34개 하위 절, Note **40개**, 이름·좌표·프로퍼티 변경 **53건**을 [[../part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/_coverage|Chapter 15 coverage]]에 매핑했다.
- **이 Chapter에는 실행 가능한 코드 리스팅이 하나도 없다.** 본문의 대부분이 이름·좌표·프로퍼티 키의 변경 목록이며, 전부 대조표로 옮겼다.
- `pdfimages -f 494 -l 517 -list` 출력이 **헤더 두 줄뿐**이었다. 이 범위에는 raster 이미지가 없어 추출 대상이 아예 없다.

### Chapter 15 기계 검사

| 검사 | 결과 |
|---|---|
| Deep-tutor `check-note.sh` | 1/1 PASS |
| frontmatter terms(34개) → glossary 등재 | 미등재 0건 |
| glossary 항목 중 본문 미사용 | 0건 |
| Chapter 15 wiki link (156개) | unresolved 0 |
| image reference | 0 |
| Mermaid block | 2 |
| Mermaid 밝은 theme init | 2/2 |
| Mermaid CLI + Chrome SVG render | 2/2 성공 |
| `git diff --check` | PASS |

### Chapter 15에서 이 노트가 더한 것

원문은 변경을 영역별로 나열하기만 한다. 노트는 그 위에 두 개의 축을 얹었다.

- **다섯 방향**: 명시성 / 모듈 세분화 / 벤더 중립 표준 채택 / 빌드 시점 이동 / 책임 이전. 34개 항목을 각 방향에 배정했고, ⑤에 역방향 예외(Spring Authorization Server가 Spring Security로 편입)가 하나 있음을 밝혔다.
- **변경 성격 × 발견 시점**: 이름 변경(빌드) / 기능 제거(빌드·시작) / **기본값 변경(운영 중)** / 신규 기능. 세 번째 유형만 도구가 알려 주지 않는다는 점을 근거로, 책이 `spring-boot-properties-migrator`를 첫 수로 제시하는 이유를 설명했다.

또한 이 책에 "AOT"가 세 가지 서로 다른 의미로 나온다는 점(GraalVM 네이티브 이미지 / Java AOT Cache / Spring Data AOT repository)을 정리해 Chapter 3과 연결했다.

### 사용자 지시로 수정한 깨진 링크

`chapter-15-whats-new-in-spring-boot-4/01-core-framework-changes.md:55`가 존재하지 않는 폴더 `chapter-2-building-web-applications-with-spring-boot`를 가리키고 있었다. 통합 과정에서 그 파일이 대체되며 링크가 사라졌고, **같은 의도의 참조를 올바른 경로로 통합 노트의 `## 7. 연결`에 넣었다.**

## Chapter 4 산출물

- 대상: 책 pp. 97–151 / PDF pp. 122–176, `part-2-creating-an-application-with-spring-boot/chapter-4-securing-an-application-with-spring-boot/`
- 이 책에서 가장 긴 장(55쪽). 상위 절 9개 아래 **실제 하위 제목 14개**를 그대로 분할선으로 삼아 노트 23개로 나눴다. 기존 초안 10개는 이름이 절 구조와 맞지 않아 전부 교체했다.

| 묶음 | 파일 | 원문 절 | 책 쪽 |
|---|---|---|---:|
| 기초 | `01-spring-security-filter-chain-foundations` | Exploring the foundations of Spring Security | 98–101 |
| 도입 | `02-adding-spring-security-to-the-project` | Adding Spring Security to our project | 101–102 |
| 사용자 출처 | `03-creating-users-with-userdetailsservice` · `04-spring-data-backed-users` | Creating our own users … / Swapping hardcoded users … | 102–109 |
| 경로 인가 | `05-securing-web-routes-and-http-verbs` · `05a-to-csrf-or-not-to-csrf` | Securing web routes and HTTP verbs (+ 하위 1) | 109–116 |
| 메서드 보안 | `06` · `06a` · `06b` · `06c` · `06d` · `06e` · `06f` | Securing Spring Data methods (+ 하위 6) | 116–127 |
| OAuth 이론 | `07-understanding-oauth-2-1` · `07a-oauth-vs-openid-connect` | Understanding OAuth 2.1 (+ 하위 1) | 127–129 |
| Google 연동 | `08` · `08a` · `08b` · `08c` · `08d` | Leveraging Google to authenticate users (+ 하위 4) | 129–146 |
| 데이터 보호 | `09-securing-data-in-transit` · `09a-introducing-ssl-bundles` · `09b-securing-data-at-rest` | Securing data in transit and at rest (+ 하위 3) | 146–151 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | **23/23 PASS**, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 (`InMemoryUserDetailsManager` 1건을 노트 03 §2.1에 인라인 추가해 해소) |
| wiki link | 811개 중 unresolved 0 |
| local image reference | 5건 중 missing 0, `_assets` 파일 5개와 일치 |
| Mermaid block | 41개 = 밝은 theme init 41개 = 실제 SVG 렌더 성공 41개 (실패 0). 시퀀스 4개·플로차트 2개는 PNG로 육안 확인 |
| 코드펜스에 갇힌 위키링크 | 0 |
| `git diff --check` | PASS |
| 다른 Chapter 인바운드 링크 | 파일 rename으로 끊긴 3건(Ch2·Ch3·Ch5 `_map.md`)을 최소 수정으로 복구 |

### 내용 coverage 검증

- `_coverage.md`의 본문 절, 코드·설정 예제 49개, Tip/Note 19개, Figure 9개를 노트와 1:1 재대조했다.
- 이미지 9개를 전부 PNG로 뽑아 육안 대조한 뒤 **5개만** `_assets/`에 남겼다. 판단 근거는 `_coverage.md` 4절에 Figure별로 기록했다.
- **로컬 배포물 대조** — Gradle 캐시의 Spring Boot 4.1.0 / Spring Security 7.1.0 jar를 직접 열어 다음을 확인했다.
  - `ServletWebSecurityAutoConfiguration$SecurityFilterChainConfiguration#defaultSecurityFilterChain` 바이트코드가 책의 "단순화 버전"과 정확히 일치 (`authorizeHttpRequests(anyRequest().authenticated())` → `formLogin` → `httpBasic` → `build`). **책의 클래스 이름 표기가 Boot 4 기준으로 정확하다.**
  - `UserDetailsService`의 유일한 메서드는 `loadUserByUsername(String)`.
  - `AuthorityAuthorizationManager`에 `hasRole`·`hasAuthority`·`hasAnyRole`·`hasAnyAuthority`만 있고 `hasAllRoles`는 없다 — 책의 주장이 맞다.
  - `CommonOAuth2Provider`의 상수는 `GOOGLE`·`GITHUB`·`FACEBOOK`·`OKTA` 넷. 단 Security 7에서 패키지가 `org.springframework.security.config.oauth2.client`로 이동했다.
  - Boot 4의 OAuth2 클라이언트 스타터는 `spring-boot-starter-security-oauth2-client`(테스트용 `-test`도 함께 배포). resource-server 스타터의 deprecation 메시지가 같은 개명 규칙을 명시한다.
- **Context7 `/spring-projects/spring-boot/v4.1.0` 대조** — SSL 번들 타입은 `jks`와 `pem` 둘뿐이고 PKCS#12 파일도 `spring.ssl.bundle.jks.<name>.keystore.location` 아래에 놓는다. `server.ssl.bundle`은 정의가 아니라 참조 키이며 `server.ssl`의 개별 옵션과 함께 쓸 수 없다.

### 원문의 오류·불일치 10건

`_coverage.md` 5절에 전체 표가 있다. 요약하면 다음과 같다.

| 종류 | 건수 | 예 |
|---|---:|---|
| API 이름 오기 | 1 | `loadUserByName` / `loadUserName()` (실제 `loadUserByUsername`) |
| 코드와 설명 불일치 | 3 | 정책 6줄에 설명 5개, "마지막 줄만 다르다"는 거짓, `POST /api/**`를 `/api/new-video`로 |
| 실행되지 않는 코드 | 2 | `@ElementCollection List<GrantedAuthority>`, CSS `thead th` vs 템플릿 `<td>` |
| 빠진 코드 | 2 | `/delete/videos/**` 인가 규칙, `YouTube` 프록시 빈 등록 |
| 프로퍼티 오류 | 2 | `spring.ssl.bundle.pkcs12.*.key.store`, "`server.ssl.bundle` 아래에 정의" |
| 조판 사고 | 1 | `&order=`가 HTML 엔티티로 뭉개진 `ℴ=` |

## Chapter 11 산출물

- 대상: 책 pp. 295–314 / PDF pp. 320–339, `part-4-scaling-an-application-with-spring-boot/chapter-11-virtual-threads-in-java-and-spring-boot/`
- 상위 절 6개에 실제 하위 제목이 1개뿐이고 그것이 상위 절 본문에 해당해 쪼개지 않았다. 기존 6개 파일 이름은 Ch10·Ch12가 참조하고 있어 유지했다.

| 파일 | 원문 절 | 책 쪽 |
|---|---|---:|
| `01-understanding-virtual-threads` | Understanding Virtual Threads | 296–297 |
| `02-using-virtual-threads-in-a-spring-boot-application` | Using Virtual Threads in a Spring Boot application | 297–302 |
| `03-integrating-virtual-threads-with-taskexecutor` | Integrating Virtual Threads with Spring Boot's TaskExecutor | 302–305 |
| `04-using-virtual-threads-with-restclient` | Using Virtual Threads with RestClient (+ 하위 1) | 305–308 |
| `05-using-interface-proxy-http-service-clients` | Using Interface-Proxy HTTP service clients in Spring Boot 4 | 309–310 |
| `06-error-handling-in-concurrent-tasks` | Error handling in concurrent tasks | 311–314 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | **6/6 PASS**, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 |
| wiki link | 275개 중 unresolved 0 |
| local image reference | 0건 (이 장은 이미지를 추출하지 않았다) |
| Mermaid block | 16개 = 밝은 theme init 16개 = 실제 SVG 렌더 성공 16개 (실패 0) |
| 코드펜스에 갇힌 위키링크 | 0 |
| `git diff --check` | PASS |

### 내용 coverage 검증

- `_coverage.md`의 본문 절, 코드·설정 예제 20개, Tip/Note 5개, Figure 1개를 노트와 1:1 재대조했다.
- **책 이미지 0개.** Figure 11.1은 스타일 없는 HTML 화면이고 가상 스레드에 대한 정보가 전혀 없어 미추출로 판단했다. 근거는 `_coverage.md` 4절에 기록했다.
- **Boot 4.1.0 배포물 직접 확인** — `spring.threads.virtual.enabled`가 `spring-boot-autoconfigure-4.1.0.jar`의 설정 메타데이터에 존재하고, `spring-boot-starter-restclient`가 실제 아티팩트임을 확인했다.

### 원문의 오류·공백 5건

| 종류 | 내용 |
|---|---|
| **주제와 어긋난 예제** | 마지막 `CompletableFuture.runAsync()` 예제가 실행자를 주지 않아 `ForkJoinPool.commonPool()`의 **플랫폼 스레드**에서 돈다 |
| 표현 부정확 | "Project Loom, introduced in Java 21" — Java 21에서 final이 된 것은 프로젝트가 아니라 가상 스레드 |
| 로그 불일치 | 수신 측만 `http-nio-8080-exec-1`, 나머지는 `tomcat-handler-N` |
| 설명 누락 | 앱이 자기 자신(`localhost:8080`)을 호출하는데 그것이 왜 안전한지 언급이 없다 |
| 대안 미언급 | Boot 4의 `@ImportHttpServices` 선언적 방식을 다루지 않고 `HttpServiceProxyFactory` 수동 조립만 보여 준다 |

### 이 장에서 해소한 기존 결함

- Ch11 초안의 깨진 링크 3건(`chapter-2-building-web-applications-with-spring-boot/...`, `chapter-6-externalizing-configuration-with-spring-boot/...`, part 경계를 넘지 않는 Ch13 링크)이 전면 재작성으로 사라졌다.

## Chapter 7 산출물

- 대상: 책 pp. 207–227 / PDF pp. 232–252, `part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/`
- 상위 절 4개 아래 **실제 하위 제목 4개**를 분할선으로 삼아 8개 노트로 나눴다. 기존 4개 파일 이름은 Ch8·Ch10이 참조하고 있어 유지했다.

| 파일 | 원문 절 | 책 쪽 |
|---|---|---:|
| `01-creating-an-uber-jar` | Creating an uber JAR | 208–211 |
| `02-building-a-docker-container` · `02a-building-the-right-type-of-container` | Baking a Docker container (+ 하위 1) | 212–216 |
| `03-publishing-an-image-to-docker-hub` | Releasing your application to Docker Hub | 216–219 |
| `04-tuning-and-scaling-in-production` · `04a` · `04b` · `04c` | Tweaking your application in production (+ 하위 3) | 219–227 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | **8/8 PASS**, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 |
| wiki link | 322개 중 unresolved 0 |
| local image reference | 0건 (이 장은 이미지를 추출하지 않았다) |
| Mermaid block | 20개 = 밝은 theme init 20개 = 실제 SVG 렌더 성공 20개 (실패 0) |
| 코드펜스에 갇힌 위키링크 | 0 |
| `git diff --check` | PASS |
| 표 셀 안 escape 링크 | 2건을 표 밖 문장으로 이동해 해소 |

### 내용 coverage 검증

- `_coverage.md`의 본문 절, 코드·명령 예제 20개, Tip/Note 10개, Figure 1개를 노트와 1:1 재대조했다.
- **책 이미지 0개.** Figure 7.1(Docker Hub 저장소 목록)이 유일한 raster이고, 본문이 그 내용을 그대로 서술하므로 미추출로 판단했다. 근거는 `_coverage.md` 4절에 기록했다.
- **Boot 4.1.0 배포물 직접 확인** — Gradle 캐시의 `spring-boot-jpa-4.1.0.jar`와 `spring-boot-hibernate-4.1.0.jar`의 설정 메타데이터를 열어 `spring.jpa.show-sql`은 존재하고 `spring.jpa.hibernate.show-sql`은 **존재하지 않음**을 확인했다.

### 원문의 오류·공백 6건

| 종류 | 내용 |
|---|---|
| **존재하지 않는 프로퍼티** | `spring.jpa.hibernate.show-sql` (올바른 키는 `spring.jpa.show-sql`, 항목 설명은 올바르게 적혀 있다) |
| **빠진 설명** | Docker Compose 절이 `application-instance*.properties`가 컨테이너 이미지에 어떻게 들어가는지 밝히지 않는다 |
| 버전 불일치 | build-image 로그의 플러그인 `4.0.0` vs 실행 배너 `v4.1.0` |
| 과장된 서술 | `depends_on`이 준비 완료를 "보장한다" (기동 순서만 보장) |
| 과장된 서술 | `-p 5432:5432`를 "public에 export" (호스트 인터페이스 바인딩) |
| 불필요한 설정 | `hibernate.dialect` 명시 — Hibernate 6 이후 자동 판별 |

### 이 장에서 해소한 기존 결함

- Ch7 초안의 깨진 링크 2건(`chapter-13-observability-with-spring-boot-4/...`)이 전면 재작성으로 사라지고, Ch13의 실제 경로로 대체됐다.

## Chapter 13 산출물

- 대상: 책 pp. 347–397 / PDF pp. 372–422, `part-5-observing-spring-boot-4-applications/chapter-13-observing-spring-boot-4-applications/`
- 상위 절 6개 아래 **실제 하위 제목 9개**를 분할선으로 삼아 15개 노트로 나눴다. **기존 6개 파일 이름은 유지**(Ch7·Ch11·Ch12·Ch14가 참조)하고 새 9개만 접미사 노트로 더했다.

| 묶음 | 파일 | 원문 절 | 책 쪽 |
|---|---|---|---:|
| 개념 | `01-three-pillars-of-observability` | Understanding the three pillars of observability | 348–350 |
| 구조 | `02-designing-an-observability-architecture` | Observability architecture with Spring Boot 4 | 350–352 |
| 로그 | `03` · `03a` · `03b` · `03c` | Structuring logging with Logback, Loki, and Grafana (+ 하위 3) | 352–365 |
| 메트릭 | `04` · `04a` · `04b` · `04c` | Collecting and visualizing metrics … (+ 하위 3) | 365–378 |
| 트레이스 | `05` · `05a` · `05b` · `05c` | Tracing propagation with Grafana Tempo (+ 하위 3) | 378–389 |
| 상관관계 | `06-correlating-logs-metrics-and-traces` | Correlating logs, metrics, and traces | 390–397 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | **15/15 PASS**, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 (`대시보드` 1건을 노트 04c에 인라인 추가해 해소) |
| wiki link | 621개 중 unresolved 0 |
| local image reference | 6건 중 missing 0, `_assets` 파일 6개와 일치 |
| Mermaid block | 36개 = 밝은 theme init 36개 = 실제 SVG 렌더 성공 36개 (실패 0) |
| 코드펜스에 갇힌 위키링크 | 0 |
| `git diff --check` | PASS |
| 다른 Chapter 인바운드 링크 | **손대지 않음** — 파일 이름 유지로 4건 그대로 유효 |

### 내용 coverage 검증

- `_coverage.md`의 본문 절, 코드·설정 예제 29개, Tip/Note 7개, Figure 15개를 노트와 1:1 재대조했다.
- 이미지 15개 중 6개만 추출했고, Figure별 판단 근거를 `_coverage.md` 4절에 기록했다. 개념 관계도 5개(13.1·13.2·13.3·13.5·13.8)는 Mermaid로 재현했다.
- 화면에서만 확인되는 사실 세 가지를 노트에 반영했다.
  - Figure 13.4의 `Common labels`가 Collector의 `loki.resource.labels` 승격 결과를 그대로 보여 준다.
  - Figure 13.11의 로그 본문에 최상위 `"traceid"`(소문자)와 `attributes` 안의 `"traceId"`(camelCase)가 **둘 다** 있어, `derivedFields` 정규식 `'"traceId":"([A-Fa-f0-9]+)"'`이 후자를 잡는다는 것이 확인된다.
  - Figure 13.6의 `exported_job` 라벨이 6절 `tracesToMetrics`의 `value: exported_job` 설정과 이어진다.

### 원문의 오류·불일치 9건

| 종류 | 내용 |
|---|---|
| 본문 vs 화면 | 설정의 패키지는 `com.learningspringboot4`, 화면 로그는 `com.springbootlearning4` |
| Note vs 코드 | "모든 `System.out`을 SLF4J로 교체"라는 Note와 달리 `NotificationService`에 `System.out.println` 잔존 |
| 설명 vs 코드 | 항목 설명이 언급한 `recordNotificationMetric("received")`·`("duplicate")` 호출이 인쇄된 코드에 없음 |
| 조판 | `docker-compose.yml`의 grafana 볼륨 경로 슬래시 중복, `depends_on` 항목 잘림 |
| 빠진 설정 | Prometheus가 긁을 9464 포트를 Collector 서비스에 노출하는 변경이 없음 |
| 표기 | Trace ID가 Figure 13.9·13.10 설명에서 다르게 인쇄되고 16진수 아닌 문자가 섞임 |
| 화면 vs 화면 | Figure 13.10이 "4 spans"라 표시하지만 패널에는 루트 포함 5개 행 |
| 화면 내부 | Figure 13.7의 실패율 0%와 failed 8 병존 (순간 rate vs 누적 count) |
| 문법 | Figure 13.2·13.5 설명의 주어-동사 수 불일치 |

## Chapter 6 산출물

- 대상: 책 pp. 189–205 / PDF pp. 214–230, `part-3-releasing-an-application-with-spring-boot/chapter-6-configuring-an-application-with-spring-boot/`
- 상위 절 5개 모두 **하위 제목이 없어** 절당 노트 1개를 유지했다. 기존 파일 이름이 실제 절과 1:1이고 다른 Chapter 5곳이 그 이름을 참조하고 있어 **rename 없이** 전면 재작성했다.

| 파일 | 원문 절 | 책 쪽 |
|---|---|---:|
| `01-creating-custom-properties.md` | Creating custom properties | 190–195 |
| `02-creating-profile-based-property-files.md` | Creating profile-based property files | 195–199 |
| `03-switching-to-yaml-and-metadata.md` | Switching to YAML | 199–202 |
| `04-setting-properties-with-environment-variables.md` | Setting properties with environment variables | 202–203 |
| `05-ordering-property-overrides.md` | Ordering property overrides | 203–205 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | **5/5 PASS**, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 |
| wiki link | 255개 중 unresolved 0 |
| local image reference | 1건 중 missing 0 |
| Mermaid block | 13개 = 밝은 theme init 13개 = 실제 SVG 렌더 성공 13개 (실패 0) |
| 코드펜스에 갇힌 위키링크 | 0 |
| `git diff --check` | PASS |
| 다른 Chapter 인바운드 링크 | **손대지 않음** — 파일 이름을 유지해 5건 모두 그대로 유효 |

### 내용 coverage 검증

- `_coverage.md`의 본문 절, 코드·설정 예제 19개, Tip/Note 7개, Figure 2개를 노트와 1:1 재대조했다.
- **Context7 `/spring-projects/spring-boot/v4.1.0` 대조** — 프로퍼티 소스 우선순위 15항목과 Config Data 4단계가 책과 정확히 일치한다. "Merging Complex Types" 항목이 **리스트는 병합되지 않고 최상위 우선순위 소스의 것으로 통째로 교체된다**는 책의 Tip을 그대로 확인해 준다.
- **Boot 4.1.0 jar 직접 확인** — `@ConfigurationPropertiesBinding`, `@ConfigurationPropertiesScan`, `@EnableConfigurationProperties`는 `org.springframework.boot.context.properties`에, `@ConstructorBinding`은 `...context.properties.bind`에, `RandomValuePropertySource`는 `org.springframework.boot.env`에 있다. record + 단일 생성자면 `@ConstructorBinding`이 불필요하다는 책의 Note도 공식 문서로 확인했다.
- 이미지 2개 중 1개만 추출했고, 판단 근거는 `_coverage.md` 4절에 Figure별로 기록했다.

### 원문의 오류·공백 5건

| 종류 | 내용 |
|---|---|
| **설명되지 않은 경로** | `app.config.users`와 `GrantedAuthority` 컨버터를 만들지만, 그 사용자들이 Spring Security에 도달하는 코드가 없다. 실제 소비되는 것은 `header`·`intro`뿐 |
| 타입 미정의 | `UserAccount`를 재정의하지 않는다. Chapter 4의 것은 `@Id @GeneratedValue`가 붙은 JPA 엔티티다 |
| 장 내부 불일치 | p.196은 `-D`와 환경 변수를 동등하게 소개하지만 pp.203–204의 우선순위 목록에서는 `-D`(#6)가 환경 변수(#5)보다 높다 |
| 본문 vs 그림 | 본문은 `application-alternate.yaml`, Figure 6.2의 편집기 탭은 `application-alt.yaml` |
| 표기 오기 | 항목 설명의 `Convert()` (실제는 `convert()`) |

## Chapter 5 산출물

- 대상: 책 pp. 153–185 / PDF pp. 178–210, `part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/`
- 상위 절 8개 모두 **하위 제목이 없어** 절당 노트 1개로 유지했고, 기존 8개 초안 파일 이름이 실제 절과 1:1이라 rename 없이 전면 재작성했다.

| 파일 | 원문 절 | 책 쪽 |
|---|---|---:|
| `01-junit-6-and-focused-test-starters.md` | Adding testing dependencies | 154–157 |
| `02-testing-domain-objects.md` | Testing domain objects | 157–162 |
| `03-testing-web-controllers-with-mockmvc.md` | Testing web controllers | 162–168 |
| `04-testing-services-with-mocks.md` | Testing data repositories with mocks | 168–174 |
| `05-testing-repositories-with-embedded-databases.md` | Testing data repositories with embedded databases | 174–178 |
| `06-adding-testcontainers.md` | Adding Testcontainers | 178–181 |
| `07-testing-repositories-with-testcontainers.md` | Testing data repositories with Testcontainers | 181–183 |
| `08-testing-security-policies.md` | Testing security policies | 183–185 |

### 구조 검증

| 항목 | 결과 |
|---|---|
| `check-note.sh` | 8/8 PASS, 0 FAIL |
| frontmatter `terms` → `_glossary.md` 미등재 | 0 |
| `_glossary.md` → 본문 인라인 링크 미사용 | 0 (`DDL-자동화` 1건을 노트 07 §2.1에 인라인 추가해 해소) |
| wiki link | 466개 중 unresolved 0 |
| local image reference | 2건 중 missing 0, `_assets` 파일 2개와 일치 |
| Mermaid block | 9개 = 밝은 theme init 9개 = 실제 SVG 렌더 성공 9개 (실패 0) |
| 코드펜스에 갇힌 위키링크 | 2건(노트 04·07) 발견 → 펜스 밖 문장으로 이동, 잔여 0 |
| `git diff --check` | PASS |

### 내용 coverage 검증

- `_coverage.md`의 본문 절 8개, 코드 예제 27개, Tip/Note 10개, Figure 6개를 노트와 1:1 재대조했다.
- `pdfimages -f 178 -l 210 -list` raster 6개 중 **2개만 추출**했다. Figure 5.4는 커버리지 gutter와 `VideoEntity` 소스가 함께 보여 "protected 무인자 생성자만 미커버"의 증거이고, Figure 5.6은 460ms 중 401ms가 첫 테스트에 몰린 것을 숫자로 보여 준다. 나머지 4개(5.1·5.2·5.3·5.5)는 IDE 메뉴·통과 표시라 본문 서술로 충분하며, 특히 5.2는 본문이 인용한 "49밀리초"가 그림에서 잘려 있다고 책이 직접 밝힌다.
- Context7 `/spring-projects/spring-boot/v4.1.0` 대조로 확인한 책과 공식 문서의 차이:
  - `@DataJpaTest`는 `spring-boot-data-jpa-test` 모듈 소속이다. 책은 `spring-boot-starter-data-jpa-test`로 적는다.
  - `@MockBean` → `@MockitoBean` 개명과 `@WebMvcTest` import 경로 변경은 Boot 4 변화이며 Chapter 15 노트와 연결했다.
- 원문 오류·불일치 3건을 노트에 명시했다.
  - p.182: 테스트 메서드 이름이 빠진 조판 오류 `void () throws Exception {`.
  - 절 제목 *Testing data repositories with mocks*가 실제로는 `VideoService`를 테스트한다.
  - p.174가 예고한 `delete()` 테스트가 보안 절에 끝내 나오지 않는다.

## Chapter 14 산출물

> 대상: *Learning Spring Boot 4*, Ch. 14 *Building Intelligent Applications with Spring AI*, 책 pp. 401–465 / PDF pp. 426–490. `pdftotext -layout -f 426 -l 490`으로 새로 추출한 3,028줄 전체를 읽고 대조했다.

### 구조 검증

| 항목 | 결과 |
|---|---|
| concept note `check-note.sh` | **19 / 19 PASS** |
| frontmatter 6키 | 19 / 19 |
| 필수 H2 7개 | 19 / 19 |
| 사용자 영역 marker | 19 / 19, marker 아래는 모두 비어 있음(사용자 소유) |
| `## 7. 연결` 링크 ≥ 2 | 19 / 19 (최소 3, 최대 5) |
| frontmatter `terms` → `_glossary.md` 등재 | term 참조 **155개 중 미등재 0** |
| `_glossary.md` 항목 중 본문 인라인 미사용 | **0** (전 99개 항목이 최소 한 노트에서 `**[[용어]]**` 형태로 사용됨) |
| 본문 인라인 gloss 중 frontmatter `terms` 누락 | **0** — `토큰-사용량` 1건을 노트 05 frontmatter에 추가해 해소 |
| Chapter 내 wiki link | **301개 중 unresolved 0** (코드펜스·인라인 코드스팬 제외) |
| 로컬 image reference | **0개**, missing 0 |
| Mermaid block | **21개**, 밝은 theme init **21개**, 실제 CLI SVG 렌더 **21 / 21 성공** |
| `git diff --check` | PASS |

### 렌더 육안 검증에서 잡은 결함 2건

CLI 렌더 성공만으로는 잡히지 않아 **PNG로 직접 확인**해 고쳤다.

| # | 증상 | 원인 | 조치 |
|---:|---|---|---|
| 1 | flowchart 노드 라벨이 `chatClient.prompt&(&).user&(...&)`처럼 깨져 보임 | 따옴표 안 라벨에 HTML 엔티티 `&#40;`·`&#41;`를 쓰면 Mermaid가 **리터럴 문자열로 렌더**한다 | 6개 노트 15곳의 엔티티를 그대로의 괄호로 치환하고 전체 재렌더 |
| 2 | `04b`의 `sequenceDiagram autonumber`가 9까지 매겨져 본문의 "8단계"와 어긋남 | 원문 8단계 중 마지막 단계를 화살표 2개로 그렸다 | autonumber를 빼고 원문 단계 번호를 메시지 문자열에 직접 넣음. `03`도 독립 시나리오 2개를 연속 번호로 매기고 있어 autonumber 제거 |

### 내용 coverage 검증

- 인쇄된 상위 절 **7개**, 실제 2단계 하위 제목 **11개**, 3단계 하위 제목 **10개**를 모두 확인했다. 2단계 제목 전부와 3단계 중 `What are embeddings and vector stores?` 하나를 분할선으로 삼아 **7 → 19개** 노트로 나눴다. 나머지 3단계 9개를 쪼개지 않은 근거는 `_coverage.md` §0에 적었다.
- **기존 초안 7개의 파일 이름은 하나도 바꾸지 않았다.** Ch14를 참조하는 다른 장의 inbound 링크는 0이지만, 상위 절 번호가 원문 목차와 1:1이라 유지하는 편이 낫다고 판단했다.
- `_coverage.md`의 본문 절, 코드·설정 예제 **44개**, Tip/Note **16개**, Figure **5개**를 노트와 1:1 재대조했다.
- `pdfimages -f 426 -l 490 -list`가 보여 준 raster **5개 + QR 2개** 중 **한 장도 추출하지 않았다.** 5개를 전부 PNG로 뽑아 육안 확인한 결과 화면 캡처·대시보드·책 고유 데이터가 아니라 **전부 개념 관계도**였다 — 14.1 Spring AI 추상 계층, 14.2 tool calling 8단계, 14.3 RAG 색인/질의 2단계, 14.4 MCP client + server, 14.5 LLM-as-a-Judge 흐름. 다섯 장 모두 Mermaid로 재현했고 판단 근거는 `_coverage.md` §4에 Figure별로 적었다. Ch3·Ch7·Ch11과 같은 결론이다.

### 원문의 오류·불일치 8건

| # | 원문 | 실제 |
|---:|---|---|
| 1 | p.455 `McpClientController` 코드 블록 | 클래스를 닫는 `}`가 없어 그대로 복사하면 컴파일되지 않는다 |
| 2 | p.443 RAG 응답을 `{"reply": "..."}` JSON으로 제시 | 바로 위 `rag(...)`의 반환형이 `String`이라 실제 응답은 평문이다 |
| 3 | p.463 "defensive system prompt와 **SafeGuardAdvisor**를 결합하는 방법" | 제시된 코드에 `SafeGuardAdvisor`가 없다. `defaultSystem(...)`뿐이다 |
| 4 | p.460 `gen_ai.client.token.usage` vs p.465 `gen_ai.usage.input_tokens`/`output_tokens` | 같은 대상을 두 이름으로 부른다. 앞이 Spring AI 방출 이름, 뒤는 OpenTelemetry GenAI 규약 속성 쪽 |
| 5 | 설명 항목의 대문자 오타 `.Stream()`(p.418)·`.Call()`(p.430)·`.User()`(p.442) | 같은 쪽 코드 블록에는 소문자로 정확히 쓰여 있다 |
| 6 | p.440 `TokenTextSplitter.builder().withChunkSize(800)` | 책 자신이 p.441에서 최신 Spring AI는 `chunkSize(...)`라고 경고한다 — 예제가 이미 구버전 API |
| 7 | p.436 `spring-ai-rag` 의존성 블록 | `<artifactId>`가 `<groupId>`보다 먼저다. 동작은 하지만 책의 다른 블록과 순서가 다르다 |
| 8 | Figure 14.5 캡션 "Illustrates the…" | 14.1–14.4는 모두 명사구다 |

## Chapter 8·9·10·12 산출물

> 대상: 사용자의 2026-08-28 요청으로 마지막까지 압축 초안으로 남아 있던 네 Chapter. 각각 `pdftotext -layout`으로 새로 추출해 전체를 읽고 대조했다.

### 구조 검증

| 항목 | Ch. 8 | Ch. 9 | Ch. 10 | Ch. 12 |
|---|---|---|---|---|
| 원문 범위 (책 / PDF) | 229–248 / 254–273 | 251–278 / 276–303 | 281–294 / 306–319 | 317–343 / 342–368 |
| 추출 줄 수 | 846 | 1,197 | 603 | 1,136 |
| concept note `check-note.sh` | **12 / 12** | **12 / 12** | **6 / 6** | **13 / 13** |
| 초안 대비 | 7 → 12 | 6 → 12 | 4 → 6 | 6 → 13 |
| glossary 용어 | 45 | 56 | 30 | 39 |
| frontmatter term 참조 → 등재 | 94개, 미등재 0 | 101개, 미등재 0 | 45개, 미등재 0 | 81개, 미등재 0 |
| glossary 항목 중 본문 미사용 | 0 | 0 | 0 | 0 |
| 인라인 gloss 중 frontmatter 누락 | 0 | 0 | 0 | 0 |
| Chapter 내 wiki link | 179개, unresolved 0 | 180개, unresolved 0 | 83개, unresolved 0 | 164개, unresolved 0 |
| image reference | 1개, missing 0 | 0개 | 0개 | 1개, missing 0 |
| Mermaid (밝은 theme = 실제 SVG 렌더) | 14 = 14 = **14/14** | 14 = 14 = **14/14** | 8 = 8 = **8/8** | 16 = 16 = **16/16** |

### 파일 이름 처리

기존 초안 23개 중 **21개는 이름을 유지**하고 **2개만 rename**했다. 두 건 모두 rename 전에 저장소 전체를 읽기 전용으로 확인해 **해당 Chapter 밖의 inbound 링크가 0건**임을 확인했다.

| 원래 이름 | 새 이름 | 이유 |
|---|---|---|
| `chapter-8-.../07-java-25-aot-cache-and-crac-comparison.md` | `07-using-java-25-aot-cache.md` | CRaC 비교가 하위 제목 `07b`로 분리되며 이름이 실제 내용과 어긋남 |
| `chapter-10-.../04-connecting-reactive-data-to-api-and-templates.md` | `04-loading-data-with-r2dbcentitytemplate.md` | API·템플릿 연결이 `04a`·`04b`로 분리되며 이름이 어긋남 |

Ch9의 6개 이름은 **Ch10의 세 노트가 직접 참조**하고 있어 하나도 바꾸지 않았고, Ch10의 `01`·`02`도 Ch9가 참조하므로 유지했다.

### 내용 coverage 검증

| Chapter | 상위 절 | 2단계 하위 제목 | 코드 예제 | Tip/Note | Figure |
|---|---:|---:|---:|---:|---:|
| 8 | 7 | 6 | 19 | 6 | 2 |
| 9 | 6 | 7 | 20 | 9 | 3 |
| 10 | 4 | 3 | 12 | 4 | 0 |
| 12 | 6 | 11 | 19 | 3 | 6 |

네 Chapter 모두 **인쇄된 하위 제목만을 분할선**으로 삼았다. 상위 절 도입부가 한두 문단이고 곧바로 첫 하위 제목의 예고로 이어지는 경우(Ch9 `01`, Ch10 `04`, Ch12의 네 절)는 **도입과 첫 하위 제목을 한 노트로** 합쳤다.

### Figure 처리 판단

raster **11개를 전부 PNG로 뽑아 육안 확인**하고 **2개만 `_assets/`에 넣었다.**

| Figure | 판단 | 근거 |
|---|---|---|
| **8.1** (책 p.237) | **추출** | `native:compile` 출력의 **수치 자체가 학습 대상**이다 — 메서드 컴파일 161초, 총 159.62MB(코드 영역 94.15MB / 이미지 힙 63.70MB), **hibernate-core 21.60MB가 최대 기여**, reflection metadata 1.65MB, Peak RSS 5.03GB. 본문은 "오래 걸린다"고만 말한다 |
| **12.6** (책 p.340) | **추출** | 좌측 트리의 **`employee-events-dlt` 자동 생성**과 payload의 **`"email":null`**(실패 원인)이 그 그림에만 있다. 본문은 "DLT로 전달됐다"고만 말한다 |
| 8.2 | 미추출 | macOS 방화벽 표준 대화상자. 책 자신이 "정상 동작이며 문제가 아니다"라고만 말한다 |
| 9.1·9.2·9.3 | 미추출 | 스타일 없는 브라우저 화면이고 **리액티브에 관한 정보가 화면에 없다.** 같은 화면이 MVC로도 나온다. Ch11 Figure 11.1과 같은 판단 |
| 10 (없음) | — | 본문에 Figure 번호가 한 번도 등장하지 않는다. raster는 마지막 쪽 QR·로고뿐 |
| 12.1·12.2·12.3·12.4 | 미추출 | 개념 관계도 — sequence 2개, producer-broker-consumer, topic·partition·consumer group. 전부 Mermaid로 재현 |
| 12.5 | 미추출 | 책 자신이 이 도구를 **"선택 사항"**이라 명시. 다만 화면의 Zookeeper 설정이 KRaft 구성과 어긋나므로 그 불일치는 노트에 기록 |

### 공식 문서·배포물 대조로 확인한 것

Gradle 캐시의 실제 jar(Boot 4.1.1 / Framework 7.0.9 / reactor-core 3.8.7 / spring-webflux 7.0.9)와 Context7을 함께 썼다.

| 확인 대상 | 결과 |
|---|---|
| `MemberCategory` deprecation | `INVOKE_DECLARED_CONSTRUCTORS`·`INVOKE_PUBLIC_METHODS`는 **유효**. deprecated는 `PUBLIC_FIELDS`·`DECLARED_FIELDS`뿐 |
| `RuntimeHintsRegistrar` 시그니처 | `registerHints(RuntimeHints, ClassLoader)` — 책과 일치 |
| `@RegisterReflectionForBinding` 위치 | spring-context가 아니라 **spring-core의 `org.springframework.aot.hint.annotation`** |
| `spring.context.exit` | `DefaultLifecycleProcessor`가 6.1부터 구현. **짝인 `spring.context.checkpoint`(CRaC)도 같은 클래스에 있다** |
| AOT 캐시 training run 절차 | **공식은 `jarmode=tools extract`를 먼저 시킨다.** 책은 uber JAR에 직접 건다 |
| `native-maven-plugin` · `native` profile | `org.graalvm.buildtools`, `spring-boot-starter-parent`가 선언 — 책과 일치 |
| Hibernate 강화 옵션 3개 | `enableLazyInitialization` 등 **전부 deprecated for removal** |
| `spring-boot-starter-webflux-test` | 실제 배포 아티팩트 |
| `Rendering` | `view(String)`과 **`redirectTo(String)`** 두 static 진입점 |
| `Mono.zip` | static 오버로드 19개, `zipDelayError`가 Tuple2~Tuple8 |

### 원문의 오류·공백 — 네 Chapter 합계 28건

| Chapter | 건수 | 대표 |
|---|---:|---|
| 8 | 7 | AOT 캐시 training run을 uber JAR에 직접 건다(공식은 `extract` 선행), 근거 JEP에서 **514가 빠짐**, Hibernate 옵션 3개가 이미 deprecated, CRaC만 명령 없이 언급, CDS 미언급, "0.1초"가 실측 0.528초와 불일치 |
| 9 | 7 | p.275 `InIn this case,` 오타, `@EnableHypermediaSupport(type = HAL)`이 static import 없이 컴파일 불가, redirect에 `Rendering.redirectTo` 대안이 있는데 문자열 규약 사용, §1의 연장인 절이 POST 절 뒤에 배치, "25% 손실"이 낙관적 하한 |
| 10 | 6 | p.291 **`});f`** 오타(컴파일 실패), record에 **`e.getName()`** 호출(같은 장 다른 곳은 `e.name()`), `subscribe()`가 오류를 삼킴, "툴킷을 쓰라"면서 스키마는 저수준으로 내려가야 함을 미명시 |
| 12 | 8 | `EmployeeCreatedEvent`가 **`Instant` vs `LocalDateTime`** 두 버전, **Figure 12.5의 Zookeeper 설정이 KRaft 구성과 모순**, 저장과 발행에 **트랜잭션 경계 없음**(outbox Note와 미연결), `trusted.packages: "*"`를 경고하면서 예제는 그대로, 실패 시뮬레이션 순서 오류, 멱등 검사가 재시도 중복을 못 막음, 제목 DLQ ↔ 본문 DLT |

### 자체 결함 — 렌더 육안 확인으로 잡은 것

| # | 증상 | 원인 | 조치 |
|---:|---|---|---|
| 1 | Ch9 `05b`의 `sequenceDiagram`이 **`Parse error`로 렌더 실패** | 블록 안의 **`&lt;`·`&gt;` HTML 엔티티**가 sequence 파서를 깨뜨린다 | 1차로 엔티티를 평문(`Mono of Rendering`)으로 치환해 에러는 없앴으나, **아래 재검증에서 더 정확한 표기(`Mono<Rendering>`)로 다시 고쳤다** |
| 2 | Ch8 `05`의 flowchart 라벨에 HTML 엔티티 `&#40;` 사용 | Ch14에서 확인한 **리터럴 렌더** 문제 재발 | 15곳을 그대로의 괄호로 치환하고 재렌더·PNG 육안 확인 |

### 재검증에서 정정한 것 — Mermaid 표기 규칙

1차 조치 후 **"CLI 렌더 성공 = 시각적으로 정확"이 아니다**라는 Ch14의 교훈을 이 네 Chapter에도 적용해 다시 확인했다. 그 결과 **1차 진단이 부정확했음**이 드러났다.

최소 재현 테스트(각 표기를 단독 다이어그램으로 렌더하고 SVG의 실제 텍스트를 확인)로 얻은 규칙은 이렇다. **두 다이어그램 종류가 서로 반대다.**

| 표기 | flowchart | sequenceDiagram |
|---|---|---|
| raw `Flux<Employee>` | **내용이 사라진다** — `<Employee>`가 HTML 태그로 먹혀 화면에 `Flux`만 남는다 | **정상** |
| `Flux&lt;Employee&gt;` | **정상** | **Parse error** |
| 뒤에 공백이 오는 `< 0.5` | 정상 | 정상 |
| `&#40;` `&#41;` | **리터럴로 렌더**된다 (`&(&`) | 리터럴로 렌더된다 |

즉 파서를 깨뜨린 것은 `<`·`>` 자체가 아니라 **엔티티 표기**였고, sequenceDiagram에서는 **raw 꺾쇠가 정확한 답**이었다. 이에 따라 두 곳을 다시 고쳤다.

- Ch9 `05b`: `Mono of Rendering` → **`Mono<Rendering>`**, `Mono of Employee` → **`Mono<Employee>`**
- Ch12 `05`: 1차에서 과하게 우회했던 flowchart 라벨을 코드와 같은 **`Math.random() < 0.5`**로 복원

**저장소 전수 검사 결과 두 결함 패턴 모두 15개 Chapter에서 0건**이다. 특히 flowchart에서 raw 꺾쇠 때문에 **내용이 유실된 곳은 한 군데도 없었다**(`<br/>` 제외 태그 유사 패턴 0건). 고친 두 다이어그램은 PNG로 육안 재확인했다.

### 사후 검증 — 세션 안에서 근거를 대지 않았던 주장

원문 오류 28건 중 대부분은 PDF 원문·Gradle 캐시의 실제 jar·Context7 공식 문서로 세션 안에서 확인했으나, **JEP 514 관련 주장 하나만은 근거 없이 단정**한 상태였다. 이를 OpenJDK 자료로 사후 확인했다.

| 주장 | 결과 |
|---|---|
| JEP 514의 제목이 *Ahead-of-Time Command-Line Ergonomics*이고 JDK 25 대상이다 | **확인됨** |
| 책이 쓰는 `-XX:AOTCacheOutput`이 그 JEP가 도입한 옵션이다 | **확인됨.** JVM이 `AOTMode=create` 하위 호출을 스스로 오케스트레이션한다 |
| (추가로 발견) one-step 워크플로는 **힙이 두 배** 필요하다 | 캐시 생성 하위 호출이 training run과 같은 크기의 자기 힙을 쓴다. `-Xmx4g`면 환경에 8GB가 필요하다. **책에 없는 운영상 함정**이라 [[../part-3-releasing-an-application-with-spring-boot/chapter-8-going-native-with-spring-boot/07a-enabling-aot-cache-for-spring-boot]] §5에 추가했다 |

## Mermaid 259개 전수 육안 검증 (2026-08-28)

앞선 재검증이 남긴 한계 — **"네 Chapter의 Mermaid 52개 중 표본만 육안 확인했다"** — 를 해소하기 위해 **저장소 전체 15개 Chapter의 Mermaid 블록 259개를 하나도 빼지 않고 PNG로 확인했다.** part-0은 대상 밖이다.

### 방법

1. `mmdc -i <note>.md -o out.md -e png`로 노트마다 한 번씩 batch 렌더해 **259개 PNG**를 얻었다. Chapter별 PNG 개수가 소스의 블록 개수와 정확히 일치함을 먼저 확인했다(17·17·15·41·9·13·20·14·14·8·16·16·36·21·2).
2. 259개를 **전부 눈으로 봤다.**
3. mmdc의 기본 PNG 폭이 784px이라 **가로:세로 비가 6 이상인 28개는 글자가 뭉개져 판독이 불가능**했다. 이 28개는 블록을 따로 뽑아 **`-s 3`으로 3배 확대 렌더한 뒤 1,300px 타일 56장으로 잘라** 다시 봤다.

### 잡은 결함 7건 — 전부 CLI 렌더는 성공한 것들

| # | 위치 | 증상 | 원인 | 조치 |
|---|---|---|---|---|
| 1 | Ch5 `07-testing-repositories-with-testcontainers` | 자기 순환 화살표의 `401ms — 여기에 비용이 몰린다` 라벨이 옆 노드에 가려 절반만 보임 | flowchart의 **self-loop(`E -.->|...| E`)** 는 라벨을 노드 위에 겹쳐 그린다 | 별도 노드 `COST`로 분리하고 점선으로 연결 |
| 2 | Ch7 `04c-running-the-setup-with-docker-compose` | `localhost = 자기 자신!`과 `postgres:5432` 두 라벨이 겹쳐 `×postgres:5432 자신`으로 읽힘 | 같은 self-loop 문제 | `SELF["자기 자신을 가리킨다 / 그 안에 DB가 없다"]` 노드로 교체 |
| 3 | Ch8 `02-adapting-an-application-for-native-image` | 화살표 라벨이 **`E2 진입점을 늘린다`** 로 렌더 | 라벨 문자열에 **노드 id `E2`가 그대로 섞여 있었다** | `진입점을 늘린다`로 수정 |
| 4 | Ch12 `_map.md` (2번째 블록) | `중복을 새로 만든다` 라벨이 `중복을 새로 만`에서 잘림 | 주석 노드를 **subgraph에 연결(`P -.- NOTE`)** 하면 노드가 라벨 위로 배치된다 | 구체 노드에 연결(`P3 -.- NOTE`) |
| 5 | Ch13 `05b-enabling-trace-export-and-kafka-propagation` | 노드가 `Observation.observe(` · `Timer.record(` 로 보여 **텍스트가 잘린 것처럼** 읽힘 | 라벨의 **여는 괄호가 닫히지 않은 채** 작성돼 있었다 | 같은 블록의 다른 노드와 같이 `( ... )`로 통일 |
| 6 | Ch14 `04-designing-prompts-and-tool-calling` | `도구가 필요하다고 판단`과 `결과`가 겹쳐 **`도구가 필요하다고결과!`** 로 읽힘 | 같은 두 노드 사이의 **역방향 화살표 쌍**은 라벨이 같은 자리에 놓인다 | 복귀 경로를 `TR["도구 결과"]` 노드를 거치도록 바꿔 라벨을 떼어 놓음 |
| 7 | Ch14 `04b-tool-calling` | 마지막 두 메시지가 **둘 다 `8.`** 이라 번호 오류처럼 보임 | 책 p.436의 8단계가 실제로 "LLM이 최종 응답을 만들고 **애플리케이션이 클라이언트에 반환한다**"는 한 단계다 | 뒤엣것을 `8. (같은 단계) …`로 명시 |

7건 모두 고친 뒤 **다시 렌더해 PNG로 재확인**했다.

### 결함 패턴별 저장소 전수 검사

육안으로 찾은 것을 개별 수정에서 끝내지 않고, 같은 패턴이 다른 곳에 있는지 스크립트로 전수 검사했다.

| 패턴 | 결과 |
|---|---|
| flowchart self-loop (`X --> X`) | 2건 발견 → 둘 다 수정 → **현재 0건** |
| 화살표 라벨이 같은 블록의 노드 id로 시작 | 1건 발견 → 수정 → **현재 0건** |
| 라벨 안의 괄호·대괄호 불균형 | **0건** |
| 역방향 화살표 쌍(A→B와 B→A) | 7쌍. 6쌍은 육안으로 겹침 없음 확인, 1쌍(Ch14 `04`)만 수정 |

sequenceDiagram의 self-message(`A->>A: …`)는 별개 문법이고 겹침 없이 정상 렌더된다 — Ch4 `07a`·`09b`, Ch11 `04`, Ch12 `04c` 등에서 확인했다.

### 결함이 아니라고 판정한 것

- `_map.md`의 읽는 순서 사슬이 가로로 매우 길어 축소 렌더에서 글자가 작다. 3배 확대에서는 전부 정상이고 **Obsidian·GitHub은 SVG로 렌더**하므로 실제 열람에는 문제가 없다.
- subgraph가 선언 순서와 반대로(오른쪽에 "전", 왼쪽에 "후") 배치되는 경우가 몇 있다(Ch2 `04b`, Ch11 `03`, Ch13 `05b`). dagre의 배치 결과이고 각 subgraph에 제목이 붙어 있어 의미는 흐려지지 않는다.
- Ch13 `03c`의 `싸다`, Ch7 `02a`의 `Spring · Mustache …`는 원문 대조 결과 **의도한 표기**다.

### 검증 후 저장소 상태

| 항목 | 결과 |
|---|---|
| concept note deep-tutor 게이트 | **163 / 163 PASS** |
| Mermaid block = 밝은 theme init | **259 = 259** |
| PNG 육안 확인 | **259 / 259** (그중 28개는 3배 확대 타일 56장으로 재확인) |
| `git diff --check` | PASS |
| `part-0-jpa-foundations/` | 이 검증에서는 대상 밖(읽기·수정 없음). 이후 별도로 전수 검증했다 — 아래 절 참조 |

"CLI 렌더 성공"은 **문법이 맞다는 뜻일 뿐 그림이 옳다는 뜻이 아니다.** 이번에 잡은 7건은 전부 렌더가 성공한 블록에서 나왔다.

## part-0-jpa-foundations 전수 검증 (2026-08-28)

이 트랙은 다른 세션이 작성했고, 그동안 책 트랙의 검증 대상 밖이었다. 커밋 후 사용자 요청으로 **책 트랙과 같은 기준으로 전수 검증**했다.

### 구조·렌더

| 항목 | 결과 |
|---|---|
| concept note deep-tutor 게이트 | **14 / 14 PASS** |
| frontmatter 6키 | 누락 0. `source:`는 14개 전부 공식 문서 + 김영한 대응 장을 병기 |
| glossary 대조 | j1 17/17 · j2 17/17 · j3 15/15 — 미등재 0, 미사용 0 |
| 사용자 영역 marker | 14개 전부 존재하고 **전부 비어 있다** |
| wiki link | 386개 중 미해결 0 (챕터 내 236 + 챕터 간 32) |
| Mermaid | 17 block = 17 밝은 theme init = **17/17 PNG 육안 확인** |
| `_map.md` | 챕터마다 **관계 축 4개** (책 트랙 요구치는 2개) |
| `_coverage.md` | 규정대로 **주제 → 출처 매핑**. Context7 library ID까지 기록 |

### 내용 — 14개 전문 대조

노트 14개를 처음부터 끝까지 읽고, 반증 가능한 주장을 Context7으로 공식 문서와 대조했다.

**공식 문서로 확인해 맞았던 것**

| 노트 | 주장 | 근거 |
|---|---|---|
| j1 `03` | `@DynamicUpdate`는 `@Version` 없으면 위험 | Hibernate `Advanced.adoc` 원문과 일치 |
| j1 `01` | JPQL이 읽은 행을 버리고 캐시 인스턴스를 반환 | `CacheMode.REFRESH_SESSION`의 존재가 기본 동작의 반증 |
| j1 `02` | `COMMIT` 모드여도 네이티브 SQL은 플러시 | Flushing 챕터 원문과 일치 |
| j2 `04` | 프록시 `getId()`는 SQL을 내지 않는다 | `Interacting.adoc`이 같은 형태의 예제로 명시 |
| j3 `02` | `List` 둘을 페치 조인하면 예외 | Hibernate 자체 테스트 `MultipleBagFetchHqlTest` |
| j3 `03` | 자기 호출·rollback-only·`LockModeType.WRITE`가 낙관적 모드 | Spring Framework Reference와 JPA 명세 |

**고친 오류 3건** — 셋 다 같은 노트 안에서 자기 모순이었다.

| # | 위치 | 증상 | 조치 |
|---|---|---|---|
| 1 | j1 `02` | `write-behind`를 "쓰기를 읽기 뒤로 미룬다"로 풀이 | 캐시 용어의 실제 뜻(메모리 반영이 먼저, DB 반영이 뒤따름 · write-through의 반대)으로 교체. 같은 노트 §2.1이 **자동 플러시로 쓰기를 읽기 앞으로 보낸다**고 설명해 정면으로 어긋나 있었다 |
| 2 | j2 `05` | "`REMOVE`만 켜고 컬렉션에서 빼면 FK가 `null`이 되어 `NOT NULL` 위반" | 이 매핑은 `mappedBy` 반대편이라 **아무 일도 일어나지 않는다.** 같은 절 12줄 뒤가 이미 옳게 적고 있었다. 단방향 `@JoinColumn` 경우를 대조로 남겼다 |
| 3 | j3 `05` | "OSIV가 커넥션을 요청 끝까지 붙잡는다" 위에 세운 수치 논증 | Hibernate User Guide — RESOURCE_LOCAL은 **트랜잭션이 끝나면 커넥션을 반환**한다. 실제 비용(트랜잭션 밖 쿼리 · 요청당 획득 횟수의 예측 불가능성)으로 논증을 다시 썼고, 옛 주장은 `*_AND_HOLD` 모드에서 성립한다는 단서와 확인 방법과 함께 남겼다 |

### 판정

구조는 책 트랙과 같거나 그 이상이다(`_map` 축 4개, glossary 완전 1:1, 사용자 영역 무침범). 내용도 위 3건 외에는 공식 문서와 어긋나는 곳을 찾지 못했다. **다만 "오류가 없다"가 아니라 "14개 전문을 읽고 반증 가능한 주장을 대조한 결과 3건을 찾아 고쳤다"가 정확한 표현이다.**

## 남은 범위

- 상세 재작성 대상이 **더 남아 있지 않다.** 다음 단계는 사용자가 노트를 읽은 뒤의 **인출 연습**이다.
- 인출 연습과 regen 일정은 사용자가 책 전체 정리를 마친 뒤 시작하기를 원했으므로 아직 설정하지 않았다.
- `part-0-jpa-foundations/`는 **2026-08-28에 전수 검증을 마쳤다**(아래 절). 책 트랙과의 위키 링크는 여전히 만들지 않았다 — 연결은 각 `_map.md`의 표에 둔다.

### 해소된 항목

- Chapter 15 `01-core-framework-changes.md:55`의 깨진 폴더 링크는 Ch15 통합 재작성 때 해당 초안 9개를 삭제하며 함께 사라졌다.
- `README.md`의 Chapter 2 주제 수와 완료 범위 문구는 사용자 지시에 따라 갱신했다.
- Chapter 7의 깨진 Ch13 링크 2건은 Ch7 전면 재작성으로 해소됐다.
- Chapter 11의 깨진 링크 3건(`chapter-2-building-web-applications-...`, `chapter-6-externalizing-configuration-...`, part 경계를 넘지 않는 Ch13 링크)은 Ch11 전면 재작성으로 해소됐다.
- Chapter 4의 파일 rename으로 끊긴 인바운드 링크 3건(Ch2 `_map.md:186`, Ch3 `_map.md:181`, Ch5 `_map.md:159`)을 링크 한 줄씩만 고쳐 복구했다.

### 대상 밖 기존 결함 — **전부 해소됨**

- `chapter-12-.../04-building-event-driven-services.md:69`의 깨진 링크(존재하지 않는 `chapter-3-data-persistence-with-spring-data`)는 **Ch12 전면 재작성으로 사라졌다.**

책 트랙 스윕(코드펜스·인라인 코드스팬 제외, Obsidian의 오른쪽 부분경로 매칭 적용) 결과 **위키 링크 2,916개 중 미해결 0개**였다. 이후 part-0을 포함한 저장소 전체 스윕에서도 **7,292개 중 미해결 0개**다. 저장소에 깨진 내부 링크가 하나도 남아 있지 않다.

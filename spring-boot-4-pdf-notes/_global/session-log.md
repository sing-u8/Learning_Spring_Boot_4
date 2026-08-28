# Session Log

## Regen Schedule

| Category | Last Regen | Next Due |
|---|---|---|
| chapter-1-core-features-of-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-2-creating-web-and-api-applications-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-3-querying-for-data-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-15-whats-new-in-spring-boot-4 | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-5-testing-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-4-securing-an-application-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-6-configuring-an-application-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-13-observing-spring-boot-4-applications | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-7-releasing-an-application-with-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |
| chapter-11-virtual-threads-in-java-and-spring-boot | 아직 미실시 | 인출 학습 시작 후 결정 |

## 2026-08-27 — PDF-first 재작성 시작

- 기존 노트는 구조만 확인하고 본문은 재사용하지 않기로 확정했다.
- 538쪽 PDF에서 목차와 Chapter 1–15를 `pdftotext -layout`으로 새로 추출했다.
- Part 1–7, Chapter 1–15, 상위 주제 95개를 학습 범위로 정했다.
- Chapter 16은 출판사 혜택 안내이므로 제외했다.
- 새 저장소 `spring-boot-4-pdf-notes`를 만들었다.

## 2026-08-27 — PDF-first 1차 정리 완료

- PDF 목차를 다시 대조해 예상 95개가 아니라 실제 99개 주제로 확정했다.
- 15개 Chapter 각각에 `_map.md`, `_glossary.md`와 주제별 concept note를 작성했다.
- 모든 주제 노트의 `source`에 책 쪽과 PDF 쪽 범위를 기록했다.
- Chapter 2에서 browser UI 1개, Chapter 13에서 Loki·metrics dashboard·Tempo 화면 3개를 PDF에서 직접 추출하고 육안 확인했다.
- Spring Boot 4.1과 Spring AI 2.0 계열 공식 문서를 보조 대조했으나 구성·순서·설명의 1차 근거는 PDF로 유지했다.
- Deep-tutor 검사 99/99, wiki link·image reference 검사, Mermaid 116/116 실제 SVG 렌더링을 완료했다.
- 기존 노트 폴더의 본문은 복사하지 않았으며 기존 폴더를 수정하지 않았다.

## 2026-08-27 — Chapter 1 상세 재작성

- **Modes**: Prepare / batch. 사용자 요청에 따라 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 3–21 / PDF pp. 28–46을 `pdftotext -layout`으로 새로 추출해 다시 읽었다.
- 기존 5개 압축 노트는 내용 완결성이 부족하다고 판정하고 전면 재작성했다.
- 원문의 `Creating custom properties`, `Externalizing application configuration`, `Configuring property-based beans`를 독립 노트로 분리해 Chapter 1 concept note를 5개에서 8개로 늘렸다.
- `_coverage.md`에서 모든 하위 절, 코드 예제, Tip/Note를 노트와 매핑했다.
- Spring Boot 4.0.3 공식 문서로 자동 구성, property source 순서, 조건부 프로퍼티, BOM을 교차 확인했다.
- 책의 `@ConditionalOnProperty` 설명에 `false` 예외가 빠진 점과 property source 목록에 `@DynamicPropertySource`가 빠진 점을 노트에서 명시적으로 보강했다.
- Chapter 1 PDF에는 추출 가능한 raster 이미지가 없음을 `pdfimages -list`로 확인해, 원본 이미지 대신 밝은 배경 Mermaid를 사용했다.
- **Validation**: concept note 8/8 deep-tutor PASS, glossary/frontmatter terms PASS, wiki links PASS, Mermaid 17/17 실제 SVG 렌더링 PASS.
- **Gaps added**: 없음. 아직 사용자의 인출 시도가 없으므로 약점을 추정해 기록하지 않았다.
- **Gaps resolved**: 없음.
- **Regen due**: 아직 인출 학습 전이므로 일정 없음.
- **Next**: 사용자가 요청하면 같은 절차로 Chapter 2를 상세 재작성한다.

## 2026-08-27 — Chapter 2 상세 재작성

- **Modes**: Prepare / batch. 사용자 요청에 따라 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 25–69 / PDF pp. 50–94를 `pdftotext -layout -f 50 -l 94`로 새로 추출해 1,974줄 전체를 다시 읽었다.
- 기존 10개 압축 초안은 내용 완결성이 부족하다고 판정하고 전면 재작성했다.
- 원문의 실제 하위 절을 기준으로 concept note를 10개에서 15개로 늘렸다.
  - `Leveraging templates to create content` → `04` + `04a` + `04b` + `04c` + `04d`
  - `Hooking in Node.js to a Spring Boot web app` → `06` + `07`(번들링) + `07a`(React)
  - `07-bundling-javascript-and-building-a-react-app.md`는 실제 절 이름에 맞춰 `07-bundling-javascript-with-nodejs.md`로 `git mv` 했다. 다른 Chapter에서의 inbound link가 없음을 먼저 확인했다.
- `_coverage.md`를 새로 만들어 본문 절, 코드·명령·설정 예제 50개, Tip/Note 19개와 인용 1개, Figure 13개를 노트와 매핑했다.
- `pdfimages -f 50 -l 94 -list`로 raster 이미지 15개를 확인했다. Figure 2.1–2.13 중 학습 가치가 있는 10개를 `_assets/`로 추출하고 육안 대조했다. Figure 2.5·2.10(중복 UI 패턴), 2.11(2.6과 동일), PDF p.94의 Packt QR·로고는 제외했다.
- 기존 `assets/learning-spring-boot-4-simplify-the-deve-p59-fig2-7.png`는 PDF p.59 추출본과 SHA-1이 일치함을 확인한 뒤 `_assets/lsb4-p59-fig2-7-mustache-static-page.png`로 `git mv` 했다.
- Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)로 starter 구성, API versioning property 모델, HTTP Service Client 등록 방식을 교차 확인했다.
- 책의 오류·단순화 네 건을 노트에서 명시적으로 정정했다: React의 "shadow DOM"(실제는 virtual DOM), `await fetch(...).json()`(Promise에는 `.json()`이 없음), "`npm install`이 번들을 빌드한다"는 서술, 버전 property 목록 누락(`supported`와 예외 두 종).
- **Validation**: concept note 15/15 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 항목 0, wiki link 746개 중 unresolved 0, image reference 10개 중 missing 0, Mermaid 17/17 밝은 theme + 17/17 실제 SVG 렌더 PASS, `git diff --check` PASS.
- sequence diagram의 label 따옴표가 화면에 그대로 렌더되는 문제를 발견해 5개 블록을 수정하고 다시 렌더해 확인했다.
- **Gaps added**: 없음. 아직 사용자의 인출 시도가 없으므로 약점을 추정해 기록하지 않았다.
- **Gaps resolved**: 없음.
- **Regen due**: 아직 인출 학습 전이므로 일정 없음.
- **Next**: 사용자가 요청하면 같은 절차로 Chapter 3(책 pp. 71–96 / PDF pp. 96–121)을 상세 재작성한다. 아직 시작하지 않았다.
- **미처리로 남긴 것**: `spring-boot-4-pdf-notes/README.md`의 Chapter 2 주제 수가 아직 `10`이고 "Chapter 1만 상세 재작성 완료"라는 문구가 남아 있다. 작업 범위 규칙상 대상 Chapter와 `_global/` 밖 파일은 수정하지 않았으므로 사용자 확인 후 갱신이 필요하다.

## 2026-08-27 — Chapter 3 상세 재작성

- **Modes**: Prepare / batch. 사용자 요청에 따라 인출 연습은 시작하지 않았다.
- **작업 순서 지정**: 사용자가 Ch3 → Ch15 → Ch5 → Ch4 → Ch6 → Ch13 → Ch7 → Ch11 → Ch14 순서를 지정했다. Ch8·Ch9·Ch10·Ch12는 지시가 있을 때까지 손대지 않는다. `part-0-jpa-foundations/`는 다른 세션이 작성 중이므로 건드리지 않았다.
- **Source**: 책 pp. 71–96 / PDF pp. 96–121을 `pdftotext -layout -f 96 -l 121`로 새로 추출해 1,219줄 전체를 다시 읽었다.
- 기존 6개 압축 초안은 내용 완결성이 부족하다고 판정하고 전면 재작성했다.
- 원문의 실제 하위 절을 기준으로 concept note를 6개에서 12개로 늘렸다.
  - `Adding Spring Data to an existing Spring Boot application` → `01` + `01a` + `01b`
  - `DTOs, entities, and POJOs, oh my!` → `02` + `02a` + `02b`
  - `Using custom finders` → `04` + `04a`(정렬) + `04b`(제한)
  - 하위 제목이 없는 절(`03`, `05`, `06`)은 쪼개지 않았다. `04`의 다중 필드 검색 실습도 원문에 제목이 없어 `04` 안에 두었다.
  - `04-using-custom-finders-sorting-and-limits.md`는 정렬·제한이 분리되면서 이름이 맞지 않아 `04-using-custom-finders.md`로 `git mv` 했다. 이 rename으로 깨지는 외부 링크 1건(`chapter-5-testing-with-spring-boot/07-testing-repositories-with-testcontainers.md:54`)을 같은 작업에서 수정했다.
- `_coverage.md`를 새로 만들어 본문 절, 코드·설정 예제 27개, Tip/Note 12개를 노트와 매핑했다.
- `pdfimages -f 96 -l 121 -list` 결과 Chapter 3 범위의 raster 이미지는 PDF p.121의 Packt QR·로고 4개(smask 포함)뿐이라 **책 이미지를 하나도 추출하지 않았다.**
- Spring Boot 4.1.0 공식 문서(Context7 `/spring-projects/spring-boot/v4.1.0`)로 `spring-boot-h2console`, `spring-boot-persistence`, `spring-boot-data-jpa-test`, `spring.aot.enabled`를 교차 확인했다.
- 책의 부정확·불일치 다섯 건을 노트에서 명시적으로 정정했다: `spring.aot.enabled`만으로는 AOT repository가 생기지 않음, 테스트 모듈 이름 표기 차이, `spring-boot-h2console`이 이미 `h2`에 의존한다는 사실, `TypedSort` 예제가 이 장의 엔티티와 맞지 않음, 프로브·4-JOIN 예제가 이 장에 없는 필드를 씀.
- **Validation**: concept note 12/12 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 항목 0, wiki link 616개 중 unresolved 0, image reference 0, Mermaid 15/15 밝은 theme + 15/15 실제 SVG 렌더 PASS, `git diff --check` PASS.
- 육안 확인에서 `stateDiagram-v2` 하나가 라벨 겹침으로 읽기 어려워 flowchart로 교체하고 다시 렌더했다.
- Chapter 2 `_map.md`의 ASCII 도표 안에 코드펜스 때문에 렌더되지 않는 축약 위키링크 5건이 있어 평문으로 고쳤다(이번 세션이 만든 결함의 수정).
- `README.md`의 Chapter 2 주제 수(10 → 15)와 "Chapter 1만 완료" 문구를 사용자 지시대로 갱신했고, Chapter 3까지 반영했다.
- **Gaps added**: 없음. 아직 사용자의 인출 시도가 없으므로 약점을 추정해 기록하지 않았다.
- **Gaps resolved**: 없음.
- **Regen due**: 아직 인출 학습 전이므로 일정 없음.
- **Next**: 지정 순서상 다음은 **Chapter 15**(책 pp. 469–492 / PDF pp. 494–517)이며, 챕터 단위로 통째 정리하고 `01-core-framework-changes.md:55`의 깨진 링크를 함께 고친다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 15 상세 재작성 (챕터 단위 통합)

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 469–492 / PDF pp. 494–517을 `pdftotext -layout -f 494 -l 517`로 새로 추출해 1,130줄 전체를 읽었다.
- **분할 방식이 이전 Chapter와 다르다.** 사용자 지시("절 단위로 쪼개지 말고 챕터 단위로 통째로 정리한다")에 따라 기존 9개 절 단위 초안을 **단일 노트 `01-whats-new-in-spring-boot-4.md`로 통합**했다. 근거는 `_coverage.md` §0에 세 가지로 적었다 — 원문이 개념 전개가 아닌 변경 카탈로그이고, 설명 가능한 개념이 "Boot 4가 어느 방향으로 움직였는가" 하나이며, 절-Chapter 짝짓기는 표 하나로 제공하는 편이 정확하기 때문이다.
- 제거한 9개 초안(`01-core-framework-changes` … `09-additional-migration-changes`)은 사용자 영역이 모두 비어 있음을 사전에 확인했고, part-7 전체가 git 미추적 상태여서 `rm`으로 제거했다.
- `_coverage.md`에 9개 영역·34개 하위 절, Note 40개(교차 참조 15 / 공식 문서 링크 24 / 미수록 명시 1), 이름·좌표·프로퍼티 변경 53건을 매핑했다. **코드 리스팅은 원문에 하나도 없다.**
- `pdfimages -f 494 -l 517 -list` 결과 **이 범위에는 raster 이미지가 하나도 없다.** 헤더 두 줄만 출력됐다. 따라서 책 이미지를 추출하지 않았다.
- 노트의 중심 기여는 34개 항목을 관통하는 **다섯 방향**(명시성 / 모듈 세분화 / 벤더 중립 표준 / 빌드 시점 이동 / 책임 이전)과, 변경을 **네 성격 × 발견 시점**으로 나눈 위험도 축이다. 특히 "컴파일도 되고 시작도 되는데 동작만 달라지는" 유형(Batch 인메모리, `@SpringBootTest` 웹 테스트, LiveReload, SSL 만료 상태)을 별도로 묶었다.
- **사용자가 지시한 깨진 링크 수정**: `01-core-framework-changes.md:55`가 존재하지 않는 폴더 `chapter-2-building-web-applications-with-spring-boot`를 가리켰다. 그 파일이 통합 노트로 대체되면서 링크도 사라졌고, 같은 의도의 참조를 올바른 경로(`chapter-2-creating-web-and-api-applications-with-spring-boot/10-writing-null-safe-applications-with-jspecify`)로 통합 노트의 `## 7. 연결`에 넣었다.
- Chapter 3 `_map.md`가 가리키던 `03-data-layer-changes`도 통합 노트로 링크를 옮겼다.
- **Validation**: concept note 1/1 deep-tutor PASS, frontmatter terms 34개 전부 glossary 등재, 미사용 glossary 항목 0, wiki link 156개 중 unresolved 0, image reference 0, Mermaid 2/2 밝은 theme + 2/2 실제 SVG 렌더 PASS, `git diff --check` PASS.
- **README·상태 문서**: Chapter 15 주제 수 9 → 1, 전체 105개로 갱신했다.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 5**(책 pp. 153–185 / PDF pp. 178–210)다. 아직 시작하지 않았다.
- **남은 깨진 링크 (작업 대상 밖)**: `chapter-11-.../05-using-interface-proxy-http-service-clients.md:64`도 같은 잘못된 폴더 이름을 쓴다. Ch11은 지정 순서상 여덟 번째이므로 그때 함께 고친다. `chapter-12-.../04-building-event-driven-services.md:69`의 `chapter-3-data-persistence-with-spring-data`는 Ch12가 작업 대상이 아니라 남겨 뒀다.

## 2026-08-27 — Chapter 5 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 153–185 / PDF pp. 178–210을 `pdftotext -layout -f 178 -l 210`으로 새로 추출해 1,437줄 전체를 읽었다.
- 상위 절 8개에 **하위 제목이 하나도 없어** 절당 노트 하나로 두고 쪼개지 않았다. 기존 8개 초안의 파일 이름도 실제 절과 1:1로 맞아 rename 없이 전면 재작성했다.
- `_coverage.md`에 본문 절, 코드 예제 27개, Tip/Note 10개, Figure 6개를 매핑했다.
- `pdfimages -f 178 -l 210 -list` 결과 raster 이미지 6개(Figure 5.1–5.6)를 확인하고 **2개만 추출**했다.
  - Figure 5.4(커버리지 하이라이팅): 초록/빨강 gutter와 Coverage 패널, `VideoEntity` 전체 소스가 함께 보여 "protected 무인자 생성자만 미커버"라는 서술의 증거가 된다. 이 장의 `VideoEntity`가 Chapter 3판과 달리 `username` 필드를 갖는다는 사실도 드러난다.
  - Figure 5.6(Testcontainers 결과): 460ms 중 첫 테스트가 401ms를 차지해 **컨테이너 비용이 첫 테스트에 몰린다**는 것을 숫자로 보여 준다.
  - 미추출 4개(5.1·5.2·5.3·5.5)는 IDE 메뉴와 단순 통과 표시라 본문 서술로 충분하다고 판단했다. 특히 5.2는 본문이 언급하는 "49밀리초"가 **그림에서 잘려 없다**고 책 스스로 밝힌다.
- 원문의 오류·불일치 3건을 노트에 명시했다: p.182 테스트 메서드 이름이 비어 있는 조판 오류(`void () throws Exception {`), 절 제목과 테스트 대상 불일치(제목은 리포지토리, 실제는 `VideoService`), p.174가 예고한 `delete()` 테스트가 보안 절에 없음.
- Chapter 15에서 정리한 Boot 4 변화(`@MockitoBean` 개명, `@WebMvcTest` import 경로, Testcontainers 2.x 좌표)를 이 장의 코드와 연결했다.
- **Validation**: concept note 8/8 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0, wiki link 466개 중 unresolved 0, image reference 2개 중 missing 0, Mermaid 9/9 밝은 theme + 9/9 실제 SVG 렌더 PASS, `git diff --check` PASS.
- 자체 결함 수정: 코드펜스 안에 들어가 렌더되지 않던 위키링크 2건(노트 04·07)을 펜스 밖으로 옮겼다. 노트 07의 `DDL-자동화` 용어가 §4 표에만 있고 본문 인라인 링크가 없어 추가했다.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 4**(책 pp. 97–151 / PDF pp. 122–176)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 4 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 97–151 / PDF pp. 122–176을 `pdftotext -layout -f 122 -l 176`으로 새로 추출해 2,372줄 전체를 읽었다. 이 책에서 가장 긴 장이다.
- 상위 절 9개 아래에 **실제 하위 제목 14개**가 있어, 책에 인쇄된 하위 제목을 그대로 분할선으로 삼아 노트 **23개**로 나눴다. 하위 제목을 새로 만들어 쪼갠 곳은 없다. 기존 초안 10개는 파일 이름이 절 구조와 맞지 않아(예: `05-protecting-against-csrf`가 실제로는 하위 제목) 전부 교체했다.
- `_coverage.md`에 본문 절, 코드·설정 예제 49개, Tip/Note 19개, Figure 9개를 매핑했다.
- `pdfimages -f 122 -l 176 -list` raster 9개(Figure 4.1–4.9)를 전부 PNG로 뽑아 육안 대조한 뒤 **5개만** 추출했다.
  - 4.2 기본 로그인 폼, 4.4 인증 정보 렌더 화면, 4.7 YouTube 브랜드 계정 선택, 4.8 렌더된 YouTube 표, 4.9 자체 서명 인증서 경고.
  - 특히 4.4에서 책 본문이 한 번도 언급하지 않는 **`FactorGrantedAuthority [authority=FACTOR_PASSWORD, …]`**(Spring Security 7의 인증 수단 authority)가 `ROLE_USER` 옆에 찍혀 있는 것을 발견해 노트에 반영했다. 같은 화면이 alice에게 bob 소유 동영상의 Delete 버튼까지 보여 준다는 사실도 "서버 인가와 화면 렌더링은 별개"의 증거로 썼다.
  - 미추출 4개: 4.1은 개념 관계도라 Mermaid로 재현, 4.3은 4.2와 같은 폼, 4.5는 브라우저 기본 403 화면, 4.6은 4.7과 중복이고 개인 이메일이 노출돼 있다.
- **로컬 배포물 대조.** Gradle 캐시의 Spring Boot 4.1.0 / Spring Security 7.1.0 jar를 직접 열어 확인했다. `ServletWebSecurityAutoConfiguration$SecurityFilterChainConfiguration#defaultSecurityFilterChain`의 바이트코드가 책의 "단순화 버전"과 정확히 일치했고, `UserDetailsService.loadUserByUsername`, `AuthorizationManagers.allOf/anyOf/not`, `AuthorityAuthorizationManager`에 `hasAllRoles`가 없다는 점, `CommonOAuth2Provider`의 상수 4개, `OAuth2ClientHttpRequestInterceptor#setClientRegistrationIdResolver`, `spring-boot-starter-security-oauth2-client` 아티팩트를 각각 확인했다.
- **원문의 오류·불일치 10건**을 노트와 `_coverage.md` 5절에 명시했다. 대표적으로 `loadUserByName`/`loadUserName()` 오기, 정책 코드 6줄에 설명 5개(`/admin` 규칙 누락), "마지막 줄 하나만 다르다"는 서술과 실제 diff 불일치, `@ElementCollection List<GrantedAuthority>`의 JPA 매핑 불가, `/delete/videos/**` 허용 규칙 부재, `YouTube` 빈 등록 코드 부재, SSL Bundle 프로퍼티 이름 오류(Boot 4.1 타입은 `jks`·`pem`), CSS 선택자와 템플릿 태그 불일치.
- **Validation**: concept note 23/23 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0, wiki link 811개 중 unresolved 0, image reference 5개 중 missing 0, Mermaid 41/41 밝은 theme + 41/41 실제 SVG 렌더 PASS(대표 6개는 PNG로 육안 확인), 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **다른 Chapter 링크 보수.** 파일 이름이 바뀌면서 끊긴 인바운드 링크 3건을 최소 수정했다 — Ch2 `_map.md:186`, Ch3 `_map.md:181`, Ch5 `_map.md:159`.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 6**(책 pp. 189–205 / PDF pp. 214–230)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 6 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 189–205 / PDF pp. 214–230을 `pdftotext -layout -f 214 -l 230`으로 새로 추출해 694줄 전체를 읽었다.
- 상위 절 5개에 **하위 제목이 하나도 없어** 절당 노트 하나로 두고 쪼개지 않았다. 기존 5개 초안의 파일 이름이 실제 절과 1:1이고, **Ch1 `_map.md`와 Ch7 노트 2개·Ch8 노트 1개가 그 이름을 직접 참조**하고 있어 rename도 하지 않았다. 덕분에 이번엔 다른 Chapter 링크를 손대지 않았다.
- `_coverage.md`에 본문 절, 코드·설정 예제 19개, Tip/Note 7개, Figure 2개를 매핑했다.
- `pdfimages` raster 2개를 모두 PNG로 뽑아 육안 대조한 뒤 **1개만** 추출했다.
  - Figure 6.2(IntelliJ 코드 완성): 팝업에 `app.config.users` `List<UserAccount>`, `app.config.header` `String`이 **선언한 타입과 함께** 떠 있어, `spring-boot-configuration-processor`가 만드는 메타데이터가 이름만이 아니라 타입까지 담는다는 사실이 드러난다. 이 절의 주장을 증명하는 유일한 자료다.
  - Figure 6.1(IntelliJ 실행 구성)은 미추출. 본문이 위치를 그대로 서술하고, 세 활성화 방법 중 가장 이식성이 낮으며, 화면에 본문과 무관한 `java 25 graalvm-25` 런타임 선택까지 찍혀 있어 잡음이 된다. 화면이 주는 유일한 추가 정보인 "Comma-separated list of profiles" 힌트는 노트에 문장으로 옮겼다.
- **공식 문서·배포물 대조.** Context7 `/spring-projects/spring-boot/v4.1.0`으로 프로퍼티 소스 우선순위 15항목과 Config Data 4단계가 책과 **정확히 일치**함을 확인했고, "Merging Complex Types" 항목에서 **리스트는 병합되지 않고 통째로 교체된다**는 책의 Tip도 확인했다. Boot 4.1.0 jar에서 `@ConfigurationPropertiesBinding`·`@ConfigurationPropertiesScan`·`@EnableConfigurationProperties`·`bind/ConstructorBinding`·`RandomValuePropertySource`의 존재와 패키지를 직접 확인했다.
- **원문의 오류·공백 5건**을 노트와 `_coverage.md` 5절에 명시했다. 가장 큰 것은 `app.config.users`를 정의하고 컨버터까지 만들면서 **그 값이 Spring Security에 도달하는 경로를 끝내 보여 주지 않는다**는 점이다. 그 밖에 `UserAccount` 재정의 부재, `-D`와 환경 변수를 동등하게 소개하면서 우선순위 차이를 언급하지 않는 점, 본문(`application-alternate.yaml`)과 Figure 6.2(`application-alt.yaml`)의 파일 이름 불일치, `Convert()` 대문자 오기.
- **Validation**: concept note 5/5 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0, wiki link 255개 중 unresolved 0, image reference 1개 중 missing 0, Mermaid 13/13 밝은 theme + 13/13 실제 SVG 렌더 PASS, 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 13**(책 pp. 347–397 / PDF pp. 372–422)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 13 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 347–397 / PDF pp. 372–422를 `pdftotext -layout -f 372 -l 422`로 새로 추출해 2,082줄 전체를 읽었다.
- 상위 절 6개 아래에 **실제 하위 제목 9개**가 있어 15개 노트로 나눴다. **기존 6개 파일 이름은 하나도 바꾸지 않았다** — Ch11·Ch12·Ch14가 `06-correlating-logs-metrics-and-traces`를, Ch7이 `02-designing-an-observability-architecture`를 참조하고 있어서다. 새로 만든 9개만 접미사 노트(`03a`~`03c`, `04a`~`04c`, `05a`~`05c`)로 더했다.
- `_coverage.md`에 본문 절, 코드·설정 예제 29개, Tip/Note 7개, Figure 15개를 매핑했다.
- `pdfimages` raster 15개(Figure 13.1–13.15)를 UI 후보 위주로 뽑아 육안 대조한 뒤 **6개만** 추출했다.
  - 13.4(Loki 구조화 로그): `Common labels`에 `deployment_environment=local`·`service_name=employee-service`가 찍혀 Collector의 `loki.resource.labels` 승격이 실제로 먹었음을 증명한다.
  - 13.6(Prometheus 질의): `employee_created_count_total{…, role="ENGINEER"} 15` — `.tag("role", role)`이 질의 가능한 라벨이 됐다는 직접 증거이고, `exported_job` 라벨이 6절 `tracesToMetrics` 설정과 이어진다.
  - 13.7(Grafana 대시보드): `outcome` 태그 4종이 패널 항목(duplicate 8·failed 8·received 23·sent 7)과 1:1로 대응한다.
  - 13.10(Tempo waterfall): span 5개 계층과 `process employee notification (2.18s)`이 4.69초의 약 46%를 차지하는 것이 막대 길이로 보인다.
  - 13.11(View Trace 링크): 로그 본문에 최상위 `"traceid"`(소문자)와 `attributes` 안의 `"traceId"`(camelCase)가 둘 다 있어, `derivedFields` 정규식이 어느 쪽을 잡는지 눈으로 확인된다.
  - 13.13(span 링크 메뉴): `tracesToMetrics`의 질의 이름 셋과 `tracesToLogsV2`의 Related logs가 설정한 문자열 그대로 메뉴에 뜬다.
  - 미추출 9개: 13.1·13.2·13.3·13.5·13.8은 개념 관계도라 Mermaid로 재현했고, 13.9·13.12는 각각 13.10과 중복, 13.14·13.15는 13.13이 보여 주는 이동의 도착지라 본문 서술로 충분하다.
- **원문의 오류·불일치 9건**을 노트와 `_coverage.md` 5절에 명시했다. 대표적으로 설정의 패키지(`com.learningspringboot4`)와 화면 로그(`com.springbootlearning4`) 불일치, "모든 `System.out`을 SLF4J로 바꿨다"는 Note와 달리 `NotificationService`에 남아 있는 `System.out.println`, 설명이 언급한 `recordNotificationMetric("received")`·`("duplicate")` 호출이 인쇄된 코드에 없는 점, Trace ID가 두 곳에서 다르게 인쇄되고 16진수가 아닌 문자가 섞인 점, 대시보드의 실패율 0%와 failed 8의 병존, 9464 포트 노출 설정 부재.
- **Validation**: concept note 15/15 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0(`대시보드` 1건을 노트 04c에 인라인 추가해 해소), wiki link 621개 중 unresolved 0, image reference 6개 중 missing 0, Mermaid 36/36 밝은 theme + 36/36 실제 SVG 렌더 PASS, 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **다른 Chapter 링크**: 파일 이름을 유지해 인바운드 링크 4건을 손대지 않았다. 다만 Ch7의 두 링크는 **이번 작업 이전부터** 존재하지 않는 폴더 `chapter-13-observability-with-spring-boot-4`를 가리키고 있다. Ch7 차례에 함께 고친다.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 7**(책 pp. 207–227 / PDF pp. 232–252)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 7 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 207–227 / PDF pp. 232–252를 `pdftotext -layout -f 232 -l 252`로 새로 추출해 925줄 전체를 읽었다.
- 상위 절 4개 아래에 **실제 하위 제목 4개**가 있어 8개 노트로 나눴다. **기존 4개 파일 이름은 유지**했다 — Ch8 `04-building-native-container-images`와 Ch10 `03-creating-reactive-repositories-and-r2dbc-access`가 참조한다.
- `_coverage.md`에 본문 절, 코드·명령 예제 20개, Tip/Note 10개, Figure 1개를 매핑했다.
- **책 이미지는 추출하지 않았다.** 이 장의 raster 이미지는 Figure 7.1 하나뿐이고, Docker Hub Repositories 목록의 한 행(`namespace/name`, Public, 5분 전)이 전부다. 그 정보는 본문의 `docker tag` 설명과 Note가 그대로 서술하며, 학습 대상은 화면이 아니라 두 명령이다. 9.4MB로 얻는 것에 비해 과해 미추출로 판단하고 노트에 표로 정리했다.
- **Boot 4.1.0 배포물 대조.** Gradle 캐시의 설정 메타데이터를 직접 열어 확인한 결과, 책이 p.222에 적은 **`spring.jpa.hibernate.show-sql`은 존재하지 않는 키**였다. `spring.jpa.hibernate` 아래에는 `ddl-auto`·`naming.*`·`use-new-id-generator-mappings`만 있고 SQL 출력 키는 `spring-boot-jpa` 모듈의 `spring.jpa.show-sql`이다. 바로 아래 항목 설명은 올바른 키를 쓰고 있어 코드와 설명이 어긋난다.
- **원문의 오류·공백 6건**을 노트와 `_coverage.md` 5절에 명시했다. 가장 큰 것은 Docker Compose 절이 `application-instance*.properties`의 **위치를 밝히지 않는다**는 점이다. 앞 절은 그 파일을 JAR 옆에 만들라고 했는데 Compose는 이미지를 그대로 띄우므로, 그대로 따르면 컨테이너가 프로파일 설정을 찾지 못한다. 그 밖에 플러그인 버전(4.0.0)과 배너(v4.1.0) 불일치, `depends_on`이 준비 완료를 "보장한다"는 서술, `-p 5432:5432`를 "public에 export"라 한 표현, Hibernate 6 이후 불필요한 방언 명시.
- **Validation**: concept note 8/8 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0, wiki link 322개 중 unresolved 0, Mermaid 20/20 밝은 theme + 20/20 실제 SVG 렌더 PASS, 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **해소된 결함**: Ch7 초안이 갖고 있던 깨진 링크 2건(존재하지 않는 폴더 `chapter-13-observability-with-spring-boot-4`)이 전면 재작성으로 사라졌고, Ch13의 실제 경로(`../../part-5-.../chapter-13-observing-spring-boot-4-applications/...`)로 대체됐다. 저장소 전체에서 그 문자열이 남은 곳은 `_global` 기록 문서뿐이다.
- 표 셀 안에서 `\|`로 escape한 위키링크 2건이 checker에서 미해석으로 잡혀, 링크를 표 밖 문장으로 옮겨 정리했다.
- **Gaps added / resolved**: 없음.
- **Next**: 지정 순서상 다음은 **Chapter 11**(책 pp. 295–314 / PDF pp. 320–339)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 11 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 295–314 / PDF pp. 320–339를 `pdftotext -layout -f 320 -l 339`로 새로 추출해 886줄 전체를 읽었다.
- 상위 절 6개에 **실제 하위 제목은 1개**(*Using RestClient with Virtual Threads*)뿐이고, 그것이 상위 절 도입 두 문단 바로 뒤에 붙는 같은 절의 본문이라 쪼개지 않고 `04`에 담았다. **기존 6개 파일 이름은 유지**했다 — Ch12가 `01`·`03`을, Ch10이 `04`를 참조한다.
- `_coverage.md`에 본문 절, 코드·설정 예제 20개, Tip/Note 5개, Figure 1개를 매핑했다.
- **책 이미지는 추출하지 않았다.** 유일한 raster인 Figure 11.1은 스타일 없는 HTML 화면(`Employees` 제목, 목록 세 줄, 입력 두 칸)이고 **이 장의 주제인 가상 스레드에 대한 정보가 하나도 없다.** 본문도 이 화면 바로 뒤에서 "로그를 봐도 가상 스레드 관련 항목이 보이지 않을 것"이라고 말한다. 이 장의 진짜 증거는 로그 출력이며 책에 텍스트로 실려 있어 노트에 그대로 인용했다.
- **Boot 4.1.0 배포물 대조.** `spring.threads.virtual.enabled`가 `spring-boot-autoconfigure-4.1.0.jar`의 설정 메타데이터에 존재함을, `spring-boot-starter-restclient`가 실제 배포 아티팩트임을 Gradle 캐시에서 직접 확인했다.
- **원문의 오류·공백 5건**을 노트와 `_coverage.md` 5절에 명시했다. 가장 실질적인 것은 마지막 예제의 `CompletableFuture.runAsync()`가 **실행자를 주지 않아 `ForkJoinPool.commonPool()`의 플랫폼 스레드에서 돈다**는 점이다. 장의 주제가 가상 스레드인데 마지막 코드가 그것을 쓰지 않으며, 책은 "커스텀 실행자를 줄 수 있다"고만 언급하고 예제를 고치지 않는다. 그 밖에 "Project Loom, introduced in Java 21" 표현, 수신 측 로그만 `http-nio-8080-exec-1` 명명, 앱이 자기 자신을 호출하는 구조의 안전성 미설명, `@ImportHttpServices` 대안 미언급.
- **Validation**: concept note 6/6 deep-tutor PASS, frontmatter terms → glossary 미등재 0, 미사용 glossary 0, wiki link 275개 중 unresolved 0, Mermaid 16/16 밝은 theme + 16/16 실제 SVG 렌더 PASS, 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **해소된 결함**: Ch11 초안이 갖고 있던 깨진 링크 3건이 전면 재작성으로 사라졌다 — 존재하지 않는 폴더 `chapter-2-building-web-applications-with-spring-boot`(`_global`의 기존 결함 목록에 있던 항목), `chapter-6-externalizing-configuration-with-spring-boot`, 그리고 part 경계를 넘지 않는 형태로 적힌 Ch13 링크. 저장소 전체에서 앞의 두 문자열이 남은 곳은 없다.
- **Next**: 지정 순서상 마지막은 **Chapter 14**(책 pp. 401–465 / PDF pp. 426–490)다. 아직 시작하지 않았다.

## 2026-08-27 — Chapter 14 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 401–465 / PDF pp. 426–490을 `pdftotext -layout -f 426 -l 490`으로 새로 추출해 3,028줄 전체를 읽었다.
- 상위 절 7개 아래에 **실제 2단계 하위 제목 11개, 3단계 하위 제목 10개**가 있다. 2단계 제목 전부와 3단계 중 `What are embeddings and vector stores?` 하나만 분할선으로 삼아 **7 → 19개** 노트로 나눴다. **기존 7개 파일 이름은 하나도 바꾸지 않았다** — 상위 절과 1:1로 맞고, Ch14를 참조하는 다른 장의 inbound 링크는 0이다.
- 3단계 제목 9개를 쪼개지 않은 근거: `Inline prompt parameterization`/`Externalizing prompts with templates`는 같은 문제(동적 prompt)의 두 선택지라 나란히 둬야 결정 기준이 보이고, `Prompt caching`/`Local models…`도 비용을 줄이는 두 수단이며, `Prompt injection` 이하 4개는 한 노트 안에서 위협→대응 순서로 읽히는 쪽이 낫다. 반대로 embedding·vector store·semantic search는 RAG 없이도 성립하는 독립 개념이고 원문도 6쪽을 쓰므로 `05a`로 분리했다.
- `_coverage.md`에 본문 절, 코드·설정 예제 44개, Tip/Note 16개, Figure 5개를 매핑했다.
- **책 이미지는 한 장도 추출하지 않았다.** `pdfimages -f 426 -l 490 -list`가 실제 이미지 5개(PDF pp. 429·450·457·475·482)와 마지막 쪽 QR 2개를 보여 줘 5개를 전부 PNG로 뽑아 **육안으로 확인**한 결과, 화면 캡처·대시보드·책 고유 데이터가 아니라 **전부 개념 관계도**였다 — 14.1 Spring AI 추상 계층, 14.2 tool calling 8단계, 14.3 RAG 색인/질의 2단계, 14.4 MCP client+server, 14.5 LLM-as-a-Judge 평가 흐름. CLAUDE.md의 "개념 관계는 Mermaid 우선" 규칙에 따라 다섯 장 모두 Mermaid로 재현했다. Ch3·Ch7·Ch11과 같은 결론이다.
- **원문의 오류·불일치 8건**을 노트와 `_coverage.md` 5절에 명시했다. 실질적인 것 넷:
  - `McpClientController` 코드 블록에 클래스를 닫는 `}`가 없어 그대로 복사하면 컴파일되지 않는다(p.455).
  - RAG 응답을 `{"reply": "..."}` JSON으로 보여 주지만 바로 위 `rag(...)`의 반환형은 `String`이라 실제 응답은 평문이다(p.443).
  - "defensive system prompt와 **SafeGuardAdvisor**를 결합하는 방법을 보여 준다"고 쓰고 제시한 코드에는 `SafeGuardAdvisor`가 없다 — `defaultSystem(...)`뿐이다(p.463).
  - token metric을 p.460은 `gen_ai.client.token.usage`(label `gen_ai_token_type`)로, p.465는 `gen_ai.usage.input_tokens`/`output_tokens`로 부른다. 같은 대상을 두 이름으로 가리킨다.
  - 나머지: 설명 항목의 대문자 오타 `.Stream()`·`.Call()`·`.User()` 3건, 책 자신이 구버전이라고 경고하는 `withChunkSize(...)` 예제, `spring-ai-rag` 의존성 블록의 `<artifactId>`·`<groupId>` 역순, Figure 14.5 캡션만 동사로 시작.
- **Mermaid 렌더 중 잡은 결함 2건**을 실제 SVG/PNG 육안 확인으로 고쳤다. flowchart 라벨에 쓴 HTML 엔티티 `&#40;`·`&#41;`가 **리터럴 문자열로 렌더**되어 `prompt&(&)` 형태로 깨졌고(6개 노트 15곳), `04b`의 `sequenceDiagram autonumber`가 화살표 9개를 세어 본문의 "8단계"와 어긋났다. 전자는 따옴표 안 괄호를 그대로 쓰도록 바꾸고, 후자는 autonumber를 빼고 원문 단계 번호를 메시지에 직접 넣었다. `03`도 독립 시나리오 2개를 연속 번호로 매기고 있어 autonumber를 제거했다.
- **Validation**: concept note 19/19 deep-tutor PASS, frontmatter term 참조 155개 중 glossary 미등재 0, 미사용 glossary 0, 인라인 gloss 중 frontmatter 누락 0(`토큰-사용량` 1건을 노트 05 frontmatter에 추가해 해소), wiki link 301개 중 unresolved 0, 로컬 image reference 0개(missing 0), Mermaid 21/21 밝은 theme + 21/21 실제 SVG 렌더 PASS, 코드펜스에 갇힌 위키링크 0, `git diff --check` PASS.
- **다른 Chapter 링크**: Ch13(`04-metrics-…`, `06-correlating-…`)·Ch9·Ch5·Ch6·Ch3·Ch15를 `../../part-…` 전체 경로로 참조하며 전부 실재를 확인했다. 기존 초안이 part 경계를 넘지 않는 형태로 적어 두었던 Ch13·Ch9 링크 2건은 전면 재작성으로 사라졌다.
- **Gaps added / resolved**: 없음.
- **Next**: 사용자가 지정한 순서(Ch3 → Ch15 → Ch5 → Ch4 → Ch6 → Ch13 → Ch7 → Ch11 → Ch14)가 **전부 끝났다.** 남은 상세 재작성 대상은 Ch8·Ch9·Ch10·Ch12 네 개이며, 사용자의 별도 지시 전에는 시작하지 않는다. `part-0-jpa-foundations/`는 다른 세션의 작업 영역이라 이번에도 손대지 않았다.

## 2026-08-28 — Chapter 8 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 229–248 / PDF pp. 254–273을 `pdftotext -layout -f 254 -l 272`로 추출해 846줄 전체를 읽고, 요약이 다음 쪽까지 이어져 `-f 273 -l 275`를 추가 확인했다.
- 상위 절 7개 아래에 **2단계 하위 제목 6개**가 있어 12개 노트로 나눴다(7 → **12**). 하위 제목 5개를 모두 분리한 이유는 각각이 다른 질문에 답하기 때문이다 — 비용 논증, Spring Native의 행방, 서드파티 준비 상태, AOT 캐시 명령, 네 전략 비교.
- **기존 7개 중 6개는 이름을 유지하고 하나만 rename**했다. `07-java-25-aot-cache-and-crac-comparison` → `07-using-java-25-aot-cache`. CRaC 비교가 `07b`로 분리되며 원래 이름이 실제 내용과 어긋났고, 저장소 전체 확인 결과 **Ch8 밖 inbound 링크가 0건**이었다(참조 4건은 전부 이번에 재작성하는 Ch8 자신).
- `_coverage.md`에 본문 절, 코드·명령 예제 19개, Tip/Note 6개, Figure 2개를 매핑했다.
- **책 이미지 1개 추출.** raster 2개를 전부 PNG로 뽑아 육안 확인했다. **Figure 8.1**(`native:compile` 출력)은 메서드 컴파일 161초, 이미지 159.62MB(코드 영역 94.15MB / 이미지 힙 63.70MB), **hibernate-core 21.60MB가 최대 기여**, reflection metadata 1.65MB, Peak RSS 5.03GB 같은 **수치 자체가 학습 대상**이라 `_assets/`에 넣었다. **Figure 8.2**(macOS 방화벽 대화상자)는 OS 표준 UI라 미추출.
- **Boot 4.1.1 / Framework 7.0.9 배포물 대조.** Gradle 캐시에서 직접 확인했다 — `MemberCategory.INVOKE_DECLARED_CONSTRUCTORS`·`INVOKE_PUBLIC_METHODS`는 **deprecated가 아니고**(deprecated는 `PUBLIC_FIELDS`·`DECLARED_FIELDS`뿐), `RuntimeHintsRegistrar.registerHints(RuntimeHints, ClassLoader)` 시그니처가 책과 정확히 일치하며, `@RegisterReflectionForBinding`은 spring-context가 아니라 **spring-core의 `org.springframework.aot.hint.annotation`**에 있고, `spring.context.exit`는 `DefaultLifecycleProcessor`가 6.1부터 구현한다.
- **Context7 대조**로 두 가지를 확인했다. `org.graalvm.buildtools:native-maven-plugin`과 `spring-boot-starter-parent`의 `native` profile은 책 서술과 일치한다. 반면 **AOT 캐시 training run 절차는 책과 공식 문서가 다르다** — 공식은 `java -Djarmode=tools -jar app.jar extract`로 먼저 풀어낸 뒤 그 디렉터리에서 훈련하라고 하며, 그 이유("AOT cache 친화적 배치")까지 밝힌다.
- **원문의 오류·공백 7건**을 노트와 `_coverage.md` 5절에 명시했다. 대표적으로 uber JAR에 직접 training run을 거는 절차, 근거 JEP에서 **JEP 514(단일 명령 흐름의 실제 근거)가 빠진** 점, Hibernate 강화 옵션 3개가 이미 **deprecated for removal**인 점, CRaC만 명령 없이 언급되고 끝나는 점(공식에는 `spring.context.checkpoint=onRefresh`와 `Restored` 배너가 있다), CDS 미언급, "0.1초에 뜬다"가 실측 0.528초와 어긋나는 점, GraalVM이라는 이름이 VM과 `native-image` 컴파일러 둘을 가리키는 점.
- **Validation**: concept note 12/12 deep-tutor PASS, term 참조 94개 중 glossary 미등재 0, 미사용 glossary 0, 인라인 gloss 중 frontmatter 누락 0, wiki link 179개 중 unresolved 0, image reference 1개 중 missing 0, Mermaid 14/14 밝은 theme + 14/14 실제 SVG 렌더 PASS, `git diff --check` PASS.
- **Next**: Chapter 9.

## 2026-08-28 — Chapter 9 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 251–278 / PDF pp. 276–303을 `pdftotext -layout -f 276 -l 303`으로 추출해 1,197줄 전체를 읽었다.
- 상위 절 6개 아래에 **2단계 하위 제목 7개**가 있어 12개 노트로 나눴다(6 → **12**). `Introduction to Reactive`만은 상위 절 도입과 이어져 배압 하나를 설명하는 한 덩어리라 `01`에 합쳤다.
- **기존 6개 파일 이름은 하나도 바꾸지 않았다** — Ch10의 세 노트가 `02`·`04`·`05`를 직접 참조한다.
- `_coverage.md`에 본문 절, 코드 예제 20개, Tip/Note 9개, Figure 3개를 매핑했다.
- **책 이미지는 한 장도 추출하지 않았다.** raster 3개(Figure 9.1·9.2·9.3)를 전부 PNG로 뽑아 육안 확인한 결과 **스타일 없는 브라우저 화면**이고 **리액티브에 관한 정보가 화면 어디에도 없다** — 같은 화면이 Spring MVC로도 똑같이 나온다. 9.2 → 9.3의 POST-redirect-GET 왕복은 `05b`에 Mermaid sequence로 재현했다. Ch11 Figure 11.1과 같은 판단이다.
- **Boot 4.1 / Framework 7.0.9 배포물 대조.** `spring-boot-starter-webflux-test`가 실제 배포 아티팩트임을, `Rendering`이 `view(String)`과 **`redirectTo(String)`** 두 static 진입점을 가짐을, `Mono.zip`의 static 오버로드가 19개이고 `zipDelayError`가 Tuple2~Tuple8까지 있음을 Gradle 캐시에서 직접 확인했다.
- **원문의 오류·공백 7건**을 노트와 `_coverage.md` 5절에 명시했다. 대표적으로 p.275의 `InIn this case,` 오타, `@EnableHypermediaSupport(type = HAL)`이 static import 없이는 컴파일되지 않는 점, redirect에 문자열 규약 대신 **`Rendering.redirectTo`라는 타입 있는 대안**이 있는데 쓰지 않는 점, `Scaling applications with Project Reactor`가 내용상 §1의 연장인데 POST 절 뒤에 배치돼 읽는 흐름이 끊기는 점, "25% 손실"이 낙관적 하한인 점, "인터페이스 4개뿐"이 TCK와 규칙 문서를 빠뜨린 서술인 점, 가상 스레드를 "다른 길"로 언급만 하고 결정 기준을 비교하지 않는 점.
- **자체 결함 1건을 렌더로 잡았다.** `05b`의 `sequenceDiagram`에 쓴 **`&lt;`·`&gt;` HTML 엔티티가 Mermaid sequence 파서를 깨뜨린다**(`Parse error`). 최소 재현으로 확인한 뒤 해당 블록의 엔티티를 평문으로 바꿨다. **flowchart에서는 같은 엔티티가 정상 렌더**되므로(PNG 육안 확인) sequenceDiagram에서만 금지된다.
- **Validation**: concept note 12/12 deep-tutor PASS, term 참조 101개 중 glossary 미등재 0, 미사용 glossary 0, 인라인 gloss 중 frontmatter 누락 0, wiki link 180개 중 unresolved 0, 로컬 image reference 0개, Mermaid 14/14 밝은 theme + 14/14 실제 SVG 렌더 PASS.
- **Next**: Chapter 10.

## 2026-08-28 — Chapter 10 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 281–294 / PDF pp. 306–319를 `pdftotext -layout -f 306 -l 319`로 추출해 603줄 전체를 읽었다. 이 책에서 가장 짧은 축의 장이다.
- 상위 절 4개 아래에 **2단계 하위 제목 3개**(전부 §4)가 있어 6개 노트로 나눴다(4 → **6**). §4 도입부는 첫 하위 제목과 합쳤다 — "데이터베이스 초기화와 샘플 데이터 적재부터 시작한다"가 곧 그 제목의 예고이기 때문이다.
- **기존 4개 중 3개는 이름을 유지하고 하나만 rename**했다. `04-connecting-reactive-data-to-api-and-templates` → `04-loading-data-with-r2dbcentitytemplate`. API·템플릿 연결이 `04a`·`04b`로 분리되며 이름이 어긋났고, **Ch10 밖 inbound 링크가 0건**임을 확인했다. Ch9는 이 장의 `01`·`02`만 참조하며 그 이름은 유지했다.
- `_coverage.md`에 본문 절, 코드 예제 12개, Tip/Note 4개를 매핑했다.
- **책 이미지 0개.** `pdfimages` 결과 이 범위의 raster는 마지막 쪽의 QR·로고 4개뿐이고 **본문에 Figure 번호가 한 번도 등장하지 않는다.** Ch3와 같은 상황이라 `_assets/`도 만들지 않았다.
- **원문의 오류·공백 6건**을 노트와 `_coverage.md` 5절에 명시했다. 실질적인 것 셋 — p.291 POST 코드의 **`});f`** 오타(그대로 복사하면 컴파일 실패), p.293이 record에 **`e.getName()`·`e.getRole()`**을 호출하는데 같은 장 p.290은 올바르게 `e.name()`을 쓰는 **접근자 문법 불일치**, 초기화 코드가 **`subscribe()`를 인자 없이 불러 오류를 삼키는** 점(테이블 생성이 실패해도 애플리케이션은 정상 기동한다).
- 그 밖에 "R2DBC는 저수준이니 툴킷을 쓰라"고 해 놓고 **스키마 정의만은 저수준 `DatabaseClient`로 내려가야 한다는 사실을 명시하지 않는** 공백, "25% 하락"이 Ch9와 같은 낙관적 하한인 점, 장 끝의 "템플릿은 변경 없이 복사"가 위 접근자 오류와 합쳐져 독자에게 판단을 떠넘기는 점을 기록했다.
- **Validation**: concept note 6/6 deep-tutor PASS, term 참조 45개 중 glossary 미등재 0, 미사용 glossary 0, 인라인 gloss 중 frontmatter 누락 0, wiki link 83개 중 unresolved 0, 로컬 image reference 0개, Mermaid 8/8 밝은 theme + 8/8 실제 SVG 렌더 PASS.
- **Next**: Chapter 12.

## 2026-08-28 — Chapter 12 상세 재작성

- **Modes**: Prepare / batch. 인출 연습은 시작하지 않았다.
- **Source**: 책 pp. 317–343 / PDF pp. 342–368을 `pdftotext -layout -f 342 -l 368`로 추출해 1,136줄 전체를 읽었다.
- 상위 절 6개 아래에 **2단계 하위 제목 11개**가 있어 13개 노트로 나눴다(6 → **13**). 네 상위 절(`01`·`02`·`04`·`05`)의 도입부는 모두 **첫 하위 제목과 합쳤다** — 도입이 한두 문단이고 곧바로 첫 하위 제목의 예고로 이어지기 때문이다.
- **기존 6개 파일 이름은 하나도 바꾸지 않았다.** 상위 절과 1:1로 대응하고 Ch12 밖 inbound 링크가 0건이다.
- `_coverage.md`에 본문 절, 코드 예제 19개, Tip/Note 3개, Figure 6개를 매핑했다.
- **책 이미지 1개 추출.** raster 6개를 전부 PNG로 뽑아 육안 확인했다. Figure 12.1·12.2(sequence)·12.3(producer-broker-consumer)·12.4(topic·partition·consumer group)는 **개념 관계도**라 Mermaid로 재현했다. **Figure 12.6**(Offset Explorer 화면)만 추출했다 — 좌측 트리의 **`employee-events-dlt`가 자동 생성됐다는 사실**과 payload의 **`"email":null`**이라는 **실패 원인이 그 그림에만 있고** 본문은 "DLT로 전달됐다"고만 말하기 때문이다. Figure 12.5(Add Cluster 대화상자)는 책 자신이 도구를 "선택 사항"이라 명시해 미추출하되, 화면의 불일치는 아래에 기록했다.
- **원문의 오류·공백 8건**을 노트와 `_coverage.md` 5절에 명시했다. 실질적인 것 넷:
  - p.323과 p.330의 `EmployeeCreatedEvent`가 **`Instant` vs `LocalDateTime`** 두 버전으로 제시된다. JSON 표현이 달라 섞어 쓰면 역직렬화가 깨진다.
  - **Figure 12.5가 Zookeeper 접근을 켜고 포트 2181을 설정**해 보여 주는데, 같은 절의 `docker-compose.yml`은 **KRaft 모드**라 Zookeeper가 아예 없다. `Kafka Cluster Version: 0.11`도 `cp-kafka:7.8.8`과 맞지 않는다. 그대로 따라 하면 막힌다.
  - `createEmployee`가 **JPA 저장과 Kafka 발행을 트랜잭션 경계 없이** 한 메서드에서 수행한다. 책 자신이 p.342 Note에서 **outbox 패턴**이 해법이라고 말하면서도 그 Note와 이 코드를 연결하지 않는다.
  - `spring.json.trusted.packages: "*"`를 "production에서는 제한하라"고 덧붙이면서 **예제 설정은 그대로 `*`**로 둔다.
  - 그 밖에 `EmployeeService`의 `final` 누락, 실패 시뮬레이션에서 `Math.random()` 줄이 맨 앞이라 **영구 실패 경로가 1/8 확률로만 도달**하는 점, 멱등 검사가 `sendNotification` 성공 뒤에 ID를 추가해 **재시도가 만드는 중복은 막지 못하는** 점, 제목은 DLQ인데 본문은 DLT인 점.
- **해소된 결함**: Ch12 초안이 갖고 있던 깨진 링크 1건(존재하지 않는 `chapter-3-data-persistence-with-spring-data`)이 전면 재작성으로 사라졌다. **이로써 저장소 전체(part-0 제외)의 위키 링크 2,916개 중 미해결이 0개**가 됐다.
- **Validation**: concept note 13/13 deep-tutor PASS, term 참조 81개 중 glossary 미등재 0, 미사용 glossary 0, 인라인 gloss 중 frontmatter 누락 0, wiki link 164개 중 unresolved 0, image reference 1개 중 missing 0, Mermaid 16/16 밝은 theme + 16/16 실제 SVG 렌더 PASS.
- **Gaps added / resolved**: 없음.
- **Next**: **학습 대상인 Chapter 1–15의 상세 재작성이 전부 끝났다.** Chapter 16은 출판사 혜택 안내라 범위 밖이다. `part-0-jpa-foundations/`는 다른 세션의 작업 영역이라 이번에도 손대지 않았다. 다음 단계는 사용자가 노트를 읽은 뒤 인출 연습으로 넘어가는 것이다.

## 2026-08-28 — 재검증: Mermaid 표기 규칙 정정과 JEP 514 사후 확인

사용자가 "그 결함들을 제대로 해결한 게 맞느냐"고 물어 다시 확인했다. **두 가지를 정정했다.**

- **1차 진단이 부정확했다.** Ch9 `05b`의 sequence 파서 에러 원인을 "`<`·`>` 때문"이라고 적었는데, 최소 재현 테스트 결과 **파서를 깨뜨린 것은 엔티티 표기(`&lt;`)이고 raw 꺾쇠는 정상**이었다. 즉 `Mono of Rendering`이라는 1차 조치는 에러는 없앴지만 **불필요하게 나쁜 표기**였다.
- 확정한 규칙은 **두 다이어그램 종류가 서로 반대**라는 것이다. flowchart는 raw `Flux<Employee>`를 쓰면 **`<Employee>`가 HTML 태그로 먹혀 내용이 사라지고**(화면에 `Flux`만) 엔티티 `&lt;`가 정답이다. sequenceDiagram은 그 반대로 raw 꺾쇠가 정답이고 엔티티는 파서 에러다. 뒤에 공백이 오는 `< 0.5`는 양쪽 다 정상이다.
- 그에 따라 Ch9 `05b`를 `Mono<Rendering>`·`Mono<Employee>`로, Ch12 `05`를 코드와 같은 `Math.random() < 0.5`로 다시 고치고 **PNG로 육안 재확인**했다.
- **저장소 전수 검사**: 두 결함 패턴 모두 15개 Chapter에서 0건. flowchart에서 raw 꺾쇠로 **내용이 유실된 곳도 0건**이다(`<br/>` 제외 태그 유사 패턴 검사).

그리고 원문 오류 28건 중 **세션 안에서 근거를 대지 않고 단정한 유일한 항목**인 JEP 514를 OpenJDK 자료로 사후 확인했다.

- 제목 *Ahead-of-Time Command-Line Ergonomics*, JDK 25 대상, 책이 쓰는 **`-XX:AOTCacheOutput`을 도입한 JEP가 맞다.** 주장은 옳았고 이제 근거가 붙었다.
- 확인 과정에서 **책에 없는 운영상 함정**을 하나 더 얻었다 — one-step 워크플로는 캐시 생성 하위 호출이 training run과 **같은 크기의 자기 힙**을 쓰므로 `-Xmx4g`면 환경에 **8GB**가 필요하다. `07a` §5에 추가했다.

이 시점의 한계는 **이번 네 Chapter의 Mermaid 52개 중 표본만 PNG로 육안 확인했다**는 것이었다. 아래 항목에서 해소했다.

## 2026-08-28 — Mermaid 259개 전수 육안 검증

- **Modes**: 검증만. 인출 연습은 시작하지 않았다.
- 사용자 요청("나머지 Mermaid도 전부 PNG로 육안 확인해줘")에 따라 **15개 Chapter의 Mermaid 블록 259개를 하나도 빼지 않고 PNG로 확인했다.** part-0은 대상 밖이다.
- 노트마다 `mmdc`를 한 번씩 돌리는 **markdown batch 렌더**로 259개를 뽑았고(블록당 개별 실행보다 3배 빠르다), Chapter별 개수가 소스와 정확히 일치함을 먼저 확인했다.
- mmdc 기본 폭이 784px이라 **가로:세로 비 6 이상인 28개는 판독이 불가능**했다. 이 28개는 `-s 3` 확대 렌더 후 **1,300px 타일 56장**으로 잘라 다시 봤다.
- **결함 7건을 잡아 전부 고치고 재렌더·재확인했다.** 모두 **CLI 렌더는 성공한** 블록이다.
  - flowchart **self-loop**의 라벨이 노드에 가려짐 — Ch5 `07`, Ch7 `04c`. 별도 노드로 분리했다.
  - 화살표 라벨에 **노드 id가 그대로 섞여** `E2 진입점을 늘린다`로 렌더 — Ch8 `02`.
  - 주석 노드를 **subgraph에 연결**해 라벨을 덮음 — Ch12 `_map.md`. 구체 노드에 연결로 바꿨다.
  - 라벨의 **여는 괄호가 닫히지 않아** `Observation.observe(`로 잘려 보임 — Ch13 `05b`.
  - **역방향 화살표 쌍**의 두 라벨이 겹쳐 `도구가 필요하다고결과!` — Ch14 `04`. 복귀 경로에 노드를 하나 세웠다.
  - sequence 마지막 두 메시지가 **둘 다 `8.`** — Ch14 `04b`. 책 p.436의 8단계가 실제로 두 동작을 한 단계로 묶으므로 `8. (같은 단계)`로 명시했다.
- **패턴별 전수 검사**로 개별 수정에서 끝내지 않았다. self-loop 2건(→0), 노드 id가 섞인 라벨 1건(→0), 괄호 불균형 0건, 역방향 화살표 쌍 7쌍 중 6쌍은 겹침 없음을 육안 확인.
- **결함이 아닌 것**도 구분해 기록했다 — `_map` 사슬이 가로로 길어 축소 렌더에서 작게 보이는 것(SVG 열람에서는 정상), subgraph가 선언 역순으로 배치되는 것, Ch13 `03c`의 `싸다`처럼 원문 대조로 의도한 표기임을 확인한 것.
- **Validation**: concept note **163/163** deep-tutor PASS, Mermaid block 259 = 밝은 theme init 259, **PNG 육안 확인 259/259**, `git diff --check` PASS.
- **Gaps added / resolved**: 없음. `part-0-jpa-foundations/`는 이번에도 손대지 않았다.
- **Next**: 사용자가 노트를 읽은 뒤의 인출 연습.

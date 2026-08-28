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

## 2026-08-28 — part-0-spring-core-internals 신규 트랙 (c1~c4)

- **Modes**: Prepare / batch. 사용자 요청에 따라 인출 연습은 시작하지 않았다.
- **계기**: 사용자가 "이 노트가 공식 문서로 깊이 공부한 것과 같은 수준인가"를 물었다. 실측으로 답했다 — 178개 노트 중 공식 문서가 1차 소스인 것은 15개(8%)뿐이었고, `BeanPostProcessor`·`CGLIB`·`HandlerAdapter`·`ArgumentResolver`·`HttpMessageConverter`·`ApplicationEvent`는 저장소 전체에서 **0건**이었다. 그 격차를 메우는 트랙을 사용자가 지시했다.
- **Source**: PDF가 아니라 **공식 문서 1차**. `docs.spring.io` 직접 조회 12개 페이지(Framework Reference의 Container Extension Points·Lifecycle Callbacks·Proxying Mechanisms·AOP Concepts·Autoproxying·@Bean/@Configuration·DispatcherServlet 4개 절·Method Arguments·Content Types, Boot Reference의 Auto-configuration·Developing Auto-configuration) + Context7(`/websites/spring_io_spring-framework_reference`, `/spring-projects/spring-boot/v4.0.3` — 소스·Actuator API 포함).
- **산출**: concept note 17개(c1 4 · c2 4 · c3 5 · c4 4), `_map`·`_glossary`·`_coverage` 각 4개. 176,337자, 용어 50개, coverage 매핑 292행.
- **검증**: `check-note.sh` 17/17, `check-chapter.sh` 4/4, frontmatter `terms` ↔ glossary 50/50, wiki link 미해결 0, **Mermaid 21개 전부 mermaid-cli로 SVG 실제 렌더 성공**(21 블록 = 21 dark init = 21 렌더), `git diff --check` 통과.
- **공식 문서 대조로 드러난 흔한 설명과의 차이**: 각 챕터 `_coverage.md` §4에 총 41행. 대표 3건 —
  1. "인터페이스가 있으면 JDK 프록시"는 **Boot에서 틀리다.** Boot 자동 구성은 CGLIB가 기본(`spring.aop.proxy-target-class`).
  2. back-off는 우선순위가 아니라 **조건 불통과**다. 빈이 둘 생겼다가 하나가 선택되는 것이 아니다.
  3. `postHandle`에서 응답 헤더를 못 바꾼다. `@ResponseBody`는 `HandlerAdapter` 안에서 커밋되므로 공식 문서 표현대로 "이미 늦었다".
- **작업 중 발견한 기존 결함**: `part-0-web-foundations`(w1)가 `_global`에 **등록돼 있지 않았다.** 저장소 전체 노트 수가 177로 적혀 있었으나 실제는 178이었다. 이번 갱신에서 `config.md`·`source-manifest.md`를 바로잡았다(현재 195).
- **다음 범위**: 인출 연습. 사용자가 노트를 읽을 시간을 둔다. 답안 파일은 `config.md`의 진행 상태 표 순서를 따른다.

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

## 2026-08-28 — part-0-jpa-foundations 전수 검증과 상태 문서 등록

- **Modes**: 검증 + 상태 문서 정리. 인출 연습은 시작하지 않았다.
- **Source**: PDF가 아니라 Hibernate ORM / Spring Data JPA / Spring Framework·Boot 공식 문서(Context7). 이 트랙의 1차 소스가 그것이기 때문이다.
- 커밋·푸시 뒤 사용자 요청으로 **다른 세션이 쓴 part-0 14개 노트를 책 트랙과 같은 기준으로 검증**했다.
- **구조**: deep-tutor 14/14 PASS, frontmatter 누락 0, glossary 양방향 불일치 0(17·17·15), wiki link 386개 중 미해결 0, Mermaid 17개 전부 렌더 + **17/17 PNG 육안 확인**. 사용자 영역 marker 14개 전부 존재하고 전부 비어 있다.
- **내용**: 14개 **전문을 읽고** 반증 가능한 주장을 공식 문서와 대조했다. `@DynamicUpdate`+`@Version` 경고, JPQL의 캐시 인스턴스 반환, 네이티브 SQL 플러시, 프록시 `getId()`, `MultipleBagFetchException`, 자기 호출·rollback-only·`LockModeType.WRITE` — 전부 정확했다.
- **오류 3건을 찾아 고쳤다.** 셋 다 같은 노트 안에서 자기 모순이었다 — j1 `02`의 `write-behind` 어원(§2.1과 정반대), j2 `05`의 반대편 컬렉션 동작(12줄 뒤 서술과 모순), j3 `05`의 OSIV 커넥션 점유 논증(Hibernate RESOURCE_LOCAL 문서와 불일치). 마지막 건은 노트의 중심 논증이라 §1·§3 도표·§5까지 다시 썼다.
- **상태 문서 등록**: 이 트랙이 `config.md`·`source-manifest.md`·`README.md` 어디에도 없었다. CLAUDE.md가 part-0 작업 중 `_global/` 수정을, 책 트랙 작업 중 part-0을 각각 금지해 **어느 쪽도 등록할 권한이 없었던 규칙의 틈**이다. 세 문서에 트랙 상태·출처·"PDF 쪽 범위가 없는 이유"를 적었다. 이로써 저장소 concept note는 163 + 14 = **177개**다.
- **Validation**: concept note **177/177** deep-tutor PASS, wiki link **7,292개 중 미해결 0**, `git diff --check` PASS.
- **Gaps added / resolved**: 없음. 인출 연습 전이므로 [[gaps]]는 여전히 비어 있는 것이 맞다.
- **Next**: 정리 단계에서 남은 작업이 없다. 다음은 사용자가 노트를 읽은 뒤의 **인출 연습**이다.

## 2026-08-28 — 첫 인출 세션 · Ch1 `01-autoconfiguring-spring-beans`

- **Modes**: Depth(2단계 인출). Map 워크스루는 생략했다 — 대상 노트가 이미 지정된 상태로 세션이 열렸다.
- **Source**: 새 원문 대조 없음. 기존 정리물에 대한 인출 훈련이다.
- 사용자가 노트의 「8. 스스로 확인」 8문항 중 **7문항을 시도, 1문항(Q8) 미시도**했다. 답변 전문을 노트 구분자 아래 `## 내 설명 시도`에 기록했다.
- **매끄러웠던 곳**: Q1(DI가 만드는 교체 경계), Q3(Spring bean vs JavaBean), Q7(Framework/Boot 책임 분리).
- **정밀도 부족**: Q2(`@Bean` 반환값이 메서드 이름으로 등록된다는 점 누락), Q4(자동 구성 사이의 ordering 단계 누락), Q6(뼈대는 맞으나 본인이 확신하지 못함).
- **Gaps added**: 4건. 전부 `open`. 이 저장소의 **첫 gap 기록**이라 [[gaps]]의 "아직 인출 연습을 시작하지 않았다"는 안내 문장도 함께 갱신했다.
  - `core-mechanism` — 백오프의 검사 대상을 이름으로만 답함(Q5, Level 2 미달)
  - `vs-사용자-구성` — 백오프 시 사용자 빈의 등록 주체를 자동 구성으로 잘못 귀속(Q4)
  - `depends-on-애플리케이션-컨텍스트` — 자동 구성이 빈을 만드는지 빈 정의만 보태는지 미확정(Q6)
  - `core-mechanism` — Boot 4 모듈화의 인과 사슬 미시도(Q8)
- **Gaps resolved**: 없음.
- **Validation**: `check-note.sh` PASS. frontmatter `status: prepared → attempted`.
- **정리물 보강 판단**: 4건 모두 노트 본문(§2.4·2.5·2.6·2.8, §5)에 답이 있으므로 **설명 부족이 아니라 인출 실패**로 판정했다. 정리물은 고치지 않았다.
- **후속(같은 날)**: 사용자가 꼬리질문 A~D를 시도하는 대신 **모범답안 전체를 요청**해 제공했다. 스킬 기본 규칙(시도 전 답 제공 금지)보다 사용자의 명시적 지시를 우선했다.
  - Context7로 `/spring-projects/spring-boot/v4.0.3`을 3회 대조했다. 확인된 것: `@ConditionalOnMissingBean`의 기본 대상 타입 = `@Bean` 메서드의 **반환 타입**, 자동 구성 클래스는 **사용자 빈 정의가 등록된 뒤** 처리되므로 백오프가 성립한다는 점, `OnBeanCondition`이 filter/`REGISTER_BEAN` 2단계로 동작하고 `@ConditionalOnMissingBean`은 `REGISTER_BEAN` 단계에서만 평가된다는 점.
  - **노트가 담지 못한 Boot 4 사실 2건을 확인했다.** (1) `DataSourceAutoConfiguration`이 Boot 4에서는 `spring-boot-autoconfigure`가 아니라 **`spring-boot-jdbc` 모듈**의 `org.springframework.boot.jdbc.autoconfigure` 패키지에 있다 — §2.6의 모듈화 서술에 붙일 구체 근거다. (2) `AutoConfigurationReplacements`가 `META-INF/spring/<annotation>.replacements`로 옛 자동 구성 클래스명 참조를 새 이름에 매핑한다 — 모듈 분할이 호환 레이어를 요구할 만큼의 변화였다는 증거다.
- **Gaps 상태**: 4건 전부 `open` 유지. 답을 읽은 것은 인출이 아니므로 닫지 않았다.
- **후속 2 — 정리물 보강 + 답안 파일 분리 (사용자 요청)**: Ch1 `01`의 **구분자 위**만 고쳤다. 구분자 아래는 손대지 않았다.
  - `§2.4`에 조건 평가의 두 단계(필터 / `REGISTER_BEAN`)와 순서 지정 애노테이션(`@AutoConfiguration(before, after)`, `@AutoConfigureBefore/After`)을 추가하고, 자동 구성의 산출물이 객체가 아니라 **빈 정의**임을 명시했다.
  - `§2.5`에 「백오프는 우선순위 경쟁이 아니다」(무엇을·언제·누가 3칸 표 + `NoUniqueBeanDefinitionException`이 나지 않는다는 대조)와 「판정 기준은 이름이 아니라 타입이다」를 추가했다. Q5 stall을 정면으로 겨냥한 보강이다.
  - `§2.6`에 Boot 4의 실제 모듈·패키지 위치 표, 빌드 파일이 아키텍처 선언이 되는 인과, `AutoConfigurationReplacements` 호환 레이어를 추가했다. Q8 stall 대응이다.
  - `§6`의 "편의 기능을 잃을 수 있다" 한 줄을 구체 항목 4개(`spring.datasource.*` 조용한 무시 포함)와 오버라이드 3단계 전략으로 확장했다.
  - `_glossary.md`에 **빈-정의 (BeanDefinition)** 1건 신설, `01`의 frontmatter `terms`에 등재.
  - **답안 파일 신설**: `_answers-01-autoconfiguring-spring-beans.md`. `_` 접두라 `check-note.sh`·`check-chapter.sh`의 concept note 스키마와 고아 검사에서 면제된다(챕터 노트 수는 8개 그대로). `01`의 `§8` 끝에 "먼저 답한 뒤에 열라"는 경고와 함께 링크를 걸었다.
- **Validation**: `check-chapter.sh` **PASS**(필수 파일 3, coverage 참조·미해결·고아 전부 OK), 챕터 노트 **8/8** `check-note.sh` PASS, 새 파일의 wiki link 4개 전부 해결, `git diff --check` PASS.
- **미해결로 남긴 것**: `01`의 Mermaid init 2개가 작업 트리에서 프로젝트 규칙(밝은 theme)이 아닌 `{'theme': 'dark'}`로 바뀐 채 커밋되지 않은 상태다. 이번 세션의 변경이 아니고 사용자 확인 전이라 되돌리지 않았다.
- **Next**: 다음 세션은 Review 모드. 같은 문항을 반복하지 말고 엣지 형태로 재출제한다. 재출제 문항 5개는 `_answers-01-autoconfiguring-spring-beans.md` 끝에 적어 두었다. Level 3 도달 시 `resolved` 전환.

## 2026-08-28 — Ch1 `02` 답안 파일 + §2 보강

- **Modes**: 사용자 요청에 따른 답안 정리. 합의한 절차([[config]] 「인출 진행 방식」) 6번대로 **답안을 쓰기 전에 본문이 그 질문에 답하는지 먼저 점검**했다.
- **본문 점검 결과**: 7문항 중 **Q1~Q5는 답이 충분**(§2.2 6단계 · §2.7 표 · §2.3 표 · §2.4 6항목), **Q6·Q7은 얇았다.**
  - Q6은 §2.5가 "Spring은 자체 모델을 제공하면서도 표준 계약은 Jakarta EE API를 활용한다"고 **사실만 진술**하고 "왜 모순이 아닌가"의 논증이 없었다.
  - Q7은 §2.6이 "범위"와 "빌드 가독성" 두 축으로 정리된 곳이 없었고, 나뉘기 전 상태와의 대비도 없었다.
- **§2 보강 3건** (구분자 위만):
  - `§2.5` — "Jakarta EE"가 ①API 사양과 ②완전한 엔터프라이즈 런타임 두 층을 함께 가리킨다는 구분표, Spring이 대체한 것은 ②이고 의존하는 것은 ①이라는 논증, Servlet 계약이 컨테이너 교체 가능성을 산다는 이유, 공식 문서 근거 3건.
  - `§2.6` — 「나뉘면 무엇이 좋아지는가」 두 축 표(범위 / 빌드 가독성) + 범용 스타터와의 관계에 대한 주의.
  - `§2.4` — `spring-boot-starter-webmvc`의 실제 build.gradle 좌표 5줄과 옛 `spring-boot-starter-web`의 deprecated 표시.
- **공식 문서 대조로 찾은 것** (Context7, `/spring-projects/spring-boot/v4.0.3`):
  - ✅ `spring-boot-starter-webmvc`의 실제 구성 = `starter` + `starter-jackson` + `starter-tomcat` + `http-converter` + `webmvc`. 옛 `spring-boot-starter-web`은 이 스타터를 위해 **deprecated**.
  - ⚠ **책의 단순화 1** — 책은 MVC 스타터의 범위로 "검증과 오류 처리"를 들지만 **실제 좌표에 Bean Validation 스타터가 없다.** `spring-boot-starter-validation`이 따로 필요할 수 있다. `§2.4`에 주의 문단으로 넣었다. (main 브랜치 빌드 파일 기준이므로 사용 버전에서 dependency tree 확인 권고를 함께 적었다.)
  - ⚠ **책의 단순화 2** — 기술별 테스트 스타터가 범용 `spring-boot-starter-test`를 **대체한 것이 아니다.** Boot 4 문서는 여전히 범용 스타터를 기본으로 안내하고 기술별 `-test` 모듈을 **누적**해 쓰는 구성을 설명한다. 또 실제 좌표로 확인된 이름은 `spring-boot-{기술}-test` 형태의 **모듈**이며, 책이 쓰는 `spring-boot-starter-{기술}-test` 스타터 좌표는 이번 대조에서 확인하지 못했다. 둘 다 `§2.6` 주의 문단에 적었다.
  - ✅ Jakarta: BOM이 `jakarta.servlet-api` 6.1.0 · `jakarta.persistence-api` 3.2.0 · `jakarta.validation-api` 3.1.1을 직접 관리. Boot 4는 빌드 단계에서 `javax.*`를 금지(`javax.batch`·`cache`·`money`만 예외). Servlet 6.1 요구, Tomcat 11.0.x·Jetty 12.1.x.
- **답안 파일**: `_answers-02-adding-portfolio-components-using-spring-boot-starters.md` 신설. `§8` 끝에 경고와 함께 링크. 끝에 재출제 문항 7개.
- **Validation**: `check-chapter.sh` **PASS**, 챕터 노트 8/8 `check-note.sh` PASS, `git diff --check` PASS. `check-chapter`의 WARN(원문 2쪽 이하 독립 노트)은 이번 변경과 무관한 기존 경고이며, 병합 조건 (b)에 해당하지 않는다 — `02`는 자체 Mermaid 2개와 독립 메커니즘을 가진다.
- **Gaps**: 이번에는 사용자의 인출 시도가 없었으므로 추가하지 않았다. Ch1 `01`의 4건은 여전히 `open`.
- **Next**: 사용자가 `02`의 7문항을 스스로 시도한 뒤 답안과 대조. 다음 인출은 재출제 문항으로.
- **후속 — 답안 파일 배치 변경(사용자 요청)**: 챕터 루트에 두던 `_answers-*.md`를 **`{챕터}/answers/`** 폴더로 옮기고 이름을 `_{노트파일명}.md`로 줄였다. 폴더가 "답안"이라는 의미를 이미 주기 때문이다.
  - 훅은 `-notes` 아래 **깊이 1~2**만 검사하므로 `chapter-*/answers/*.md`(깊이 3)는 게이트 대상이 아니고, `check-chapter.sh`도 `$DIR/*.md`만 훑어 제외된다.
  - **그럼에도 `_` 접두는 유지해야 한다.** 이유가 폴더와 무관하다 — `check-note.sh`가 노트 본문의 `[[링크]]` 중 `_` 접두가 아닌 것을 용어로 보고 용어집과 대조한다. 비접두 이름으로 시험했더니 링크를 건 `01` 노트가 `FAIL 용어집 미등재: [[01-autoconfiguring-spring-beans-answers]]`로 떨어졌다. 실측으로 확인하고 되돌렸다.
  - 재검증: 노트 2개 `check-note.sh` PASS, `check-chapter.sh` PASS, 답안 파일의 wiki link 8개와 노트→답안 링크 2개 전부 해결, `git diff --check` PASS.
  - [[config]] 「인출 진행 방식」 4번을 새 경로와 두 제약으로 다시 썼다.

## 2026-08-28 — Ch1 `03`·`03a`·`03b`·`03c`·`04` 답안 파일 + §2 보강

- **Modes**: 사용자 요청에 따른 답안 정리. [[config]] 「인출 진행 방식」 6번대로 **답안을 쓰기 전에 본문 점검을 먼저** 했다.
- **본문 점검 결과 — 33문항 중 30개는 답이 충분, 3개가 얇았다.**

| 노트 | 문항 | 판정 |
|---|---:|---|
| `03` | 6 | Q6(properties vs yml이 **동일하게** 해결하는 것) 얇음 — 표가 차이만 보여 주고 공통점이 없었다 |
| `03a` | 6 | Q1의 **환경 변수 경로**를 설명할 근거가 본문에 없었다. §2.2가 "여러 소스가 합쳐진 승자 값"이라 하는데 환경 변수는 점 표기를 못 쓴다 |
| `03b` | 7 | Q5(`location` vs `additional-location`) 얇음 — 한 문장으로만 언급 |
| `03c` | 7 | 전부 충분. 보강 없음 |
| `04` | 8 | 전부 충분. 보강 없음 |

- **§2 보강 3건** (구분자 위만):
  - `03 §2.2` — 「무엇이 같은가」 표 신설(키 이름 공간·우선순위 층·도달 지점·바인딩 규칙). 진짜 차이는 두 파일 형식 사이가 아니라 **파일과 환경 변수 사이**임을 짚고 `03a`로 넘겼다.
  - `03a §2.7` **신설** — 「환경 변수로는 `my.app.header`라고 쓸 수 없다」. 느슨한 바인딩의 표준형 개념, 환경 변수 변환 규칙 3가지, 소스별 허용 표기 표, kebab-case 권장, `@ConfigurationProperties` 한정이라는 경계.
  - `03b §2.2` — `location`/`additional-location` 비교표 + 실패 증상(“JAR 안 기본값이 통째로 사라진다”) + `optional:`·디렉터리 `/`·처리 순서.
- **용어집**: `느슨한-바인딩 (relaxed binding)` 1건 신설, `03a` frontmatter `terms`와 §4 표에 등재.
- **공식 문서 대조** (Context7, `/spring-projects/spring-boot/v4.0.3`), 전부 ✅로 답안에 표시:
  - 표준형 → 환경 변수: 점을 밑줄로, **하이픈은 제거**, 대문자. `spring.main.log-startup-info` → `SPRING_MAIN_LOGSTARTUPINFO`. 리스트는 인덱스를 밑줄로 감싼다(`MY_SERVICE_0_OTHER`). `SystemEnvironmentPropertyMapper` javadoc과 external-config 문서 양쪽에서 확인.
  - 소스별 허용 표기: 파일·시스템 프로퍼티는 camelCase·kebab·밑줄, **환경 변수는 대문자+밑줄만**. 저장은 소문자 kebab 권장.
  - `spring.config.location`은 기본 위치를 **대체**, `additional-location`은 **추가**하며 추가 위치가 기본 위치를 **덮는다**. 없는 위치는 `ConfigDataLocationNotFoundException`으로 **시작 실패**, `optional:` 접두사와 `spring.config.on-not-found=ignore`가 회피 수단. 디렉터리는 `/`로 끝내야 하고, 두 키 모두 **환경 프로퍼티로 줘야** 한다.
- **답안 파일 5개 신설**: `answers/_03-*.md`(114줄), `_03a-*.md`(164줄), `_03b-*.md`(159줄), `_03c-*.md`(164줄), `_04-*.md`. 각 노트 `§8` 끝에 경고와 링크를 달았고, 파일 끝에 재출제 문항을 5~7개씩 넣었다.
- **Validation**: `check-chapter.sh` **PASS**, 챕터 노트 **8/8** `check-note.sh` PASS, 답안 파일 7개의 wiki link 전부 해결, 노트→답안 링크 7개 전부 해결, `git diff --check` PASS.
- **Gaps**: 사용자의 인출 시도가 없었으므로 추가하지 않았다. Ch1 `01`의 4건은 여전히 `open`.
- **Next**: Ch1 답안 파일이 8개 노트 중 7개에 갖춰졌다(`00-technical-requirements`만 없음). 사용자가 각 노트의 문항을 시도한 뒤 대조한다.

## 2026-08-28 — Ch2 전체 답안 파일 (15개 노트 · 122문항)

- **Modes**: 사용자 요청("Ch2부터 순서대로")에 따른 답안 정리. [[config]] 「인출 진행 방식」 6번대로 **답안을 쓰기 전에 본문 점검을 먼저** 했다.
- **본문 점검 결과 — 122문항 전부 답이 충분했다. 보강 0건.**
  - Ch1과 대비된다. Ch1은 33문항 중 3개가 얇아 `§2`를 세 곳 보강해야 했는데, **Ch2는 15개 노트 어디에도 보강이 필요 없었다.**
  - 이유가 노트 자체에 있다. Ch2 노트들은 `§1`에 "출발 장면 → 여기서 뭐가 무너지나 → 그래서 나온 생각" 구조를 두고, 비유마다 "→ 비유가 깨지는 지점"을 명시하며, `§5`·`§6`에 판별 질문과 경계를 따로 둔다. `§8` 문항이 그 구조의 각 지점을 그대로 겨냥하고 있어 대응이 1:1에 가깝다.
  - 그리고 Ch2 노트들은 **책의 오류를 이미 잡아 두었다** — `07a`의 `fetch(...).json()` 코드 오류와 "shadow DOM"→virtual DOM 용어 오류, `07`의 "`npm install`이 번들을 빌드한다"는 표현 정정. 답안은 그 정정을 그대로 반영했다.
- **답안 파일 15개 신설**: `chapter-2-.../answers/_01-*.md` ~ `_10-*.md`. 각 노트 `§8` 끝에 경고와 링크를 달았고, 파일 끝에 재출제 문항을 5~7개씩 넣었다.
- **공식 문서 대조** (Context7, `/spring-projects/spring-boot/v4.0.3`): 이번 챕터에서 새로 대조한 것은 `spring-boot-starter-webmvc`의 실제 구성뿐이며, 이는 Ch1 `02` 작업에서 확인한 것을 재사용했다(✅ 표시). 나머지는 노트 본문이 이미 공식 문서 보강을 담고 있어 추가 대조가 불필요했다.
- **Validation**: 챕터 노트 **15/15** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 파일 15개의 wiki link 전부 해결(`_09`의 `[[08]]` 축약 링크 1건을 전체 이름으로 고쳤다), `git diff --check` PASS.
- **Gaps**: 사용자의 인출 시도가 없었으므로 추가하지 않았다. Ch1 `01`의 4건은 여전히 `open`.
- **누적 상태**: 답안 파일이 Ch1에 7개(8개 노트 중 `00-technical-requirements` 제외), Ch2에 15개. **합계 22개.**
- **Next**: Ch3(12개 노트, 96문항)부터 같은 절차로 이어간다. 남은 범위는 Ch3~Ch15와 part-0을 합쳐 **노트 154개**다.

## 2026-08-28 — Ch3 전체 답안 파일 (12개 노트 · 96문항)

- **Modes**: 답안 정리. [[config]] 「인출 진행 방식」 6번대로 **본문 점검을 먼저** 했다.
- **본문 점검 결과 — 96문항 전부 답이 충분했다. 보강 0건.** Ch2에 이어 두 챕터 연속이다.
- **Ch3 노트가 이미 잡아 둔 책의 오류·모호점** (답안에 그대로 반영):
  - `04a` — 책의 `TypedSort` 예제(`Sort.sort(Video.class)`, `Video::getName`)가 이 장 코드로는 컴파일되지 않는다. 도메인 타입이 `VideoEntity`이고 Chapter 2의 `Video`는 getter가 없는 record이기 때문.
  - `05` — 책 예제의 `probe.setTags(...)`가 이 장 `VideoEntity`에 없는 필드다. 설명용 예시로 읽어야 한다.
  - `06` — `spring.aot.enabled=true`만으로는 AOT 리포지토리가 생기지 않는다. ✅ 공식 문서 기준 **빌드 시점 생성**(Maven `-Pnative` / Gradle `org.springframework.boot.aot`)이 선행돼야 하고, 그 프로퍼티는 실행 시점 스위치다.
  - `01b` — 책의 `spring-boot-starter-data-jpa-test` 좌표가 ✅ 공식 문서의 `spring-boot-data-jpa-test` **모듈** 표기와 다르다. Initializr가 내주는 좌표를 그대로 쓰는 것이 확실하다.
  - `01b` — ✅ `spring-boot-h2console`이 이미 `com.h2database:h2`를 api 의존성으로 갖는데도 책이 `h2`를 따로 넣는 이유(콘솔 제거 시 드러난 의도 + `runtime` scope 직접 지정).
- **답안 파일 12개 신설**: `chapter-3-.../answers/_01-*.md` ~ `_06-*.md`. 각 노트 `§8` 끝에 경고와 링크, 파일 끝에 재출제 문항 5~6개.
- **Validation**: 챕터 노트 **12/12** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 파일 12개의 wiki link 전부 해결, `git diff --check` PASS.
- **Gaps**: 사용자의 인출 시도가 없었으므로 추가하지 않았다.
- **누적**: 답안 파일 Ch1 7 + Ch2 15 + Ch3 12 = **34개**.
- **Next**: **Ch4**(23개 노트, 168문항). 이 저장소에서 가장 큰 챕터다.

## 2026-08-28 — Ch4 전체 답안 파일 (23개 노트 · 168문항)

- **Modes**: 답안 정리. 본문 점검을 먼저 했다.
- **본문 점검 결과 — 168문항 전부 답이 충분했다. 보강 0건.** Ch2·Ch3에 이어 **세 챕터 연속**이다.
- **Ch4 노트가 이미 잡아 둔 책의 오류** (답안에 반영):
  - `04` — 책이 `UserDetailsService`의 메서드를 `loadUserByName`, 두 문단 뒤 `loadUserName()`으로 **서로 다르게** 적는다. 실제는 `loadUserByUsername`. 그리고 `List<GrantedAuthority>` + `@ElementCollection`은 **그대로는 부팅되지 않는다**(인터페이스는 대상이 될 수 없다).
  - `05` — 코드에 규칙이 6줄인데 설명은 5개뿐이고 `/admin` 규칙을 건너뛴다.
  - `05a` — "직전 정책과 뒤에서 둘째 줄만 다르다"고 하지만 `.requestMatchers("/admin")` 규칙도 함께 사라졌다.
  - `08b` — 스타터 이름이 Boot 4에서 `spring-boot-starter-security-oauth2-client`로 바뀌었다(✅ 배포물 확인). `clientId` 표기는 완화된 바인딩 덕에 동작하지만 정규 표기는 kebab-case.
  - `08c` — 프록시 등록 코드(`@ImportHttpServices` 등)를 **끝내 보여 주지 않는다.** 그리고 `&order`가 HTML 엔티티로 해석돼 `ℴ`로 인쇄된 조판 사고.
  - `08d` — CSS 선택자가 `thead th`인데 템플릿 헤더는 `<td>`다. Figure 4.8에서 테두리만 먹고 열 너비가 균등한 이유.
  - `09a` — 책의 `spring.ssl.bundle.pkcs12.*` 표기가 Boot 4.1과 맞지 않는다. 번들 타입은 **`jks`와 `pem` 둘뿐**이고 키스토어 경로 키는 `keystore.location`이다. 또 "번들은 `server.ssl.bundle` 아래에 정의한다"는 서술도 틀렸다(그건 참조 키다).
- **답안 파일 23개 신설**: `chapter-4-.../answers/_01-*.md` ~ `_09b-*.md`. 각 노트 `§8` 끝에 경고와 링크, 파일 끝에 재출제 문항 5~7개.
- **Validation**: 챕터 노트 **23/23** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 파일 23개의 wiki link 전부 해결, `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 = **57개**.
- **Next**: **Ch5**(8개 노트, 64문항).

## 2026-08-28 — Ch5 답안 파일 (8/8)

- **Mode**: 인출 대비 답안 정리(Prepare 보조). 대상 `part-2-.../chapter-5-testing-with-spring-boot/`.
- **범위**: 노트 8개, `## 8. 스스로 확인` **65문항**(01=7, 02~07=8, 08=9).
- **본문 보강**: **0건.** 65문항 전부 노트 본문(§1 출발 장면 / §2 단계별 이유 / §5 판별 / §6 경계)에서 답이 나온다. Ch2~Ch4와 같은 결과.
- **Ch5 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `08` — 책 p.182 리스팅이 `void () throws Exception {`으로 인쇄돼 **메서드 이름이 비어 있다.** 다음 문단이 `unauthUserShouldNotAccessHomePage`를 언급하므로 조판 사고.
  - `08` — 책이 `05`절에서 예고한 **`delete()` 보안 테스트가 이 절에 없다.** `delete`는 `SecurityConfig` 규칙 목록에만 나온다.
  - `07` — 저자 스스로 `findByNameContainsOrDescriptionContainsAllIgnoreCase`가 "책의 편집을 망가뜨린다"며 Query by Example 전환을 권한다.
  - `06` — Testcontainers 2.x 좌표 변경(`junit-jupiter` → `testcontainers-junit-jupiter`)이 Boot 3 예제와 어긋나는 지점.
- **답안 파일 8개 신설**: `chapter-5-.../answers/_01-*.md` ~ `_08-*.md`. 각 노트 `§8` 끝에 경고와 링크, 파일 끝에 재출제 문항 5~9개.
- **수정 1건**: `_04` 답안을 실제 문항 순서에 맞춰 재작성했다(초안이 Q1 "원문 제목이 오해를 부르는 이유"를 건너뛰어 번호가 한 칸씩 밀려 있었다).
- **Validation**: 챕터 노트 **8/8** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 파일 8개 wiki link **unresolved 0**(`_01`의 Ch1 링크가 part 경계를 넘어 `../../part-1-...`로 교정), `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 + Ch5 8 = **65개**.
- **Next**: **Ch6**(5개 노트).

## 2026-08-28 — Ch6 답안 파일 (5/5)

- **Mode**: 인출 대비 답안 정리. 대상 `part-3-.../chapter-6-configuring-an-application-with-spring-boot/`.
- **범위**: 노트 5개, `## 8. 스스로 확인` **41문항**(01=9, 02=8, 03=8, 04=7, 05=9).
- **본문 보강**: **0건.** 41문항 전부 노트 본문에서 답이 나온다.
- **Ch6 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `01` — `app.config.users`를 정의하고 컨버터까지 만들지만 **그 사용자들이 Spring Security에 어떻게 도달하는지 끝내 보여 주지 않는다.** Ch4의 `UserDetailsService`는 여전히 `UserRepository`를 본다. `UserAccount` 재정의도 없다(Ch4의 것은 JPA 엔티티).
  - `02` — `-D`와 `SPRING_PROFILES_ACTIVE`를 **동등한 선택지**로 제시하지만, 같은 장 `05`의 우선순위 목록에서는 **시스템 프로퍼티가 환경 변수보다 높다.** 동시 지정 시 `-D`가 이긴다는 사실이 언급되지 않는다.
  - `03` — 본문은 `application-alternate.yaml`을 만들라고 하는데 Figure 6.2의 편집기 탭은 **`application-alt.yaml`**이다. 실행 예제가 `SPRING_PROFILES_ACTIVE=alternate`이므로 본문 쪽이 맞다.
- **답안 파일 5개 신설**: `chapter-6-.../answers/_01-*.md` ~ `_05-*.md`. 각 노트 `§8` 끝에 경고와 링크, 파일 끝에 재출제 문항 7~9개.
- **Validation**: 노트 **5/5** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 + Ch5 8 + Ch6 5 = **70개**.
- **Next**: **Ch7**(8개 노트).

## 2026-08-28 — Ch7 답안 파일 (8/8)

- **Mode**: 인출 대비 답안 정리. 대상 `part-3-.../chapter-7-releasing-an-application-with-spring-boot/`.
- **범위**: 노트 8개, `## 8. 스스로 확인` **66문항**(01·02·03·04·04a·04b=8, 02a·04c=9).
- **본문 보강**: **0건.** 66문항 전부 노트 본문에서 답이 나온다.
- **Ch7 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `02a` — build-image 로그는 `spring-boot-maven-plugin:**4.0.0**`인데 바로 아래 컨테이너 실행 로그 배너는 `Spring Boot (v**4.1.0**)`이다.
  - `04b` — 코드 블록의 **`spring.jpa.hibernate.show-sql`은 존재하지 않는 키**다(정답은 `spring.jpa.show-sql`). 바로 아래 설명은 올바른 키를 쓰고 있어 블록과 설명이 어긋난다. `spring.jpa.properties.hibernate.dialect` 명시도 Hibernate 6 이후 대개 불필요.
  - `04b` — `-p 5432:5432`를 "public에 export된다"고 설명하지만 실제로는 호스트 인터페이스 바인딩이다.
  - `04c` — **가장 큰 공백.** `compose.yml`이 `image: ch7:...`를 그대로 띄우는데, 앞 절이 만든 `application-instance{N}.properties`는 **호스트의 JAR 옆**에 있어 이미지 안에 없다. 그대로 따르면 프로파일 설정도 DB 접속 정보도 적용되지 않는다. 이미지에 담으면 이번엔 `server.port`(9000)와 포트 매핑(→8080)이 어긋난다. 책은 둘 다 설명하지 않는다.
  - `04c` — `depends_on`을 "DB가 먼저 뜨도록 **보장한다**"고 쓰지만 실제로는 **기동 순서만** 보장한다.
- **답안 파일 8개 신설**: `chapter-7-.../answers/_01-*.md` ~ `_04c-*.md`. 각 노트 `§8` 끝에 경고와 링크, 파일 끝에 재출제 문항 8~9개.
- **Validation**: 노트 **8/8** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 + Ch5 8 + Ch6 5 + Ch7 8 = **78개**.
- **Next**: **Ch8**(12개 노트).

## 2026-08-28 — Ch8 답안 파일 (12/12)

- **Mode**: 인출 대비 답안 정리. 대상 `part-3-.../chapter-8-going-native-with-spring-boot/`.
- **범위**: 노트 12개, `## 8. 스스로 확인` **48문항**(전 노트 4문항, `-` 불릿).
- **본문 보강**: **0건.**
- **Ch8 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `01` — 책이 GraalVM을 "새로운 가상 머신"으로 소개하지만 이 장이 실제로 쓰는 것은 **`native-image` AOT 컴파일러**다. 최종 산출물에 JVM이 없다.
  - `02` — Hibernate 강화 옵션 셋(`enableLazyInitialization` 등)이 공식 문서 기준 **모두 deprecated for removal**.
  - `03a` — **숫자 불일치.** 책이 "우리 앱이 방금 그랬듯 0.1초"라 쓰지만 실측 로그는 **0.528초**다. "5.6시간 → 17분" 대비가 그 가정 위에 서 있고, 실측으로는 약 8.8분.
  - `05` — 책이 패키지를 안 적는다(`@ImportRuntimeHints`만 `context.annotation`, 나머지는 `aot.hint`). 필드 카테고리는 SF7에서 `ACCESS_*`로 개명.
  - `06` — **CDS를 통째로 빠뜨렸다.** Java 24 미만 팀에게는 유일한 선택지인데 언급이 없다.
  - `07` — 근거 JEP로 483·515만 들지만, 단일 training-run 명령과 `-XX:AOTCacheOutput`을 실제로 도입한 것은 **JEP 514**다.
  - `07a` — **`jarmode=tools extract` 단계 누락.** 공식 절차는 uber JAR을 먼저 풀고 그 디렉터리에서 훈련한다. 또 one-step 워크플로가 **힙을 두 배** 요구한다는 점도 없다. `onRefresh` 종료와 "대표적 동작 시키기"가 한 명령으로 양립 불가인 것도 설명하지 않는다.
  - `07b` — CRaC만 명령이 없다. 실제로는 `spring.context.checkpoint=onRefresh`가 있고 배너도 `Restored`로 바뀐다.
- **답안 파일 12개 신설**: `chapter-8-.../answers/_01-*.md` ~ `_07b-*.md`.
- **Validation**: 노트 **12/12** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 + Ch5 8 + Ch6 5 + Ch7 8 + Ch8 12 = **90개**.
- **Next**: **Ch9**(12개 노트).

## 2026-08-28 — Ch9 답안 파일 (12/12)

- **Mode**: 인출 대비 답안 정리. 대상 `part-4-.../chapter-9-writing-reactive-web-controllers/`.
- **범위**: 노트 12개, `## 8. 스스로 확인` **48문항**(전 노트 4문항, `-` 불릿).
- **본문 보강**: **0건.**
- **Ch9 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `03` — `Flux.just(...)` 예제가 리액티브의 미래적 성격을 거스른다는 점을 **책 자신이 Note로 인정**한다.
  - `04a` — 절의 **배치가 어색하다.** POST 절 뒤에 있지만 내용은 §1의 연장("리액티브가 어떻게 확장을 만드나")이라 흐름이 끊긴다.
  - `04b` — **"4코어에서 25% 손실"은 낙관적 하한.** Netty가 연결을 이벤트 루프에 고정 배정하므로 실제 영향은 25%를 크게 넘을 수 있다.
  - `05b` — redirect를 `Mono<String>` + `"redirect:/"` 문자열로 처리하지만, **`Rendering.redirectTo(String)`**이라는 타입 있는 방법이 있다(`spring-webflux` 7.0.9 확인). 같은 장에서 `Rendering`을 쓰면서 redirect만 문자열 규약인 것이 일관되지 않는다.
  - `05b` — **WebFlux와 가상 스레드의 결정 기준을 어느 장에서도 정면으로 비교하지 않는다.** 답안에서 판별표를 세웠다(핵심: 가상 스레드는 배압을 주지 않는다).
  - `06` — **`@EnableHypermediaSupport(type = HAL)`을 그대로 붙여 넣으면 컴파일되지 않는다.** `HypermediaType.HAL`의 static import가 필요한데 책이 import 목록을 안 보인다.
  - `06` — 책 p.275에 **`InIn this case,`** 오타.
- **답안 파일 12개 신설**: `chapter-9-.../answers/_01-*.md` ~ `_06-*.md`.
- **Validation**: 노트 **12/12** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: Ch1 7 + Ch2 15 + Ch3 12 + Ch4 23 + Ch5 8 + Ch6 5 + Ch7 8 + Ch8 12 + Ch9 12 = **102개**.
- **Next**: **Ch10**(6개 노트).

## 2026-08-28 — Ch10 답안 파일 (6/6)

- **Mode**: 인출 대비 답안 정리. 대상 `part-4-.../chapter-10-working-with-data-reactively/`.
- **범위**: 노트 6개, **24문항**(전 노트 4문항).
- **본문 보강**: **0건.**
- **Ch10 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `04` — 책이 `02`에서 "R2DBC는 저수준이니 툴킷을 쓰라"고 해 놓고, 초기화 코드는 `getDatabaseClient().sql(...)`로 **저수준을 직접 쓴다.** 스키마 정의만은 툴킷이 덮지 않는다는 사실이 명시되지 않는다. 그리고 인자 없는 `subscribe()`가 **오류를 삼킨다.**
  - `04a` — 책 p.291 POST 코드에 **`});f`** 오타(그대로 복사하면 컴파일 실패).
  - `04b` — **접근자 불일치.** p.293이 `e.getName()`/`e.getRole()`을 쓰는데 `Employee`는 **record**라 `e.name()`이 맞다. 같은 장 p.290은 올바르게 쓴다. 게다가 p.294가 "템플릿은 변경 없이 복사하라"로 끝나 독자가 스스로 판단해야 하는 상태로 마무리된다.
- **답안 파일 6개 신설**: `chapter-10-.../answers/_01-*.md` ~ `_04b-*.md`.
- **Validation**: 노트 **6/6** `check-note.sh` PASS, `check-chapter.sh` **PASS**, 답안 wiki link **unresolved 0**(part-0 j1 노트명 `01-persistence-context-and-first-level-cache`로 교정), `git diff --check` PASS.
- **누적**: **108개**.
- **Next**: **Ch11**(6개 노트).

## 2026-08-28 — Ch11 답안 파일 (6/6)

- **Mode**: 인출 대비 답안 정리. 대상 `part-4-.../chapter-11-virtual-threads-in-java-and-spring-boot/`.
- **범위**: 노트 6개, **47문항**(01=7, 02~06=8).
- **본문 보강**: **0건.**
- **Ch11 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `01` — 본문이 "**Project Loom, introduced in Java 21**"이라 해 프로젝트 자체가 Java 21에 도입된 것처럼 읽힌다. Loom은 2017년경 시작됐고 Java 21에서 최종화된 것은 산물인 가상 스레드다.
  - `04` — 수신 측 로그 스레드 이름이 **`http-nio-8080-exec-1`**인데 같은 앱의 다른 로그는 전부 `tomcat-handler-N`이다. 전자는 **가상 스레드를 안 켠 Tomcat의 워커 이름**이라 한 실행에 두 명명 규칙이 섞인 것이 설명되지 않는다. 또 `baseUrl`로 **자기 자신을 호출**하는데 왜 안전한지(가상 스레드라 자기 호출 교착이 없다) 언급이 없다.
  - `05` — 프록시 빈을 `HttpServiceProxyFactory`로 **손수 조립**한다. Boot 4에는 `@ImportHttpServices` + `spring.http.serviceclient.*`가 있고 Ch2가 이미 다뤘는데 언급하지 않는다.
  - `06` — **가장 큰 공백.** 마지막 예제 `CompletableFuture.runAsync(...)`가 실행자를 안 줘서 **`ForkJoinPool.commonPool()`의 플랫폼 스레드**에서 돈다. 장의 주제가 가상 스레드인데 마지막 예제만 적용 밖이고 그 사실이 강조되지 않는다.
- **답안 파일 6개 신설**: `chapter-11-.../answers/_01-*.md` ~ `_06-*.md`.
- **Validation**: 노트 **6/6** PASS, `check-chapter.sh` **PASS**, wiki link **unresolved 0**.
- **누적**: **114개**.
- **Next**: **Ch12**(13개 노트).

## 2026-08-28 — Ch12 답안 파일 (13/13)

- **Mode**: 인출 대비 답안 정리. 대상 `part-4-.../chapter-12-messaging-and-asynchronous-communication-in-spring-boot-4/`.
- **범위**: 노트 13개, **52문항**(전 노트 4문항).
- **본문 보강**: **0건.**
- **Ch12 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `04` — **Figure 12.5가 본문과 어긋난다.** 화면은 `Enable Zookeeper access` + port 2181 + cluster version `0.11`인데, 이 장의 compose는 **KRaft 모드라 Zookeeper가 없고** 이미지는 `cp-kafka:7.8.8`이다. 그대로 따라 하면 막힌다.
  - `04a` — `EmployeeCreatedEvent`의 `createdAt`이 p.323은 **`Instant`**, p.330은 **`LocalDateTime`**이다. JSON 표현이 달라 producer/consumer가 어긋나면 깨진다.
  - `04b` — **트랜잭션 경계가 없다.** `save()`와 `send()`가 원자적이지 않은데 책은 outbox 패턴을 **멱등성 절 Note에** 지나가듯 두고 이 코드와 연결하지 않는다. 게다가 `send`의 `CompletableFuture` 반환값을 버려 **발행 실패가 조용히 지나간다.** `employeeRepository` 필드에만 `final`이 빠져 있다.
  - `04c` — `spring.json.trusted.packages: "*"`가 **예제 그대로 남아 있다.** 임의 클래스 역직렬화를 허용하는 알려진 취약점 경로.
  - `05` — 시뮬레이션 코드에서 `Math.random() < 0.5`가 **맨 앞**이라 `email` 검사에 닿기 전에 절반이 일시적 실패로 빠진다. 영구 실패 경로 도달 확률이 1/8이라 **두 유형을 대비해 보이려는 의도와 실행이 어긋난다.**
  - `05a` — **제목은 DLQ, 본문은 DLT.** Kafka에는 topic만 있으므로 본문이 정확하다.
  - `05b` — **재시도와 멱등 검사가 맞물리지 않는다.** ID 추가가 성공 뒤라 재시도가 만드는 중복은 못 막는다. `contains` + `add`에 경합도 있다.
- **부수 수정 1건**: `_coverage.md` 84행의 셀 안 `||`가 이스케이프되지 않아 `check-chapter.sh`의 칸 수 검사에 걸렸다. `\|\|`로 고쳐 **PASS**.
- **답안 파일 13개 신설**: `chapter-12-.../answers/_01-*.md` ~ `_06-*.md`.
- **Validation**: 노트 **13/13** PASS, `check-chapter.sh` **PASS**, wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: **127개**.
- **Next**: **Ch13**(15개 노트).

## 2026-08-29 — Ch13 답안 파일 (15/15)

- **Mode**: 인출 대비 답안 정리. 대상 `part-5-.../chapter-13-observing-spring-boot-4-applications/`.
- **범위**: 노트 15개, **116문항**(01·02·03·04·05=7, 나머지=8, 06=9).
- **본문 보강**: **0건.**
- **Ch13 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - `03a` — grafana 볼륨 경로에 **슬래시 중복**(`provisioning//datasources`)과 `depends_on:` 아래 항목 누락.
  - `03b`·`03c` — 설정은 패키지를 `com.learningspringboot4`로 적는데 실제 화면은 **`com.springbootlearning4`**다. `logging.level` 필터가 실제 패키지와 맞지 않는다.
  - `04b` — Note는 모든 `System.out`을 SLF4J로 바꿨다고 하지만 중복 이벤트 분기에 **`System.out.println`이 남아 있다.** 또 항목 설명은 `recordNotificationMetric("received")`/`("duplicate")`를 호출한다고 하지만 **인쇄된 코드에 그 두 호출이 없다**(대시보드에는 값이 찍혀 있다).
  - `04c` — `Notification Failure Rate` 0%와 `failed 8`이 함께 있는데 **책이 그 차이(rate vs 누적)를 설명하지 않는다.**
  - `05c` — **Trace ID 표기 세 가지 문제.** 두 Figure 설명의 값이 다르고, 후자에 **16진수가 아닌 `w`·`s`**가 섞였다. Span Filters는 "4 spans"인데 패널에는 **5개 행**. 본문 나열에 **루트 span이 빠졌다.**
- **답안 파일 15개 신설**: `chapter-13-.../answers/_01-*.md` ~ `_06-*.md`.
- **Validation**: 노트 **15/15** PASS, `check-chapter.sh` **PASS**, wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: **142개**.
- **Next**: **Ch14**(19개 노트).

## 2026-08-29 — Ch14 답안 파일 (19/19)

- **Mode**: 인출 대비 답안 정리. 대상 `part-6-.../chapter-14-building-intelligent-applications-with-spring-ai/`.
- **범위**: 노트 19개, **75문항**(04=3, 나머지=4).
- **본문 보강**: **0건.**
- **Ch14 노트가 이미 잡아 둔 책의 문제** (답안에 반영):
  - **대소문자 오타 3건** — `03`의 `.Stream()`(p.418), `04b`의 `.Call()`(p.430), `05c`의 `.User(...)`(p.442). 셋 다 **코드 블록은 소문자로 정확**하고 **설명 항목만** 틀렸다.
  - `05a` — `spring-ai-rag` 의존성 블록이 **`<artifactId>`를 `<groupId>`보다 먼저** 쓴다(다른 블록과 순서가 다르다).
  - `05b` — `TokenTextSplitter`의 **`withChunkSize`가 이미 구버전 API**다. 책 자신이 다음 쪽에서 `chunkSize(...)`로 바뀌었다고 경고한다.
  - `05c` — 응답 예시를 **`{"reply": ...}` JSON**으로 보여 주는데 메서드 반환형이 **`String`**이라 실제로는 평문이다.
  - `06b` — `McpClientController` 코드 블록에 **클래스를 닫는 `}`가 없다.**
  - `07b` — **metric 이름 불일치.** p.460은 `gen_ai.client.token.usage`, p.465는 같은 대상을 `gen_ai.usage.input_tokens`로 부른다.
  - `07d` — "defensive system prompt와 **`SafeGuardAdvisor`를 결합**하는 방법을 보여 준다"고 쓰는데 **제시된 코드에 `SafeGuardAdvisor`가 없다.**
- **답안 파일 19개 신설**: `chapter-14-.../answers/_01-*.md` ~ `_07d-*.md`.
- **Validation**: 노트 **19/19** PASS, `check-chapter.sh` **PASS**, wiki link **unresolved 0**, `git diff --check` PASS.
- **누적**: **161개**.
- **Next**: **Ch15**(1개 노트).

## 2026-08-29 — Ch15 모범답안 (1노트 / 12문항)

- 모드: 모범답안 정리 (Prepare 파생). 대상 `part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/`.
- 소스: 노트 본문 재독(§1 네 성격 표 → §2.0~§2.10 아홉 영역 34항목 → §3 도표 3개 → §5 혼동 6개 → §6 경계 6개). 이 장은 실행 코드 예제가 없어 코드 대조 없음.
- 산출: `answers/_01-whats-new-in-spring-boot-4.md` (12문항 + 재출제 8문항). 노트 `§8`에 열두 문항 포인터 삽입.
- **본문 보강 0건.** 12문항 전부 노트 본문에서 근거를 찾았다. 특히 Q3(Undertow)·Q6(슬라이스 확장)·Q11(⑤의 역방향 예외)은 본문이 이미 "왜"까지 적어 둔 항목이다.
- 답안에서 명시적으로 정리한 것:
  - Q1의 위험 기준을 "오류 유무"가 아니라 **발견 시점**으로 재진술.
  - Q3에 반사실 검사(기준선을 포기하거나 기다리는 두 선택지밖에 없다)를 추가.
  - Q4에 일괄 치환 시 오류 메시지가 "덜 바꿨다"로 오독되는 경로를 추가.
  - Q7에 Boot 3.5 / Boot 4 재시작 시나리오 대조 다이어그램, "조용함"의 세 겹.
  - Q9를 "애플리케이션이 아니라 **감시 장치**가 조용히 멎는다"로 규정 — 침묵이 정상 신호라 경보 사망을 감지할 수 없다는 점.
  - Q12에 프로퍼티 21개 내역 표와 마이그레이터의 한계(프로퍼티 아닌 기본값 변경은 못 잡는다).
- 검증: `check-note.sh` 노트 1/1 PASS · `check-chapter.sh` PASS · answers 위키링크 unresolved 0 · `git diff --check` OK.
  - 부수 조정 1건: answers 파일에서 용어 위키링크 4개(`전이-의존성`·`클래식-스타터`·`테스트-슬라이스`·`배치-메타데이터`)를 굵은 글씨로 바꿨다. answers 폴더에는 `_glossary.md`가 없어 링크가 해소되지 않으며, 다른 챕터 answers도 용어를 링크하지 않는 관례다.
- 누적: **162개** 모범답안 파일 (Ch1 8 · Ch2 15 · Ch3 12 · Ch4 23 · Ch5 8 · Ch6 5 · Ch7 8 · Ch8 12 · Ch9 12 · Ch10 6 · Ch11 6 · Ch12 13 · Ch13 15 · Ch14 19 · Ch15 1).
- **책 트랙(Ch1~Ch15) 전 챕터 모범답안 완료.**
- 다음: `part-0-jpa-foundations` (chapter-j1/j2/j3, 14노트). 그 뒤 `part-0-web-foundations` w1(1), `part-0-spring-core-internals` c1~c4(17).

## 2026-08-29 — part-0-jpa-foundations 모범답안 (14노트 / 114문항)

- 모드: 모범답안 정리. 대상 `part-0-jpa-foundations/chapter-j1~j3/`.
- 소스: 각 노트 본문 재독(§1 출발 장면·§2 메커니즘·§5 혼동·§6 경계·§7 연결). 이 트랙은 PDF가 아니라 Spring Data JPA·Hibernate 공식 문서가 1차 소스이므로, 답안의 인용도 노트가 이미 대조해 둔 공식 문서 문장을 그대로 따랐다.
- 산출: `answers/_01…` 14개 파일. 각 노트 `§8`에 포인터 삽입.
  - j1 (영속성 컨텍스트) 4노트 32문항 — 1차 캐시·쓰기 지연/플러시·더티 체킹/스냅샷·생명주기/준영속
  - j2 (연관과 프록시) 5노트 39문항 — 주인/`mappedBy`·연결 엔티티·배타적 연관·프록시/지연 로딩·전이/고아 제거/DB 연쇄
  - j3 (성능과 트랜잭션) 5노트 43문항 — N+1·페치 전략 3종·전파/프록시 한계·격리/낙관적 락·OSIV
- **본문 보강 0건.** 114문항 전부 노트 본문에서 근거를 찾았다.
- 답안에서 명시적으로 정리한 것:
  - j1-01 Q4를 "캐시를 끄는 스위치는 JPA를 끄는 스위치"로 재진술하고, 수명이 짧다는 것을 부수성의 증거로 제시.
  - j1-04 Q1에 두 축이 만드는 네 칸 중 "관리하는데 식별자 없는" 칸이 없는 이유(1차 캐시가 `(타입, 식별자)` 맵이라서)를 추가.
  - j2-01 Q4에 "무시한다가 버그처럼 보이지만 설계"임을 Q1의 충돌 문제와 연결.
  - j2-03 Q3에 `@Any`의 "안 거는 것"과 "못 거는 것"을 부채 대 영구 손실로 대비.
  - j2-05 Q6에 같은 테이블에서 `CASCADE`/`RESTRICT`가 갈리는 기준을 "누가 소유자인가"로 일반화.
  - j3-01 Q7에 인덱스 추가라는 흔한 오진과 그것이 왜 효과가 없는지를 추가.
  - j3-03 Q6에 ①분리가 ②③과 달리 "제약을 우회"가 아니라 "설계를 요구에 맞추는" 것이라는 대비.
  - j3-04 Q4에 갱신 0건이 유일하게 충돌로만 해석되는 논리 사슬을 단계로 분해.
  - j3-05 Q4에서 "커넥션을 요청 끝까지 붙잡는다"의 부정확함이 **결론이 아니라 진단 방향**을 바꾼다는 점을 강조.
- 검증: `check-note.sh` 14/14 PASS · `check-chapter.sh` j1·j2·j3 전부 PASS · answers 위키링크 unresolved 0 · `git diff --check` OK.
  - 부수 조정 3건: answers 파일에서 용어 위키링크(`동일성-보장`·`배타적-연관`·`메모리-페이징`)를 굵은 글씨로 바꿨다. answers 폴더에 `_glossary.md`가 없어 해소되지 않으며, 다른 챕터 answers도 용어를 링크하지 않는 관례다.
- 누적: **176개** 모범답안 파일 (책 트랙 162 + part-0 j1~j3 14).
- 다음: `part-0-web-foundations` w1(1노트), 그 뒤 `part-0-spring-core-internals` c1~c4(17노트).

## 2026-08-29 — part-0-web-foundations + part-0-spring-core-internals 모범답안 (18노트 / 160문항)

- 모드: 모범답안 정리. 대상 `part-0-web-foundations/chapter-w1`, `part-0-spring-core-internals/chapter-c1~c4`.
- 소스: 각 노트 본문 재독. 이 트랙들도 1차 소스가 PDF가 아니라 Spring Framework·Spring Boot 공식 문서이므로, 답안의 인용은 노트가 대조해 둔 문서 문장을 따랐다.
- 산출: `answers/_01…` 18개 파일. 각 노트 `§8`에 포인터 삽입.
  - w1 (서블릿과 컨테이너) 1노트 6문항 — 계약/구현/배치 3층, 내장 대 외부, Undertow 제거 근거
  - c1 (컨테이너 생명주기) 4노트 36문항 — 빈 정의·두 후처리기·8단계 생명주기·순환 참조
  - c2 (AOP 프록시 내부) 4노트 39문항 — JDK/CGLIB·어드바이저와 자동 프록시·final/private/자기 호출·설정 클래스 강화
  - c3 (MVC 요청 파이프라인) 5노트 49문항 — 프런트 컨트롤러·매핑과 어댑터·인자/반환값·컨버터와 협상·예외와 필터/인터셉터
  - c4 (자동 구성 내부) 4노트 39문항 — imports 파일·조건과 백오프·순서·조건 평가 보고서
- **본문 보강 0건.** 160문항 전부 노트 본문에서 근거를 찾았다.
- 답안에서 명시적으로 정리한 것:
  - c1-01 Q4를 "클래스는 '나는 이런 것이다'만 말하고 '어떻게 쓰일지'는 정의가 정한다"로 IoC의 구체적 형태와 연결.
  - c1-02 Q5에 "자기가 자기를 감쌀 수 없는" 두 이유(위치·논리)를 분해.
  - c1-04 Q10에 엔티티 양방향 연관이 빈 순환 참조와 다른 이유를 표로 대비 — "진단명이 같다고 처방이 같지 않다".
  - c2-01 Q6에 CGLIB 전환으로 해결되는 증상과 안 되는 증상을 나누고, `final` 제약이 오히려 새로 생긴다는 역설을 추가.
  - c2-04 Q10에 `@Component`의 `@Bean`이 `proxyBeanMethods = false`보다 위험한 이유(눈에 안 보인다)를 추가.
  - c3-01 Q4에 "6단계 파이프라인"이라는 그림이 REST API에서 부정확하다는 점(4단계가 부풀고 5단계가 빈다)을 명시.
  - c3-05 Q10에 "DTO를 반환하라"에 근거가 넷(j1-03·j3-05·c3-04·c3-05)이라는 것을 표로 모음 — "근거가 넷이면 취향이 아니라 원칙이다".
  - c4-02 Q10에 "이름은 좋은 은유이지만 은유는 메커니즘이 아니다"를 챕터 전체의 교훈으로 정리.
  - c4-04 Q7에 `final`이 c2-03에서는 제약이고 여기서는 보증이라는 대비.
- 검증: `check-note.sh` 18/18 PASS · `check-chapter.sh` w1·c1·c2·c3·c4 전부 PASS · answers 위키링크 unresolved 0 · `git diff --check` OK.
  - 부수 조정: answers 파일의 용어 위키링크를 굵은 글씨로 일괄 변환(스크립트화). answers 폴더에 `_glossary.md`가 없어 해소되지 않으며, 다른 챕터 answers도 용어를 링크하지 않는 관례다.
- 누적: **194개** 모범답안 파일 (책 트랙 162 + part-0 32).
- **책 트랙 Ch1~Ch15와 part-0 전 트랙(j1~j3·w1·c1~c4) 모범답안 완료. 사용자가 지시한 범위를 전부 끝냈다.**
- 다음: 없음. 사용자가 인출 연습을 시작하겠다고 하면 그때 `_map.md` 리뷰부터 연다.

## 2026-08-29 — Ch1 `00-technical-requirements` 보완 (1노트 / 5문항)

- 진행 중 `_global/config.md`에 "그 노트에는 `§8`이 없다"고 잘못 적었다가, 실제 파일을 확인해 `§8` 5문항이 있는 것을 발견하고 답안을 채웠다. config의 해당 메모도 바로잡았다.
- 산출: `part-1-.../chapter-1-.../answers/_00-technical-requirements.md` (5문항 + 재출제 5문항). 노트 `§8`에 포인터 삽입.
- **본문 보강 0건.**
- 답안에서 정리한 것: Q1의 "Java 버전이 정해지는 지점 셋", Q2의 "최소 지원 버전 대 검증 기준 버전" 구분(Ch15의 같은 정리와 연결), Q4의 "IDE 설정은 공유되지 않는다 → 빌드 파일이 정본", Q5의 원본 저장소 대조 3단계(막힌 조각만 본다).
- 검증: `check-note.sh` PASS · Ch1 `check-chapter.sh` PASS(노트 8개) · 위키링크 unresolved 0 · `git diff --check` OK.
- 누적: **195개** 모범답안 파일. **전 범위 완료.**

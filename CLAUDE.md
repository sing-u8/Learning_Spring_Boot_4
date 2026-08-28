# Learning Spring Boot 4 PDF 학습 노트 프로젝트

## 프로젝트 목표

이 프로젝트는 *Learning Spring Boot 4* 전체를 PDF 원문에서 다시 읽고, 학습자가 책을 대신해 읽어도 핵심 맥락·코드·작동 원리·경계를 이해할 수 있는 상세 한국어 노트로 재작성한다.

- 노트 저장소: `spring-boot-4-pdf-notes/`
- 주교재 PDF: `Learning Spring Boot 4 Simplify the development of production-grade applications using Java and Spring (Wanderson Xesquevixos, Ranga Rao Karanam etc.) (z-library.sk, 1lib.sk, z-lib.sk).pdf`
- 기존 `spring-boot-notes/`, `spring-boot-4-notes/`, `spring-boot-4-complete-notes/`는 구조 참고 외에는 수정하지 않는다.
- 기존 압축 노트는 원문 근거가 아니다. 대상 Chapter의 PDF를 다시 읽고 작성한다.
- 책 전체의 상세 정리가 우선이다. 사용자가 별도로 요청하기 전에는 인출 연습을 시작하지 않는다.

## 실제 상태의 유일한 기준

작업을 시작할 때 다음 파일을 순서대로 실제로 읽는다.

1. `spring-boot-4-pdf-notes/_global/config.md`
2. `spring-boot-4-pdf-notes/_global/source-manifest.md`
3. `spring-boot-4-pdf-notes/_global/validation-report.md`
4. 대상 Chapter의 `_map.md`, `_coverage.md`, `_glossary.md`

대화 요약이나 과거의 “전체 완료” 문구보다 `_global/config.md`의 Chapter별 상세 재작성 상태를 우선한다. 상세 coverage 검증 전의 문서는 압축 초안으로 취급한다.

Chapter 1의 다음 파일은 목표 품질의 기준 예시다.

- `part-1-the-basics-of-spring-boot/chapter-1-core-features-of-spring-boot/_map.md`
- 같은 폴더의 `_coverage.md`
- 같은 폴더의 `01-autoconfiguring-spring-beans.md`
- 같은 폴더의 `03b-externalizing-application-configuration.md`
- 같은 폴더의 `_glossary.md`

위 경로는 모두 `spring-boot-4-pdf-notes/`를 기준으로 한다.

## 필수 skill과 문서 확인

### deep-tutor

- Claude Code에서는 `/deep-tutor`를 사용한다.
- 작업 전에 deep-tutor `SKILL.md`를 끝까지 읽는다.
- concept note를 쓰기 전 `references/note-authoring.md`, `references/figures.md`, `references/templates.md`를 끝까지 읽는다.
- host hook이나 bundled script를 다룰 때 `references/host-compatibility.md`를 읽는다.
- 이 프로젝트에서는 Prepare/batch 방식으로 Chapter를 정리한다.

### PDF

- `pdftotext`는 반드시 `-layout` 옵션으로 실행한다.
- PDF text layer가 있어도 코드·표·페이지 배치가 중요한 곳은 원본 페이지와 대조한다.
- 이미지가 학습에 의미가 있는지 `pdfimages -list`와 페이지 렌더링으로 확인한다.

### Context7

Spring Boot, Spring Framework, Java 라이브러리, API, 애노테이션, 설정 키, 버전 호환성처럼 프레임워크 문서가 필요한 내용은 기억으로 단정하지 않는다.

1. Context7 `resolve-library-id`로 공식 프로젝트를 찾는다.
2. 책의 버전과 가장 가까운 공식·version-specific ID를 고른다.
3. 사용자의 전체 질문 또는 확인할 구체 개념으로 `query-docs`한다.
4. PDF를 학습 순서의 1차 기준으로 유지하고, 공식 문서는 오류·단순화·버전 차이의 보조 확인에 사용한다.
5. 책과 공식 동작이 다르면 둘을 명시적으로 구분한다.

## 보조 소스 트랙 — part-0-jpa-foundations

*Learning Spring Boot 4* Ch. 3 `Querying for data with Spring Boot`는 책 26쪽 6절이며, Spring Data 추가·DTO/Entity/POJO·리포지토리와 선언적 쿼리·커스텀 파인더·Query by Example·커스텀 JPA 쿼리로 끝난다. 영속성 컨텍스트, 연관관계 매핑, 프록시와 지연 로딩, N+1, `@Transactional` 전파, 락, OSIV는 이 책에 없다. Ch. 15의 data layer 절도 Boot 4 변경점이지 그 기반이 아니다. 이 책만으로는 Spring Data JPA를 쓰는 코드가 왜 그렇게 동작하는지 설명할 수 없다.

`spring-boot-4-pdf-notes/part-0-jpa-foundations/`는 그 빠진 층을 복원하는 보조 트랙이다.

- 1차 소스는 PDF가 아니라 Spring Data JPA·Hibernate ORM 공식 문서다. Context7로 대조하고, frontmatter `source:`에 어떤 문서와 어떤 책의 어느 장을 대조했는지 적는다.
- 대조 읽기용 참고서는 김영한 『자바 ORM 표준 JPA 프로그래밍』이다. 각 노트에 대응 장을 표기하되, 그 책의 서술을 옮기지 않는다.
- concept note 구조, 필수 H2, 사용자 영역 marker, `check-note.sh` 완료 게이트는 Chapter 노트와 동일하게 적용한다.
- `_coverage.md`는 PDF 원문 행 대조가 아니라 `주제 → 출처` 매핑으로 쓴다. 원문이 여러 문서에 흩어져 있어 행 단위 대조가 성립하지 않는다.
- 디렉토리는 `part-0-jpa-foundations/chapter-jN-.../` 형식을 지킨다. hook이 `*-notes/part-*/chapter-*/*.md`만 선별하므로 이 경로를 벗어나면 게이트를 받지 못한다. `jN`의 `j` 접두어는 책 Chapter 번호와 구분하기 위한 것이다.
- 이 트랙은 Chapter 상세 재작성과 별개로 진행할 수 있다. 대상 Chapter 밖 파일을 수정하지 않는다는 규칙은 그대로 적용되며, part-0 작업 중에는 part-1~7과 `_global/`을 수정하지 않는다.

## 작업 범위 규칙

- 한 번에 사용자가 지정한 Chapter만 상세 재작성한다.
- 대상 Chapter가 완료 게이트를 통과하기 전에는 다음 Chapter로 넘어가지 않는다.
- 대상 Chapter와 필요한 `_global/` 상태 문서 외의 파일은 수정하지 않는다.
- 관련 없는 초안의 포맷 정리, 일괄 rename, 일괄 수정은 하지 않는다.
- 파일 수나 줄 수를 품질 목표로 사용하지 않는다.
- 전체 책 또는 아직 검증하지 않은 Chapter를 완료했다고 보고하지 않는다.

## Chapter별 PDF-first 작업 순서

1. `_global/config.md`에서 현재 상세 완료 범위와 다음 Chapter를 확인한다.
2. `_global/source-manifest.md`에서 책 쪽과 PDF 쪽 범위를 확인한다.
3. 대상 Chapter의 기존 파일을 읽되 압축 초안으로만 취급한다.
4. 대상 PDF 범위를 새 `/private/tmp` 파일에 `pdftotext -layout`으로 추출한다.
5. 추출문을 처음부터 끝까지 읽는다.
6. 상위 제목, 실제 하위 제목, 모든 코드·명령·설정 예제, Tip/Note, 그림을 목록화한다.
7. concept note 작성 전에 Chapter의 `_coverage.md`를 만든다.
8. 한 상위 절에 독립 개념이 여러 개면 실제 하위 제목 기준으로 note를 분리한다.
9. concept note와 `_glossary.md`를 함께 작성한다.
10. `_map.md`를 단순 목차가 아니라 최소 두 개 이상의 관계 축으로 갱신한다.
11. 각 concept note를 저장한 직후 수동 `check-note.sh`를 실행한다.
12. Chapter 전체의 용어, 링크, 이미지, Mermaid를 검증한다.
13. `_coverage.md`의 모든 원문 행을 다시 대조한다.
14. `_global/config.md`, `session-log.md`, `source-manifest.md`, `validation-report.md`를 실제 결과에 맞게 갱신한다.

## Concept note 필수 구조

파일명은 영어 kebab-case를 사용한다.

frontmatter 필수 키:

```yaml
category:
concept:
title:
source: "Learning Spring Boot 4, Ch. N, 책 pp. X-Y / PDF pp. A-B"
terms: []
status: prepared
```

필수 H2:

- `## 한눈에 보기`
- `## 1. 왜 이게 필요한가`
- `## 2. 어떻게 동작하는가`
- `## 3. 그림으로 보기`
- `## 4. 이 노트에 나온 용어`
- `## 7. 연결`
- `## 8. 스스로 확인`

`## 5. 자주 헷갈리는 것`과 `## 6. 언제 안 쓰나 / 경계`는 해당 개념에 적용할 혼동·한계가 있으면 작성한다.

## Concept note 설명 품질

- 첫 설명은 정의가 아니라 구체적인 코드, 실패, 숫자, 배포 상황으로 시작한다.
- 전문 용어 첫 등장에 `**[[용어]]**(=쉬운 인라인 설명)`을 붙인다.
- 해당 용어는 같은 Chapter의 `_glossary.md`에 `## 용어 (original)` 형식으로 한 번만 정의한다.
- “무엇인가”에서 끝내지 않고 “왜 필요한가”, “어떤 순서로 동작하는가”, “없으면 무엇이 깨지는가”를 설명한다.
- 메커니즘의 각 단계에 그 단계가 필요한 이유를 붙인다.
- 코드 앞에서 문제와 목적을 설명하고, 핵심 줄과 시작·실행 흐름을 해설한다.
- 최소 한 개의 비유를 사용하고 그 비유가 깨지는 지점을 바로 명시한다.
- 이름이 왜 그렇게 붙었는지 설명한다.
- 비슷한 개념의 결정적인 구분 기준과 적용 경계를 설명한다.
- `## 7. 연결`에는 같은 Chapter의 concept note를 `- [[X]] — 관계 설명` 형식으로 최소 두 개 연결한다.
- 책의 문장을 길게 복사하지 않고 자신의 한국어 설명으로 재구성한다.
- 논문 초록처럼 핵심어만 압축한 문서는 완료로 판정하지 않는다.

## 사용자 소유 영역

다음 marker 아래는 사용자의 영역이다.

```markdown
<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->
```

- marker 아래의 기존 텍스트를 수정·덮어쓰기·삭제하지 않는다.
- 정리물을 보강할 때는 marker 위만 수정한다.
- 인출 연습 전에는 `내 설명 시도`, `막혔던 지점`, `리뷰 이력`을 에이전트의 설명으로 채우지 않는다.

## 그림과 책 이미지

- 실제 코드가 아닌 개념 관계는 Mermaid나 비교표를 우선한다.
- 원본 화면, UI, 대시보드, 책의 고유 도표 자체가 학습 대상일 때만 PDF 이미지를 추출한다.
- 새 원본 이미지는 대상 Chapter의 `_assets/`에 두고 의미 있는 영어 파일명을 사용한다.
- 기존 `assets/` 파일은 검증 없이 삭제·이동하지 않는다.
- 추출 이미지는 잘림, 해상도, 대상 페이지 일치를 육안으로 확인한다.

모든 Mermaid block은 다음 dark theme로 시작한다.

```text
%%{init: {'theme': 'dark'}}%%
```

- **2026-08-28 변경.** 이전 규칙은 밝은 `theme: 'base'` + themeVariables였다. 사용자가 "밝아서 안 보인다"는 이유로 저장소 전체 279개 block을 dark로 일괄 교체했다(사용자 본인 작업). 이 규칙은 그 결정을 반영한 것이며, **밝은 theme로 되돌리지 않는다.**
- 새로 쓰는 block도 이 한 줄로 시작한다.
- node label에 애노테이션, 괄호, slash 등이 있으면 parser 오류가 없도록 따옴표를 사용한다.
- 정규식으로 문법을 추정하지 말고 모든 Mermaid block을 실제 CLI renderer로 SVG 렌더링한다.

## 검증 규칙

프로젝트 훅:

- `.claude/settings.json`의 `PostToolUse` hook이 Claude Code의 `Write|Edit` 뒤에 실행된다.
- `.claude/hooks/deep-tutor-note-gate.sh`가 중첩된 `*-notes/part-*/chapter-*/*.md` concept note만 선별한다.
- `.codex/hooks.json`도 같은 프로젝트 hook을 사용한다.
- hook은 보조 안전망이다. deep-tutor가 요구하는 수동 검사를 생략하지 않는다.

각 note 저장 직후:

```bash
"$HOME/.claude/skills/deep-tutor/scripts/check-note.sh" "<concept-note.md>"
```

Claude 경로가 없으면 현재 host의 deep-tutor root를 확인하고 그 안의 `scripts/check-note.sh`를 사용한다.

Chapter 완료 전 반드시 확인한다.

- 모든 concept note가 `check-note.sh` 통과
- frontmatter의 모든 `terms`가 `_glossary.md`에 등재
- wiki link target unresolved 0
- local image reference missing 0
- Mermaid block 수 = 밝은 theme init 수 = 실제 SVG 렌더 성공 수
- `_coverage.md`의 본문·코드·Tip/Note 항목 전부 반영
- 대상 변경 파일에 `git diff --check` 통과

## 상태 문서 책임

- `_coverage.md`: 원문의 제목·예제·Tip/Note·이미지가 어느 note에 반영됐는지 추적한다.
- `_map.md`: 최소 두 축 이상의 개념 관계와 다음 Chapter 연결을 보여 준다.
- `_glossary.md`: 해당 Chapter 전문 용어 정의의 유일한 원본이다.
- `_global/config.md`: Chapter별 상세 재작성 진행 상태의 유일한 기준이다.
- `_global/session-log.md`: 사용한 source, mode, 검증 결과, 다음 범위를 기록한다.
- `_global/gaps.md`: 문서 작성 체크리스트가 아니라 실제 인출에서 확인된 stall만 기록한다.
- `_global/validation-report.md`: 구조 검증과 내용 coverage 검증을 구분해 기록한다.

## Worktree 안전

- worktree가 dirty일 수 있다. 기존 변경과 untracked 파일은 사용자 또는 이전 작업의 소유다.
- `git reset --hard`, `git checkout --`, 일괄 삭제를 사용하지 않는다.
- 대상 Chapter 밖의 변경을 되돌리거나 정리하지 않는다.
- 삭제·rename 전에 정확한 대상과 참조 링크를 읽기 전용으로 확인한다.
- 기존 사용자 영역과 관련 없는 변경을 보존한다.

## 완료 보고

Chapter 작업이 끝나면 다음을 구체적으로 보고한다.

- 새로 읽고 대조한 책 쪽·PDF 쪽 범위
- 작성·분리한 concept note와 `_coverage.md` 링크
- 책 이미지 추출 또는 미사용 판단과 근거
- deep-tutor 통과 개수
- glossary·wiki link·image reference 검증 결과
- Mermaid 실제 렌더 성공 개수
- 공식 문서 대조로 발견한 책의 단순화·버전 차이
- 다음 Chapter는 아직 시작하지 않았다는 상태

정리 직후 인출 질문을 시작하지 않는다. 사용자가 노트를 읽을 시간을 준다.

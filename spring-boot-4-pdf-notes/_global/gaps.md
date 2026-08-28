# Gaps — 인출에서 확인된 취약 엣지

> 이 파일은 문서 작성 체크리스트가 아니라 사용자가 설명을 시도하다 실제로 막힌 개념 관계를 기록하는 큐다. 2026-08-28 Ch1 `01-autoconfiguring-spring-beans`에서 인출 연습을 시작했다.

| Date | Category | Concept | Edge Type | Status | Resolved Date |
|---|---|---|---|---|---|
| 2026-08-28 | chapter-1-core-features-of-spring-boot | autoconfiguration-and-application-context | `core-mechanism` — 백오프가 무엇을 검사해 일어나는지를 이름으로만 답함 | open | |
| 2026-08-28 | chapter-1-core-features-of-spring-boot | autoconfiguration-and-application-context | `vs-사용자-구성` — 백오프 시 사용자 빈을 등록하는 주체를 자동 구성으로 잘못 귀속 | open | |
| 2026-08-28 | chapter-1-core-features-of-spring-boot | autoconfiguration-and-application-context | `depends-on-애플리케이션-컨텍스트` — 자동 구성이 빈을 만드는지, 빈 정의만 보태는지 미확정 | open | |
| 2026-08-28 | chapter-1-core-features-of-spring-boot | autoconfiguration-and-application-context | `core-mechanism` — Boot 4 모듈화가 빌드 파일의 의도를 드러내는 인과를 시도조차 못함 | open | |

## Edge Type

- `core-mechanism`: 개념 내부의 작동 순서에서 막힘
- `vs-{X}`: 비슷한 개념 X와 구분하지 못함
- `depends-on-{X}`: 선행 개념 X와의 의존 관계가 약함
- `cross-{category}`: 다른 Chapter·영역과의 연결이 약함
- `regen-loss`: map을 백지에서 다시 만들 때 잊은 연결
- `mock-stall`: 모의 설명 중 멈춘 지점

## 문서 작성 상태와의 구분

- Chapter별 상세 재작성 진행 상황은 [[config]]에서 관리한다.
- 원문 누락 여부는 각 Chapter의 `_coverage.md`에서 관리한다.
- 구조·링크·Mermaid 검증 결과는 [[validation-report]]에서 관리한다.
- 인출을 시작하기 전에는 약점을 추정해 이 표에 넣지 않는다. 위 행은 전부 사용자의 실제 인출 시도에서 관찰된 것이다.

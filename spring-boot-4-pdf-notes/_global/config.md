# Config

## 정리 모드

mode: batch

- 목표: 책 전체를 Chapter 순서대로 PDF 원문과 다시 대조해 상세 학습 노트로 재작성한다.
- 현재 방식: 한 Chapter씩 `원문 추출 → coverage 작성 → concept notes 작성 → glossary/map 갱신 → 구조·링크·Mermaid 검증`을 완료한 뒤 다음 Chapter로 이동한다.
- 인출 연습: **2026-08-28 시작됨.** 진행 방식은 아래 「인출 진행 방식」을 따른다.
- `prepared`: 원문 대조와 노트 작성까지 끝난 상태이며, 사용자의 실제 인출 성공을 뜻하지 않는다.

## 인출 진행 방식

2026-08-28 사용자와 합의한 방식이다. 정리 단계가 전부 끝났으므로 이제 기본 모드는 인출이다.

1. 사용자가 노트를 **한 파일씩** 읽는다.
2. 그 노트의 `## 8. 스스로 확인`을 **스스로 먼저 시도한다.** 에이전트는 시도 전에 답을 주지 않는다.
3. 답이 오래 걸린다고 사용자가 판단하면 그때 **모범답안 파일 정리**를 요청한다.
4. 요청을 받으면 답안 파일을 **`{챕터}/answers/_{노트파일명}.md`** 로 만든다. 예: `answers/_01-autoconfiguring-spring-beans.md`.
   - **폴더**: 챕터마다 `answers/` 하위 디렉터리에 모은다. `check-note-hook.sh`는 `-notes` 아래 **깊이 1~2**만 검사하므로 `chapter-*/answers/*.md`는 깊이 3이라 게이트 대상이 아니고, `check-chapter.sh`도 `$DIR/*.md`만 훑으므로 마찬가지로 제외된다.
   - **`_` 접두는 폴더에 넣어도 여전히 필수다.** 이유가 다르다 — `check-note.sh`가 개념 노트 본문의 `[[링크]]` 중 `_` 접두가 **아닌** 것을 용어로 간주해 `_glossary.md`와 대조하기 때문이다. 답안 링크를 `[[01-...-answers]]`처럼 쓰면 노트가 "용어집 미등재"로 FAIL 한다(2026-08-28 실측).
   - 파일명은 대상 노트와 **같은 문자열이면 안 된다.** wiki link가 파일명으로 해석되므로 충돌한다. `_` 접두가 그 구분까지 겸한다.
5. 답안 파일 맨 위와 대상 노트의 `## 8.` 끝에 "먼저 답하고 나서 열 것" 경고를 둔다. 노트 쪽 링크는 구분자 위(스킬 영역)에 쓴다.
6. 답안을 쓰기 **전에** 그 노트 본문이 실제로 그 질문에 답하고 있는지 확인한다. 얇으면 `§2`를 먼저 보강한다. 판정은 인상이 아니라 원문 문장을 꺼내 읽고 한다.
7. 버전 민감한 내용은 Context7로 대조하고, 확인한 항목만 답안에 `✅`로 표시한다. 표시가 없으면 대조하지 않았다는 뜻이다.
8. 답을 읽은 문항의 gap은 `resolved`로 닫지 않는다. [[gaps]]에 `open`으로 두고 다음에 **다른 표현**으로 재출제한다. 재출제 문항은 답안 파일 끝에 적어 둔다.

### 답안 파일 진행 상태 (2026-08-28 시작)

사용자 요청으로 **Ch2부터 챕터 순서대로 전 노트의 답안 파일을 만드는 중이다.** 사용량 제한 등으로 세션이 끊기면 **이 표에서 다음 대상을 읽고 이어간다.**

| 범위 | 노트 | 답안 파일 | 상태 |
|---|---:|---:|---|
| Ch1 | 8 | 8 | **완료** — 보강 0건 |
| Ch2 | 15 | 15 | **완료** — 보강 0건 |
| Ch3 | 12 | 12 | **완료** — 보강 0건 |
| Ch4 | 23 | 23 | **완료** — 보강 0건 |
| Ch5 | 8 | 8 | **완료** — 보강 0건 |
| Ch6 | 5 | 5 | **완료** — 보강 0건 |
| Ch7 | 8 | 8 | **완료** — 보강 0건 |
| Ch8 | 12 | 12 | **완료** — 보강 0건 |
| Ch9 | 12 | 12 | **완료** — 보강 0건 |
| Ch10 | 6 | 6 | **완료** — 보강 0건 |
| Ch11 | 6 | 6 | **완료** — 보강 0건 |
| Ch12 | 13 | 13 | **완료** — 보강 0건 |
| Ch13 | 15 | 15 | **완료** — 보강 0건 |
| Ch14 | 19 | 19 | **완료** — 보강 0건 |
| Ch15 | 1 | 1 | **완료** — 보강 0건 |
| part-0 j1~j3 | 14 | 14 | **완료** — 보강 0건 |
| part-0 w1 | 1 | 1 | **완료** — 보강 0건 |
| part-0 c1~c4 | 17 | 17 | **완료** — 보강 0건 |

- **2026-08-29 기준 지시받은 범위를 전부 끝냈다.** Ch1의 `00-technical-requirements`까지 채워 남은 노트가 없다.
- 챕터 하나를 끝낼 때마다 이 표와 `session-log.md`를 갱신한다.
- 사용자가 **챕터마다 승인하지 않기로 했다**(2026-08-28). 끝까지 이어서 진행한다.
- 일부 챕터(Ch8·Ch9·Ch10·Ch12·Ch14)는 `§8` 문항이 번호가 아니라 `-` 불릿이다. 문항 수 집계와 포인터 문구를 그 형식에 맞춘다.

### 이 방식을 정한 이유

시도 전에 답을 보면 그 문항을 다시 인출 문제로 쓸 수 없다. 반대로 답이 안 나오는 문항을 무한정 붙들고 있는 것도 낭비다. 손절 시점을 사용자가 직접 정하는 것이 두 손실을 모두 피하는 방법이라고 판단했다.

6번은 첫 세션(2026-08-28)의 오판에서 나왔다. Ch1 `01`의 Q5·Q8을 "인출 실패"로 분류했으나, 원문을 다시 꺼내 보니 Q5의 핵심인 순서 보장 서술이 **본문에 아예 없었고** Q8의 근거여야 할 표는 **주장만** 하고 있었다. 이 결함은 기계 검사로 안 잡힌다 — 용어는 본문에 다 있기 때문이다.

## 소스

| 파일·자료 | 종류 | 스캔본 | 역할 |
|---|---|---|---|
| `Learning Spring Boot 4 ... .pdf` | 책 PDF, 538쪽 | 아니오 | 주교재·목차·예제·서술 순서의 1차 기준 |
| `/spring-projects/spring-boot/v4.0.3` 공식 문서 | Context7 | 해당 없음 | 버전 민감한 동작의 보조 교차 확인 |
| Packt `Learning-Spring-Boot-4` GitHub 저장소 | 예제 코드 | 해당 없음 | 책에서 생략된 전체 코드 확인용, 이번 Chapter에서는 직접 복제하지 않음 |

## 페이지 기준

- Chapter 1: 책 pp. 3–21 / PDF pp. 28–46
- Chapter 2: 책 pp. 25–69 / PDF pp. 50–94
- Chapter 3: 책 pp. 71–96 / PDF pp. 96–121
- Chapter 15: 책 pp. 469–492 / PDF pp. 494–517
- Chapter 5: 책 pp. 153–185 / PDF pp. 178–210
- Chapter 4: 책 pp. 97–151 / PDF pp. 122–176
- Chapter 6: 책 pp. 189–205 / PDF pp. 214–230
- Chapter 13: 책 pp. 347–397 / PDF pp. 372–422
- Chapter 7: 책 pp. 207–227 / PDF pp. 232–252
- Chapter 11: 책 pp. 295–314 / PDF pp. 320–339
- Chapter 14: 책 pp. 401–465 / PDF pp. 426–490
- Chapter 8: 책 pp. 229–248 / PDF pp. 254–273
- Chapter 9: 책 pp. 251–278 / PDF pp. 276–303
- Chapter 10: 책 pp. 281–294 / PDF pp. 306–319
- Chapter 12: 책 pp. 317–343 / PDF pp. 342–368
- 책 쪽과 PDF 쪽의 offset: `+25`
- Chapter 16은 출판사 혜택 안내이므로 학습 본문 범위에서 제외한다.
- `part-0-*` 트랙(`jpa-foundations`·`web-foundations`·`spring-core-internals`)은 PDF 쪽 범위가 없다. 1차 소스가 책이 아니라 공식 문서이기 때문이며, 출처는 각 노트의 `source:`와 챕터 `_coverage.md` §1에 적혀 있다.

## 진행 위치

> 사용자가 지정한 작업 순서(2026-08-27): **Ch3 → Ch15 → Ch5 → Ch4 → Ch6 → Ch13 → Ch7 → Ch11 → Ch14.** Ch8·Ch9·Ch10·Ch12는 별도 지시가 있을 때까지 손대지 않는다. Ch15는 절 단위로 쪼개지 않고 챕터 단위로 정리한다.
>
> **2026-08-27 기준 이 순서는 전부 완료됐다.**
>
> 이어서 사용자의 요청(2026-08-28)으로 남아 있던 **Ch8 → Ch9 → Ch10 → Ch12**도 같은 절차로 상세 재작성했다. **이로써 학습 대상인 Chapter 1–15가 전부 상세 재작성 완료 상태다.**

| Chapter | 상세 재작성 상태 | 현재 산출물 | 다음 |
|---:|---|---|---|
| 1 | **완료** | concept notes 8, map 1, glossary 1, coverage 1 | — |
| 2 | **완료** | concept notes 15, map 1, glossary 1, coverage 1, 책 이미지 10 | — |
| 3 | **완료** | concept notes 12, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 4 | **완료** | concept notes 23, map 1, glossary 1, coverage 1, 책 이미지 5 | — |
| 5 | **완료** | concept notes 8, map 1, glossary 1, coverage 1, 책 이미지 2 | — |
| 6 | **완료** | concept notes 5, map 1, glossary 1, coverage 1, 책 이미지 1 | — |
| 7 | **완료** | concept notes 8, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 8 | **완료** | concept notes 12, map 1, glossary 1, coverage 1, 책 이미지 1 | — |
| 9 | **완료** | concept notes 12, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 10 | **완료** | concept notes 6, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 11 | **완료** | concept notes 6, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 12 | **완료** | concept notes 13, map 1, glossary 1, coverage 1, 책 이미지 1 | — |
| 13 | **완료** | concept notes 15, map 1, glossary 1, coverage 1, 책 이미지 6 | — |
| 14 | **완료** | concept notes 19, map 1, glossary 1, coverage 1, 책 이미지 0 | — |
| 15 | **완료** | concept note 1(챕터 단위 통합), map 1, glossary 1, coverage 1, 책 이미지 0 | — |

### 보조 소스 트랙 — part-0-*

책 트랙과 별개로 진행되는 트랙들이다. *Learning Spring Boot 4*가 **전제하지만 본문에서 다루지 않는 기반 층**을, PDF가 아니라 **공식 문서를 1차 소스로** 복원한다. 현재 세 트랙이 있다.

#### part-0-jpa-foundations — 책 Ch. 3이 다루지 않는 JPA 내부

대조 읽기용 참고서는 김영한 『자바 ORM 표준 JPA 프로그래밍』이다.

| Chapter | 상태 | 현재 산출물 | 1차 소스 |
|---|---|---|---|
| j1 · 영속성 컨텍스트 | **완료** | concept notes 4, map 1, glossary 1, coverage 1 | Hibernate ORM User Guide (Persistence Context · Flushing · Caching), Spring Data JPA Reference |
| j2 · 연관관계와 프록시 | **완료** | concept notes 5, map 1, glossary 1, coverage 1 | Hibernate ORM User Guide (Domain Associations), Introduction (Proxies · Cascading · @Any) |
| j3 · 성능과 트랜잭션 | **완료** | concept notes 5, map 1, glossary 1, coverage 1 | Hibernate ORM (Fetching · HQL From · Locking), Spring Framework/Boot Reference |

#### part-0-web-foundations — 서블릿 층

| Chapter | 상태 | 현재 산출물 | 1차 소스 |
|---|---|---|---|
| w1 · 서블릿과 컨테이너 | **완료** | concept note 1, map 1, glossary 1, coverage 1 | Spring Boot 4.0 Reference (Web/Servlet · System Requirements · Another Web Server), Undertow 문서 |

> **2026-08-28 정정.** 이 트랙은 만들어진 뒤로 이 문서에 등록되지 않은 채였다. 그래서 아래 총계도 1개 적게 잡혀 있었다(177 → 실제 178). 이번 갱신에서 바로잡았다.

#### part-0-spring-core-internals — 프레임워크 내부 동작

책은 `@Transactional`·`@Bean`·컨트롤러를 **쓰는 법**은 다루지만 그것들이 **어떤 메커니즘으로 동작하는지**는 다루지 않는다. `BeanPostProcessor`·`HandlerAdapter`·`AutoConfiguration.imports`는 책에 한 번도 나오지 않는다. 1차 소스는 Spring Framework/Boot Reference이며, 각 노트 `source:`에 대조한 절을 적었다.

| Chapter | 상태 | 현재 산출물 | 1차 소스 |
|---|---|---|---|
| c1 · 컨테이너 생명주기 | **완료** | concept notes 4, map 1, glossary 1, coverage 1 | Framework Reference (Container Extension Points · Lifecycle Callbacks · Bean Scopes · Circular dependencies), Boot Reference·소스 |
| c2 · AOP 프록시의 실체 | **완료** | concept notes 4, map 1, glossary 1, coverage 1 | Framework Reference (Proxying Mechanisms · AOP Concepts · Autoproxying · @Bean/@Configuration), Boot Reference (AOP) |
| c3 · MVC 요청 파이프라인 | **완료** | concept notes 5, map 1, glossary 1, coverage 1 | Framework Reference (DispatcherServlet · Special Bean Types · Processing · Interception · Exceptions · Method Arguments · Content Types) |
| c4 · 자동 구성의 내부 | **완료** | concept notes 4, map 1, glossary 1, coverage 1 | Boot Reference (Auto-configuration · Developing Auto-configuration · Troubleshoot), Actuator API, Boot 소스 |

- **읽는 순서는 c1 → c2 → c3 → c4다.** c1의 "정의 단계와 인스턴스 단계" 구분이 나머지 셋의 전제다.
- 네 챕터는 같은 설계 패턴("비싼 판정은 시작 시점에 한 번, 런타임에는 조회만")의 네 사례로 이어진다. 그 축은 c4 `_map.md` 축 3에 있다.

#### 세 트랙 공통 규칙

- `_coverage.md`는 원문 행 대조가 아니라 **주제 → 출처 매핑**이다. 원문이 여러 문서에 흩어져 있어 행 단위 대조가 성립하지 않는다.
- 책 트랙과 part-0 사이에는 위키 링크를 만들지 않았다. 연결은 각 `_map.md`의 표에 적혀 있다. part-0 트랙끼리도 마찬가지다 — `check-note.sh`가 같은 폴더 밖 `[[링크]]`를 용어로 간주해 실패시키기 때문이다.
- 새 part-0 챕터의 `_coverage.md` 상태 표는 마지막 열 헤더를 반드시 **`상태`**로 쓴다(deep-tutor `book-mode.md` §12). 기존 j1~j3의 `반영`은 호환 조치일 뿐이다.
- 세 트랙을 포함하면 저장소의 concept note는 **163 + 14 + 1 + 17 = 195개**다.

## 품질 상태의 의미

| 표현 | 의미 |
|---|---|
| 기존 압축 초안 | 파일과 기본 구조는 있으나, 원문 중요 내용의 충분한 설명을 보장하지 않음 |
| 상세 재작성 완료 | 원문 하위 절·코드·Tip/Note를 coverage에서 대조하고 각 메커니즘의 이유와 경계를 설명함 |
| 검증 완료 | deep-tutor 구조, 용어집, 내부 링크, Mermaid 실제 렌더링을 모두 통과함 |

초기 99개 문서에 대한 과거의 “완료” 표시는 구조 검사 통과를 내용 완결성으로 잘못 확대한 것이었다. 현재는 Chapter별 상세 재작성 상태만 완료로 인정한다.

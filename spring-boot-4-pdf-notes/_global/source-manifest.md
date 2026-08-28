# PDF 페이지·주제 명세

이 문서는 작업이 기존 노트가 아니라 PDF 본문에서 출발했음을 추적하기 위한 명세다. `책 쪽`은 본문에 인쇄된 페이지, `PDF 쪽`은 뷰어의 실제 페이지다. 주제 파일 수는 현재 파일 수이며, **학습 대상인 Chapter 1–15가 전부 상세 재작성 완료**다.

| Ch | 책 쪽 | PDF 쪽 | 주제 파일 수 |
|---:|---:|---:|---:|
| 1 | 3–21 | 28–46 | 8 |
| 2 | 25–69 | 50–94 | 15 |
| 3 | 71–96 | 96–121 | 12 |
| 4 | 97–151 | 122–176 | 23 |
| 5 | 153–185 | 178–210 | 8 |
| 6 | 189–205 | 214–230 | 5 |
| 7 | 207–227 | 232–252 | 8 |
| 8 | 229–248 | 254–273 | 12 |
| 9 | 251–278 | 276–303 | 12 |
| 10 | 281–294 | 306–319 | 6 |
| 11 | 295–314 | 320–339 | 6 |
| 12 | 317–343 | 342–368 | 13 |
| 13 | 347–397 | 372–422 | 15 |
| 14 | 401–465 | 426–490 | 19 |
| 15 | 469–492 | 494–517 | 1 |
| **합계** |  |  | **163** |

## 보조 소스 트랙 — part-0-jpa-foundations

1차 소스가 PDF가 아니라 공식 문서이므로 책 쪽·PDF 쪽이 없다.

| Chapter | 1차 소스 | 대조 읽기 | 주제 파일 수 |
|---|---|---|---:|
| j1 · 영속성 컨텍스트 | Hibernate ORM User Guide · Spring Data JPA Reference | 김영한 3장 | 4 |
| j2 · 연관관계와 프록시 | Hibernate ORM User Guide · Introduction | 김영한 5·6·7·8장 | 5 |
| j3 · 성능과 트랜잭션 | Hibernate ORM · Spring Framework/Boot Reference | 김영한 12·13·15·16장 | 5 |
| **소계** |  |  | **14** |

책 트랙 163개와 합해 저장소 전체 concept note는 **177개**다.

## 원문 처리 원칙

1. Chapter별 PDF 범위를 `pdftotext -layout`으로 새 임시 경로에 추출한다.
2. 목차의 제목을 기본 경계로 삼되, 한 상위 절에 독립적으로 설명해야 할 개념이 여러 개면 실제 하위 제목을 별도 concept note로 분리한다.
3. 요약문은 원문 문장을 길게 옮기지 않고 개념·맥락·작동 순서를 한국어로 재구성한다.
4. 코드와 설정은 동작 원리를 설명하는 최소 예제로만 제시한다.
5. 현재 공식 문서와 다른 부분은 책의 서술과 현재 사실을 구분해 표시한다.

## 범위 판정

- PDF는 총 538쪽이며 text layer가 있어 OCR 없이 직접 추출했다.
- Chapter 1은 본문 하위 절·코드·Tip/Note까지 coverage 대조를 완료했다.
- Chapter 2도 같은 절차로 본문 하위 절·코드 50개·Tip/Note 19개·인용 1개·Figure 13개를 대조 완료했다.
- Chapter 3도 같은 절차로 본문 하위 절·코드 27개·Tip/Note 12개를 대조 완료했다.
- Chapter 15는 원문이 변경 사항 카탈로그라 절 단위로 쪼개지 않고 **챕터 단위 단일 노트**로 정리했다. 근거는 그 Chapter의 `_coverage.md` §0에 있다.
- Chapter 4는 이 책에서 가장 긴 장(55쪽)이고 상위 절 9개 아래에 **실제 하위 제목 14개**가 있다. 책에 인쇄된 하위 제목을 그대로 분할선으로 삼아 주제 파일을 10 → **23**으로 늘렸다. 기존 초안 10개는 파일 이름이 실제 절 구조와 맞지 않아 전부 교체했다.
- Chapter 11은 상위 절 6개에 실제 하위 제목이 1개뿐이고, 그 하나가 상위 절 도입 바로 뒤에 붙는 같은 절의 본문이라 쪼개지 않았다(주제 파일 수 6 → 6). 기존 파일 이름은 Ch10·Ch12가 참조하고 있어 유지했다.
- Chapter 7은 상위 절 4개 아래에 실제 하위 제목 4개가 있어 8개로 나눴다(주제 파일 수 4 → 8). 기존 4개 파일 이름은 Ch8·Ch10이 참조하고 있어 유지했다.
- Chapter 13은 상위 절 6개 아래에 실제 하위 제목 9개가 있어 15개로 나눴다(주제 파일 수 6 → 15). 기존 6개 파일 이름은 Ch11·Ch12·Ch14가 참조하고 있어 하나도 바꾸지 않았고, 새로 만든 9개만 접미사 노트로 더했다.
- Chapter 8은 상위 절 7개 아래에 2단계 하위 제목 6개가 있어 12개로 나눴다(주제 파일 수 7 → **12**). 기존 7개 중 6개는 이름을 유지했고, `07-java-25-aot-cache-and-crac-comparison`만 CRaC 비교가 `07b`로 분리되며 실제 내용과 어긋나 `07-using-java-25-aot-cache`로 rename했다(Ch8 밖 inbound 0건 확인).
- Chapter 9는 상위 절 6개 아래에 2단계 하위 제목 7개가 있어 12개로 나눴다(주제 파일 수 6 → **12**). 기존 6개 이름은 Ch10이 참조하고 있어 하나도 바꾸지 않았다. `Introduction to Reactive`만은 상위 절 도입과 한 덩어리라 `01`에 합쳤다.
- Chapter 10은 상위 절 4개 아래에 2단계 하위 제목 3개(전부 §4)가 있어 6개로 나눴다(주제 파일 수 4 → **6**). `04-connecting-reactive-data-to-api-and-templates`만 API·템플릿이 `04a`·`04b`로 분리되며 rename했다(Ch10 밖 inbound 0건 확인). Ch9는 이 장의 `01`·`02`만 참조하며 그 이름은 유지했다.
- Chapter 12는 상위 절 6개 아래에 2단계 하위 제목 11개가 있어 13개로 나눴다(주제 파일 수 6 → **13**). 네 상위 절의 도입부는 모두 첫 하위 제목과 합쳤다. 기존 6개 이름은 상위 절과 1:1이라 그대로 뒀다.
- Chapter 14는 상위 절 7개 아래에 실제 2단계 하위 제목 11개, 3단계 하위 제목 10개가 있다. 2단계 제목 전부와 3단계 제목 중 `What are embeddings and vector stores?` 하나만 분할선으로 삼아 주제 파일을 7 → **19**로 늘렸다. 기존 초안 7개는 파일 이름이 상위 절과 1:1로 맞아 하나도 바꾸지 않았고(Ch14를 참조하는 다른 장의 inbound 링크는 0), 새로 만든 12개만 접미사 노트로 더했다. 3단계 제목 9개를 쪼개지 않은 근거는 그 Chapter의 `_coverage.md` §0에 있다.
- Chapter 6도 상위 절 5개에 하위 제목이 없어 절당 노트 하나를 유지했다(주제 파일 수 5 → 5). Ch1 `_map.md`와 Ch7·Ch8 노트가 이 Chapter의 파일 이름을 직접 참조하고 있어 rename도 하지 않았다.
- Chapter 5는 상위 절 8개에 하위 제목이 하나도 없어 절당 노트 하나로 두고 쪼개지 않았다. 기존 초안의 파일 이름도 실제 절과 1:1로 맞아 그대로 유지했다(주제 파일 수 8 → 8).
- Chapter 16은 학습 본문이 아닌 Packt 혜택 안내이므로 제외했다.
- Preface와 index는 개념 노트 대상에서 제외했다.
- 현재 파일은 163개다. Chapter 1의 설정 상위 절을 하위 개념 세 개로 분리해 99개에서 102개가 되었고, Chapter 2에서 5개, Chapter 3에서 6개가 늘어 113개가 되었고, Chapter 15에서 9개를 1개로 통합해 105개가 되었으며, Chapter 4에서 13개가 늘어 118개가 되었고, Chapter 13에서 9개가 늘어 127개가 되었고, Chapter 7에서 4개가 늘어 131개가 되었으며, Chapter 14에서 12개가 늘어 143개가 되었고, 마지막으로 Chapter 8에서 5개·Chapter 9에서 6개·Chapter 10에서 2개·Chapter 12에서 7개가 늘어 **163개**가 되었다. Chapter 5는 하위 제목이 없어 8개 그대로다.
- Chapter 2에서 늘어난 5개의 근거: `Leveraging templates to create content`가 실제로는 `Adding demo data to a template`·`Building our app with a better design`·`Injecting dependencies through constructor calls`·`Changing the data through HTML forms` 네 개의 독립 하위 절을 갖고, `Hooking in Node.js to a Spring Boot web app`이 `Bundling JavaScript with Node.js`·`Creating a React.js app` 두 개를 갖는다. 상위 절 기준 9개를 하위 절 기준 15개로 나눴다.

- Chapter 3에서 늘어난 6개의 근거: `Adding Spring Data to an existing Spring Boot application`이 `Using Spring Data to easily manage data`·`Adding Spring Data JPA to our project` 두 하위 절을, `DTOs, entities, and POJOs, oh my!`가 `Entities`·`DTOs`·`POJOs` 세 하위 절을, `Using custom finders`가 `Sorting the results`·`Limiting query results` 두 하위 절을 갖는다. 상위 절 기준 6개를 하위 절 기준 12개로 나눴다. 하위 제목이 없는 절은 쪼개지 않았다.

# Config

## 정리 모드

mode: batch

- 목표: 책 전체를 Chapter 순서대로 PDF 원문과 다시 대조해 상세 학습 노트로 재작성한다.
- 현재 방식: 한 Chapter씩 `원문 추출 → coverage 작성 → concept notes 작성 → glossary/map 갱신 → 구조·링크·Mermaid 검증`을 완료한 뒤 다음 Chapter로 이동한다.
- 인출 연습: 사용자가 책 전체 정리를 우선 요청했으므로 자동으로 시작하지 않는다.
- `prepared`: 원문 대조와 노트 작성까지 끝난 상태이며, 사용자의 실제 인출 성공을 뜻하지 않는다.

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
- `part-0-jpa-foundations/`는 PDF 쪽 범위가 없다. 1차 소스가 책이 아니라 공식 문서이기 때문이며, 출처는 각 노트의 `source:`와 챕터 `_coverage.md`에 적혀 있다.

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

### 보조 소스 트랙 — part-0-jpa-foundations

책 트랙과 별개로 진행된 트랙이다. *Learning Spring Boot 4* Ch. 3이 다루지 않는 JPA 내부 층을 **PDF가 아니라 Spring Data JPA·Hibernate ORM 공식 문서**에서 복원한다. 대조 읽기용 참고서는 김영한 『자바 ORM 표준 JPA 프로그래밍』이다.

| Chapter | 상태 | 현재 산출물 | 1차 소스 |
|---|---|---|---|
| j1 · 영속성 컨텍스트 | **완료** | concept notes 4, map 1, glossary 1, coverage 1 | Hibernate ORM User Guide (Persistence Context · Flushing · Caching), Spring Data JPA Reference |
| j2 · 연관관계와 프록시 | **완료** | concept notes 5, map 1, glossary 1, coverage 1 | Hibernate ORM User Guide (Domain Associations), Introduction (Proxies · Cascading · @Any) |
| j3 · 성능과 트랜잭션 | **완료** | concept notes 5, map 1, glossary 1, coverage 1 | Hibernate ORM (Fetching · HQL From · Locking), Spring Framework/Boot Reference |

- `_coverage.md`는 원문 행 대조가 아니라 **주제 → 출처 매핑**이다. 원문이 여러 문서에 흩어져 있어 행 단위 대조가 성립하지 않는다.
- 책 트랙과 이 트랙 사이에는 위키 링크를 만들지 않았다. 연결은 각 `_map.md`의 「다음으로 이어지는 곳」 표에 적혀 있다.
- 이 트랙을 포함하면 저장소의 concept note는 **163 + 14 = 177개**다.

## 품질 상태의 의미

| 표현 | 의미 |
|---|---|
| 기존 압축 초안 | 파일과 기본 구조는 있으나, 원문 중요 내용의 충분한 설명을 보장하지 않음 |
| 상세 재작성 완료 | 원문 하위 절·코드·Tip/Note를 coverage에서 대조하고 각 메커니즘의 이유와 경계를 설명함 |
| 검증 완료 | deep-tutor 구조, 용어집, 내부 링크, Mermaid 실제 렌더링을 모두 통과함 |

초기 99개 문서에 대한 과거의 “완료” 표시는 구조 검사 통과를 내용 완결성으로 잘못 확대한 것이었다. 현재는 Chapter별 상세 재작성 상태만 완료로 인정한다.

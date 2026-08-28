# Learning Spring Boot 4 — PDF 기반 학습 노트

이 저장소는 *Learning Spring Boot 4*를 Chapter 순서대로 PDF 원문과 다시 대조해 만드는 학습 노트다. 전체 목차의 초기 파일은 존재하지만, 내용 품질을 다시 판정한 결과 현재 **학습 대상인 Chapter 1–15 전부가 상세 재작성 완료**다. 기존 `spring-boot-notes`, `spring-boot-4-notes`, `spring-boot-4-complete-notes`의 본문은 재사용하지 않으며, **Part → Chapter → 주제 파일**이라는 구조 형식만 참고한다.

## 범위와 기준

- 1차 출처: `Learning Spring Boot 4 ... .pdf` (총 538 PDF쪽)
- 학습 범위: Part 1–7, Chapter 1–15
- 제외: Chapter 16(출판사 혜택 안내), 서문, 색인
- PDF쪽은 인쇄된 책 쪽보다 25쪽 크다. 예: 책 3쪽 = PDF 28쪽.
- 한 파일은 하나의 설명 가능한 개념을 다룬다. 한 상위 주제가 여러 독립 개념을 포함하면 원문의 하위 절을 별도 파일로 분리한다.
- 각 Chapter에 `_coverage.md`를 두어 원문 하위 절·코드·Tip/Note의 반영 위치를 추적한다. 이 기준을 Chapter 1–15 전부에 적용했다.
- 설명용 시각화는 밝은 배경과 어두운 글자의 Mermaid를 우선한다. 책의 화면·구성 자체가 학습에 중요한 경우에만 PDF에서 이미지를 추출한다.
- Spring Boot 4.1 공식 문서는 사실 확인을 위한 보조 자료일 뿐이며, 노트의 순서와 핵심 서술은 PDF를 따른다.

## 현재 산출물 상태

| 항목 | Ch 1 | Ch 2 | Ch 3 | Ch 4 | Ch 5 | Ch 6 | Ch 7 | Ch 8 | Ch 9 | Ch 10 | Ch 11 | Ch 12 | Ch 13 | Ch 14 | Ch 15 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 상세 concept note | 8 | 15 | 12 | 23 | 8 | 5 | 8 | 12 | 12 | 6 | 6 | 13 | 15 | 19 | 1 |
| 원문 coverage | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| Chapter glossary 용어 | 44 | 79 | 56 | 100 | 42 | 41 | 40 | 45 | 56 | 30 | 40 | 39 | 74 | 99 | 34 |
| Mermaid (밝은 배경 + SVG 렌더 + PNG 육안 확인) | 17 | 17 | 15 | 41 | 9 | 13 | 20 | 14 | 14 | 8 | 16 | 16 | 36 | 21 | 2 |
| Deep-tutor note 검사 | 8/8 | 15/15 | 12/12 | 23/23 | 8/8 | 5/5 | 8/8 | 12/12 | 12/12 | 6/6 | 6/6 | 13/13 | 15/15 | 19/19 | 1/1 |
| PDF 이미지 추출 | 0 | 10 | 0 | 5 | 2 | 1 | 0 | 1 | 0 | 0 | 0 | 1 | 6 | 0 | 0 |

Chapter 15만 노트가 하나다. 원문이 개념 전개가 아니라 **변경 사항 카탈로그**(9개 영역·34개 하위 절·코드 리스팅 0개)여서 절 단위로 쪼개면 항목을 관통하는 방향이 오히려 보이지 않기 때문이다.

- 압축 초안 상태로 남은 Chapter는 **없다.** 저장소 전체 위키 링크 2,916개 중 미해결 0개다.
- Mermaid **259개 전부를 PNG로 육안 확인**했다(가로로 긴 28개는 3배 확대 타일로 재확인). 그 과정에서 렌더는 성공하지만 그림이 틀린 결함 7건을 잡아 고쳤다. 근거는 [[_global/validation-report|검증 보고서]]에 있다.
- Chapter 16은 출판사 혜택 안내라 학습 범위에서 제외했다.

## 읽는 순서

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    P1[Part 1<br/>핵심 원리] --> P2[Part 2<br/>웹·데이터·보안·테스트]
    P2 --> P3[Part 3<br/>설정·배포·네이티브]
    P3 --> P4[Part 4<br/>리액티브·가상 스레드·메시징]
    P4 --> P5[Part 5<br/>관측 가능성]
    P5 --> P6[Part 6<br/>Spring AI]
    P6 --> P7[Part 7<br/>Boot 4 변화]
```

상세 재작성이 끝난 Chapter는 `_map.md`에서 개념 축과 읽는 순서를 먼저 보고, `_coverage.md`에서 원문 반영 범위를 확인한 뒤 번호 순서대로 읽는다. 용어는 같은 폴더의 `_glossary.md`에서 확인한다. 현재 단계는 책 전체 정리를 우선하므로 인출 연습은 자동으로 진행하지 않는다. 각 노트 끝의 사용자 영역은 이후 학습 때 직접 채울 수 있도록 비워 둔다.

## 책 전체 구조

> 아래 주제 수는 현재 파일 수다. **Chapter 1–15 전부가 상세 재작성 완료**이며 합계 163개다. 여기에 보조 트랙 `part-0-jpa-foundations`의 14개를 더하면 저장소 전체는 **177개**다.

| Part | Chapter map | 책 쪽 | PDF 쪽 | 주제 수 |
|---|---|---:|---:|---:|
| 1 | [[part-1-the-basics-of-spring-boot/chapter-1-core-features-of-spring-boot/_map|1. Core Features of Spring Boot · 상세 재작성 완료]] | 3–21 | 28–46 | 8 |
| 2 | [[part-2-creating-an-application-with-spring-boot/chapter-2-creating-web-and-api-applications-with-spring-boot/_map|2. Creating Web and API Applications · 상세 재작성 완료]] | 25–69 | 50–94 | 15 |
| 2 | [[part-2-creating-an-application-with-spring-boot/chapter-3-querying-for-data-with-spring-boot/_map|3. Querying for Data · 상세 재작성 완료]] | 71–96 | 96–121 | 12 |
| 2 | [[part-2-creating-an-application-with-spring-boot/chapter-4-securing-an-application-with-spring-boot/_map|4. Securing an Application · 상세 재작성 완료]] | 97–151 | 122–176 | 23 |
| 2 | [[part-2-creating-an-application-with-spring-boot/chapter-5-testing-with-spring-boot/_map|5. Testing with Spring Boot · 상세 재작성 완료]] | 153–185 | 178–210 | 8 |
| 3 | [[part-3-releasing-an-application-with-spring-boot/chapter-6-configuring-an-application-with-spring-boot/_map|6. Configuring an Application · 상세 재작성 완료]] | 189–205 | 214–230 | 5 |
| 3 | [[part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/_map|7. Releasing an Application · 상세 재작성 완료]] | 207–227 | 232–252 | 8 |
| 3 | [[part-3-releasing-an-application-with-spring-boot/chapter-8-going-native-with-spring-boot/_map|8. Going Native · 상세 재작성 완료]] | 229–248 | 254–273 | 12 |
| 4 | [[part-4-scaling-an-application-with-spring-boot/chapter-9-writing-reactive-web-controllers/_map|9. Writing Reactive Web Controllers · 상세 재작성 완료]] | 251–278 | 276–303 | 12 |
| 4 | [[part-4-scaling-an-application-with-spring-boot/chapter-10-working-with-data-reactively/_map|10. Working with Data Reactively · 상세 재작성 완료]] | 281–294 | 306–319 | 6 |
| 4 | [[part-4-scaling-an-application-with-spring-boot/chapter-11-virtual-threads-in-java-and-spring-boot/_map|11. Virtual Threads · 상세 재작성 완료]] | 295–314 | 320–339 | 6 |
| 4 | [[part-4-scaling-an-application-with-spring-boot/chapter-12-messaging-and-asynchronous-communication-in-spring-boot-4/_map|12. Messaging and Async Communication · 상세 재작성 완료]] | 317–343 | 342–368 | 13 |
| 5 | [[part-5-observing-spring-boot-4-applications/chapter-13-observing-spring-boot-4-applications/_map|13. Observability · 상세 재작성 완료]] | 347–397 | 372–422 | 15 |
| 6 | [[part-6-building-intelligent-applications-with-spring-ai/chapter-14-building-intelligent-applications-with-spring-ai/_map|14. Spring AI · 상세 재작성 완료]] | 401–465 | 426–490 | 19 |
| 7 | [[part-7-whats-new-in-spring-boot-4/chapter-15-whats-new-in-spring-boot-4/_map|15. What's New in Spring Boot 4 · 상세 재작성 완료]] | 469–492 | 494–517 | 1 |

### 보조 트랙 — part-0-jpa-foundations

책 Ch. 3은 Spring Data JPA를 26쪽으로 다루고 커스텀 파인더에서 끝난다. 영속성 컨텍스트, 연관관계 매핑, 프록시와 지연 로딩, N+1, `@Transactional` 전파, 락, OSIV는 이 책에 없다. 그 층을 **PDF가 아니라 Spring Data JPA·Hibernate ORM 공식 문서**에서 복원한 트랙이다.

| Chapter map | 1차 소스 | 주제 수 |
|---|---|---:|
| [[part-0-jpa-foundations/chapter-j1-persistence-context/_map\|j1. 영속성 컨텍스트]] | Hibernate ORM User Guide · Spring Data JPA Reference | 4 |
| [[part-0-jpa-foundations/chapter-j2-associations-and-proxies/_map\|j2. 연관관계와 프록시]] | Hibernate ORM User Guide · Introduction | 5 |
| [[part-0-jpa-foundations/chapter-j3-performance-and-transactions/_map\|j3. 성능과 트랜잭션]] | Hibernate ORM · Spring Framework/Boot Reference | 5 |

`_coverage.md`는 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다. 대조 읽기용 참고서로 김영한 『자바 ORM 표준 JPA 프로그래밍』의 대응 장을 각 노트에 표기했다.

## 전역 문서

- [[_global/source-manifest|PDF 페이지·주제 명세]]
- [[_global/cross-bridges|Part 사이의 연결]]
- [[_global/config|진행 상태]]
- [[_global/session-log|작성 기록]]
- [[_global/gaps|남은 확인 사항]]
- [[_global/validation-report|검증 보고서와 현재 한계]]

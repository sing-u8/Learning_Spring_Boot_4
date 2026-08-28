# chapter-w1 출처 커버리지

> 이 챕터는 PDF 원문의 절 순서를 따라간 것이 아니라 공식 문서를 1차 소스로 만들었다. 그래서 Chapter 노트의 `_coverage.md`와 성격이 다르다 — 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다.
>
> 이 트랙이 왜 필요한지는 아래 3절에 있다. 요약하면 *Learning Spring Boot 4*는 "내장 Tomcat이 활성화된다"와 "어떤 컨테이너를 쓰든 `server.port`가 적용된다"를 **결과로만** 말하고, 그 사이의 계약·구현·배치 세 층을 설명하지 않는다.

## 1. 1차 소스

| 소스 | 접근 | 역할 |
|---|---|---|
| Spring Boot Reference — Web / Servlet | Context7 `/spring-projects/spring-boot` | `ServletWebServerApplicationContext`가 `ServletWebServerFactory` 빈을 찾아 부트스트랩한다는 규정 |
| Spring Boot Reference — System Requirements | Context7 `/spring-projects/spring-boot` | Servlet 6.1 기준선, Tomcat 11.0.x·Jetty 12.1.x, "any Servlet 6.1+ compatible container" |
| Spring Boot How-to — Use Another Web Server | Context7 `/spring-projects/spring-boot` | Tomcat exclude + Jetty 스타터 추가 Maven/Gradle 예제, Boot 4 지원 목록에서 Undertow 부재 |
| Spring Boot How-to — Traditional Deployment | Context7 `/spring-projects/spring-boot` | WAR 패키징, `SpringBootServletInitializer`, `provided`·`providedRuntime` 범위 |
| Undertow README · Quick Start · Servlet API | Context7 `/undertow-io/undertow` | `undertow-core`와 `undertow-servlet`의 아티팩트 분리, 서블릿 4.0–6.0 지원 범위 |


> **문서 루트 (2026-08-28 추가).** 이 챕터는 이전 세션이 Context7로 조회해 작성했고, **절 단위 URL이 기록되지 않았다.** 아래는 위 표의 문서 이름에 대응하는 공식 문서의 최상위 주소다. 절 이름으로 찾아 들어가면 대조할 수 있다. 내가 직접 열어 확인한 페이지가 아니므로 **절 단위 앵커는 지어내지 않았다.**
>
> | 문서 | 루트 |
> |---|---|
> | Spring Boot Reference — Web/Servlet | `https://docs.spring.io/spring-boot/reference/web/servlet.html` |
> | Spring Boot Reference — Another Web Server | `https://docs.spring.io/spring-boot/how-to/webserver.html` |
> | Undertow | `https://undertow.io/` |

## 2. 책과의 대조 지점

책이 이 주제를 건드리는 곳은 Chapter 1의 두 쪽뿐이다. 노트는 이 문장들을 **출발점**으로 쓰고 그 뒤를 공식 문서로 잇는다.

| 책 쪽 | PDF 쪽 | 책의 서술 | 노트에서의 처리 |
|---:|---:|---|---|
| 12 | 37 | `spring-boot-starter-webmvc`가 제공하는 6개 기능 중 "An embedded servlet container" | §1.3의 ③(배치)로 확장. 무엇이 내장된 것인지를 §2.3에서 분해 |
| 12 | 37 | Jakarta EE Note — servlets·persistence·validation 사양 위에 구축 | §1.3의 ①(계약)의 근거. 네임스페이스와 버전 기준선까지 확장 |
| 13 | 38 | "내장 Apache Tomcat이 선택된 서블릿 컨테이너로 활성화된다", 포트·컨텍스트 경로·SSL·스레드 가정 | §2.1의 1~4단계로 분해 |
| 13 | 38 | "Jetty를 포함한 대체 서블릿 컨테이너 스타터가 있다. 선택 방법은 Chapter 2에서" | §1.1의 exclude + 스타터 교체 예제로 앞당김 — 공식 how-to가 정본 |
| 14 | 39 | Note — Servlet 6.1 요구, Undertow 미호환으로 제거 | §5의 네 번째 항목. Undertow 저장소의 서블릿 지원 범위(4.0–6.0)로 근거 보강 |
| 14 | 39 | "어떤 서블릿 컨테이너를 쓰든 `server.port`가 적용된다", 컨테이너 전용 설정도 있다 | §2.1의 4단계 — 팩터리 층이 값을 번역한다는 메커니즘으로 설명 |

## 3. 책에 없어서 이 트랙이 채운 것

| 빠진 층 | 왜 필요한가 | 노트 위치 |
|---|---|---|
| 서블릿이 무엇인지 | 책은 용어를 쓰기만 하고 정의하지 않는다. "혼자 못 도는 객체"라는 성질을 모르면 컨테이너가 왜 필요한지 설명할 수 없다 | §1.3, 용어집 |
| 계약 / 구현 / 배치의 3층 구분 | Tomcat·Jetty·Undertow와 "내장 서블릿 컨테이너"가 같은 층에 있는 말로 읽히는 혼동의 원인 | §1.3 표 |
| `DispatcherServlet`이 서블릿 하나라는 사실 | 서버를 바꿔도 컨트롤러가 그대로인 이유의 핵심. Ch2는 이름만 언급한다 | §2.2 8~9단계 |
| `ServletWebServerFactory` 층 | `server.port` 공통성의 실제 구현 지점 | §2.1 2~4단계 |
| 커넥터와 서블릿 컨테이너의 역할 분리 | "Tomcat은 웹 서버인가"·"Nginx는 대체재인가" 혼동 해소 | §5 |
| 내장/외부의 대비 | 배치가 제품 선택과 다른 축이라는 점 | §2.3 표, §6 |

## 4. 주제 → 노트 매핑

| 주제 | 노트 | 반영 |
|---|---|---|
| 서블릿의 정의와 이름의 유래 | [[01-servlet-and-embedded-containers]] | 반영 — §1.3, 용어집 |
| 계약·구현·배치 3층 구분 | [[01-servlet-and-embedded-containers]] | 반영 — §1.3 |
| 서버 교체 절차와 로그 변화 | [[01-servlet-and-embedded-containers]] | 반영 — §1.1 |
| 시작 시 서버가 정해지는 5단계 | [[01-servlet-and-embedded-containers]] | 반영 — §2.1 |
| 요청 하나의 경로 5단계 | [[01-servlet-and-embedded-containers]] | 반영 — §2.2 |
| 내장 대 외부의 대비 | [[01-servlet-and-embedded-containers]] | 반영 — §2.3 표 |
| Undertow 제거의 실제 근거 | [[01-servlet-and-embedded-containers]] | 반영 — §5 |
| WAR 전통 배포 조건 | [[01-servlet-and-embedded-containers]] | 반영 — §6 |
| WebFlux/Reactor Netty가 이 계약 밖이라는 점 | [[01-servlet-and-embedded-containers]] | 반영 — §6 |

## 5. 이미지·도표 판단

- 이 트랙은 PDF 원문 도표가 대상이 아니다. 추출한 책 이미지는 없다.
- 3층 구조와 요청 경로는 모두 개념 관계라 밝은 theme Mermaid로 재현했다(flowchart 1, sequence 1). 내장/외부 대비는 두 세계를 나란히 놓는 편이 읽히므로 ASCII 블록으로 썼다.
- Mermaid 2개 전부 `mmdc`로 PNG 렌더 후 육안 확인했다(2026-08-28).

## 6. 완료 기준

- [x] 노트가 `check-note.sh` 통과
- [x] frontmatter `terms` 8개가 전부 `_glossary.md`에 등재
- [x] `## 7. 연결`의 타 챕터 상대 경로 링크 4개가 실제 파일로 해소됨
- [x] Mermaid 2개 = 밝은 theme init 2개 = 실제 렌더 성공 2개
- [x] 책의 해당 문장(책 pp. 12–14 / PDF pp. 37–39)을 `pdftotext -layout`으로 다시 추출해 대조
- [x] 버전 민감한 내용을 Spring Boot·Undertow 공식 문서로 교차 확인

## 공식 문서 대조 검증 (2026-08-29)

> 이 트랙은 **한 번도 검증된 적이 없었다.** `_global`에 등록조차 안 돼 있던 것을 2026-08-28에 바로잡았고, 내용 대조는 이번이 처음이다. `part-0-spring-core-internals` c3(MVC 요청 파이프라인)가 바로 위층이라 교차 대조했다.

### 결과 — 정정 0건

| 확인한 것 | 결과 |
|---|---|
| 서블릿·컨테이너·"내장"의 층위 | *"**서블릿은 그들이 지켜야 할 계약이고, 내장은 그들을 실행하는 방식이다**"* — 계약과 배치 방식을 정확히 분리한다 |
| `DispatcherServlet`이 하나뿐이라는 것 | *"컨트롤러가 100개여도 컨테이너가 아는 것은 서블릿 하나뿐"* — c3 `01`의 프런트 컨트롤러 서술과 정확히 일치 |
| 컨테이너가 Spring 개념을 모른다는 것 | *"컨테이너에게 Spring의 개념(컨트롤러·`@GetMapping`)을 전혀 노출하지 않기 위해서다. 이 안쪽은 컨테이너에게 그냥 '서블릿 하나가 알아서 하는 일'이다"* — 두 층의 경계를 옳게 긋는다 |
| 책이 결론만 준 지점을 메운다는 자기 규정 | 책 p.13~14의 "어떤 컨테이너를 쓰든 `server.port`는 적용된다"에 대해 *"왜 그럴 수 있는지, 그 사이에 무슨 층이 있는지는 설명하지 않는다. 이 노트가 그 빈칸이다"* — 책 밖 보강의 범위를 명시한 모범 형태 |

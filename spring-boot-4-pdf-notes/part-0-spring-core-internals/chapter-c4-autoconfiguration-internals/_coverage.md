# chapter-c4 출처 커버리지

> PDF 원문이 아니라 공식 문서를 대조해 만든 챕터다. 책 쪽 대조표가 아니라 **주제 → 출처 매핑**이다.
>
> 이 챕터가 존재하는 이유: *Learning Spring Boot 4* Ch. 1은 자동 구성을 **결과**로 설명한다 — "클래스패스에 있으면 켜지고, 사용자 빈이 있으면 물러난다". 그 두 문장이 **어떤 메커니즘으로 성립하는지**(후보 목록, 조건 평가, 순서 보장)는 다루지 않고, 무엇보다 **왜 안 됐는지 진단하는 방법**이 없다. 실무에서 자동 구성 관련 시간의 대부분은 그 진단에 쓰인다.

## 1. 1차 소스

> 아래 URL은 이 챕터를 쓰면서 **실제로 열어 대조한 페이지**다. 내 설명을 믿지 말고 이 주소에서 직접 확인할 수 있게 남긴다.

| 소스 | 정확한 위치 | 역할 |
|---|---|---|
| Boot Ref — Auto-configuration | `https://docs.spring.io/spring-boot/reference/using/auto-configuration.html` | 옵트인 성격, **비침습적(non-invasive)·"backs away"**, `--debug` 조건 보고서, `exclude`/`excludeName`/`spring.autoconfigure.exclude` |
| Boot Ref — Creating Your Own Auto-configuration | `https://docs.spring.io/spring-boot/reference/features/developing-auto-configuration.html` | `@AutoConfiguration`, **`AutoConfiguration.imports` 경로와 형식**, 컴포넌트 스캔 금지 3항, 조건 애노테이션 목록, **빈 조건의 순서 민감성 경고**, 순서 지정 3수단, **정의 순서 vs 생성 순서** |
| Boot Ref — Troubleshoot Auto-configuration | `https://docs.spring.io/spring-boot/reference/how-to/application.html` | `ConditionEvaluationReport` 존재, `conditions` 엔드포인트 권장 |
| Boot Actuator API — `GET /actuator/conditions` | Context7 `/spring-projects/spring-boot/v4.0.3` | 응답 구조(`positiveMatches`·`negativeMatches`·`unconditionalClasses`)와 실제 메시지 예시 |
| Boot 소스 — `SpringBootCondition` | Context7 같음 | `matches()`가 `final`이고 `recordEvaluation`을 강제, `ConditionOutcome` 반환 |
| Boot Actuator Ref — Endpoints | Context7 같음 | `beans`·`mappings`·`conditions` 역할 구분 |

## 2. 책 트랙과의 관계

| 책의 서술 | 이 챕터가 채우는 것 |
|---|---|
| Ch. 1 — 자동 구성이 클래스패스를 보고 빈을 등록한다 | 그 후보 목록이 **어디에 적혀 있고** 어떻게 수집되는지 |
| Ch. 1 — 사용자가 빈을 만들면 자동 구성이 back off 한다 | back-off가 양보가 아니라 **조건 불통과**이며, 그것이 성립하려면 **순서 보장**이 필요하다는 것 |
| Ch. 1 — `@ConditionalOnClass` 예제 | 조건 애노테이션의 **전체 지형**과 빈 조건만 순서에 민감한 이유 |
| Ch. 1 — 자동 구성 목록(AMQP…WebSocket) | 그 목록이 "적용된 것"이 아니라 "후보"라는 구분 |
| 책에 없음 — `AutoConfiguration.imports`, `@AutoConfigureAfter`, 조건 평가 보고서 | 이 챕터의 핵심. 특히 **진단 방법**은 책에 전혀 없다 |

## 3. 주제 → 노트 매핑

| 주제 | 출처 | 정리 노트 | 상태 |
|---|---|---|---|
| 자동 구성이 옵트인이라는 것 | Boot Ref · Auto-configuration (원문) | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 2.1·5절 |
| `AutoConfiguration.imports` 경로와 형식 | Boot Ref · Creating Your Own (원문) | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 2.2 |
| **컴포넌트 스캔 금지 3항** | 같음 (원문) | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 2.3·6절 |
| 왜 스캔이 아니라 목록 파일인가 | 위 금지 조항에서 도출 | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 1절·3절 |
| `@SpringBootApplication`의 세 구성 요소 | Boot Ref · Auto-configuration | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 5절 |
| `exclude`·`excludeName`·`spring.autoconfigure.exclude` | Boot Ref · Auto-configuration (원문·예제) | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 2.4 |
| 제외와 백오프의 구분 | 두 메커니즘의 시점 비교에서 도출 | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 5절 |
| `@AutoConfiguration`이 라이트 모드라는 것 | c2의 `@Configuration(proxyBeanMethods=false)`와 연결 | [[01-enableautoconfiguration-and-imports-file]] | 반영 — 용어집 |
| 비침습적 성격과 "backs away" | Boot Ref · Auto-configuration (원문) | [[02-conditional-evaluation-and-backoff]] | 반영 — 1절 |
| back-off의 메커니즘이 조건이라는 것 | 위 서술 + 조건 애노테이션 문서 종합 | [[02-conditional-evaluation-and-backoff]] | 반영 — 1절·3절 |
| 조건 애노테이션 전체 목록 | Boot Ref · Condition Annotations (원문) | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.1 |
| **빈 조건의 순서 민감성 경고** | 같음 (원문) | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.2·3절 |
| 자동 구성은 사용자 빈 정의 이후 로드된다는 보장 | 같음 (원문) | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.2 |
| 사용자 코드의 `@ConditionalOnMissingBean`이 오작동하는 이유 | 위 보장에서 도출 | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.2·3절·6절 |
| 클래스 조건이 클래스 로딩 없이 평가된다는 성질 | Boot Ref + `SpringBootCondition` 구조에서 도출 | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.3 |
| 클래스 레벨 vs 메서드 레벨 조건의 차이 | Boot Ref · Condition Annotations (원문) | [[02-conditional-evaluation-and-backoff]] | 반영 — 2.4 |
| 백오프·`@Primary`·`exclude`의 구분 | 세 메커니즘의 시점·결과 비교 | [[02-conditional-evaluation-and-backoff]] | 반영 — 5절 |
| 조건이 타입 기준이라는 것 | `@ConditionalOnMissingBean` 계약 | [[02-conditional-evaluation-and-backoff]] | 반영 — 5절 |
| 순서 지정 3수단 | Boot Ref · Ordering (원문) | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 2.2 |
| **정의 순서와 생성 순서의 구분** | Boot Ref · Ordering (원문 명시) | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 1절·2.1·3절 |
| `@AutoConfigureOrder`가 `@Order`와 다른 이유 | Boot Ref · Ordering (원문) | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 2.2·2.5·5절 |
| `beforeName`·`afterName`이 문자열인 이유 | 클래스패스 부재 가능성에서 도출 | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 2.2 |
| 사용자 빈 → 자동 구성의 처리 경계 | Boot Ref · Condition Annotations (원문 보장) | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 2.3·3절 |
| 생성 순서를 강제하는 4가지 방법 | Framework Ref(`@DependsOn`·`SmartLifecycle`) + Boot(`ApplicationRunner`) | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 2.4 |
| `@AutoConfigureAfter`와 `@DependsOn`의 구분 | 두 애노테이션의 대상 단계 비교 | [[03-autoconfiguration-ordering-and-user-precedence]] | 반영 — 5절 |
| `--debug`로 조건 보고서를 보는 방법 | Boot Ref · Auto-configuration (원문) | [[04-condition-evaluation-report]] | 반영 — 2.1 |
| `ConditionEvaluationReport`의 존재 | Boot Ref · Troubleshoot (원문) | [[04-condition-evaluation-report]] | 반영 — 1절 |
| `/actuator/conditions` 응답 구조 | Actuator API (원문 스키마·예시) | [[04-condition-evaluation-report]] | 반영 — 2.2 |
| 세 절이 각각 답하는 질문 | 위 구조에서 도출 | [[04-condition-evaluation-report]] | 반영 — 2.2·3절 |
| `condition` 값별 진단 행동 | 조건 애노테이션 목록과 대응 | [[04-condition-evaluation-report]] | 반영 — 2.3 |
| `SpringBootCondition.matches()`가 `final`이라는 구조 | Boot 소스 (원문 코드) | [[04-condition-evaluation-report]] | 반영 — 2.5 |
| `ConditionOutcome` 반환의 이유 | 같음에서 도출 | [[04-condition-evaluation-report]] | 반영 — 2.5 |
| `negativeMatches`가 길어도 정상이라는 것 | 후보 수백 개 구조에서 도출 | [[04-condition-evaluation-report]] | 반영 — 5절 |
| 네 진단 엔드포인트의 역할 분담 | Actuator Ref · Endpoints (원문) | [[04-condition-evaluation-report]] | 반영 — 5절 |
| `@ConfigurationProperties` 바인딩의 상세 | Boot Ref · Externalized Configuration | — | 미반영 — 책 트랙 Ch. 1의 `03a`~`03c`가 이미 상세히 다룬다. 중복이라 이 챕터에서 반복하지 않고 `configprops` 엔드포인트로 진단 관점만 연결했다 |
| `FailureAnalyzer`와 기동 실패 메시지 커스터마이징 | Boot Ref · Failure Analyzer | — | 미반영 — c1의 `04`에서 순환 참조 실패 분석기를 실제 사례로 다뤘다. 자기 분석기를 **만드는** 방법은 스타터 저작 주제이지 자동 구성 이해의 필수 고리가 아니다 |
| 스타터(starter) 모듈 구성과 명명 규칙 | Boot Ref · Creating Your Own Starter | — | 미반영 — 이 챕터는 자동 구성이 **동작하는 원리**가 축이다. 배포 가능한 스타터를 만드는 절차는 실제로 만들기로 결정한 뒤 필요한 정보다 |
| AOT 처리와 네이티브 이미지에서의 자동 구성 | Boot Ref · Native Image | — | 미반영 — 책 트랙 Ch. 8이 다룬다. 조건 평가가 빌드 시점으로 옮겨간다는 사실만 c2에서 언급했다 |

## 4. 흔한 요약과 공식 동작이 갈리는 지점

| 흔한 요약 | 공식 동작 | 위치 |
|---|---|---|
| "자동 구성은 컴포넌트 스캔으로 발견된다" | 임포트 파일로만 로드된다. 스캔 대상이 되면 **안 된다** | 01 — 2.3 |
| "`@SpringBootApplication`이 알아서 다 해 준다" | 자동 구성은 **옵트인**이다. 세 애노테이션의 묶음일 뿐 | 01 — 2.1·5절 |
| "후보 목록에 있으면 적용된다" | 수백 개 후보 중 수십 개만 조건을 통과한다 | 01 — 5절 |
| "Spring이 사용자 빈을 우선시한다" | 우선순위가 아니라 **조건 불통과**다. 빈이 둘 생긴 적이 없다 | 02 — 1절·3절 |
| "back-off는 프레임워크가 양보하는 것" | 조건문의 결과일 뿐. 내 빈이 잘못돼 있어도 그대로 물러난다 | 02 — 1절·5절 |
| "`@ConditionalOnMissingBean`은 어디서나 쓸 수 있다" | 자동 구성 클래스에만 권장. 사용자 코드에서는 항상 통과한다 | 02 — 2.2·6절 |
| "`@AutoConfigureAfter`로 초기화 순서를 정한다" | **정의 순서만** 바뀐다. 생성 순서는 의존성이 정한다 | 03 — 1절·2.1 |
| "자동 구성 순서에 `@Order`를 쓴다" | 자동 구성 전용 `@AutoConfigureOrder`가 따로 있다 | 03 — 5절 |
| "왜 안 되는지는 소스를 읽어 알아낸다" | 조건 평가 보고서에 이유가 문장으로 기록돼 있다 | 04 — 1절 |
| "`negativeMatches`에 뭐가 많으면 문제다" | 대부분 정상이다. 안 쓰는 기술이 안 켜진 것 | 04 — 5절 |

## 5. 아직 다루지 않은 것

| 주제 | 왜 보류인가 |
|---|---|
| `@ConfigurationProperties` 바인딩 상세 | 책 트랙 Ch. 1이 이미 상세히 다룬다. 중복 회피 |
| `FailureAnalyzer` 직접 작성 | 스타터 저작 주제. c1에서 실제 사례로만 다뤘다 |
| 스타터 모듈 구성·명명 규칙 | 만들기로 결정한 뒤 필요한 절차 정보다 |
| AOT·네이티브 이미지의 자동 구성 | 책 트랙 Ch. 8의 주제 |
| `@ImportRuntimeHints`·런타임 힌트 | 같은 이유로 Ch. 8 |
| 테스트 슬라이스(`@WebMvcTest` 등)의 자동 구성 필터링 | 책 트랙 Ch. 5의 주제이고, 별도의 조건 메커니즘이 얹힌다 |

## 6. 정정 이력

| # | 위치 | 처음에 쓴 것 | 보강 | 근거 |
|---|---|---|---|---|
| 1 | `02` §2.3 | **"조건 자체가 클래스 로딩 없이 평가된다"**고 뭉뚱그렸다 | 정확히는 **"애노테이션 값을 `Class` 객체가 아니라 클래스 이름 문자열로 읽어, 자동 구성 클래스 자신을 로드하지 않고도 판정한다"**이다. 존재 확인 자체는 클래스로더에 물어본다. 닭과 달걀(조건을 읽으려면 애노테이션을 읽어야 하는데 그 값이 없는 클래스라면?)을 어떻게 푸는지를 명시적으로 설명하도록 다시 썼다 | `https://docs.spring.io/spring-boot/reference/features/developing-auto-configuration.html` + Boot 소스 `SpringBootCondition` (Context7 `/spring-projects/spring-boot/v4.0.3`) |

**성격.** 결론은 맞았지만 **메커니즘 설명이 한 단계 생략돼 있었다.** 이 챕터의 존재 이유가 "결과가 아니라 메커니즘"인데 정작 그 대목에서 결과만 말한 셈이라, 다른 오류보다 이 노트의 목적에 더 어긋난다.

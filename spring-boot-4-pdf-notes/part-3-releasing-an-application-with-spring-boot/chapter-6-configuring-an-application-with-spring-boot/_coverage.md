# Chapter 6 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 6 *Configuring an Application with Spring Boot*, 책 pp. 189–205 / PDF pp. 214–230. PDF를 `pdftotext -layout -f 214 -l 230`으로 새로 추출해 694줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

이 Chapter의 상위 절은 5개이고 **하위 제목이 하나도 없다.** 그래서 절 하나당 노트 하나로 두고 쪼개지 않았다. 기존 5개 초안의 파일 이름도 실제 절과 1:1로 맞아 rename 없이 전면 재작성했다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-creating-custom-properties]] | Creating custom properties | 190–195 | 215–220 |
| [[02-creating-profile-based-property-files]] | Creating profile-based property files | 195–199 | 220–224 |
| [[03-switching-to-yaml-and-metadata]] | Switching to YAML | 199–202 | 224–227 |
| [[04-setting-properties-with-environment-variables]] | Setting properties with environment variables | 202–203 | 227–228 |
| [[05-ordering-property-overrides]] | Ordering property overrides | 203–205 | 228–230 |

**`03`의 파일 이름은 원문 제목보다 길다.** 원문 제목은 *Switching to YAML*이지만 그 절의 후반부가 통째로 `spring-boot-configuration-processor`와 IDE 코드 완성(설정 메타데이터) 이야기다. 기존 초안의 이름(`03-switching-to-yaml-and-metadata`)이 내용에 더 맞고, 다른 Chapter에서 이 파일을 참조하는 링크도 없어 그대로 유지했다.

**이 Chapter의 파일 이름은 하나도 바꾸지 않았다.** Ch1 `_map.md`, Ch7 노트 2개, Ch8 노트 1개가 `01-creating-custom-properties`·`02-creating-profile-based-property-files`·`05-ordering-property-overrides`를 직접 가리키고 있어, rename하면 대상 Chapter 밖 파일을 고쳐야 한다.

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 189 | 214 | 장 도입: 설정은 "몇 개 프로퍼티 세팅"이 아니라 **코드와 현실 세계를 잇는 연결점**이라는 관점, 환경별로 앱의 행동을 빚는 도구, 다룰 5개 주제 | [[_map]] | 반영 |
| 190 | 215 | Note: 이 장의 소스는 저장소 `ch6` 폴더 | [[01-creating-custom-properties]] | 반영 |
| 190 | 215 | Chapter 4에서 쓴 `spring.mustache.servlet.expose-request-attributes=true` 회상, 내장 프로퍼티만이 아니라 **직접 만들 수 있다** | [[01-creating-custom-properties]] | 반영 |
| 190 | 215 | `AppConfig` record와 `@ConfigurationProperties("app.config")`, 항목별 3개 설명(애노테이션·이름은 무관·필드가 곧 프로퍼티 이름) | [[01-creating-custom-properties]] | 반영 |
| 190 | 215 | Note: record는 정규 생성자가 있어 `@ConstructorBinding`이 필요 없다. 생성자가 여러 개일 때만 필요 | [[01-creating-custom-properties]] | 반영 |
| 191 | 216 | `application.properties`에 header·intro·users 11줄, 대괄호 인덱스 표기로 리스트 채우기, 항목별 3개 설명 | [[01-creating-custom-properties]] | 반영 |
| 191 | 216 | 프로퍼티만으로는 앱이 못 쓴다 — 컴포넌트 스캔에 잡히는 빈에 **등록**해야 한다, 앱 전역이므로 진입점에 붙인다 | [[01-creating-custom-properties]] | 반영 |
| 191–192 | 216–217 | `@SpringBootApplication` + `@EnableConfigurationProperties(AppConfig.class)` | [[01-creating-custom-properties]] | 반영 |
| 192 | 217 | Tip: 어디에 붙이는 게 좋은가 — 특정 빈 전용이면 그 빈에, 여러 빈이 쓰면 진입점에 | [[01-creating-custom-properties]] | 반영 |
| 192 | 217 | `@EnableConfigurationProperties` 또는 `@ConfigurationPropertiesScan`으로 등록되면 `AppConfig` 빈이 컨텍스트에 생긴다 | [[01-creating-custom-properties]] | 반영 |
| 192–193 | 217–218 | `HomeController`에 `AppConfig` 필드 추가(생성자 주입), `index()`에서 header·intro를 모델 속성으로 | [[01-creating-custom-properties]] | 반영 |
| 193 | 218 | `index.mustache`의 `{{header}}` / `{{intro}}` — 하드코딩이 템플릿 변수가 됐다 | [[01-creating-custom-properties]] | 반영 |
| 193 | 218 | "문자열 두 개 뽑아낸 게 대단한가?" → `users` 필드로 진짜 힘을 보여 준다는 전환 | [[01-creating-custom-properties]] | 반영 |
| 193 | 218 | 프로퍼티 파일은 근본적으로 **문자열 key-value**다, 내장 컨버터가 있지만 `List<GrantedAuthority>`는 직접 만들어야 한다 | [[01-creating-custom-properties]] | 반영 |
| 194 | 219 | `SecurityConfig`에 `Converter<String, GrantedAuthority>` 빈 + `@ConfigurationPropertiesBinding`, 항목별 3개 설명(생명주기 이른 시점이라 자기 완결적으로 유지) | [[01-creating-custom-properties]] | 반영 |
| 194 | 219 | IDE가 람다·메서드 참조로 줄이라고 권하지만 **동작하지 않는다** — 자바의 타입 소거 | [[01-creating-custom-properties]] | 반영 |
| 194–195 | 219–220 | `interface GrantedAuthorityCnv extends Converter<String, GrantedAuthority> {}` 명명 하위 인터페이스로 제네릭을 고정, 항목별 2개 설명, 어느 쪽이 나은지는 취향 | [[01-creating-custom-properties]] | 반영 |
| 195 | 220 | 프로퍼티 주도로 바꿔 두면 환경별 커스터마이즈가 가능해진다는 전환 | [[02-creating-profile-based-property-files]] | 반영 |
| 195 | 220 | 앱은 한 맥락에서만 돌지 않는다 — 개발·테스트·스테이징·운영, DB·테스트 계정·외부 시스템이 각각 다르다 | [[02-creating-profile-based-property-files]] | 반영 |
| 195–196 | 220–221 | `application-test.properties` 11줄과 항목별 3개 설명(`-test` 접미사가 프로파일과 연결, 맞춤 메시지, 환경별 사용자) | [[02-creating-profile-based-property-files]] | 반영 |
| 196 | 221 | 프로파일 활성화 3가지 — `-Dspring.profiles.active=test`, `export SPRING_PROFILES_ACTIVE=test`, IntelliJ 실행 구성 | [[02-creating-profile-based-property-files]] | 반영 |
| 197 | 222 | Figure 6.1 IntelliJ 실행 구성의 Active profiles 필드 | [[02-creating-profile-based-property-files]] | 반영 (미추출 — 아래 4절) |
| 198 | 223 | Tip: **프로파일은 가산적이다.** `application.properties`를 대체하지 않고 덧붙는다. 중복 키는 나중 것이 이긴다. **리스트는 병합되지 않고 통째로 교체된다.** 쉼표로 여러 개 적용 가능 | [[02-creating-profile-based-property-files]] | 반영 |
| 198–199 | 223–224 | 개발 랩 / 테스트 베드 / 운영 시나리오와 두 가지 전략 — 개발을 기본값으로(안전) vs 운영을 기본값으로(사고 위험) | [[02-creating-profile-based-property-files]] | 반영 |
| 199 | 224 | 실제로 운영 설정은 아티팩트에 넣지 않는다, `spring.config.additional-location`과 `spring.config.location`의 차이, `SPRING_CONFIG_ADDITIONAL_LOCATION`, 클라우드에서도 같은 원리 | [[02-creating-profile-based-property-files]] | 반영 |
| 199 | 224 | Chapter 4의 OAuth2 YAML 설정을 이미 봤다는 회상, "Spring 방식은 선택지를 준다" | [[03-switching-to-yaml-and-metadata]] | 반영 |
| 199–200 | 224–225 | key/value 방식이 커지면 감당이 안 된다, 인덱스 값을 일일이 적는 게 투박했다 | [[03-switching-to-yaml-and-metadata]] | 반영 |
| 200 | 225 | `application-alternate.yaml` 전체와 항목별 4개 설명(중첩이 중복을 막는다, 하이픈이 배열, 복합 타입은 필드별 줄, authorities도 리스트) | [[03-switching-to-yaml-and-metadata]] | 반영 |
| 200 | 225 | Note: YAML은 작은 파일에서 읽기 좋지만 길어지면 나빠진다. **들여쓰기가 의미를 갖고** 위쪽 오류를 찾기 어렵다 | [[03-switching-to-yaml-and-metadata]] | 반영 |
| 201 | 226 | IDE 코드 완성이 `.properties`와 `.yaml` 양쪽을 지원한다(Figure 6.2), key/value로 뜨지만 YAML 형식으로 적용된다 | [[03-switching-to-yaml-and-metadata]] | 반영 (이미지 추출) |
| 201–202 | 226–227 | 내 커스텀 프로퍼티도 완성 목록에 띄우려면 `spring-boot-configuration-processor`가 필요하다, Initializr가 이미 넣었을 수 있으니 `pom.xml`을 먼저 확인 | [[03-switching-to-yaml-and-metadata]] | 반영 |
| 202 | 227 | 명령줄에서 설정할 수 없으면 안 된다 — 아무리 설계해도 무언가는 터진다 | [[04-setting-properties-with-environment-variables]] | 반영 |
| 202 | 227 | Note: JAR을 풀어 프로퍼티를 고치고 다시 묶지 마라. 20년 전에나 통했다 | [[04-setting-properties-with-environment-variables]] | 반영 |
| 202 | 227 | `SPRING_PROFILES_ACTIVE=alternate ./mvnw spring-boot:run`과 항목별 4개 설명(완화된 바인딩, 프로파일 이름, Maven 래퍼, run 골) | [[04-setting-properties-with-environment-variables]] | 반영 |
| 203 | 228 | 이 방식은 **그 명령에만** 적용된다, 셸 세션 전체에 유지하려면 `export` | [[04-setting-properties-with-environment-variables]] | 반영 |
| 203 | 228 | `SPRING_PROFILES_ACTIVE=test,alternate`로 다중 프로파일, **왼쪽에서 오른쪽으로** 적용돼 마지막이 이긴다 → YAML 계정이 최종 | [[04-setting-properties-with-environment-variables]] | 반영 |
| 203–204 | 228–229 | 프로퍼티 소스 우선순위 15항목(낮음 → 높음), `application.properties`는 상대적으로 낮다는 결론 | [[05-ordering-property-overrides]] | 반영 |
| 204 | 229 | Config data 파일 4단계 순서 — JAR 안 기본 → JAR 안 프로파일별 → JAR 밖 기본 → JAR 밖 프로파일별 | [[05-ordering-property-overrides]] | 반영 |
| 205 | 230 | 실행 가능 JAR 옆에 프로퍼티 파일을 두면 오버라이드가 된다, 앞의 "JAR 열지 마라" 경고가 필요 없는 이유 | [[05-ordering-property-overrides]] | 반영 |
| 205 | 230 | Note: 명령줄에서 즉석 조정에도 위험이 있다 — 기록하고 형상 관리에 반영하라, 패치에 덮이는 것보다 나쁜 건 없다 | [[05-ordering-property-overrides]] | 반영 |
| 205 | 230 | Twelve-Factor App(2011, Heroku)의 **세 번째 factor가 config**, 환경마다 달라질 것을 전부 외부화하라, 모든 factor가 지금도 유효한지는 논쟁적 | [[05-ordering-property-overrides]] | 반영 |
| 205 | 230 | Summary: 타입 안전 설정 클래스 → 프로퍼티 파일 부트스트랩 → 주입 → 프로파일 → YAML → 명령줄 오버라이드 | [[_map]] | 반영 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 |
|---:|---|---:|---|
| 1 | `AppConfig` record + `@ConfigurationProperties("app.config")` | 190 | [[01-creating-custom-properties]] |
| 2 | `application.properties`의 `app.config.*` 11줄 | 191 | [[01-creating-custom-properties]] |
| 3 | `@EnableConfigurationProperties(AppConfig.class)` | 191 | [[01-creating-custom-properties]] |
| 4 | `HomeController` 생성자에 `AppConfig` 추가 | 192 | [[01-creating-custom-properties]] |
| 5 | `index()`의 `model.addAttribute("header"/"intro")` | 193 | [[01-creating-custom-properties]] |
| 6 | `index.mustache`의 `{{header}}` / `{{intro}}` | 193 | [[01-creating-custom-properties]] |
| 7 | `Converter<String, GrantedAuthority>` 빈 + `@ConfigurationPropertiesBinding` | 194 | [[01-creating-custom-properties]] |
| 8 | 람다·메서드 참조 축약안(본문 인라인) | 194 | [[01-creating-custom-properties]] |
| 9 | `GrantedAuthorityCnv` 명명 하위 인터페이스 + 빈 | 194–195 | [[01-creating-custom-properties]] |
| 10 | `application-test.properties` 11줄 | 195–196 | [[02-creating-profile-based-property-files]] |
| 11 | 프로파일 활성화 3가지(`-D`, `export`, IDE) | 196 | [[02-creating-profile-based-property-files]] |
| 12 | `-Dspring.config.additional-location=file:/opt/app/config/` | 199 | [[02-creating-profile-based-property-files]] |
| 13 | `application-alternate.yaml` 전체 | 200 | [[03-switching-to-yaml-and-metadata]] |
| 14 | `spring-boot-configuration-processor` 의존성(`<optional>true</optional>`) | 201–202 | [[03-switching-to-yaml-and-metadata]] |
| 15 | `SPRING_PROFILES_ACTIVE=alternate ./mvnw spring-boot:run` | 202 | [[04-setting-properties-with-environment-variables]] |
| 16 | `export SPRING_PROFILES_ACTIVE=test` | 203 | [[04-setting-properties-with-environment-variables]] |
| 17 | `SPRING_PROFILES_ACTIVE=test,alternate ./mvnw spring-boot:run` | 203 | [[04-setting-properties-with-environment-variables]] |
| 18 | 프로퍼티 소스 우선순위 15항목 목록 | 203–204 | [[05-ordering-property-overrides]] |
| 19 | Config data 파일 4단계 순서 목록 | 204 | [[05-ordering-property-overrides]] |

## 3. Tip / Note 블록 → 노트 매핑

| # | 종류 | 요지 | 책 쪽 | 노트 |
|---:|---|---|---:|---|
| 1 | Note | 이 장의 소스는 `ch6` 폴더 | 190 | [[01-creating-custom-properties]] |
| 2 | Note | record의 정규 생성자 덕에 `@ConstructorBinding`이 불필요 | 190 | [[01-creating-custom-properties]] |
| 3 | Tip | 커스텀 프로퍼티를 어디에 활성화할 것인가 | 192 | [[01-creating-custom-properties]] |
| 4 | Tip | 프로파일은 가산적, 마지막이 이김, **리스트는 병합되지 않음**, 다중 프로파일 | 198 | [[02-creating-profile-based-property-files]] |
| 5 | Note | YAML은 작은 파일에 좋고 커지면 들여쓰기 오류를 찾기 어렵다 | 200 | [[03-switching-to-yaml-and-metadata]] |
| 6 | Note | JAR을 풀어 프로퍼티를 고치지 마라 | 202 | [[04-setting-properties-with-environment-variables]] |
| 7 | Note | 즉석 조정도 기록하고 형상 관리에 반영하라 | 205 | [[05-ordering-property-overrides]] |

## 4. Figure 처리 판단

`pdfimages -f 214 -l 230 -list` 결과 raster 이미지 2개(Figure 6.1–6.2)를 확인하고 둘 다 PNG로 뽑아 육안 대조한 뒤 **1개만** `_assets/`에 남겼다.

| Figure | 책 쪽 / PDF 쪽 | 판단 | 근거 |
|---|---:|---|---|
| 6.1 IntelliJ 실행 구성의 Active profiles | 197 / 222 | 미추출 | IntelliJ의 Run/Debug Configurations 대화상자다. 본문이 위치를 그대로 서술하고("Active profiles 필드를 찾아 test로 설정"), 이 절이 제시하는 세 방법 중 **가장 이식성이 낮은 것**이다. 화면에는 본문이 설명하지 않는 `java 25 graalvm-25` 런타임 선택까지 찍혀 있어 이 장의 주제와 무관한 잡음이 된다. 화면이 주는 유일한 추가 정보인 "Comma-separated list of profiles" 힌트는 노트 본문에 문장으로 옮겼다 |
| 6.2 IntelliJ 코드 완성 | 201 / 226 | **추출** | 이 절의 주장(`spring-boot-configuration-processor`를 넣으면 **내가 만든** 프로퍼티도 완성 목록에 뜬다)을 눈으로 증명하는 유일한 자료다. 팝업에 `app.config.users` `List<UserAccount>`, `app.config.header` `String`, `app.config.intro` `String`이 **선언한 타입과 함께** 떠 있어, 메타데이터가 이름만이 아니라 타입까지 담는다는 사실이 드러난다. `lsb4-p201-fig6-2-intellij-completion-for-custom-properties.png` |

## 5. 원문의 오류·공백 (노트에 명시)

| # | 위치 | 내용 |
|---:|---|---|
| 1 | 책 pp. 190–195 전체 | `AppConfig`가 `List<UserAccount>`를 담고 `app.config.users[*]`로 사용자 3명을 정의하지만, **그 값이 Spring Security에 어떻게 도달하는지는 끝내 보여 주지 않는다.** Chapter 4의 `UserDetailsService`는 `UserRepository`(DB)를 보고 있었고, 이 장은 그것을 바꾸는 코드를 제시하지 않는다. `header`·`intro`만 실제로 소비되는 경로가 나온다 |
| 2 | 책 p. 190 | `UserAccount`를 재정의하지 않는다. Chapter 4의 `UserAccount`는 `@Entity`에 `@Id @GeneratedValue`가 붙은 JPA 엔티티이고 `@ElementCollection List<GrantedAuthority>`를 갖는다. 설정 바인딩 대상으로 JPA 엔티티를 쓰는 것이 의도인지, 별도 타입인지 본문이 구분하지 않는다 |
| 3 | 책 p. 196 vs pp. 203–204 | 프로파일 활성화 방법으로 `-Dspring.profiles.active`(시스템 프로퍼티)와 `SPRING_PROFILES_ACTIVE`(환경 변수)를 **동등하게** 제시한다. 그런데 같은 장 뒤의 우선순위 목록에서는 시스템 프로퍼티(#6)가 환경 변수(#5)보다 **높다.** 둘을 동시에 지정하면 `-D` 쪽이 이긴다는 사실이 언급되지 않는다 |
| 4 | 책 p. 200 vs Figure 6.2 | 본문은 `application-alternate.yaml`을 만들라고 하지만, Figure 6.2의 편집기 탭에는 `application-alt.yaml`이 열려 있다. 실행 예제가 `SPRING_PROFILES_ACTIVE=alternate`이므로 파일 이름은 `application-alternate.yaml`이 맞다 |
| 5 | 책 p. 194 | 항목 설명에서 메서드 이름을 `Convert()`로 대문자 표기한다. 실제 `Converter` 인터페이스의 메서드는 `convert()`다 |

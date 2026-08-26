# 01-core 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 의존성 (dependency)
어떤 객체 A가 자기 비즈니스 로직을 수행하기 위해 반드시 협력해야 하는 다른 객체 B를 A의 의존성이라 한다.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[의존성-주입]], [[빈]]

## 빈 (bean)
개발자가 직접 `new` 연산자로 생성하지 않고, 스프링 컨테이너가 생성·조립·생명주기를 대신 관리하는 자바 객체.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[컴포넌트-스캔]], [[컨테이너]]

## 컨테이너 (container)
애플리케이션에 필요한 빈들을 생성하고, 의존관계를 연결하며, 초기화부터 소멸까지의 생명주기를 관장하는 프레임워크 엔진. 스프링에서는 `ApplicationContext`가 이 역할을 한다.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[빈]], [[제어의-역전]]

## 제어의-역전 (inversion of control)
객체의 생성과 의존 객체 결합의 제어 권한이 호출자(개발자 코드)에서 외부 프레임워크(컨테이너)로 뒤집히는 설계 원칙.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[의존성-주입]]

## 의존성-주입 (dependency injection)
객체가 필요한 의존 객체를 직접 만들지 않고, 외부 컨테이너가 생성자나 메서드를 통해 전달(주입)해주는 IoC의 구체적 구현 기법.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[제어의-역전]]

## 생명주기 (lifecycle)
객체가 메모리에 생성되어 의존성이 주입되고, 초기화 메서드를 거쳐 비즈니스 요청을 처리하다가, 컨테이너 종료 시 소멸하기까지 거치는 일련의 단계.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[컨테이너]]

## 컴포넌트-스캔 (component scan)
`@Component`, `@Service`, `@Repository` 등의 어노테이션이 부여된 자바 클래스들을 스프링 부트가 클래스패스에서 자동으로 탐색하여 빈으로 등록하는 메커니즘.
- 처음 나온 곳: [[01-spring-boot-architecture-and-context]]
- 섞이는 말: [[빈]]

## 자동-구성 (auto-configuration)
개발자가 수동으로 빈을 등록하지 않아도, 클래스패스에 존재하는 라이브러리와 설정 프로퍼티를 감지하여 가장 적절한 기본 빈들을 컨테이너에 자동 등록해주는 스프링 부트의 핵심 엔진.
- 처음 나온 곳: [[02-autoconfiguration-and-conditionals]]
- 섞이는 말: [[조건부-등록]], [[컴포넌트-스캔]]

## 조건부-등록 (conditional registration)
`@ConditionalOnClass`, `@ConditionalOnMissingBean` 등 특정 조건(라이브러리 존재 여부, 기존 빈 유무, 프로퍼티 값 등)이 참(true)으로 만족될 때만 선택적으로 빈을 생성하는 메커니즘.
- 처음 나온 곳: [[02-autoconfiguration-and-conditionals]]
- 섞이는 말: [[자동-구성]], [[백오프]]

## 백오프 (backing off)
개발자가 동일한 역할의 빈을 직접 정의하여 등록한 경우, 프레임워크의 기본 자동 구성 빈 생성을 스스로 철회하고 물러서는 스프링 부트의 양보 정책.
- 처음 나온 곳: [[02-autoconfiguration-and-conditionals]]
- 섞이는 말: [[조건부-등록]]

## 클래스패스 (classpath)
JVM과 스프링 부트 애플리케이션이 실행될 때 자바 클래스 파일(.class)과 라이브러리(.jar)를 탐색하고 로드하는 파일 경로 목록.
- 처음 나온 곳: [[02-autoconfiguration-and-conditionals]]
- 섞이는 말: [[자동-구성]]

## 스타터 (starter)
특정 기술(웹, JPA, 보안 등)을 사용하는 데 필요한 모든 관련 라이브러리 의존성을 하나로 묶어놓은 스프링 부트의 배포 패키지 디펜던시 묶음.
- 처음 나온 곳: [[03-starters-and-dependency-management]]
- 섞이는 말: [[의존성-관리]], [[빌-오브-머티리얼]]

## 의존성-관리 (dependency management)
수십 개의 서로 다른 오픈소스 라이브러리 간 호환 버전 조합을 개발자가 일일이 지정하지 않고 중앙에서 일관되게 제어하는 빌드 도구 체계.
- 처음 나온 곳: [[03-starters-and-dependency-management]]
- 섞이는 말: [[빌-오브-머티리얼]], [[전이-의존성]]

## 빌-오브-머티리얼 (bill of materials)
스프링 부트가 호환성을 검증한 수백 개 라이브러리의 표준 버전 목록을 정의해 둔 부모 POM/플러그인 명세서 (`spring-boot-dependencies`).
- 처음 나온 곳: [[03-starters-and-dependency-management]]
- 섞이는 말: [[의존성-관리]]

## 전이-의존성 (transitive dependency)
내 프로젝트가 직접 선언한 라이브러리 A가 내부적으로 필요로 하여 자동으로 함께 다운로드되고 연결되는 라이브러리 B.
- 처음 나온 곳: [[03-starters-and-dependency-management]]
- 섞이는 말: [[스타터]]

## 설정-프로퍼티 (configuration properties)
애플리케이션 설정값을 자바 코드와 분리하여 파일이나 환경 변수로 관리하고, 이를 타입 세이프한 자바 객체(POJO/Record)에 자동 바인딩하는 스프링 부트의 설정 주입 체계 (`@ConfigurationProperties`).
- 처음 나온 곳: [[04-configuration-properties-and-profiles]]
- 섞이는 말: [[외부화-설정]], [[프로필]]

## 외부화-설정 (externalized configuration)
데이터베이스 주소, API 키, 포트 번호 등 환경마다 달라지는 설정값을 소스 코드 외부(`application.yml`, OS 환경변수, CLI 인자)에 두어 재컴파일 없이 환경을 전환할 수 있게 하는 메커니즘.
- 처음 나온 곳: [[04-configuration-properties-and-profiles]]
- 섞이는 말: [[설정-프로퍼티]], [[오버라이드-우선순위]]

## 프로필 (profile)
`local`, `dev`, `test`, `prod`처럼 실행 환경에 따라 서로 다른 설정 파일(`application-{profile}.yml`)과 빈들을 논리적으로 그룹화하여 활성화하는 환경 격리 체계.
- 처음 나온 곳: [[04-configuration-properties-and-profiles]]
- 섞이는 말: [[외부화-설정]]

## 오버라이드-우선순위 (override precedence)
여러 출처(기본값, 내부 프로퍼티, 외부 프로퍼티, 환경 변수, CLI 인자)에서 동일한 설정 키가 제공되었을 때 어떤 값을 최종 적용할지 결정하는 스프링 부트의 계층적 규칙 순서.
- 처음 나온 곳: [[04-configuration-properties-and-profiles]]
- 섞이는 말: [[외부화-설정]]

## 프로그래밍-빈-등록 (programmatic bean registration)
어노테이션 기반 리플렉션 탐색 대신, 람다와 `BeanRegistrar` 인터페이스를 사용하여 함수형 코드로 직접 빈을 등록하는 고성능·AOT 친화적 빈 등록 방식.
- 처음 나온 곳: [[05-bean-registration-and-null-safety]]
- 섞이는 말: [[컴포넌트-스캔]], [[사전-컴파일]]

## 널-안전성 (null safety)
자바 코드에서 런타임 `NullPointerException`이 발생하는 것을 방지하기 위해, 파라미터나 반환값의 null 허용 여부를 명시하고 컴파일 타임에 강제하는 언어/프레임워크 수준의 안전 보장 체계.
- 처음 나온 곳: [[05-bean-registration-and-null-safety]]
- 섞이는 말: [[제이스펙]]

## 제이스펙 (jspecify)
자바 표준 진영이 합의한 차세대 표준 널 어노테이션 규격(`org.jspecify.annotations`)으로, Spring Boot 4에서 프레임워크 전반의 널 검증 표준으로 전면 채택됨.
- 처음 나온 곳: [[05-bean-registration-and-null-safety]]
- 섞이는 말: [[널-안전성]]

## 사전-컴파일 (ahead-of-time compilation)
애플리케이션을 실행하기 전에 런타임 리플렉션 및 동적 바이트코드 생성을 미리 분석하여 머신 코드 또는 최적화된 초기화 코드로 변환해 두는 컴파일 기법 (GraalVM / Spring AOT).
- 처음 나온 곳: [[05-bean-registration-and-null-safety]]
- 섞이는 말: [[프로그래밍-빈-등록]]

## 마이그레이션 (migration)
구버전 프레임워크(Spring Boot 3.x)에서 신버전(Spring Boot 4)으로 프로젝트의 의존성, 설정, API 변경사항을 점진적으로 전환하는 프로세스.
- 처음 나온 곳: [[06-spring-boot-4-migration-and-breaking-changes]]
- 섞이는 말: [[클래식-스타터]]

## 클래식-스타터 (classic starter)
Spring Boot 4로 마이그레이션 시 구형 자동 구성 및 프로퍼티 동작 방식을 임시로 유지하여 점진적 전환을 돕는 과도기 지원 스타터 패키지 (`spring-boot-starter-classic`).
- 처음 나온 곳: [[06-spring-boot-4-migration-and-breaking-changes]]
- 섞이는 말: [[스타터]], [[마이그레이션]]

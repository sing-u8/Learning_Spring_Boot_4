# Chapter 6 용어집

> *Learning Spring Boot 4*, Ch. 6 *Configuring an Application with Spring Boot* (책 pp. 189–205 / PDF pp. 214–230)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 외부화된-설정 (externalized configuration)

애플리케이션이 연결할 대상(데이터베이스·메시지 브로커·인증 시스템·외부 서비스)의 좌표와 자격 증명을 **코드 밖**에 두는 방식. 같은 바이너리를 환경마다 다르게 동작시키기 위한 전제 조건이다.

## 설정-프로퍼티 (configuration property)

`key=value` 한 쌍으로 표현되는 설정 항목. Spring Boot는 프로퍼티 파일, 환경 변수, 명령줄 인자 등 여러 출처에서 이것을 모아 하나의 환경으로 합친다.

## ConfigurationProperties (@ConfigurationProperties)

특정 접두사로 시작하는 프로퍼티들을 자바 타입에 통째로 묶어 주는 애노테이션. 개별 값을 `@Value`로 하나씩 꺼내는 대신 **관련된 설정 한 벌**을 한 객체로 다룬다.

## 프로퍼티-접두사 (property prefix)

`@ConfigurationProperties("app.config")`의 `app.config`처럼, 그 타입이 담당할 프로퍼티들의 공통 앞부분. 필드 이름이 그 뒤에 이어 붙어 전체 키가 된다.

## 타입-안전-바인딩 (type-safe binding)

프로퍼티 값을 문자열이 아니라 선언된 자바 타입(`int`, `List<UserAccount>` 등)으로 변환해 넣는 것. 타입이 맞지 않으면 **기동 시점에** 실패하므로, 값을 쓰는 순간까지 오류가 미뤄지지 않는다.

## record (record)

필드·정규 생성자·접근자·`equals`/`hashCode`/`toString`을 자동으로 만들어 주는 자바의 불변 데이터 타입. 설정 묶음처럼 "만들어지고 나면 바뀌지 않는" 값에 잘 맞는다.

## 생성자-바인딩 (constructor binding)

setter를 호출하는 대신 **생성자 인자로** 프로퍼티를 주입하는 바인딩 방식. 객체가 불완전한 중간 상태를 갖지 않으며, 필드를 `final`로 둘 수 있다.

## ConstructorBinding (@ConstructorBinding)

생성자가 여러 개일 때 어느 것으로 바인딩할지 지정하는 애노테이션. 생성자가 하나뿐이면(record가 그렇다) 붙이지 않아도 자동으로 생성자 바인딩이 쓰인다.

## EnableConfigurationProperties (@EnableConfigurationProperties)

지정한 `@ConfigurationProperties` 타입을 빈으로 등록해 주입 가능하게 만드는 애노테이션. 어느 Spring 빈에 붙여도 애플리케이션 전체에 적용된다.

## ConfigurationPropertiesScan (@ConfigurationPropertiesScan)

`@ConfigurationProperties`가 붙은 타입을 패키지에서 훑어 자동 등록하는 애노테이션. 타입 하나하나를 손으로 나열하는 `@EnableConfigurationProperties`의 대안이다.

## 컴포넌트-스캔 (component scanning)

지정한 패키지 아래를 훑어 `@Component`·`@Configuration` 같은 표시가 붙은 클래스를 찾아 빈으로 등록하는 Spring의 동작.

## 인덱스-표기법 (index notation)

`app.config.users[0].username`처럼 대괄호와 숫자로 리스트의 몇 번째 항목인지 지정하는 프로퍼티 표기. `.properties`는 계층 구조가 없어서 리스트를 이렇게 편다.

## 컨버터 (Converter)

한 타입의 값을 다른 타입으로 바꾸는 Spring의 함수형 인터페이스. `Converter<S, T>`의 `convert(S)` 하나만 구현하면 된다.

## ConfigurationPropertiesBinding (@ConfigurationPropertiesBinding)

이 컨버터를 **설정 프로퍼티를 바인딩할 때** 쓰라고 표시하는 애노테이션. 바인딩은 애플리케이션 생명주기의 아주 이른 시점에 일어나므로, 표시된 컨버터는 다른 빈에 의존하지 않는 자기 완결적인 것이어야 한다.

## 타입-소거 (type erasure)

자바가 컴파일 후 제네릭 타입 인자를 지워 버리는 성질. `Converter<String, GrantedAuthority>`가 런타임에는 그냥 `Converter`가 되어, 어떤 타입을 어떤 타입으로 바꾸는 컨버터인지 알 수 없게 된다.

## 메서드-참조 (method reference)

`SimpleGrantedAuthority::new`처럼 기존 메서드나 생성자를 람다 대신 가리키는 자바 문법. 코드는 짧아지지만 **선언된 제네릭 타입이 남지 않는다.**

## 제네릭-타입-해석 (generic type resolution)

Spring이 빈의 실제 제네릭 타입 인자를 알아내는 과정. 클래스나 인터페이스에 **선언으로** 박혀 있는 타입 인자는 읽을 수 있지만, 람다가 만든 객체에는 그 정보가 없다.

## 프로파일 (profile)

"이 설정 묶음은 이 상황에서만 쓴다"고 이름 붙이는 Spring의 장치. 활성화된 프로파일에 따라 추가로 읽히는 설정 파일과 등록되는 빈이 달라진다.

## 프로파일별-프로퍼티-파일 (profile-specific property file)

`application-test.properties`처럼 파일 이름에 `-{프로파일}`을 붙인 설정 파일. 해당 프로파일이 활성화될 때만 읽힌다.

## 가산적 (additive)

프로파일 설정이 기본 설정을 **대체하지 않고 그 위에 얹히는** 성질. 프로파일 파일에 없는 키는 기본 파일의 값이 그대로 살아남는다.

## 리스트-교체 (list replacement)

리스트·컬렉션 프로퍼티는 여러 출처에서 정의돼도 **병합되지 않고**, 우선순위가 가장 높은 출처의 것으로 통째로 갈아치워지는 규칙.

## spring.config.additional-location (spring.config.additional-location)

Spring Boot의 기본 설정 탐색 위치에 **추가로** 볼 경로를 지정하는 프로퍼티. 기본 위치를 통째로 갈아치우는 `spring.config.location`과 다르다.

## spring.config.import (spring.config.import)

설정 파일 안에서 다른 설정 파일이나 외부 소스를 끌어오도록 선언하는 프로퍼티. 가져온 쪽의 값이 가져오게 한 파일의 값보다 우선한다.

## YAML (YAML)

들여쓰기로 계층을 표현하는 데이터 표기 형식. 같은 접두사를 반복하지 않아도 되어 중첩이 깊은 설정에서 `.properties`보다 짧아진다.

## 들여쓰기-유의 (significant whitespace)

들여쓰기 자체가 문법이 되어, 공백 하나가 구조를 바꾸는 성질. YAML이 짧아지는 대가이며 긴 파일에서 오류를 찾기 어렵게 만든다.

## 설정-메타데이터 (configuration metadata)

애플리케이션이 가진 설정 키의 이름·타입·설명을 담은 JSON 문서(`META-INF/spring-configuration-metadata.json`). IDE는 이 파일을 읽어 코드 완성 목록을 만든다.

## spring-boot-configuration-processor (spring-boot-configuration-processor)

`@ConfigurationProperties` 타입을 컴파일 시점에 훑어 설정 메타데이터를 생성해 주는 애노테이션 프로세서. 빌드에만 필요하므로 선택적 의존성으로 넣는다.

## 코드-완성 (code completion)

편집기가 입력 중인 키에 맞는 후보를 띄워 주는 기능. 설정 파일에서는 메타데이터가 있어야 동작한다.

## 환경-변수 (environment variable)

셸이나 운영체제가 프로세스에 넘겨주는 이름-값 쌍. 애플리케이션 아티팩트를 건드리지 않고 실행 시점에 설정을 주입하는 대표적인 수단이다.

## 완화된-바인딩 (relaxed binding)

`spring.profiles.active`, `SPRING_PROFILES_ACTIVE`, `spring-profiles-active`처럼 표기가 달라도 같은 설정 키로 묶어 주는 Spring Boot의 규칙. 점을 쓸 수 없는 환경 변수 이름을 그대로 받아들일 수 있는 이유다.

## 시스템-프로퍼티 (system property)

`java -Dkey=value`로 JVM에 넘기는 값. `System.getProperties()`로 읽으며, 우선순위에서 환경 변수보다 **높다.**

## Maven-래퍼 (Maven wrapper)

프로젝트에 함께 커밋된 `mvnw` 스크립트. Maven을 설치하지 않은 환경에서도 정해진 버전으로 빌드를 돌릴 수 있게 해 준다.

## 프로퍼티-소스 (PropertySource)

이름과 값들의 묶음 하나를 나타내는 Spring의 추상. 프로퍼티 파일, 환경 변수, 명령줄 인자가 각각 하나의 프로퍼티 소스가 되고, 이들이 순서대로 쌓여 하나의 환경을 이룬다.

## 우선순위 (precedence)

같은 키가 여러 프로퍼티 소스에 있을 때 어느 값이 이기는지 정하는 순서. Spring Boot에서는 **나중에 고려되는 소스가 앞의 값을 덮는다.**

## Config-Data (config data)

`application.properties`·`application.yaml`과 그 프로파일 변형처럼 Spring Boot가 파일에서 읽어 들이는 설정. 우선순위 목록에서는 하나의 항목으로 묶여 비교적 **낮은** 자리에 있다.

## RandomValuePropertySource (RandomValuePropertySource)

`random.int`, `random.uuid` 같은 키를 읽을 때마다 새 난수를 만들어 주는 내장 프로퍼티 소스.

## SPRING_APPLICATION_JSON (SPRING_APPLICATION_JSON)

환경 변수나 시스템 프로퍼티 하나에 JSON 문자열을 통째로 넣어 여러 설정을 한 번에 주입하는 방법.

## 명령줄-인자 (command-line argument)

`java -jar app.jar --server.port=9000`처럼 `--`로 시작해 넘기는 값. 일반 프로퍼티 소스 중에서는 가장 높은 우선순위를 갖는다.

## DevTools (Spring Boot DevTools)

개발 편의 기능(자동 재시작, 캐시 비활성화 등)을 모아 둔 모듈. 활성 상태일 때 `$HOME/.config/spring-boot`의 전역 설정을 읽으며, 그 값이 우선순위 목록에서 가장 높다.

## 불변-아티팩트 (immutable artifact)

한 번 빌드한 뒤로는 내용을 고치지 않는 배포물. 같은 JAR이 개발·테스트·운영에서 그대로 돌고, 달라지는 것은 밖에서 주입하는 설정뿐이라는 원칙이다.

## Twelve-Factor-App (Twelve-Factor App)

2011년 Heroku가 정리한, 클라우드에서 잘 돌아가는 애플리케이션의 12가지 원칙. **세 번째 factor가 config**이며, 환경마다 달라지는 값을 코드 밖으로 빼라고 말한다.

# Configuring An Application with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## custom-properties
application.properties에 개발자가 독자적인 네임스페이스(접두어)를 설정하여 애플리케이션에 주입하는 설정값
- 처음 나온 곳: [[01-creating-custom-properties]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## configuration-properties-binding
외부 속성 파일의 텍스트(String) 값을 스프링 내부의 구체적인 자바 타입으로 바인딩할 때 사용하는 컨버터를 지칭하는 애노테이션
- 처음 나온 곳: [[01-creating-custom-properties]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-profile
특정 환경에 맞는 빈 설정이나 프로퍼티 설정을 그룹화하여 활성화/비활성화할 수 있도록 돕는 기능
- 처음 나온 곳: [[02-creating-profile-based-property-files]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## twelve-factor-app
클라우드 네이티브 애플리케이션을 구축하기 위한 12가지 방법론으로, 그중 설정(Config)은 코드에서 분리되어야 한다고 강조한다
- 처음 나온 곳: [[02-creating-profile-based-property-files]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## yaml
'YAML Ain't Markup Language'의 약자로 사람이 읽기 쉽게 만들어진 데이터 직렬화 언어
- 처음 나온 곳: [[03-switching-to-yaml]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-boot-configuration-processor
사용자가 정의한 커스텀 프로퍼티의 메타데이터를 추출해 IDE에서 자동완성이나 유효성 검증을 돕는 애노테이션 프로세서 의존성
- 처음 나온 곳: [[03-switching-to-yaml]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## relaxed-binding
SPRING_PROFILES_ACTIVE와 같은 대문자 및 언더스코어 환경변수명을 spring.profiles.active 같은 자바 프로퍼티 명으로 유연하게 매핑해주는 스프링 부트의 기능
- 처음 나온 곳: [[04-setting-properties-with-environment-variables]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## property-override
늦게 로드되거나 우선순위가 높은 구성 소스(Configuration Source)가 기존에 세팅된 값을 교체(덮어쓰기)하는 동작
- 처음 나온 곳: [[05-ordering-property-overrides]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

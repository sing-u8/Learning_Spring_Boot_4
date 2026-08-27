# Core Features Of Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## jdk
Java 소스 컴파일러, 런타임, 진단 도구를 포함한 개발 키트
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: JRE

## lts
일반 릴리스보다 오랫동안 보안 수정과 유지보수를 제공하는 장기 지원 릴리스
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 최신 기능 릴리스

## sdkman
셸에서 여러 Java와 SDK 버전을 설치하고 전환하는 도구
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 운영체제 패키지 관리자

## ide
코드 편집, 빌드, 실행, 디버깅을 통합한 개발 환경
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: 텍스트 편집기

## github
Git 저장소 호스팅과 협업 기능을 제공하는 서비스
- 처음 나온 곳: [[00-technical-requirements]]
- 섞이는 말: Git

## autoconfiguration
상황과 포함된 라이브러리에 맞게 스프링 빈을 자동 등록하는 기능
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## application-context
생성된 객체(빈)들을 담아두고 생명주기를 관리하는 컨테이너
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-bean
애플리케이션 컨텍스트에 의해 관리되는 객체
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## dependency-injection
객체가 스스로 의존성을 만들지 않고 외부에서 주입받는 패턴
- 처음 나온 곳: [[01-autoconfiguring-spring-beans]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-boot-starter
특정 기능(웹, DB 등)을 구현할 때 필요한 라이브러리들을 하나로 묶어둔 패키지
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## jakarta-ee
엔터프라이즈 자바의 현대 표준 스펙 (Java EE의 후속작)
- 처음 나온 곳: [[02-adding-portfolio-components-using-spring-boot-starters]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## configuration-properties
외부 속성값을 읽어서 객체의 필드에 바인딩(주입)하는 기능
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## profile
개발/테스트/운영 등 환경에 따라 다른 설정을 묶어놓은 그룹 명칭
- 처음 나온 곳: [[03-customizing-the-setup-with-configuration-properties]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## bill-of-materials
(BOM) 호환성이 검증된 수많은 라이브러리들의 정확한 버전 목록을 담은 명세서
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## cve
(Common Vulnerabilities and Exposures) 공개적으로 알려진 소프트웨어의 보안 취약점
- 처음 나온 곳: [[04-managing-application-dependencies]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

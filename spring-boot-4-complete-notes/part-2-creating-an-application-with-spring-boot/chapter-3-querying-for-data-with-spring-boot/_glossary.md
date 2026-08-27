# Querying For Data with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## spring-data
다양한 데이터 저장소 접근을 단순화하고, 각 DB의 특성을 극대화할 수 있도록 지원하는 스프링 모듈
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-spring-boot-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## spring-data-jpa
자바의 관계형 데이터베이스 표준(JPA)을 기반으로 리포지토리 추상화 등을 제공하는 Spring Data 모듈
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-spring-boot-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## h2-database
자바로 작성되어 설정 없이 바로 쓸 수 있고, 앱 종료 시 데이터가 휘발되어 프로토타이핑에 적합한 내장형 관계형 DB
- 처음 나온 곳: [[01-adding-spring-data-to-an-existing-spring-boot-application]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## entity
JPA 등 영속성 계층에서 관리되며, 데이터베이스와 직접 연결되어 데이터를 저장하고 조회하는 목적의 클래스
- 처음 나온 곳: [[02-dtos-entities-and-pojos-oh-my]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## dto
Data Transfer Object, 계층 간(특히 서버-클라이언트 간)에 필요한 데이터만 모아서 전송하기 위한 불변 데이터 객체
- 처음 나온 곳: [[02-dtos-entities-and-pojos-oh-my]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## pojo
Plain Old Java Object, 복잡한 프레임워크 코드를 상속받지 않아 가볍고 테스트하기 쉬운 평범한 자바 객체
- 처음 나온 곳: [[02-dtos-entities-and-pojos-oh-my]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## single-responsibility-principle
단일 책임 원칙(SRP), 하나의 클래스는 단 하나의 책임을 져야 하며 클래스가 변경될 이유도 오직 하나뿐이어야 한다는 객체지향 원칙
- 처음 나온 곳: [[02-dtos-entities-and-pojos-oh-my]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## repository-pattern
애플리케이션 계층이 데이터 저장소 기술에 종속되지 않도록, 도메인 객체의 저장/조회를 전담하는 객체를 두는 패턴
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries-with-spring-data]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## jpa-repository
스프링 데이터 JPA가 제공하며, 페이징과 정렬을 포함한 핵심 CRUD 메서드들을 미리 정의해 둔 인터페이스
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries-with-spring-data]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## query-derivation
Spring Data가 리포지토리 인터페이스를 분석하여 실행 시점에 데이터베이스 쿼리를 자동으로 파생(생성)해 내는 기술
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries-with-spring-data]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## crud-operations
소프트웨어가 가지는 기본적인 데이터 처리 기능인 Create(생성), Read(조회), Update(수정), Delete(삭제)
- 처음 나온 곳: [[03-creating-repositories-and-declarative-queries-with-spring-data]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## custom-finders
규칙에 맞춰 명명된 메서드 시그니처만으로 Spring Data가 자동 생성해주는 커스텀 조회 쿼리
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## sql-injection
외부 입력값을 검증 없이 쿼리에 붙여 넣을 때 발생하는 보안 취약점으로, 악의적인 SQL이 실행되게 만드는 공격 기법
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## jpql
자바 영속성 쿼리 언어(Jakarta Persistence Query Language)로, 데이터베이스 테이블이 아닌 '엔티티 객체'를 대상으로 작성하는 쿼리 언어
- 처음 나온 곳: [[04-using-custom-finders]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## query-by-example
QBE, 찾고자 하는 데이터의 조건을 '엔티티 샘플 객체' 형태로 만들어 전달하여 동적으로 데이터를 조회하는 방식
- 처음 나온 곳: [[05-using-query-by-example-to-find-tricky-answers]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## probe
검색 조건을 담고 있는 도메인 엔티티의 실제 인스턴스 (비어있는 필드는 무시됨)
- 처음 나온 곳: [[05-using-query-by-example-to-find-tricky-answers]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## example-matcher
Probe에 담긴 값들을 정확히 일치시킬지(Exact), 부분 일치시킬지(Containing), 대소문자를 무시할지 등 검색 규칙을 정의하는 객체
- 처음 나온 곳: [[05-using-query-by-example-to-find-tricky-answers]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## query-annotation
개발자가 스프링 데이터의 자동 생성 기능을 무시하고 직접 쿼리를 주입할 수 있게 해주는 애노테이션
- 처음 나온 곳: [[06-using-the-custom-java-persistence-api-jpa]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## parameter-binding
SQL 인젝션을 막기 위해 외부에서 들어온 값을 쿼리의 특정 위치(?1)나 이름(:name)에 안전하게 매핑하는 기술
- 처음 나온 곳: [[06-using-the-custom-java-persistence-api-jpa]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## pagination-and-sorting
대량의 데이터를 페이지 단위로 끊어서 가져오고 정렬 순서를 지정하는 기능으로, 커스텀 쿼리에서도 Spring Data가 이를 자동 지원함
- 처음 나온 곳: [[06-using-the-custom-java-persistence-api-jpa]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

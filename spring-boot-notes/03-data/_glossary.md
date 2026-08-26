# 03-data 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 엔티티 (entity)
데이터베이스의 특정 테이블과 매핑되어 고유 식별자(`@Id`)를 가지며 영속성 컨텍스트에서 상태 변화가 추적되는 영속 자바 객체.
- 처음 나온 곳: [[01-spring-data-jpa-repositories]]
- 섞이는 말: [[디티오]], [[포조]]

## 디티오 (dto)
계층 간(컨트롤러 ↔ 서비스, 클라이언트 ↔ 서버) 데이터 전송만을 목적으로 하는 순수 데이터 운반 객체(Java Record).
- 처음 나온 곳: [[01-spring-data-jpa-repositories]]
- 섞이는 말: [[엔티티]], [[포조]]

## 포조 (pojo)
특정 프레임워크나 어노테이션 기술에 종속되지 않고 순수한 자바 객체 지향 비즈니스 로직만을 캡슐화한 기본 자바 객체 (Plain Old Java Object).
- 처음 나온 곳: [[01-spring-data-jpa-repositories]]
- 섞이는 말: [[엔티티]], [[디티오]]

## 제이피에이-리포지토리 (jpa repository)
인터페이스 선언만으로 기본적인 CRUD, 정렬, 페이징 SQL을 스프링 데이터가 런타임에 자동 생성해 주는 데이터 접근 계층 인터페이스 (`JpaRepository`).
- 처음 나온 곳: [[01-spring-data-jpa-repositories]]
- 섞이는 말: [[하이버네이트]], [[파생-쿼리]]

## 하이버네이트 (hibernate)
자바 객체와 관계형 데이터베이스 테이블 사이의 매핑을 처리하는 JPA(Jakarta Persistence) 표준 명세의 대표적인 ORM 구현체 (Spring Boot 4에서는 Hibernate 7 탑재).
- 처음 나온 곳: [[02-hibernate-7-and-persistence-module]]
- 섞이는 말: [[제이피에이-리포지토리]]

## 파생-쿼리 (derived query)
리포지토리 인터페이스에 `findByNameContainingIgnoreCase`처럼 정해진 메서드 이름 명명 규칙에 따라 메서드를 선언하면 스프링 데이터가 해당 조건의 JPQL/SQL을 자동으로 파싱하여 생성해 주는 쿼리 메서드.
- 처음 나온 곳: [[03-derived-queries-and-pagination]]
- 섞이는 말: [[제이피에이-리포지토리]], [[쿼리-바이-이그잼플]]

## 쿼리-바이-이그잼플 (query by example)
조건 검색용 도메인 객체(Probe)에 원하는 필드값을 채워 넣고 매처(ExampleMatcher)와 함께 전달하여 동적 WHERE 조건을 안전하게 생성하는 Spring Data의 검색 기술 (QBE).
- 처음 나온 곳: [[04-query-by-example-and-custom-jpa]]
- 섞이는 말: [[파생-쿼리]]

## 알투디비씨 (r2dbc)
기존 블로킹 JDBC의 한계를 극복하고 Reactive Streams 표준에 따라 관계형 데이터베이스와 완전한 논블로킹(Non-blocking) 비동기 통신을 수행하는 리액티브 데이터베이스 드라이버 규격.
- 처음 나온 곳: [[05-r2dbc-reactive-data-access]]
- 섞이는 말: [[제이피에이-리포지토리]]

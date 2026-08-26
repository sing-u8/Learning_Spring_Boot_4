---
category: 03-data
concept: 01-spring-data-jpa-repositories
title: Spring Data JPA와 도메인 객체 계층 분리
source: "Learning Spring Boot 4 (4th Ed) · Ch.3 · 책 p.71–82 / PDF p.91–102"
terms: [엔티티, 디티오, 포조, 제이피에이-리포지토리, 하이버네이트]
related: [02-hibernate-7-and-persistence-module, 03-derived-queries-and-pagination]
status: prepared
---

# Spring Data JPA와 도메인 객체 계층 분리

## 한눈에 보기
| 객체 유형 | 주요 어노테이션 / 형식 | 역할 및 책임 |
|-----------|------------------------|--------------|
| Entity (`VideoEntity`) | `@Entity`, `@Id`, `@GeneratedValue` | 데이터베이스 테이블과 1:1 매핑되어 영속성 관리 및 식별자 보유 |
| DTO (`VideoRecord`) | Java `record VideoDto(String name)` | 웹/API 계층과 서비스 계층 간의 불변 데이터 전송 (View 종속 방지) |
| POJO (`VideoDomain`) | 순수 자바 클래스 (No Framework) | 핵심 도메인 규칙 및 계산 로직 캡슐화 |

## 1. 왜 이게 필요한가

### 이런 상황을 상상해 보자
동영상 스트리밍 플랫폼에서 동영상 메타데이터(제목, 설명, 재생 시간)를 데이터베이스에 영속적으로 저장하고 조회하는 기능을 만든다고 하자.

```java
public interface VideoRepository extends JpaRepository<VideoEntity, Long> {
}
```

개발자는 위와 같이 단 2줄짜리 인터페이스만 선언하고 구현 클래스를 전혀 작성하지 않은 채, 서비스 계층에서 `videoRepository.save(entity)`와 `videoRepository.findAll()`을 호출했다. 스프링 부트는 런타임에 완벽한 SQL `INSERT`와 `SELECT` 쿼리를 데이터베이스로 날려준다.

이처럼 인터페이스 선언만으로 영속성 계층을 자동 생성해 주는 기술을 **[[제이피에이-리포지토리]]**(= CRUD와 쿼리 실행을 스프링이 대신 구현해 주는 데이터 접근 인터페이스)라 부른다.

### 여기서 뭐가 무너지나
과거 JDBC 시절에는 `Connection`을 열고, `PreparedStatement`에 SQL 문자열을 작성하고, `ResultSet`의 커서를 한 줄씩 돌리며 `rs.getString("title")`을 자바 객체 필드에 수작업으로 매핑하는 지루한 코드를 수천 줄씩 작성해야 했다. SQL 컬럼명이 하나만 바뀌어도 자바 코드 수십 군데를 찾아 수정해야 했다.

또한, 데이터베이스 테이블과 직접 연결된 객체를 웹 컨트롤러의 JSON 응답으로 그대로 노출하거나 HTML 폼 입력으로 직접 받으면, 클라이언트가 악의적으로 관리자 권한 필드를 덮어쓰거나 순환 참조(Circular Reference)로 인한 직렬화 무한 루프 장애가 발생한다.

### 그래서 나온 생각
스프링 진영은 데이터 객체의 역할을 명확히 3가지로 분리했다. DB 테이블과 매핑되는 **[[엔티티]]**(= DB 테이블과 매핑되어 영속성 컨텍스트에서 관리되는 영속 객체), 네트워크 통신을 위한 불변 데이터 바구니인 **[[디티오]]**(= 계층 간 데이터 전송만을 목적으로 하는 순수 전송 객체), 그리고 순수 비즈니스 로직을 담는 **[[포조]]**(= 특정 기술에 종속되지 않는 기본 자바 객체)로 계층을 철저히 격리했다.

그리고 데이터베이스와의 통신은 ORM 표준 구현체인 **[[하이버네이트]]**(= 객체와 테이블 간의 매핑을 처리하는 JPA 표준 ORM 엔진)를 스프링 데이터 리포지토리 인터페이스가 감싸서 처리하도록 설계했다.

쉽게 비유하자면, 도서관의 책 보관소와 열람실의 관계와 같다. 서고 깊숙한 곳에 보관된 귀중본 원본 도서(엔티티)는 사서(리포지토리/영속성 컨텍스트)만이 엄격하게 관리하고 상태를 추적한다. 일반 방문객(웹 클라이언트)에게는 원본 도서를 통째로 넘겨주는 것이 아니라, 필요한 페이지만 깔끔하게 복사한 복사본 인쇄물(DTO)을 건네주어 원본이 훼손되는 사고를 원천 방지한다.

→ 비유가 깨지는 지점: 복사본 도서는 원본과 내용이 분리되어 갱신되지 않지만, 웹 클라이언트가 수정된 DTO를 서버로 다시 보내면 서비스 계층이 트랜잭션 안에서 엔티티의 필드를 업데이트하고 하이버네이트의 더티 체킹(Dirty Checking)이 변경 사항을 감지하여 DB에 자동으로 `UPDATE` SQL을 실행한다.

## 2. 어떻게 동작하는가
1. **인터페이스 선언 및 프록시 생성**: 애플리케이션 시작 시 Spring Data JPA는 `JpaRepository<VideoEntity, Long>` 인터페이스를 스캔하여, 런타임에 실제 DB 쿼리를 수행하는 동적 프록시 구현체 빈을 생성한다 — 개발자가 반복적인 CRUD SQL 코드를 작성하지 않기 위해서다.
2. **DTO 수신 및 검증**: 웹 컨트롤러가 클라이언트로부터 **[[디티오]]**(Java Record)를 받아 유효성을 검증한 뒤 서비스 계층으로 넘긴다 — 외부 요청 데이터가 데이터베이스 구조에 직접 침투하지 못하게 차단하기 위해서다.
3. **엔티티 변환 및 영속화 (save)**: 서비스 계층은 DTO의 데이터를 바탕으로 **[[엔티티]]** 인스턴스를 생성하고 `videoRepository.save(entity)`를 호출한다 — 객체를 영속성 컨텍스트에 등록하여 식별자(`@Id`)를 부여받기 위해서다.
4. **하이버네이트 SQL 자동 생성 및 전송**: 영속성 계층의 **[[하이버네이트]]** 7 엔진이 DB 방언(Dialect)에 맞는 최적화된 `INSERT INTO video ...` SQL을 생성하여 커넥션 풀을 통해 DB에 전송한다 — 자바 객체 필드를 관계형 테이블 컬럼으로 완벽히 매핑하기 위해서다.
5. **조회 및 DTO 변환 반환**: 데이터를 조회할 때는 리포지토리가 반환한 엔티티를 서비스 계층에서 다시 DTO로 변환하여 상위 계층으로 전달한다 — 영속 객체의 지연 로딩 예외(`LazyInitializationException`)를 방지하고 필요한 필드만 응답하기 위해서다.

## 3. 그림으로 보기

```mermaid
flowchart TD
    subgraph ClientLayer ["클라이언트 계층"]
        Client["Client (Web / Mobile)"]
    end

    subgraph WebLayer ["웹/컨트롤러 계층"]
        Ctrl["Web Controller (@RestController)"]
    end

    subgraph ServiceLayer ["비즈니스/서비스 계층 (POJO)"]
        Svc["Business Service (POJO)"]
    end

    subgraph DataLayer ["데이터 접근 계층 (Spring Data JPA)"]
        Repo["VideoRepository (Spring Data JPA Proxy)"]
        ORM["영속성 컨텍스트 & Hibernate 7 ORM"]
    end

    subgraph DBLayer ["데이터베이스"]
        DB[(Database Table: video)]
    end

    Client -->|1. JSON 전송| Ctrl
    Ctrl -->|2. DTO Record 전달| Svc
    Svc -->|3. Entity 변환 및 save()| Repo
    Repo -->|4. 영속 상태 관리| ORM
    ORM -->|5. SQL INSERT / SELECT| DB
```

## 4. 이 노트에 나온 용어
| 용어 | 한 줄 풀이 | 용어집 링크 |
|------|------------|-------------|
| 엔티티 | 데이터베이스 테이블과 1:1 매핑되어 상태가 추적되는 영속 자바 객체 | [[_glossary#엔티티]] |
| 디티오 | 계층 간 데이터 전송만을 목적으로 하는 순수 데이터 운반 레코드/객체 | [[_glossary#디티오]] |
| 포조 | 프레임워크 기술에 오염되지 않고 순수 도메인 로직을 담는 기본 자바 객체 | [[_glossary#포조]] |
| 제이피에이-리포지토리 | CRUD와 페이징 SQL을 인터페이스 선언만으로 자동 생성하는 스프링 데이터 컴포넌트 | [[_glossary#제이피에이-리포지토리]] |
| 하이버네이트 | 객체와 관계형 DB 테이블 간의 매핑과 SQL 실행을 담당하는 표준 ORM 엔진 | [[_glossary#하이버네이트]] |

## 5. 자주 헷갈리는 것
- **Entity를 DTO로 바로 쓰면 안 되는 이유**: 엔티티는 `@OneToMany`, `@ManyToOne` 등의 연관관계를 가지므로 JSON 직렬화 시 양방향 순환 참조 무한 루프가 발생하기 쉽고, 테이블 스키마 변경이 곧바로 외부 API 스펙 변경으로 이어져 클라이언트를 깨뜨린다.
- **Java Record와 DTO**: Java 17/25의 `record`는 불변(Immutable) 데이터, 자동 생성되는 `equals/hashCode/toString`, 보일러플레이트 없는 간결한 문법을 제공하여 DTO 구현에 가장 완벽한 표준이다.

## 6. 언제 안 쓰나 / 경계
- **대량의 복잡한 통계/집계 쿼리**: 수천만 건의 데이터를 조인하여 집계하는 통계 리포트 쿼리는 JPA 엔티티 로딩 대신 MyBatis, 순수 JDBC, jOOQ 또는 DB View를 직접 조회하는 것이 메모리와 성능 면에서 유리하다.

## 7. 연결
- [[02-hibernate-7-and-persistence-module]] — Spring Boot 4에서 업그레이드된 Hibernate 7과 persistence 모듈 분리 구조로 이어진다.
- [[03-derived-queries-and-pagination]] — JpaRepository 인터페이스에 다양한 조건 검색 쿼리 메서드를 정의하는 방법으로 확장된다.

## 8. 스스로 확인
1. Entity, DTO, POJO의 세 가지 객체 유형이 담당하는 서로 다른 책임을 30초로 설명할 수 있는가?
2. `JpaRepository` 인터페이스에 별도의 구현 클래스를 작성하지 않아도 CRUD 메서드가 동작하는 원리는 무엇인가?
3. 엔티티를 컨트롤러 계층 밖으로 직접 노출하지 않고 DTO로 변환하여 응답해야 하는 아키텍처적 이유는 무엇인가?

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도

## 막혔던 지점

## 리뷰 이력

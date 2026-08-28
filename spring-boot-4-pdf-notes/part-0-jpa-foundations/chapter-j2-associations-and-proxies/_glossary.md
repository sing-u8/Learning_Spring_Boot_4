# chapter-j2 용어집

> 연관관계와 프록시 층에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다. 개념 노트는 정의를 다시 쓰지 않고 이 파일을 링크한다.
>
> 영속성 컨텍스트·영속 상태·준영속 같은 앞 챕터의 용어는 `chapter-j1-persistence-context/_glossary.md`가 원본이다. 여기서 다시 정의하지 않는다.

## 연관관계-주인 (owning side)

양방향 연관에서 **외래 키를 실제로 읽고 쓰는 쪽**. 객체는 참조를 양쪽에 둘 수 있지만 테이블에는 외래 키가 하나뿐이라, 둘 중 어느 필드를 보고 그 컬럼을 채울지 정해야 한다. 그 정해진 쪽이 주인이다.

외래 키 컬럼을 가진 테이블에 대응하는 엔티티가 주인이 된다. 즉 `@ManyToOne`이 있는 쪽이며, 선택의 문제가 아니라 스키마가 이미 정해 둔 사실이다.

- 처음 나온 곳: [[01-association-owner-and-mappedby]]
- 섞이는 말: [[반대편]], [[양방향-연관]]

## 반대편 (inverse side)

주인이 아닌 쪽. `mappedBy` 속성으로 "이 연관의 외래 키는 저쪽 필드가 관리한다"고 선언한다.

**이 쪽 컬렉션에 넣고 빼는 것만으로는 외래 키가 바뀌지 않는다.** 읽기 전용 뷰에 가깝다고 생각하는 편이 안전하다. Hibernate 문서는 unowned side라고도 부른다.

- 처음 나온 곳: [[01-association-owner-and-mappedby]]
- 섞이는 말: [[연관관계-주인]]

## 단방향-연관 (unidirectional association)

한쪽에서만 상대를 참조하는 매핑. 외래 키를 가진 쪽에만 참조를 두면 주인과 반대편을 구분할 일 자체가 없다.

반대 방향 탐색이 필요하면 리포지토리 쿼리로 해결한다. 참조를 늘리는 것보다 쿼리를 하나 더 두는 편이 나을 때가 많다.

- 처음 나온 곳: [[01-association-owner-and-mappedby]]
- 섞이는 말: [[양방향-연관]]

## 양방향-연관 (bidirectional association)

양쪽이 서로를 참조하는 매핑. 객체 그래프 탐색은 편해지지만, 두 참조가 어긋날 수 있어 동기화 책임이 생긴다.

DB에는 여전히 외래 키가 하나뿐이다. 양방향은 **객체 쪽의 편의**일 뿐 테이블 구조를 바꾸지 않는다.

- 처음 나온 곳: [[01-association-owner-and-mappedby]]
- 섞이는 말: [[연관관계-주인]], [[연관관계-편의-메서드]]

## 연관관계-편의-메서드 (association helper method)

양방향 연관에서 양쪽 참조를 한 번에 맞춰 주는 메서드. 한쪽만 세팅해 두 참조가 어긋나는 사고를 구조적으로 막는다.

- 처음 나온 곳: [[01-association-owner-and-mappedby]]
- 섞이는 말: [[양방향-연관]]

## 조인-테이블 (join table)

두 테이블의 다대다 관계를 잇기 위해 양쪽 외래 키를 담는 테이블. `@ManyToMany`는 이 테이블에 **외래 키 두 개만 있다**고 가정한다.

- 처음 나온 곳: [[02-join-entity-instead-of-many-to-many]]
- 섞이는 말: [[연결-엔티티]]

## 연결-엔티티 (join entity, association entity)

조인 테이블 자체를 엔티티로 승격시킨 것. 조인 테이블에 자체 식별자나 부가 속성이 생기면 `@ManyToMany`로는 표현할 수 없어 이 형태가 강제된다.

승격하면 다대다 하나가 **다대일 두 개**로 바뀐다. 다대다라는 매핑 종류가 사라지고 익숙한 다대일만 남는 것이 이 방식의 핵심 이득이다.

- 처음 나온 곳: [[02-join-entity-instead-of-many-to-many]]
- 섞이는 말: [[조인-테이블]]

## 배타적-연관 (exclusive association)

하나의 연관이 서로 상속 관계가 아닌 둘 이상의 타입 중 **정확히 하나**를 가리키는 형태. 표준 JPA에는 이것을 직접 표현하는 매핑이 없다.

- 처음 나온 곳: [[03-exclusive-target-associations]]
- 섞이는 말: [[판별-컬럼]]

## 판별-컬럼 (discriminator column)

배타적 연관에서 지금 가리키는 대상이 어느 타입인지 적어 두는 컬럼. Hibernate의 `@Any` 매핑이 이 방식을 쓴다.

판별 컬럼을 쓰면 외래 키 컬럼은 하나로 줄지만, 그 하나가 여러 테이블을 가리킬 수 있게 되므로 **물리적 외래 키 제약을 걸 수 없다.**

- 처음 나온 곳: [[03-exclusive-target-associations]]
- 섞이는 말: [[배타적-연관]]

## 프록시 (proxy)

실제 엔티티 대신 놓이는 대역 객체. 식별자만 들고 있다가 다른 필드에 접근하는 순간 DB에서 상태를 읽어 온다.

Hibernate 문서의 표현으로는 *"엔티티의 자리를 대신 지키는 placeholder로, 메서드가 호출될 때에만 DB에서 상태를 가져온다."* 엔티티 클래스를 상속한 하위 클래스로 만들어지므로 `getClass()`가 원래 클래스와 다르다.

- 처음 나온 곳: [[04-proxies-and-lazy-loading]]
- 섞이는 말: [[지연-로딩]], [[엔티티-참조]]

## 지연-로딩 (lazy loading)

연관 대상을 즉시 읽지 않고 실제로 쓰는 순간 읽는 방식. 그 자리를 프록시가 대신 지킨다.

`@ManyToOne`과 `@OneToOne`의 기본값은 즉시 로딩이므로 **명시적으로 `fetch = FetchType.LAZY`를 적어야** 한다. `@OneToMany`와 `@ManyToMany`는 기본이 지연이다.

- 처음 나온 곳: [[04-proxies-and-lazy-loading]]
- 섞이는 말: [[즉시-로딩]], [[프록시]]

## 즉시-로딩 (eager loading)

연관 대상을 원본 엔티티와 함께 바로 읽는 방식. 필요 없는 데이터까지 읽고, 목록 조회에서 연관마다 추가 쿼리를 유발하기 쉽다.

- 처음 나온 곳: [[04-proxies-and-lazy-loading]]
- 섞이는 말: [[지연-로딩]]

## 지연-로딩-예외 (LazyInitializationException)

프록시를 초기화하려는데 영속성 컨텍스트가 없을 때 나는 예외. 트랜잭션이 끝난 뒤 연관을 탐색하면 발생한다.

- 처음 나온 곳: [[04-proxies-and-lazy-loading]]
- 섞이는 말: [[프록시]], [[지연-로딩]]

## 엔티티-참조 (entity reference)

`EntityManager.getReference()`가 반환하는, 상태를 읽지 않은 프록시. 식별자만 알면 되는 상황 — 예를 들어 다른 엔티티의 외래 키를 채울 때 — 에 SELECT 없이 연관을 연결할 수 있다.

- 처음 나온 곳: [[04-proxies-and-lazy-loading]]
- 섞이는 말: [[프록시]]

## 영속성-전이 (cascade)

어떤 엔티티에 수행한 연산을 연관된 엔티티에도 함께 전파하는 설정. `cascade = {PERSIST, REMOVE, ...}` 형태로 지정한다.

전이는 **영속성 컨텍스트를 통과하는 연산에만** 적용된다. JPQL 벌크 삭제나 네이티브 SQL은 컨텍스트를 거치지 않으므로 전이가 일어나지 않는다.

- 처음 나온 곳: [[05-cascade-orphan-removal-vs-db-cascade]]
- 섞이는 말: [[고아-객체-제거]], [[DB-연쇄-삭제]]

## 고아-객체-제거 (orphan removal)

부모의 컬렉션에서 빠진 자식을 자동으로 삭제하는 설정. `orphanRemoval = true`로 켠다.

`CascadeType.REMOVE`와 다르다. 후자는 **부모가 삭제될 때** 자식도 삭제하고, 전자는 **부모는 살아 있는데 관계가 끊겼을 때** 자식을 삭제한다.

- 처음 나온 곳: [[05-cascade-orphan-removal-vs-db-cascade]]
- 섞이는 말: [[영속성-전이]]

## DB-연쇄-삭제 (ON DELETE CASCADE)

외래 키에 걸어 두는 DDL 수준의 연쇄 삭제. 부모 행이 지워지면 DB가 자식 행을 함께 지운다.

애플리케이션을 거치지 않으므로 영속성 컨텍스트는 이 삭제를 모른다. Hibernate에서는 `@OnDelete(action = OnDeleteAction.CASCADE)`로 이 사실을 매핑에 표시할 수 있다.

- 처음 나온 곳: [[05-cascade-orphan-removal-vs-db-cascade]]
- 섞이는 말: [[영속성-전이]]

# chapter-j3 용어집

> 성능과 트랜잭션 층에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.
>
> 영속성 컨텍스트·프록시·지연 로딩 같은 앞 챕터의 용어는 `chapter-j1-persistence-context`와 `chapter-j2-associations-and-proxies`의 용어집이 원본이다. 여기서 다시 정의하지 않는다.

## N-플러스-1-문제 (N+1 selects problem)

목록 하나를 읽는 쿼리 1번 뒤에, 그 목록의 각 항목마다 연관을 읽는 쿼리가 N번 더 나가는 현상.

이름의 `1`은 목록 쿼리, `N`은 항목 수다. 항목이 200개면 쿼리가 201번이다. 지연 로딩이 원인처럼 보이지만 즉시 로딩에서도 똑같이 일어난다 — **로딩 전략이 아니라 "연관을 항목마다 따로 읽는다"는 구조가 원인이다.**

- 처음 나온 곳: [[01-n-plus-one-when-it-happens]]
- 섞이는 말: [[쿼리-카운트-검증]]

## 쿼리-카운트-검증 (query count assertion)

테스트에서 실제로 나간 SQL 문의 개수를 세어 기대값과 비교하는 검증.

N+1은 기능 테스트를 통과한다 — 결과가 맞기 때문이다. 느려질 뿐이라 로컬의 적은 데이터에서는 드러나지 않는다. 쿼리 수를 직접 세는 검증만이 이 회귀를 잡는다.

- 처음 나온 곳: [[01-n-plus-one-when-it-happens]]
- 섞이는 말: [[N-플러스-1-문제]]

## 페치-조인 (fetch join)

JPQL에서 `join fetch`로 연관을 **같은 SQL 한 번에** 함께 읽어 오는 것. 지연 로딩 설정을 그 쿼리에 한해 무시한다.

일반 `join`과 다르다. 일반 조인은 조건에만 쓰이고 결과에 연관 객체를 채우지 않지만, `join fetch`는 연관을 실제로 로딩한다.

- 처음 나온 곳: [[02-fetch-join-entitygraph-batch-size]]
- 섞이는 말: [[엔티티-그래프]], [[메모리-페이징]]

## 엔티티-그래프 (entity graph)

어떤 연관을 함께 읽을지 쿼리 밖에서 선언하는 방식. `@EntityGraph`나 `createEntityGraph()`로 지정하며, Hibernate는 이를 left outer join으로 번역한다.

페치 조인과 효과가 겹치지만, 쿼리 문자열을 건드리지 않고 **같은 쿼리를 호출 지점마다 다른 그래프로 재사용**할 수 있다는 점이 다르다.

- 처음 나온 곳: [[02-fetch-join-entitygraph-batch-size]]
- 섞이는 말: [[페치-조인]]

## 배치-페칭 (batch fetching)

지연 로딩을 유지하되, 초기화가 필요해진 프록시를 **모아서 `IN` 절 하나로** 읽는 방식. `@BatchSize`나 `default_batch_fetch_size` 설정으로 켠다.

쿼리를 1번으로 줄이지는 못한다. N번을 `ceil(N / 배치크기)`번으로 줄인다. **없애는 것이 아니라 나누는 것**이다.

- 처음 나온 곳: [[02-fetch-join-entitygraph-batch-size]]
- 섞이는 말: [[페치-조인]]

## 메모리-페이징 (in-memory pagination)

페이징과 컬렉션 페치 조인을 함께 쓸 때 Hibernate가 취하는 동작. SQL에서 `limit`을 빼고 전부 읽어 온 뒤, 중복을 제거하고 나서 애플리케이션 메모리에서 잘라 낸다.

경고 `HHH90003004`가 로그에 찍힌다. `fail_on_pagination_over_collection_fetch`를 켜면 경고 대신 예외가 난다.

- 처음 나온 곳: [[02-fetch-join-entitygraph-batch-size]]
- 섞이는 말: [[페치-조인]]

## 트랜잭션-전파 (transaction propagation)

이미 트랜잭션이 진행 중일 때 새 트랜잭션 경계를 만나면 어떻게 할지 정하는 규칙. `@Transactional(propagation = ...)`로 지정한다.

기본값은 `REQUIRED` — 진행 중인 것이 있으면 참여하고, 없으면 새로 시작한다. `REQUIRES_NEW`는 진행 중인 것을 잠시 멈추고 항상 새로 시작한다.

- 처음 나온 곳: [[03-transactional-propagation-and-proxy-limits]]
- 섞이는 말: [[자기-호출]]

## 프록시-기반-AOP (proxy-based AOP)

대상 객체를 프록시로 감싸고, **프록시를 거쳐 들어오는 호출**에만 부가 기능을 끼워 넣는 방식. Spring의 기본 AOP 모드이며 `@Transactional`이 이 위에서 동작한다.

- 처음 나온 곳: [[03-transactional-propagation-and-proxy-limits]]
- 섞이는 말: [[자기-호출]], [[트랜잭션-전파]]

## 자기-호출 (self-invocation)

같은 객체 안에서 자기 메서드를 부르는 것. `this.otherMethod()` 형태다.

프록시를 거치지 않으므로 그 메서드에 붙은 `@Transactional`이 **아무 효과도 내지 못한다.** 공식 문서의 표현으로는 *"프록시를 통해 들어온 외부 호출만 가로채진다."*

- 처음 나온 곳: [[03-transactional-propagation-and-proxy-limits]]
- 섞이는 말: [[프록시-기반-AOP]]

## 낙관적-락 (optimistic locking)

"충돌은 드물다"고 가정하고, 충돌이 실제로 일어났을 때만 실패시키는 방식. 버전 필드를 비교해 판정한다.

읽는 동안 아무것도 잠그지 않으므로 동시성이 높다. 대신 충돌한 쪽은 작업을 잃고 다시 해야 한다.

- 처음 나온 곳: [[04-isolation-and-optimistic-locking]]
- 섞이는 말: [[비관적-락]], [[버전-필드]]

## 비관적-락 (pessimistic locking)

"충돌이 날 것"이라 가정하고 미리 DB 행을 잠그는 방식. `PESSIMISTIC_WRITE`는 `select ... for update`로, `PESSIMISTIC_READ`는 공유 락으로 번역된다.

충돌이 아예 일어나지 않지만, 잠근 동안 다른 트랜잭션이 기다린다.

- 처음 나온 곳: [[04-isolation-and-optimistic-locking]]
- 섞이는 말: [[낙관적-락]]

## 버전-필드 (version field)

낙관적 락의 판정 근거가 되는 필드. `@Version`을 붙이면 JPA가 UPDATE마다 값을 올리고, `WHERE` 절에 이전 값을 넣는다.

갱신된 행이 0건이면 그 사이 누군가 먼저 고친 것이므로 예외를 던진다. **락이라는 이름이지만 아무것도 잠그지 않는다** — 이름이 오해를 부르는 대표적인 예다.

- 처음 나온 곳: [[04-isolation-and-optimistic-locking]]
- 섞이는 말: [[낙관적-락]]

## 격리-수준 (isolation level)

동시에 실행되는 트랜잭션들이 서로의 중간 상태를 얼마나 볼 수 있는지 정하는 수준. `READ COMMITTED`, `REPEATABLE READ` 등이 있다.

애플리케이션 레벨 락과 층이 다르다. 격리 수준은 **DB가 제공하는 것**이고, 낙관적 락은 **애플리케이션이 만드는 것**이다.

- 처음 나온 곳: [[04-isolation-and-optimistic-locking]]
- 섞이는 말: [[낙관적-락]], [[비관적-락]]

## OSIV (Open Session In View)

웹 요청이 끝날 때까지 영속성 컨텍스트를 열어 두는 패턴. Spring Boot 웹 애플리케이션의 **기본값이 켜짐**이며 `spring.jpa.open-in-view: false`로 끈다.

뷰나 응답 변환 단계에서도 지연 로딩이 되게 해 주지만, 그 대가로 DB 커넥션을 요청 내내 붙잡는다.

- 처음 나온 곳: [[05-open-session-in-view]]
- 섞이는 말: [[트랜잭션-경계]]

## 트랜잭션-경계 (transaction boundary)

트랜잭션이 시작되고 끝나는 지점. `@Transactional`이 붙은 메서드의 진입과 반환이 그 지점이다.

OSIV는 영속성 컨텍스트의 수명을 이 경계보다 길게 늘인다. 그래서 "트랜잭션은 끝났는데 컨텍스트는 살아 있는" 구간이 생긴다.

- 처음 나온 곳: [[05-open-session-in-view]]
- 섞이는 말: [[OSIV]]

# Chapter 12 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 12 *Messaging and Asynchronous Communication in Spring Boot 4*, 책 pp. 317–343 / PDF pp. 342–368. PDF를 `pdftotext -layout -f 342 -l 368`로 새로 추출해 1,136줄 전체를 읽은 뒤, 제목·코드·Tip/Note·Figure를 노트와 대조했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

인쇄된 상위 절은 **6개**, 2단계 하위 제목은 **11개**, 3단계는 **없다**. 상위 절 6개 중 4개(`01`·`02`·`04`·`05`)가 하위 제목을 품고 있어 **인쇄된 하위 제목을 기준으로만** 쪼개 6 → **13개**로 늘렸다.

각 상위 절의 도입부는 별도 노트로 만들지 않고 **첫 하위 제목과 합쳤다.** 네 절 모두 도입이 한두 문단이고 곧바로 첫 하위 제목의 예고로 이어지기 때문이다 — 예컨대 §5의 도입 "우리 애플리케이션은 실패에 대비돼 있지 않다"는 그대로 §5a *Handling transient failures with retries*의 문제 제기다.

**기존 초안 6개의 파일 이름은 하나도 바꾸지 않았다.** 상위 절과 1:1로 대응하고, Ch12를 참조하는 다른 장의 inbound 링크는 0건이다.

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-asynchronous-and-event-driven-communication]] | Introducing asynchronous and event-driven communication (도입) + Synchronous vs. asynchronous communication | 318–321 | 343–346 |
| [[01a-core-components-of-event-driven-systems]] | Core components of event-driven systems | 321–322 | 346–347 |
| [[02-events-messages-and-delivery-semantics]] | Understanding events, messages, and delivery semantics (도입) + Events versus messages | 322–323 | 347–348 |
| [[02a-delivery-semantics]] | Delivery semantics: the reality of distributed systems | 323–324 | 348–349 |
| [[03-apache-kafka-fundamentals]] | Exploring the fundamentals of Apache Kafka | 324–326 | 349–351 |
| [[04-building-event-driven-services]] | Building event-driven services with Spring Boot and Apache Kafka (도입) + Setting up Apache Kafka | 326–329 | 351–354 |
| [[04a-defining-the-event-and-persistence-models]] | Defining the event and persistence models | 329–330 | 354–355 |
| [[04b-implementing-the-employee-service]] | Implementing the employee service | 330–332 | 355–357 |
| [[04c-implementing-the-notification-service]] | Implementing the notification service | 332–335 | 357–360 |
| [[05-reliability-patterns-retries-dlt-idempotency]] | Applying reliability patterns (도입) + Handling transient failures with retries | 336–338 | 361–363 |
| [[05a-dead-letter-topics]] | Handling unrecoverable failures with dead-letter topics | 338–340 | 363–365 |
| [[05b-idempotent-consumers]] | Preventing duplicates with idempotent consumers | 340–342 | 365–367 |
| [[06-choosing-between-rest-and-messaging]] | Choosing between REST and messaging | 342–343 | 367–368 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 317 | 342 | 장 도입 — 지금까지 전통적 request-response로 만들었고 그건 여전히 현대 시스템 설계의 핵심이다. **그러나 모든 상호작용이 그 모델을 따를 필요는 없다.** 이 장은 Apache Kafka를 메시징 플랫폼으로 쓴다. 다룰 6개 주제 | [[_map]] | 반영 |
| 318 | 343 | Note: 소스는 저장소 `ch12` 폴더 | [[04-building-event-driven-services]] | 반영 |
| 318 | 343 | 애플리케이션이 커지면 서비스 간 통신은 요청·응답 이상의 문제가 된다. **하나의 비즈니스 연산이 여러 서비스를 거치고** 각자 가용성·지연·처리 시간이 다르다. 직접 의존하면 **한 부분의 실패나 지연이 전체 흐름에 영향**을 준다 | [[01-asynchronous-and-event-driven-communication]] | 반영 |
| 318 | 343 | 비동기·이벤트 주도는 **발신자의 역할을 바꿔** 이를 해결한다. 다른 서비스를 호출하고 완료를 기다리는 대신, **무언가 일어났다는 사실을 이벤트로 발행**한다. 다른 서비스가 독립적으로 소비·반응한다 | [[01-asynchronous-and-event-driven-communication]] | 반영 |
| 318 | 343 | 직접 의존을 줄이고 각 부분이 더 독립적으로 진화·확장·복구하게 한다. 동시에 **새로운 설계 관심사**를 들여온다 — 이벤트 구조, 전달 보장, 순서, 재시도, 결과적 일관성 | [[01-asynchronous-and-event-driven-communication]] | 반영 |
| 319 | 344 | Figure 12.1 — 전통적 REST 기반 직원 생성 흐름 **4단계** (요청 → 생성 → 알림 서비스 호출 → 응답). **모든 단계가 같은 요청 주기 안에서** 일어나므로 알림 서비스가 느리거나 죽으면 요청 전체가 영향받는다 | [[01-asynchronous-and-event-driven-communication]] | 반영 (Mermaid 재현) |
| 320 | 345 | Figure 12.2 — 이벤트 주도 흐름 **5단계** (요청 → 생성 → `EmployeeCreated` 이벤트를 broker에 발행 → 응답 → 알림 서비스가 **비동기로** 소비) | [[01-asynchronous-and-event-driven-communication]] | 반영 (Mermaid 재현) |
| 320 | 345 | **클라이언트 상호작용은 여전히 동기**이고 클라이언트는 응답을 받는다. **내부 워크플로가 비동기가 될 뿐이다.** 이점 4가지 — 소비자를 알 필요 없음, 소비자의 독립 진화, 알림 실패가 클라이언트 요청에 영향 없음, 실패 격리 | [[01-asynchronous-and-event-driven-communication]] | 반영 |
| 320–321 | 345–346 | 핵심 이점은 **디커플링**이다. 발행하는 서비스는 **누가·몇이·언제** 소비할지 알 필요가 없다. 새 소비자를 producer 변경 없이 추가할 수 있고, 소비자가 일시적으로 죽어도 producer는 계속 발행하며 소비자는 나중에 처리한다 | [[01-asynchronous-and-event-driven-communication]] | 반영 |
| 321 | 346 | Figure 12.3 — 이벤트 주도 시스템의 핵심 구성 요소. **Producer**(의미 있는 일이 생겼을 때 이벤트를 방출) / **Event(message)**(무슨 일이 있었는지 기술하는 정보, 발행되면 메시징 인프라가 옮기는 message가 된다) / **Broker**(수신·저장·전달, producer와 consumer를 분리. Kafka·RabbitMQ) / **Consumer**(구독하고 반응) | [[01a-core-components-of-event-driven-systems]] | 반영 (Mermaid 재현) |
| 322 | 347 | 이점 — 확장성·회복력·유연성·느슨한 결합. producer와 consumer가 독립적으로 동작하므로 각자 필요에 따라 진화·확장하고, 소비자 추가·부하 분산·실패 격리가 쉬워진다 | [[01a-core-components-of-event-driven-systems]] | 반영 |
| 322 | 347 | **trade-off** — 처리가 분산·비동기라 **비즈니스 흐름 추적이 어렵고**, 타이밍과 순서를 따지기 어렵고, 실패 진단이 어렵다. 재시도·중복 전달·스키마 진화·결과적 일관성도 다뤄야 해 설계·운영 복잡도가 는다 | [[01a-core-components-of-event-driven-systems]] | 반영 |
| 322 | 347 | 실무에서 이벤트 주도는 상당한 이점을 주지만 **이해 가능하고 신뢰할 만한 상태로 유지하려면 신중한 모델링·모니터링·오류 처리 전략**이 필요하다 | [[01a-core-components-of-event-driven-systems]] | 반영 |
| 322 | 347 | Kafka로 구현하기 전에 **event와 message의 구분**, 그리고 전달 시 시스템이 주는 **보장**을 이해해야 한다 | [[02-events-messages-and-delivery-semantics]] | 반영 |
| 322–323 | 347–348 | 언뜻 두 용어는 바꿔 써도 될 것 같지만 목적이 조금 다르다. **event는 비즈니스 사실** — 직원이 생성됐다, 급여가 갱신됐다, 결제가 승인됐다. 도메인 안에서 의미를 갖는다. **message는 그 이벤트를 시스템 사이로 옮기는 기술적 컨테이너**다 | [[02-events-messages-and-delivery-semantics]] | 반영 |
| 323 | 348 | **event는 무슨 일이 있었나, message는 그 정보를 어떻게 전달하나.** `EmployeeCreatedEvent` record 예제 — **특별할 것이 없는 평범한 데이터 구조**다 | [[02-events-messages-and-delivery-semantics]] | 반영 |
| 323 | 348 | 이벤트가 message가 되어 broker를 지나면 근본 질문이 생긴다 — **전달을 보장받을 수 있나?** 분산 시스템은 trade-off 없이 완벽한 보장을 줄 수 없고, 대신 **delivery semantics**를 제공한다 | [[02a-delivery-semantics]] | 반영 |
| 323 | 348 | **At-most-once** — 0회 또는 1회. 재시도 없음, 빠르지만 **유실 위험**. 로깅·메트릭 파이프라인처럼 가끔의 유실이 허용되는 곳 | [[02a-delivery-semantics]] | 반영 |
| 323 | 348 | **At-least-once** — 1회 이상. 재시도로 신뢰성이 오르지만 **중복이 생길 수 있다.** 그래서 소비자는 **멱등**하게 설계돼야 한다 | [[02a-delivery-semantics]] | 반영 |
| 323 | 348 | **Exactly-once** — 중복도 유실도 없이 정확히 한 번. producer·broker·consumer의 **조율 보장**이 필요해 구현이 복잡하다. 그래서 실무에서 덜 쓰이고, **at-least-once + 멱등 소비자**가 대개 낫다 | [[02a-delivery-semantics]] | 반영 |
| 324 | 349 | 실무의 대부분이 **at-least-once + 멱등 처리**를 택한다. 신뢰성과 구현 복잡도의 균형이 좋기 때문이다. **중복을 없애려 하기보다 안전하게 다루도록 설계한다** | [[02a-delivery-semantics]] | 반영 |
| 324 | 349 | LinkedIn에서 개발된 **Apache Kafka**는 분산 이벤트 스트리밍 플랫폼으로, 직접 호출 대신 이벤트로 통신하게 한다. 대량 데이터를 실시간으로 다루고 신뢰성·확장성·내구성 있는 교환 메커니즘을 제공한다 | [[03-apache-kafka-fundamentals]] | 반영 |
| 324 | 349 | **분산 아키텍처** — broker·producer·consumer로 구성된 분산 시스템. 여러 노드에 데이터를 분산해 수평 확장·고가용성·내결함성을 얻는다 | [[03-apache-kafka-fundamentals]] | 반영 |
| 324 | 349 | **Topic 기반 조직** — topic은 이벤트의 채널이고 하나 이상의 **partition**으로 나뉜다. 병렬 처리·확장성·처리량을 가능하게 한다. **partition 3개일 때 consumer 1·2·3개의 배정**과, **3개를 넘으면 남는 인스턴스가 놀게 되는** 규칙 | [[03-apache-kafka-fundamentals]] | 반영 |
| 324–325 | 349–350 | **Offsets** — partition 안 모든 메시지가 고유 offset을 갖고 consumer가 처리하며 위치를 커밋한다. 실패 후 재개와 **재생(replay)**을 가능하게 한다 | [[03-apache-kafka-fundamentals]] | 반영 |
| 325 | 350 | **Consumer groups** — consumer는 그룹으로 조직되고 각자 partition의 부분집합을 처리한다. **각 partition은 그룹 내 한 consumer에만 배정**되어 중복 처리를 막는다. consumer가 죽으면 Kafka가 재분배한다 | [[03-apache-kafka-fundamentals]] | 반영 |
| 325 | 350 | **Commit log 저장** — 설정된 기간 동안 보존되는 **불변·순차 commit log**로 메시지를 저장한다. 내구성을 보장하고 필요할 때 재처리를 가능하게 한다 | [[03-apache-kafka-fundamentals]] | 반영 |
| 325 | 350 | Figure 12.4 — Kafka 단순 아키텍처 (Producer A·B → Topic의 Partition 0·1·2 → Consumer Group의 Instance 1·2·3) | [[03-apache-kafka-fundamentals]] | 반영 (Mermaid 재현) |
| 325 | 350 | producer가 topic에 메시지를 보내면 Kafka가 **어느 partition에 저장할지 결정**한다 — **key가 있으면 같은 key는 항상 같은 partition**으로(그 key 안의 순서 보존), key가 없으면 **round-robin**, 커스텀 전략도 가능 | [[03-apache-kafka-fundamentals]] | 반영 |
| 326 | 351 | Kafka는 이벤트 주도 시스템의 **중추**다. 이 아키텍처가 가능하게 하는 것 4가지 — 느슨한 결합, partitioning을 통한 높은 확장성, 복제와 consumer group을 통한 내결함성, **재생 가능한 이벤트 스트림**을 통한 유연한 데이터 처리 | [[03-apache-kafka-fundamentals]] | 반영 |
| 326 | 351 | 이론을 마쳤으니 Spring Boot와 Kafka로 **간단한 이벤트 주도 시스템**을 만든다 | [[04-building-event-driven-services]] | 반영 |
| 326–327 | 351–352 | Docker Compose로 Kafka 설정 — `confluentinc/cp-kafka:7.8.8` 이미지와 환경 변수 전문 | [[04-building-event-driven-services]] | 반영 |
| 327 | 352 | 항목별 **13개** 설명 — `services.kafka`·`image`·`ports`·`KAFKA_NODE_ID`·`KAFKA_PROCESS_ROLES`(broker이자 controller)·`KAFKA_LISTENERS`·`KAFKA_ADVERTISED_LISTENERS`·`KAFKA_LISTENER_SECURITY_PROTOCOL_MAP`(전부 PLAINTEXT — 로컬 개발용)·`KAFKA_CONTROLLER_QUORUM_VOTERS`·`KAFKA_CONTROLLER_LISTENER_NAMES`·`KAFKA_INTER_BROKER_LISTENER_NAME`·`KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR`(broker 하나라 1)·`CLUSTER_ID` | [[04-building-event-driven-services]] | 반영 |
| 327–328 | 352–353 | **Offset Explorer 3**(구 Kafka Tool)로 topic·메시지·consumer group·offset을 실시간 확인할 수 있다. 연결 설정 3개(Cluster Name·Bootstrap Servers·Security PLAINTEXT). **선택 사항이지만 이벤트 흐름의 가시성을 준다** | [[04-building-event-driven-services]] | 반영 |
| 328 | 353 | Figure 12.5 — 로컬 Kafka 클러스터 연결 설정 화면 | [[04-building-event-driven-services]] | 반영 (Figure 미추출, 불일치는 §5에 기록) |
| 328–329 | 353–354 | 애플리케이션은 **두 서비스**로 이뤄진다 — 직원을 만들면 이벤트를 발행하는 employee service, 그것을 소비하는 notification service. Initializr 좌표 9개와 의존성 4개(Spring Web·Spring JPA·H2·**Spring for Apache Kafka**) | [[04-building-event-driven-services]] | 반영 |
| 329 | 354 | 새 의존성은 하나뿐 — **Spring for Apache Kafka**. `KafkaTemplate`(발행)과 `@KafkaListener`(소비) 추상을 제공하고, Boot가 필요한 인프라를 대부분 auto-configure해 **저수준 Kafka API 대신 비즈니스 로직에 집중**하게 한다 | [[04-building-event-driven-services]] | 반영 |
| 329 | 354 | 영속성 계층은 앞 장들과 같은 방식이다 — `@Entity Employee`(id·name·role·email·createdAt)와 `EmployeeRepository extends JpaRepository`. **같은 Spring Data JPA 패턴이라 더 설명하지 않는다** | [[04a-defining-the-event-and-persistence-models]] | 반영 |
| 330 | 355 | 서비스가 새 직원을 저장한 뒤 발행할 **이벤트 객체** `EmployeeCreatedEvent` record. 저장된 직원 데이터를 담아 Kafka에 발행하며, **직원 생성이라는 사실을 다른 서비스에 알리는** 역할 | [[04a-defining-the-event-and-persistence-models]] | 반영 |
| 330–331 | 355–356 | `EmployeeService` — `EmployeeRepository`와 `KafkaTemplate<String, EmployeeCreatedEvent>`를 주입받고, `createEmployee`가 저장 후 이벤트를 발행 | [[04b-implementing-the-employee-service]] | 반영 |
| 331 | 356 | 항목별 2개 설명 — **`KafkaTemplate`**(Spring이 제공하는 메시지 발행의 주 추상. 직렬화와 연결 세부를 뒤에서 처리)과 **`send(topic, key, payload)`** 세 인자의 의미 | [[04b-implementing-the-employee-service]] | 반영 |
| 331 | 356 | 이 메시지를 보냄으로써 **비동기 통신이 가능해진다.** notification service 같은 다른 서비스가 **원래 요청 흐름에 영향을 주지 않고** 독립적으로 소비할 수 있다 | [[04b-implementing-the-employee-service]] | 반영 |
| 331–332 | 356–357 | producer용 `application.yml` — `bootstrap-servers`·`key-serializer`(StringSerializer)·`value-serializer`(**JacksonJsonSerializer**)와 항목별 3개 설명. **employee ID가 원래 `Long`인데 `toString()`으로 보내므로 StringSerializer가 실제 key 타입과 맞는다** | [[04b-implementing-the-employee-service]] | 반영 |
| 332 | 357 | Note: **Boot 4는 Jackson 3을 기본 JSON 라이브러리로 쓴다.** 그래서 Spring Kafka의 옛 `JsonSerializer`·`JsonDeserializer`는 **deprecated**이고 호환성 문제를 낳을 수 있다. **`JacksonJsonSerializer`·`JacksonJsonDeserializer`**를 써야 Boot 4의 Jackson 기반 설정과 매끄럽게 맞는다 | [[04b-implementing-the-employee-service]] | 반영 |
| 332–333 | 357–358 | `NotificationService` — `@KafkaListener(topics = "employee-events", groupId = "notification-group")`가 붙은 `handleEmployeeCreated`. 메시지가 발행되면 Spring Kafka가 자동으로 이 메서드를 호출한다. **`groupId`가 여러 인스턴스의 소비 분담을 가능하게 한다.** 메서드는 **이미 역직렬화된** 이벤트를 받는다 | [[04c-implementing-the-notification-service]] | 반영 |
| 333–334 | 358–359 | consumer용 `application.yml`과 항목별 5개 설명 — `group-id`·**`auto-offset-reset: earliest`**(커밋된 offset이 없을 때 토픽 처음부터 읽어 메시지 누락을 막는다)·`key-deserializer`·`value-deserializer`·**`spring.json.trusted.packages: "*"`**(모든 패키지를 신뢰. **production에서는 특정 패키지로 제한**해 예상 밖 클래스의 역직렬화를 막는 편이 안전하다) | [[04c-implementing-the-notification-service]] | 반영 |
| 334 | 359 | 테스트용 `EmployeeController`의 POST endpoint — 요청 본문의 `Employee`를 받아 service에 위임하고 `201 CREATED`로 저장된 직원을 반환 | [[04c-implementing-the-notification-service]] | 반영 |
| 334–335 | 359–360 | 기동 로그 — Tomcat 8080, `ConsumerConfig values` (`auto.offset.reset = earliest`, `bootstrap.servers = [localhost:9092]`), **`Subscribed to topic(s): employee-events`**, **`notification-group: partitions assigned: [employee-events-0]`** | [[04c-implementing-the-notification-service]] | 반영 |
| 335–336 | 360–361 | curl로 직원 생성 → producer 로그와 **`Sending notification to: wanderson.xesquevixos@example.com`** 콘솔 출력. 이벤트가 발행되고 비동기로 소비됐다 | [[04c-implementing-the-notification-service]] | 반영 |
| 336 | 361 | 그런데 아직 **회복력이 없다** — 이벤트를 잃거나 처리 흐름을 끊지 않고 실패를 우아하게 다루도록 설계되지 않았다. **notification service가 일시적으로 죽으면? 잘못된 데이터나 일시적 네트워크 오류로 처리가 실패하면? 같은 메시지가 두 번 오면?** | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 336 | 361 | 어떤 실패는 **일시적**이다 — Kafka가 몇 초 죽거나, DB 연결이 타임아웃되거나, 서드파티 API가 간헐적 오류를 낸다. 즉시 실패하는 것이 최선이 아니고 **재시도가 성공 가능성을 높인다** | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 336–337 | 361–362 | `sendNotification`에 실패 시뮬레이션 — `Math.random() < 0.5`로 **일시적 실패**(약 50% 확률의 간헐적 오류), `email == null || isBlank()`로 **영구적 실패**(재시도해도 없는 이메일은 생기지 않는다) | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 337 | 362 | `KafkaConsumerConfig`의 `DefaultErrorHandler` bean과 `FixedBackOff(2000L, 3L)` — **2초 간격, 최대 3회 재시도.** 일시적 실패에 유용한 이유는 **이벤트를 버리지 않고 회복 기회를 주기** 때문 | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 338 | 363 | 그런데 **모든 실패가 일시적이지 않다.** 페이로드가 잘못됐거나 필수 필드가 없으면 아무리 재시도해도 성공하지 않고 **자원만 낭비**한다. 더 나은 방법은 실패 메시지를 **dead-letter topic으로 보내는 것** | [[05-reliability-patterns-retries-dlt-idempotency]] · [[05a-dead-letter-topics]] | 반영 |
| 338 | 363 | DLT는 처리에 실패한 메시지의 **격리 구역**이다. 메인 소비 흐름은 계속되고 문제 메시지는 나중 조사를 위해 보존된다 | [[05a-dead-letter-topics]] | 반영 |
| 338 | 363 | Spring Kafka는 기본적으로 **`DeadLetterPublishingRecoverer`**로 모든 재시도 후에도 실패한 레코드를 다룬다. **원래 topic 이름 + `-dlt` 접미**를 쓴 topic으로 재발행한다. `employee-events` → **`employee-events-dlt`** | [[05a-dead-letter-topics]] | 반영 |
| 338 | 363 | `DefaultErrorHandler(recoverer, fixedBackOff)`로 DLT 처리를 더한 설정. **3회 재시도가 모두 실패하면 DLT로 보낸다.** 실패 메시지가 소비를 막지 않으면서 분석·재처리를 위해 보존된다 | [[05a-dead-letter-topics]] | 반영 |
| 339 | 364 | DLT 전용 리스너 `NotificationDeadLetterListener` — `@KafkaListener(topics = "employee-events-dlt", groupId = "notification-dlt-group")`가 **`ConsumerRecord<String, byte[]>`**를 받아 topic·partition·offset·payload를 출력 | [[05a-dead-letter-topics]] | 반영 |
| 339 | 364 | **왜 `byte[]`인가** — `EmployeeCreatedEvent`를 인자로 쓰는 것은 **원래 메시지가 성공적으로 역직렬화됐고 이후 애플리케이션 처리에서 실패한 경우**에만 통한다. 잘못된 JSON·비호환 스키마·예상 밖 포맷으로 **역직렬화 자체가 실패**했다면 DLT에 **원본 raw payload**가 담길 수 있다. 그때는 `ConsumerRecord<String, byte[]>`로 소비해 **원본 바이트를 들여다보는 편이 안전**하다 | [[05a-dead-letter-topics]] | 반영 |
| 339–340 | 364–365 | 실제 애플리케이션에서 이 consumer가 할 수 있는 일 4가지 — 실패 이벤트 저장, 알림 발생, 관측 도구에 노출, **교정 후 재생 지원** | [[05a-dead-letter-topics]] | 반영 |
| 340 | 365 | `email` 없는 curl로 확인 — 3회 재시도 후 DLT로 전달되고 `NotificationDeadLetterListener`가 소비한다 | [[05a-dead-letter-topics]] | 반영 |
| 340 | 365 | Figure 12.6 — Kafka Client 화면. DLT `employee-events-dlt`가 **생성됐고** 메시지가 그리로 전달됐음이 보인다 | [[05a-dead-letter-topics]] | 반영 (**이미지 추출**) |
| 340 | 365 | 재시도는 신뢰성을 높이지만 **중복 처리 위험도 높인다.** 재시도가 없어도 중복은 생길 수 있다. 그래서 consumer는 **멱등**하게 설계돼야 한다 | [[05b-idempotent-consumers]] | 반영 |
| 341 | 366 | 멱등 consumer는 같은 이벤트를 여러 번 처리해도 **일관되지 않은 결과를 만들지 않는다.** 중복 처리가 한 번 처리와 같은 효과여야 한다. **부수효과**(이메일 발송, 레코드 삽입·갱신, 감사 기록, 외부 시스템 호출)가 있을 때 특히 중요하다 | [[05b-idempotent-consumers]] | 반영 |
| 341 | 366 | 예제는 `employeeId`를 **멱등 키**로 쓴다. `ConcurrentHashMap.newKeySet()`에 저장하고 후속 메시지와 대조해 이미 처리했는지 판단한다. 코드와 동작 설명 | [[05b-idempotent-consumers]] | 반영 |
| 341 | 366 | **이 인메모리 방식은 시연용일 뿐이다** — 재시작하면 사라지고, 여러 consumer 인스턴스 사이에서 조율되지 않으며, Set이 무한히 자란다 | [[05b-idempotent-consumers]] | 반영 |
| 341–342 | 366–367 | Note: production에서는 **inbox·outbox 패턴**으로 구현한다. **inbox**는 소비한 메시지 ID(예: `employeeId`)를 **유니크 제약이 있는 영속 저장소**에 담아 멱등성을 구현한다. **outbox**는 producer 쪽 패턴으로, 이벤트를 **비즈니스 연산과 같은 트랜잭션 안에서** DB에 저장해 신뢰성 있는 발행을 보장한다 | [[05b-idempotent-consumers]] | 반영 |
| 342 | 367 | 재시도·DLT·멱등성은 **서로 다른 문제를 풀고 함께 쓸 때 가장 좋다.** 전체 흐름 요약 — 발행 → 소비 시도 → 일시 실패면 재시도 → 계속 실패하면 DLT → 중복이면 멱등 검사가 막는다 | [[05b-idempotent-consumers]] | 반영 |
| 342 | 367 | 두 통신 스타일을 살펴봤다 — 동기 REST와 Kafka 비동기 메시징. **핵심은 하나를 고르는 것이 아니라 각각이 어디에 맞는지 이해하는 것** | [[06-choosing-between-rest-and-messaging]] | 반영 |
| 342 | 367 | **REST는 request-response**다. 클라이언트가 보내고 즉시 결과를 기다린다. 단순하고 예측 가능하며 추론하기 쉽다. **다음으로 넘어가기 전에 연산이 완료돼야 할 때** 잘 맞는다 — 직원을 만들고 확인을 돌려주는 경우 | [[06-choosing-between-rest-and-messaging]] | 반영 |
| 342 | 367 | **메시징은 비동기**다. 서비스가 이벤트를 발행하고 다른 서비스가 독립적으로 처리한다. producer가 기다리지 않아 결합이 줄고 확장성이 오른다. **여러 서비스가 같은 이벤트에 반응해야 하거나 작업이 배경에서 일어나도 될 때** 유용하다 | [[06-choosing-between-rest-and-messaging]] | 반영 |
| 342 | 367 | 차이는 단순하다 — **REST는 서비스 사이에 직접적이고 시간에 묶인 의존을 만들고, 메시징은 이벤트를 통해 그들을 분리한다.** 실무에서는 둘을 결합한다 — 즉각적이고 클라이언트 주도인 연산에는 REST, 배경 처리와 서비스 간 반응에는 메시징 | [[06-choosing-between-rest-and-messaging]] | 반영 |
| 343 | 368 | Summary — 이벤트 주도 통신, event와 message의 차이, delivery semantics, Kafka 기초, Spring Boot와 Kafka로 만든 이벤트 주도 애플리케이션, 재시도·DLT·멱등 consumer로 높인 신뢰성, REST와 메시징 비교. 다음 장은 관측 | [[_map]] | 반영 |
| 368 | 368 | 책 PDF 다운로드 QR 안내 | — | 학습 무관, 제외 |

## 2. 코드·설정 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | `EmployeeCreatedEvent` record (개념 소개용, `Instant createdAt`) | 323 | [[02-events-messages-and-delivery-semantics]] | 반영 |
| 2 | `docker-compose.yml` Kafka 브로커 전문 | 326–327 | [[04-building-event-driven-services]] | 반영 |
| 3 | Initializr 좌표 9개 + 의존성 4개 | 328–329 | [[04-building-event-driven-services]] | 반영 |
| 4 | `@Entity Employee` | 329 | [[04a-defining-the-event-and-persistence-models]] | 반영 |
| 5 | `EmployeeRepository extends JpaRepository` | 330 | [[04a-defining-the-event-and-persistence-models]] | 반영 |
| 6 | `EmployeeCreatedEvent` record (구현용, `LocalDateTime createdAt`) | 330 | [[04a-defining-the-event-and-persistence-models]] | 반영 |
| 7 | `EmployeeService` — `KafkaTemplate.send(...)` | 330–331 | [[04b-implementing-the-employee-service]] | 반영 |
| 8 | producer `application.yml` | 331–332 | [[04b-implementing-the-employee-service]] | 반영 |
| 9 | `NotificationService` — `@KafkaListener` | 332–333 | [[04c-implementing-the-notification-service]] | 반영 |
| 10 | consumer `application.yml` | 333 | [[04c-implementing-the-notification-service]] | 반영 |
| 11 | `EmployeeController` POST endpoint | 334 | [[04c-implementing-the-notification-service]] | 반영 |
| 12 | 기동 로그 (Consumer 구독·partition 배정) | 334–335 | [[04c-implementing-the-notification-service]] | 반영 (요약) |
| 13 | curl POST + `Sending notification to:` 출력 | 335–336 | [[04c-implementing-the-notification-service]] | 반영 |
| 14 | `sendNotification` 실패 시뮬레이션 | 336–337 | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 15 | `KafkaConsumerConfig` — `DefaultErrorHandler` + `FixedBackOff` | 337 | [[05-reliability-patterns-retries-dlt-idempotency]] | 반영 |
| 16 | `DefaultErrorHandler(recoverer, fixedBackOff)` — DLT 추가 | 338 | [[05a-dead-letter-topics]] | 반영 |
| 17 | `NotificationDeadLetterListener` | 339 | [[05a-dead-letter-topics]] | 반영 |
| 18 | `email` 없는 curl | 340 | [[05a-dead-letter-topics]] | 반영 |
| 19 | 멱등 검사 — `processedEvents` Set + `handleEmployeeCreated` | 341 | [[05b-idempotent-consumers]] | 반영 |

## 3. Tip / Note 블록 → 노트 매핑

| # | Note 내용 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | 소스는 저장소 `ch12` 폴더 | 318 | [[04-building-event-driven-services]] | 반영 |
| 2 | Boot 4는 Jackson 3이 기본 — 옛 `JsonSerializer`·`JsonDeserializer`는 deprecated, `JacksonJson*`을 쓴다 | 332 | [[04b-implementing-the-employee-service]] | 반영 |
| 3 | production에서는 inbox·outbox 패턴으로 멱등성과 신뢰성을 구현한다 | 341–342 | [[05b-idempotent-consumers]] | 반영 |

## 4. Figure 처리 판단

`pdfimages -f 342 -l 368 -list`로 raster **6개**(PDF pp. 344·345·346·350·353·365)와 마지막 쪽의 QR·로고를 확인하고, **6개를 전부 PNG로 뽑아 육안 확인**한 뒤 **1개만 `_assets/`에 넣었다.**

| Figure | 책 쪽 | 내용 (육안 확인) | 판단 |
|---|---:|---|---|
| 12.1 | 319 | sequence diagram — Client → employee service(POST /employees) → self(Create Employee) → notification service(Send Notification) → Notification OK → 201 OK. **모든 것이 한 요청 주기 안에** | **미추출**. 개념 관계도이며 [[01-asynchronous-and-event-driven-communication]]에 Mermaid `sequenceDiagram`으로 재현 |
| 12.2 | 320 | 같은 형태에 Kafka lifeline이 추가 — Publish EmployeeCreated event가 **201 OK보다 먼저**, notification service는 **점선(비동기)**으로 이벤트를 받아 Process Notification | **미추출**. 12.1과 나란히 놓아야 대비가 보이므로 **같은 노트에 두 다이어그램을 이어** Mermaid로 재현 |
| 12.3 | 321 | Producer ×2 → Broker(원통) → Consumer ×2, 화살표에 Publishes Event / Delivers Event | **미추출**. 네 요소와 두 화살표뿐인 최소 도식이라 [[01a-core-components-of-event-driven-systems]]에 Mermaid로 재현 |
| 12.4 | 325 | Producer A·B → Kafka 안의 Topic → Partition 0(메시지 offset 0·1), Partition 1(0·1·2), Partition 2(0) → Consumer Group의 Instance 1·2·3에 **1:1 배정** | **미추출**. offset 번호와 배정 관계가 본문 서술과 일치하며 Mermaid로 재현 가능해 [[03-apache-kafka-fundamentals]]에 옮겼다 |
| 12.5 | 328 | Offset Explorer의 **Add Cluster** 대화상자 두 탭 — Properties(Cluster name `Local Kafka`, Bootstrap servers `localhost:9092`, **Kafka Cluster Version `0.11`**, **Enable Zookeeper access 체크**, Port `2181`)와 Security(Type `Plaintext`) | **미추출**. 책 자신이 이 도구를 **"선택 사항"**이라 명시하고, 학습 대상은 대화상자가 아니라 "브로커에 붙어 topic과 offset을 본다"는 사실이다. 다만 화면에 **본문이 언급하지 않는 Zookeeper 설정**이 켜져 있어 Docker Compose의 KRaft 구성과 어긋나므로 그 불일치는 §5에 기록했다 |
| 12.6 | 340 | Offset Explorer 화면 — 좌측 트리에 `employee-events`와 **`employee-events-dlt` → Partitions → Partition 0**, 우측에 offset 0·key 1의 레코드, 하단에 payload 전문 `{"employeeId":1,"name":"Alice Johnson",**"email":null**,"createdAt":"2026-03-30T14:32:33.456778"}` (93 bytes) | **추출** → `_assets/lsb4-p340-fig12-6-dead-letter-topic-in-kafka-client.png`. **`-dlt` 접미 topic이 자동 생성됐다는 사실과, 실패 원인인 `email: null`이 payload에 그대로 남아 있다는 사실**이 이 그림에만 있다. 본문은 "DLT로 전달됐다"고만 말한다 |

## 5. 원문의 오류·공백 (노트에 명시)

| # | 원문 | 실제 | 노트 반영 |
|---:|---|---|---|
| 1 | p.323의 `EmployeeCreatedEvent`는 **`Instant createdAt`**, p.330의 같은 record는 **`LocalDateTime createdAt`** | 같은 이름의 타입이 **필드 타입이 다른 두 버전**으로 제시된다. Kafka로 직렬화할 때 두 타입은 JSON 표현이 다르므로(`2026-03-28T18:00:00Z` vs `2026-03-28T15:00:00`) 섞어 쓰면 역직렬화가 깨진다 | [[04a-defining-the-event-and-persistence-models]] §5 |
| 2 | p.328 Figure 12.5의 연결 화면에 **Enable Zookeeper access가 체크되고 Port 2181**이 설정돼 있다 | 이 장의 `docker-compose.yml`은 **KRaft 모드**다(`KAFKA_PROCESS_ROLES: broker,controller`, `KAFKA_CONTROLLER_QUORUM_VOTERS`, `CLUSTER_ID`). **Zookeeper가 아예 없다.** 화면의 `Kafka Cluster Version: 0.11`도 `cp-kafka:7.8.8`과 맞지 않는다. 본문 설명(Cluster Name·Bootstrap Servers·Security 셋)은 화면과 다른 항목만 말한다 | [[04-building-event-driven-services]] §5 |
| 3 | p.331 `EmployeeService`의 `private EmployeeRepository employeeRepository;` | 나란히 선언된 `kafkaTemplate`은 `final`인데 이쪽만 **`final`이 빠져 있다.** 생성자에서만 대입하므로 `final`이어야 일관된다 | [[04b-implementing-the-employee-service]] §5 |
| 4 | p.330–331 `createEmployee`가 **JPA 저장과 Kafka 발행을 같은 메서드에서** 수행한다 | 트랜잭션 경계가 없다. **저장은 성공하고 발행이 실패하면** 이벤트가 유실되고, 반대로 발행 후 트랜잭션이 롤백되면 **없던 일에 대한 이벤트**가 나간다. 책 자신이 p.342 Note에서 **outbox 패턴**이 이 문제의 해법이라고 말하면서도, 예제 코드와 그 Note를 연결하지 않는다 | [[04b-implementing-the-employee-service]] §5 |
| 5 | p.336–337 실패 시뮬레이션이 `Math.random() < 0.5`를 **`sendNotification` 안 맨 앞**에 둔다 | 그러면 `email` 검사에 닿기 전에 절반이 일시적 실패로 빠져, **영구 실패 경로가 재시도 3회를 다 쓰기 전에 우연히 성공할 수도 있다.** 두 실패 유형을 구분해 보여 주려는 의도와 실행이 어긋난다 | [[05-reliability-patterns-retries-dlt-idempotency]] §5 |
| 6 | p.334 consumer 설정의 **`spring.json.trusted.packages: "*"`** | 책이 "production에서는 제한하라"고 덧붙이지만 **예제 설정은 그대로 `*`**다. 이 값은 신뢰할 수 없는 메시지가 임의 클래스를 역직렬화하게 허용하는 잘 알려진 취약점 경로다 | [[04c-implementing-the-notification-service]] §5 |
| 7 | p.341 멱등 검사가 `processedEvents`에 ID를 **`sendNotification` 성공 뒤에** 추가한다 | 의도는 맞지만, 이 Set은 책 자신이 인정하듯 **재시작에 사라지고 인스턴스 간 조율이 없으며 무한히 자란다.** 게다가 **재시도가 도는 동안에는 아직 추가되지 않아** 같은 메시지의 재시도가 멱등 검사를 통과한다 — 재시도와 멱등성이 이 구현에서 서로 맞물리지 않는다 | [[05b-idempotent-consumers]] §5 |
| 8 | 장 제목과 목차는 **DLQ**(dead-letter queue), 본문은 **DLT**(dead-letter topic)를 쓴다 | Kafka에는 queue가 아니라 topic이 있으므로 본문 쪽이 정확하다. 제목만 일반적인 메시징 용어를 쓴다 | [[05a-dead-letter-topics]] §5 |

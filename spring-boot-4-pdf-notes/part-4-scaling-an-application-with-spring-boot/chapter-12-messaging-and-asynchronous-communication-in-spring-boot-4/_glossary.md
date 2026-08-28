# Chapter 12 용어집

> *Learning Spring Boot 4*, Ch. 12 *Messaging and Asynchronous Communication in Spring Boot 4* (책 pp. 317–343 / PDF pp. 342–368)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 동기-통신 (synchronous communication)

요청을 보낸 쪽이 **응답이 올 때까지 기다리는** 통신. 모든 단계가 같은 요청 주기 안에서 일어나므로 한 단계의 지연이 전체 응답 시간이 된다.

## 비동기-통신 (asynchronous communication)

보낸 쪽이 완료를 기다리지 않는 통신. 발신자는 **무언가 일어났다는 사실만 기록**하고, 받는 쪽은 자기 속도로 처리한다.

## 이벤트-주도 (event-driven)

서비스가 서로를 직접 호출하는 대신 **이벤트를 발행하고 구독**해 통신하는 아키텍처 스타일.

## 디커플링 (decoupling)

발행하는 쪽이 **누가·몇이·언제** 소비할지 몰라도 되는 상태. 새 소비자를 producer 변경 없이 추가할 수 있게 된다.

## 결과적-일관성 (eventual consistency)

모든 서비스가 즉시 같은 상태를 보지는 않지만 **시간이 지나면 수렴**하는 성질. 비동기가 들여오는 대표적 설계 관심사다.

## Producer (producer)

시스템에서 의미 있는 일이 일어났을 때 **이벤트를 방출하는** 구성 요소.

## Consumer (consumer)

이벤트를 **구독하고 반응하는** 구성 요소.

## Broker (broker)

이벤트를 **수신·저장·전달**하는 중간자. producer와 consumer를 분리해, producer가 누가 처리할지 모르고도 발행하게 한다. Kafka와 RabbitMQ가 대표적이다.

## 이벤트 (event)

**무슨 일이 있었는지**를 기술하는 비즈니스 사실. "직원이 생성됐다", "급여가 갱신됐다"처럼 도메인 안에서 의미를 갖는다.

## 메시지 (message)

이벤트를 시스템 사이로 **옮기는 기술적 컨테이너**. 이벤트가 "무엇"이라면 메시지는 "어떻게 전달되는가"다.

## 전달-시맨틱 (delivery semantics)

분산 시스템이 메시지를 **어떻게 전달하고 처리하는지**에 대한 보장의 종류. 완벽한 보장은 없고 trade-off만 있다.

## At-most-once (at-most-once delivery)

0회 또는 1회 전달. 재시도가 없어 빠르지만 **유실 위험**이 있다. 로깅·메트릭처럼 가끔의 손실이 허용되는 곳에 쓴다.

## At-least-once (at-least-once delivery)

1회 이상 전달. 재시도로 신뢰성이 오르지만 **중복이 생긴다.** 그래서 소비자가 멱등해야 한다.

## Exactly-once (exactly-once delivery)

정확히 한 번 처리. producer·broker·consumer의 조율이 필요해 구현이 복잡하고, 실무에서는 **at-least-once + 멱등 소비자**가 대개 선호된다.

## 멱등성 (idempotency)

같은 이벤트를 여러 번 처리해도 **한 번 처리한 것과 같은 결과**가 나오는 성질. 부수효과가 있는 소비자에 특히 중요하다.

## Apache-Kafka (Apache Kafka)

LinkedIn에서 개발된 **분산 이벤트 스트리밍 플랫폼**. 대량 데이터를 실시간으로 다루며 신뢰성·확장성·내구성 있는 교환 메커니즘을 제공한다.

## Topic (topic)

이벤트가 흐르는 **채널**. 하나 이상의 partition으로 나뉜다.

## Partition (partition)

topic을 쪼갠 단위. 병렬 처리와 확장성의 근거이며, **한 partition은 그룹 내 한 consumer에만 배정**된다.

## Offset (offset)

partition 안 각 메시지의 고유 위치. consumer가 처리하며 커밋해, 실패 후 재개와 **재생(replay)**을 가능하게 한다.

## Consumer-group (consumer group)

같은 `group-id`를 공유하며 partition을 나눠 처리하는 consumer들의 묶음. 하나가 죽으면 Kafka가 partition을 재분배한다.

## Commit-log (commit log)

Kafka가 메시지를 담는 **불변·순차 로그**. 설정된 기간 동안 보존되어 내구성과 재처리를 가능하게 한다.

## 메시지-키 (message key)

partition 배정을 결정하는 값. **같은 key는 항상 같은 partition으로** 가서 그 key 안의 순서가 보존된다. key가 없으면 round-robin으로 흩어진다.

## KRaft (KRaft)

Zookeeper 없이 Kafka 자신이 메타데이터와 컨트롤러 쿼럼을 관리하는 모드. `KAFKA_PROCESS_ROLES`와 `CLUSTER_ID`가 이 구성의 표시다.

## Spring-for-Apache-Kafka (Spring for Apache Kafka)

Spring Boot와 Kafka를 잇는 모듈. `KafkaTemplate`과 `@KafkaListener` 추상을 주고 인프라 대부분을 auto-configure한다.

## KafkaTemplate (KafkaTemplate)

Spring이 제공하는 **메시지 발행의 주 추상**. 직렬화와 연결 세부를 뒤에서 처리한다. `send(topic, key, payload)` 형태로 쓴다.

## KafkaListener (@KafkaListener)

메서드를 topic 구독자로 만드는 애노테이션. 메시지가 오면 Spring Kafka가 **이미 역직렬화된 객체**로 이 메서드를 부른다.

## JacksonJsonSerializer (JacksonJsonSerializer)

Boot 4의 Jackson 3 설정과 맞물리는 직렬화기. 옛 `JsonSerializer`는 deprecated다.

## auto-offset-reset (auto-offset-reset)

커밋된 offset이 없을 때의 동작을 정하는 설정. `earliest`는 topic 처음부터 읽어 메시지 누락을 막는다.

## trusted-packages (spring.json.trusted.packages)

JSON 역직렬화를 허용할 패키지 목록. `*`는 **모든 클래스**를 허용하므로 production에서는 좁혀야 한다.

## 재시도 (retry)

일시적 실패에 대해 같은 처리를 다시 시도하는 것. 즉시 실패시키는 대신 회복 기회를 준다.

## DefaultErrorHandler (DefaultErrorHandler)

Spring Kafka에서 메시지 처리 실패를 어떻게 다룰지 정하는 구성 요소. 재시도 전략과 최종 복구자를 함께 받는다.

## FixedBackOff (FixedBackOff)

고정 간격 재시도 전략. `FixedBackOff(2000L, 3L)`은 2초 간격으로 최대 3회다.

## 일시적-실패 (transient failure)

몇 초 뒤 재시도하면 성공할 수 있는 실패. 브로커 순단, DB 연결 타임아웃, 간헐적 API 오류가 그렇다.

## 영구적-실패 (permanent failure)

재시도해도 절대 성공하지 않는 실패. 잘못된 페이로드나 없는 필수 필드가 원인이다.

## DLT (dead-letter topic)

처리에 실패한 메시지의 **격리 구역**. 메인 소비 흐름을 막지 않으면서 문제 메시지를 나중 조사·재생을 위해 보존한다.

## DeadLetterPublishingRecoverer (DeadLetterPublishingRecoverer)

모든 재시도 후에도 실패한 레코드를 **원래 topic 이름 + `-dlt`** 로 재발행하는 Spring Kafka 구성 요소.

## ConsumerRecord (ConsumerRecord)

Kafka에서 받은 레코드를 topic·partition·offset·key·value와 함께 담는 타입. **역직렬화가 실패한 경우까지 다루려면** value를 `byte[]`로 받는다.

## inbox-패턴 (inbox pattern)

소비한 메시지 ID를 **유니크 제약이 있는 영속 저장소**에 담아 멱등성을 구현하는 consumer 쪽 패턴.

## outbox-패턴 (outbox pattern)

이벤트를 **비즈니스 연산과 같은 트랜잭션 안에서** DB에 저장했다가 발행해, 신뢰성 있는 발행을 보장하는 producer 쪽 패턴.

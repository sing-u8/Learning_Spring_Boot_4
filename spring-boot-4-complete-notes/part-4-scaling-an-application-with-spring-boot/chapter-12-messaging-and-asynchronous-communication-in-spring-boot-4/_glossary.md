# Messaging and Asynchronous Communication In Spring Boot 4 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## event-driven
시스템의 상태 변경이나 의미 있는 사건(Event)을 중심으로 컴포넌트들이 비동기적으로 반응하며 작동하는 아키텍처 스타일
- 처음 나온 곳: [[01-introducing-asynchronous-and-event-driven-communication]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## broker
발행자와 소비자 사이에서 메시지를 임시 보관하고 라우팅해주어, 양쪽 서비스가 서로의 존재나 생사에 신경 쓰지 않게(Decoupling) 해주는 미들웨어 시스템
- 처음 나온 곳: [[01-introducing-asynchronous-and-event-driven-communication]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## at-least-once
브로커가 소비자의 명시적 수신 확인(ACK)을 받을 때까지 끈질기게 재시도하여 데이터 유실을 0으로 만드는 메시징 전달 전략
- 처음 나온 곳: [[02-understanding-events-messages-and-delivery-semantics]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## idempotency
멱등성. 똑같은 연산(이벤트 처리)을 여러 번 반복해서 수행하더라도, 시스템의 최종 상태는 한 번 수행했을 때와 똑같이 유지되도록 만드는 소비자 측의 필수 설계 원칙
- 처음 나온 곳: [[02-understanding-events-messages-and-delivery-semantics]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## apache-kafka
링크드인(LinkedIn)에서 개발한 분산 이벤트 스트리밍 플랫폼으로, 디스크에 순차 로그를 기록하는 방식을 채택해 엄청난 처리량과 확장성을 자랑한다
- 처음 나온 곳: [[03-exploring-the-fundamentals-of-apache-kafka]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## topic-and-partition
토픽은 이벤트의 주제별 분류함이고, 파티션은 그 분류함을 여러 개로 쪼개어 병렬(Concurrent) 읽기/쓰기를 가능하게 만드는 물리적 조각이다
- 처음 나온 곳: [[03-exploring-the-fundamentals-of-apache-kafka]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## consumer-group
여러 컨슈머 인스턴스를 하나로 묶어 서로 중복 없이 파티션 데이터를 나누어 소비하게 만들고, 인스턴스 장애 시 파티션 할당을 재조정(Rebalance)해주는 그룹 논리
- 처음 나온 곳: [[03-exploring-the-fundamentals-of-apache-kafka]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## kafka-template
JdbcTemplate, RestTemplate처럼 카프카 브로커로 메시지를 안전하게 전송하는 보일러플레이트 코드를 추상화해 둔 스프링의 유틸리티 클래스
- 처음 나온 곳: [[04-building-event-driven-services]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## kafkalistener
빈(Bean) 메서드 위에 달아두면, 지정된 토픽을 백그라운드 스레드에서 무한히 폴링(Polling)하다가 메시지가 오면 해당 메서드를 호출해주는 선언적 컨슈머 애노테이션
- 처음 나온 곳: [[04-building-event-driven-services]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## auto-offset-reset
새로 띄워진 컨슈머 그룹이 카프카에 기존 읽기 이력(커밋된 오프셋)이 없을 때, 토픽의 맨 처음(earliest)부터 읽을지 아니면 지금부터 들어오는 최신(latest) 데이터만 읽을지 결정하는 설정
- 처음 나온 곳: [[04-building-event-driven-services]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## fixed-back-off
일시적인 장애를 극복하기 위해, 실패한 작업을 일정 시간(예: 2초) 고정되게 대기한 후 다시 시도하도록 설정하는 전략
- 처음 나온 곳: [[05-applying-reliability-patterns]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## dead-letter-topic
DLQ(Dead Letter Queue). 아무리 재시도해도 처리에 실패하거나 형식이 깨져 영구적으로 처리 불가능한 '독이 든 메시지(Poison Pill)'를 따로 격리해두는 특수 토픽
- 처음 나온 곳: [[05-applying-reliability-patterns]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## inbox-outbox-pattern
실무에서 멱등성을 보장하기 위해 수신 이력을 DB에 기록하는 Inbox 패턴과, 이벤트를 DB 트랜잭션과 묶어 안전하게 발행하는 Outbox 패턴의 조합
- 처음 나온 곳: [[05-applying-reliability-patterns]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## request-response
클라이언트가 요청을 보내면 서버가 처리를 마친 후 즉시 응답을 돌려줄 때까지 통신 채널이 묶여 있는 전통적인 동기 통신 모델
- 처음 나온 곳: [[06-choosing-between-rest-and-messaging]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## eventual-consistency
비동기 시스템에서 데이터가 모든 서비스에 즉시 똑같이 반영되지는 않지만, 시간이 지나면 "결국에는(Eventual)" 일관된 상태를 맞추게 될 것이라는 분산 데이터베이스 원칙
- 처음 나온 곳: [[06-choosing-between-rest-and-messaging]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

# Chapter 12 용어집

| 용어 | 뜻 |
|---|---|
| Event | domain에서 일어난 business fact |
| Message | event를 운반하는 기술 container |
| Broker | message를 저장하고 consumer에게 전달하는 middleware |
| Topic | Kafka event channel |
| Partition | ordered log이자 Kafka 병렬 처리 단위 |
| Offset | partition 내부 record 위치 |
| Consumer group | partition을 분담하는 consumer 집합 |
| DLT | 반복 실패 message를 격리하는 dead-letter topic |
| Idempotency | 같은 입력을 반복해도 결과 효과가 한 번과 같아지는 성질 |
| Inbox / Outbox | 중복 소비와 발행 누락을 막는 persistent messaging pattern |

---
category: messaging
concept: spring-kafka-producer-consumer
title: "Spring Boot와 Kafka로 이벤트 기반 서비스 만들기"
source: "Learning Spring Boot 4, Ch. 12, pp. 326-336 (PDF pp. 351-361)"
terms: [KafkaTemplate, KafkaListener, JacksonJsonSerializer, JacksonJsonDeserializer]
status: seed
---

# Spring Boot와 Kafka로 이벤트 기반 서비스 만들기

## 한눈에 보기

Employee service는 JPA 저장 후 `KafkaTemplate`로 `EmployeeCreatedEvent`를 발행하고, notification service의 `@KafkaListener`가 이를 비동기로 소비한다. Boot가 connection·listener container를 auto-configure하며 Boot 4/Jackson 3 경로에서는 `JacksonJsonSerializer`·`JacksonJsonDeserializer`를 사용한다.

## 1. 왜 이게 필요한가

이 예제는 producer·broker·consumer 개념을 Spring 코드로 연결한다. Employee 저장이라는 client-facing transaction과 notification이라는 후속 side effect를 분리해, notification 장애가 HTTP 응답에 직접 전파되지 않게 한다.

## 2. 어떻게 동작하는가

Local Kafka는 책에서 Docker Compose의 단일 KRaft node로 띄우며 `localhost:9092`를 노출한다. 애플리케이션은 Spring Web, Spring Data JPA, H2, Spring for Apache Kafka dependency를 사용한다.

```java
Employee saved = repository.save(employee);
var event = new EmployeeCreatedEvent(
    saved.getId(), saved.getName(), saved.getEmail(), LocalDateTime.now());
kafkaTemplate.send("employee-events", saved.getId().toString(), event);
```

Employee ID를 key로 주어 같은 직원 event가 같은 partition으로 가게 한다. Consumer는 다음처럼 선언한다.

```java
@KafkaListener(topics = "employee-events", groupId = "notification-group")
void handleEmployeeCreated(EmployeeCreatedEvent event) {
    sendNotification(event);
}
```

Producer는 String key serializer와 Jackson JSON value serializer를, consumer는 대응 deserializer를 설정한다. 책의 `spring.json.trusted.packages: "*"`는 학습 편의를 위한 값이며 production에서는 허용 package를 application 범위로 좁혀야 한다. `auto-offset-reset: earliest`는 committed offset이 없을 때 처음부터 읽는 정책이지 매번 전체를 다시 읽는 옵션이 아니다.

중요한 빈틈은 DB 저장과 Kafka publish가 한 atomic transaction이 아니라는 점이다. 저장 후 publish 전에 process가 죽으면 event가 누락될 수 있어 production에서는 outbox 같은 패턴을 검토한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    API[EmployeeController] --> S[EmployeeService]
    S --> DB[(Employee DB)]
    S --> KT[KafkaTemplate]
    KT -->|JSON + employeeId key| K[(employee-events)]
    K --> LC[Listener container]
    LC --> KL[@KafkaListener]
    KL --> N[Notification side effect]
```

## 4. 이 노트에 나온 용어

- **KafkaTemplate**: record serialization과 broker 전송을 감싼 Spring Kafka producer abstraction.
- **KafkaListener**: annotated method를 Kafka consumer listener endpoint로 등록하는 annotation.
- **JacksonJsonSerializer**: Boot 4의 Jackson 3 구성과 연동해 object를 Kafka JSON payload로 바꾸는 serializer.
- **JacksonJsonDeserializer**: Kafka JSON payload를 지정 Java type으로 복원하는 Jackson 3용 deserializer.

## 7. 연결

- [[03-apache-kafka-fundamentals]] — topic·key·group·offset의 실행 구조다.
- [[05-reliability-patterns-retries-dlt-idempotency]] — 기본 producer/consumer에 실패 복구를 더한다.
- [[chapter-3-data-persistence-with-spring-data/03-creating-repositories-and-declarative-queries|JPA repository]] — event 발행 전 business state를 저장하는 계층이다.

## 8. 스스로 확인

- 전체 1차 정리 후: HTTP 요청부터 JSON serialization, partition, listener method까지 event 경로를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



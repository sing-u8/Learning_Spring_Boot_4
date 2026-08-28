# 모범답안 — 04b employee service 구현

> **먼저 답하고 나서 열 것.** [[04b-implementing-the-employee-service]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `send`의 세 인자

```java
kafkaTemplate.send("employee-events", saved.getId().toString(), employeeCreatedEvent);
```

| 인자 | **무엇** | **왜** |
|---|---|---|
| `"employee-events"` | **Topic 이름** | 어느 채널로 보낼지 |
| `saved.getId().toString()` | **메시지 키** | **[[03-apache-kafka-fundamentals]]에서 본 대로, 같은 키는 항상 같은 partition으로** 간다 |
| `employeeCreatedEvent` | **payload = 이벤트 자체** | 실제로 전달할 내용 |

**두 번째가 왜 중요한가**: **직원 ID를 키로 쓴다는 것은 같은 직원에 대한 모든 이벤트가 같은 partition으로 가서 순서가 보존된다는 뜻이다.**

> **지금은 생성 이벤트 하나뿐이라 티가 안 나지만, `EmployeeUpdated`·`EmployeeDeleted`가 생기면 이 선택이 결정적이 된다 — 삭제가 생성보다 먼저 처리되면 안 되니까.**

**즉 지금 안 쓰는 보장을 미리 확보해 두는 설계**다. 나중에 이벤트가 늘어도 **키 전략을 바꿀 필요가 없다.**

**`KafkaTemplate`의 제네릭도 의미를 갖는다** — `KafkaTemplate<String, EmployeeCreatedEvent>`는 **키가 `String`, 값이 `EmployeeCreatedEvent`**임을 선언하고, **이 타입이 [[04c-implementing-the-notification-service]]의 소비 쪽 설정과 맞아야** 한다.

**`KafkaTemplate`이 하는 일**: **직렬화와 연결 세부를 뒤에서 처리**해 broker와의 통신을 단순하게 만든다.

---

## Q2. 저장 성공 + 발행 실패 / 그 반대

| 시나리오 | **결과** |
|---|---|
| **저장 성공, 발행 실패** | **직원은 있는데 이벤트가 없다** — **알림이 영영 안 간다** |
| **발행 성공, 이후 트랜잭션 롤백** | **없는 직원에 대한 이벤트가 나갔다** |

**원인: 트랜잭션 경계가 없다.**

> **`save()`와 `send()`가 서로 다른 시스템에 쓰는데 하나의 원자적 단위가 아니다.**

**이것이 이 코드의 가장 큰 문제다.**

**더 나쁜 것은 조용하다는 점이다** — **`send`의 반환값을 버린다.** `KafkaTemplate.send`는 **`CompletableFuture`를 반환해 성공·실패를 알 수 있는데** 이 코드는 무시한다. **발행이 실패해도 `createEmployee`는 성공한 것처럼 `saved`를 반환한다.**

**비유의 깨짐이 이것이다** — **우체국은 접수하면 영수증을 준다.** 이 코드는 **영수증을 버린다.**

**해법**: 책 자신이 **p.341–342 Note에서 outbox 패턴**(= 이벤트를 비즈니스 연산과 같은 트랜잭션 안에 저장하는 producer 쪽 패턴)이 **정확히 이 문제의 해법**이라고 말한다. **그런데 그 Note와 이 코드를 연결하지 않는다** — **멱등성 이야기 끝에 지나가듯 언급될 뿐**이다. [[05b-idempotent-consumers]]에서 다시 만난다.

**§6의 지침**: **저장과 발행을 이 형태로 production에 두지 않는다.** **outbox 패턴이나 최소한 발행 실패 처리를 넣는다.** **`send`의 결과를 버리지 않는다.**

---

## Q3. `StringSerializer`를 고른 근거가 있는 줄

**`saved.getId().toString()`이다.**

```java
kafkaTemplate.send("employee-events", saved.getId().toString(), event);
//                                                  └────┬────┘
//                                         Long 을 String 으로 바꿔 보낸다
```

```yaml
key-serializer: org.apache.kafka.common.serialization.StringSerializer
```

> **직원 ID가 원래 `Long`인데 `toString()`으로 보내므로, 실제 키 타입에 맞춰 `StringSerializer`를 쓴다.**

**`Long`을 그대로 보냈다면 `LongSerializer`가 맞았을 것**이고, **이 둘이 어긋나면 런타임에 실패한다.**

**즉 설정과 코드가 짝이어야 한다** — 그리고 **컴파일러가 잡아 주지 않는다.** `KafkaTemplate<String, ...>`의 제네릭이 힌트를 주지만, **YAML 설정은 타입 검사 밖**이다.

**같은 짝이 소비 쪽에도 있다** — [[04c-implementing-the-notification-service]]의 `key-deserializer: StringDeserializer`. **producer와 consumer가 넷을 맞춰야** 한다(키 직렬화/역직렬화, 값 직렬화/역직렬화).

**§6의 지침**: **키를 아무거나 쓰지 않는다.** **키가 편중되면 특정 partition에 부하가 몰린다.**

---

## Q4. Boot 4에서 `JacksonJsonSerializer`를 써야 하는 이유

**Spring Boot 4가 Jackson 3을 기본 JSON 라이브러리로 쓰기 때문이다.**

> **Spring Kafka가 제공하던 옛 `JsonSerializer`와 `JsonDeserializer`는 이제 deprecated이며 호환성 문제를 낳을 수 있다.**
>
> **제대로 된 통합과 일관된 JSON 처리를 보장하려면 `JacksonJsonSerializer`와 `JacksonJsonDeserializer`를 써야 한다. 이들은 Boot 4의 Jackson 기반 설정과 매끄럽게 동작하도록 설계됐다.**

**실무적 함정**: **인터넷의 Kafka 예제 대부분이 `JsonSerializer`를 쓰고 있으므로, 그대로 복사하면 deprecation 경고나 호환성 문제를 만난다.**

**"일관된 JSON 처리"가 뜻하는 것**: 애플리케이션의 **다른 곳(REST 직렬화)**과 **같은 Jackson 설정**을 쓴다. 안 그러면 **REST에서는 되는 날짜 형식이 Kafka에서는 안 되는** 식의 어긋남이 생긴다 — [[04a-defining-the-event-and-persistence-models]]의 `Instant`/`LocalDateTime` 문제와 같은 층이다.

**producer 설정 전체**:
| 설정 | 하는 일 |
|---|---|
| `bootstrap-servers: localhost:9092` | **Kafka 브로커 주소** |
| `key-serializer: StringSerializer` | Q3 |
| **`value-serializer: JacksonJsonSerializer`** | **`EmployeeCreatedEvent`를 JSON으로** |

**§5의 다른 지적 하나** — **`final`이 빠졌다**: `private EmployeeRepository employeeRepository;`가 나란히 선언된 `kafkaTemplate`과 달리 `final`이 없다. **생성자에서만 대입하므로 `final`이어야 일관된다.** 사소하지만 **같은 클래스 안의 불일치**다.

---

## 재출제 문항

1. `EmployeeDeleted` 이벤트를 추가한다. 키 전략을 바꿔야 하는가?
2. 저장은 됐는데 알림이 안 왔다. 코드의 어느 구조가 원인일 수 있는가?
3. `send`의 반환값을 받아 무엇을 할 수 있는가?
4. 키를 `Long`으로 바꿨다. 무엇을 함께 고쳐야 하는가?
5. producer와 consumer가 맞춰야 하는 설정이 몇 개인가?
6. 인터넷 예제를 복사했더니 deprecation 경고가 난다. 무엇을 바꾸는가?

# 모범답안 — 04c notification service 구현

> **먼저 답하고 나서 열 것.** [[04c-implementing-the-notification-service]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `@KafkaListener` 한 줄이 대신해 주는 저수준 작업

**Kafka를 직접 쓰면 consumer 루프를 우리가 돌려야 한다**:
- **`poll()`을 반복**한다
- **레코드를 꺼낸다**
- **역직렬화한다**
- **오프셋을 커밋한다**
- **리밸런싱을 다룬다**

> **Spring Kafka가 그 전부를 가져간다.**

```java
@KafkaListener(topics = "employee-events", groupId = "notification-group")
public void handleEmployeeCreated(EmployeeCreatedEvent event) { ... }
```

**새 메시지가 발행될 때마다 Spring Kafka가 자동으로 이 메서드를 호출**하고, **메서드는 이미 `EmployeeCreatedEvent` 객체로 역직렬화된 이벤트를 받는다.** **바이트 배열도, JSON 문자열도 아니다.**

**`groupId`가 하는 일**: **여러 인스턴스가 메시지 소비를 나눠 가지고 부하를 분산**하게 한다 — [[03-apache-kafka-fundamentals]]의 **Consumer group이 여기서 코드에 나타난다.**

**구현이 의도적으로 단순하다** — **Kafka로 메시지를 비동기 소비한다는 핵심 개념에 집중하기 위해서**다.

---

## Q2. `auto-offset-reset: earliest`가 적용되는 조건

**커밋된 offset이 없을 때만이다.**

> **이미 커밋된 offset이 있으면 이 설정과 무관하게 거기서 이어 읽는다. "매번 처음부터 읽는다"는 뜻이 아니다.**

```
이 consumer group 이 처음 뜰 때  → earliest: topic 처음부터 / latest: 지금부터
이미 offset 이 있을 때           → 이 설정과 무관하게 그 offset 부터
```

**`earliest`를 고른 이유**: **`latest`였다면 뜨기 전에 발행된 메시지를 전부 건너뛴다.**

**§6의 경고**: **`latest`를 무심코 고르지 않는다.** **배포 중에 발행된 메시지를 놓칠 수 있다.**

**주의 — 그래도 완전한 보장은 아니다**: **새 group-id로 바꾸면** 다시 처음부터 읽어 **모든 이벤트가 재처리**된다. group-id 변경은 **"처음부터 다시"**를 뜻한다.

**consumer 설정 전체**:
| 설정 | 하는 일 |
|---|---|
| `group-id` | **같은 group ID를 가진 모든 인스턴스가 소비를 나눠** 확장성과 부하 분산 |
| **`auto-offset-reset: earliest`** | **topic 처음부터** 읽어 메시지 누락이 없게 |
| `key-deserializer: StringDeserializer` | **키가 문자열이므로**([[04b-implementing-the-employee-service]]) |
| `value-deserializer: JacksonJsonDeserializer` | **들어오는 JSON을 `EmployeeCreatedEvent`로** |
| `spring.json.trusted.packages: "*"` | → Q3 |

---

## Q3. `trusted.packages: "*"`가 취약점 경로인 이유

**신뢰할 수 없는 메시지가 임의의 클래스를 역직렬화하게 허용하기 때문이다.**

> **역직렬화 대상이 되는 클래스의 생성자나 setter가 부수효과를 갖는다면 그것이 실행된다.**

```
공격자가 topic 에 메시지를 넣을 수 있다면
    → 헤더에 임의의 타입 이름을 지정
    → "*" 이므로 신뢰하고 그 클래스를 역직렬화
    → 그 클래스의 생성자·setter 가 실행된다
```

**잘 알려진 취약점 경로**다 — Java 역직렬화 가젯 체인의 Kafka 버전.

**책이 스스로 단서를 단다** — **"더 나은 보안을 위해, 특히 production에서는 애플리케이션의 기본 패키지 같은 특정 패키지로 제한해 예상 밖 클래스의 역직렬화를 막을 수 있다."**

> **그런데 제시된 설정은 그대로 `*`다**(§5). **실제로는 `com.learningspringboot4` 같은 자기 패키지로 좁혀야 한다.**

**§6의 지침**: **`trusted.packages: "*"`를 production에 두지 않는다.**

**이것이 [[02-events-messages-and-delivery-semantics]]의 "이벤트에 민감 정보를 담지 않는다"와 짝을 이룬다** — **발행 쪽과 소비 쪽 모두에 보안 경계**가 필요하다.

---

## Q4. `partitions assigned: [employee-events-0]` 로그

**[[03-apache-kafka-fundamentals]]의 partition 배정 규칙이 실제로 도는 증거다.**

```
partitions assigned: [employee-events-0]
                      └──────┬──────┘└┬┘
                        topic 이름    partition 번호
```

> **`employee-events-0`은 "`employee-events` topic의 partition 0"이라는 뜻이고, 인스턴스가 하나라 그 하나가 전부를 받았다.**

**기동 로그의 세 줄이 각각 확인해 주는 것**:
| 로그 | **확인되는 것** |
|---|---|
| `ConsumerConfig values` | **우리 `application.yml` 설정이 실제로 반영됐다** |
| `Subscribed to topic(s): employee-events` | **브로커에 연결됐고 topic을 구독했다** |
| **`partitions assigned: [...]`** | **partition이 이 인스턴스에 배정됐다** |

**세 줄이 진단 순서이기도 하다** — 설정이 안 먹었나(1) → 연결이 안 됐나(2) → 배정을 못 받았나(3). **메시지가 안 들어올 때 이 순서로 확인**한다.

**인스턴스를 늘리면 이 줄이 달라진다** — 두 번째 인스턴스가 뜨면 **리밸런싱**이 일어나고 배정이 갈린다. [[03-apache-kafka-fundamentals]]의 Q1이 그 규칙이다.

**§5·§6의 나머지 경계**:
- **producer와 consumer가 같은 프로세스에 있다** — **학습에는 편하지만 실제 이벤트 주도 아키텍처의 모습이 아니다.** **두 서비스가 같은 프로세스라면 애초에 Kafka가 필요 없다**
- **리스너 메서드에서 오래 걸리는 작업을 하지 않는다** — **그 partition의 다음 메시지가 밀린다**
- **리스너에서 예외가 나면?** — **이 코드만 봐서는 알 수 없다.** 기본 동작과 그것을 바꾸는 방법이 [[05-reliability-patterns-retries-dlt-idempotency]]의 내용이다

**그리고 endpoint가 [[01-asynchronous-and-event-driven-communication]]의 그림에서 4번**이다 — **클라이언트는 여기서 응답을 받고 끝난다.**

---

## 재출제 문항

1. `@KafkaListener` 없이 직접 구현한다면 무엇을 써야 하는가?
2. 리스너 메서드가 JSON 문자열이 아니라 객체를 받는다. 누가 변환했는가?
3. `auto-offset-reset: latest`로 바꿨다. 언제 문제가 되는가?
4. group-id를 바꿨더니 모든 이벤트가 재처리됐다. 왜인가?
5. `trusted.packages`를 `*`로 두면 어떤 공격이 가능한가?
6. 메시지가 안 들어온다. 기동 로그의 어느 줄을 어떤 순서로 보는가?

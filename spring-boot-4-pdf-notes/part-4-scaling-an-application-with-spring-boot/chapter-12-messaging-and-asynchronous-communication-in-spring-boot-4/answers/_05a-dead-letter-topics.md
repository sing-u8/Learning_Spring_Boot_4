# 모범답안 — 05a Dead Letter Topic

> **먼저 답하고 나서 열 것.** [[05a-dead-letter-topics]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. DLT가 동시에 달성하는 두 가지

> **DLT는 성공적으로 처리할 수 없었던 메시지의 격리 구역 역할을 한다.**

- **메인 consumer 흐름은 계속된다** — **막힌 메시지를 치웠으니 뒤가 흐른다**
- **문제 메시지는 나중 조사를 위해 보존된다** — **버리지 않는다**

> **이 둘을 동시에 얻는 것이 DLT의 존재 이유다.**

**푸는 문제**: **메시지 하나 때문에 전체 소비가 멈추는 상태 — poison pill.**

[[05-reliability-patterns-retries-dlt-idempotency]]의 **영구적 실패**에 반복 재시도는 **자원만 낭비하고, 더 나쁘게는 그 partition의 뒤 메시지를 계속 막는다.**

**둘 중 하나만 하는 대안과 비교하면 가치가 보인다**:
```
메시지를 버린다:        흐름은 계속된다. 그런데 무엇이 실패했는지 모른다
계속 재시도한다:        보존은 된다. 그런데 뒤가 영영 막힌다
DLT:                    둘 다
```

**이름 규칙**: **Spring Kafka는 기본적으로 `DeadLetterPublishingRecoverer`로 재시도 후에도 실패한 레코드를 원래 topic 이름에 `-dlt` 접미를 붙인 topic으로 재발행**한다. `employee-events` → **`employee-events-dlt`**.

---

## Q2. `DefaultErrorHandler(recoverer, fixedBackOff)`의 인자 순서

> **먼저 재시도, 그다음 복구. 3회가 모두 실패해야 DLT로 간다.**

```java
FixedBackOff fixedBackOff = new FixedBackOff(2000L, 3L);
DeadLetterPublishingRecoverer recoverer = new DeadLetterPublishingRecoverer(kafkaTemplate);
return new DefaultErrorHandler(recoverer, fixedBackOff);
```

| 조각 | 하는 일 |
|---|---|
| `FixedBackOff(2000L, 3L)` | **2초 간격 3회 재시도** |
| `DeadLetterPublishingRecoverer(kafkaTemplate)` | **실패 레코드를 주어진 `KafkaTemplate`으로 DLT에 발행** |
| `DefaultErrorHandler(recoverer, fixedBackOff)` | **재시도 후에도 실패하면 recoverer를 부른다** |

**[[05-reliability-patterns-retries-dlt-idempotency]]의 설정과 딱 한 가지가 다르다 — recoverer가 하나 더 들어갔다.**

**Q2의 설계적 의미**: **재시도와 복구가 조합된다.** **일시적 실패는 재시도가 흡수하고, 그것을 넘기면 영구적으로 판정해 DLT로** 보낸다. **즉 "3회 재시도해도 안 되면 영구적"이라는 휴리스틱**이다.

**`KafkaTemplate<Object, Object>`인 것도 눈여겨볼 만하다** — **DLT에는 어떤 타입의 실패 메시지든 올 수 있으므로 구체 타입을 못 박지 않는다.**

**얻는 것**: **실패 메시지가 소비를 막지 않으면서 분석이나 재처리를 위해 보존된다.**

---

## Q3. DLT 리스너를 `ConsumerRecord<String, byte[]>`로 받는 이유

| 상황 | **`EmployeeCreatedEvent`로 받으면** |
|---|---|
| **역직렬화는 성공했고 이후 애플리케이션 처리에서 실패** (알림 발송 실패 등) | **잘 동작한다** |
| **잘못된 JSON·비호환 스키마·예상 밖 포맷으로 역직렬화 자체가 실패** | **DLT 리스너도 같은 이유로 실패한다** |

> **두 번째 경우 DLT에는 원본 raw payload가 담길 수 있다. 그래서 `ConsumerRecord<String, byte[]>`로 소비하는 것이 더 안전하다 — 원본 바이트를 들여다보고 실패 원인을 진단할 수 있기 때문이다.**

**이 판단이 중요한 이유**: **DLT 리스너가 실패하면 갈 곳이 없다. DLT의 DLT를 만들 수는 없다.**

**`ConsumerRecord`가 함께 주는 것**: **topic·partition·offset·key·value.** 원본 위치를 알아야 **재생**할 수 있다.

**`groupId`가 `notification-dlt-group`으로 원래 그룹과 다른 것도 의도적이다** — **DLT는 별개의 소비 흐름**이다.

**비유의 깨짐이 이것이다** — **짐은 열어 보면 내용을 알 수 있지만 역직렬화가 실패한 메시지는 열 수 없다.** 그래서 **`byte[]`로 받아 원본 바이트를 본다.**

**§6의 지침**: **DLT 리스너에서 다시 원래 처리를 시도하지 않는다.** **무한 루프가 된다.**

---

## Q4. Figure 12.6의 payload에서 실패 원인 읽기

**`"email":null`이 그대로 보인다.**

```json
{"employeeId":1,"name":"Alice Johnson","email":null,"createdAt":"..."}   (93 bytes)
```

| 위치 | **보이는 것** | **뜻** |
|---|---|---|
| 좌측 트리 | `employee-events`와 **`employee-events-dlt`** | **DLT가 자동으로 생성됐다. 우리가 만들지 않았다** |
| 우측 상단 | offset `0`, key `1`, value에 JSON | **메시지가 실제로 DLT에 들어왔다** |
| **하단 payload** | **`"email":null`** | **실패 원인이 payload에 그대로 남아 있다** |

> **`email`이 `null`인 것이 눈에 보이므로, 왜 실패했는지 바로 알 수 있고 교정 후 재생할 수 있다.**

**DLT가 자동 생성된 것도 짚어 둘 지식이다**(§5) — **Kafka의 `auto.create.topics.enable`이 켜져 있어 가능한 것**이고, **production에서는 이 설정이 꺼져 있을 수 있다** — **그러면 DLT를 미리 만들어 둬야 한다**(§6).

**실무에서 DLT consumer가 할 일**: **실패 이벤트를 운영 검토용으로 저장 / 알림 발생 / 관측 도구에 실패 노출 / 교정 후 재생 지원.**

> **이것이 DLT가 가치 있는 이유다 — 메인 처리 흐름을 끊지 않으면서 회복 가능한 실패와 불가능한 실패를 분리한다.**

**비유의 다른 깨짐**: **공항은 누군가 그 구역을 정기적으로 살펴보지만, DLT는 아무도 안 보면 그냥 쌓인다** — **그래서 알림과 관측이 목록에 들어 있는 것**이다. **§6: DLT를 만들어 두고 방치하지 않는다.**

**용어 주의**(§5): **이 장의 제목과 목차는 DLQ(dead-letter queue)를 쓰는데 본문은 DLT(dead-letter topic)를 쓴다.** **Kafka에는 queue가 아니라 topic이 있으므로 본문 쪽이 정확하다** — [[03-apache-kafka-fundamentals]]의 **Commit log**이고 **DLT의 메시지도 읽어도 사라지지 않는다.**

---

## 재출제 문항

1. poison pill 상태가 무엇이고 DLT가 어떻게 푸는가?
2. `DefaultErrorHandler`에 recoverer만 주고 backOff를 안 주면?
3. DLT 리스너를 `EmployeeCreatedEvent`로 받았다. 어떤 실패에서 문제가 되는가?
4. DLT 리스너가 실패하면 어디로 가는가?
5. production에 배포했더니 DLT가 안 생긴다. 무엇을 확인하는가?
6. DLT에 메시지가 쌓이고 있는데 아무도 모른다. 무엇이 빠졌는가?

# 모범답안 — 04 이벤트 주도 서비스 만들기

> **먼저 답하고 나서 열 것.** [[04-building-event-driven-services]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `KAFKA_PROCESS_ROLES: broker,controller`와 `CLUSTER_ID`

**KRaft 모드의 표시다.**

**KRaft**: **Zookeeper 없이 Kafka 자신이 메타데이터를 관리하는 모드.**

> **예전 Kafka는 메타데이터 관리에 Zookeeper가 필요했지만, KRaft에서는 Kafka 노드 자신이 controller 역할을 겸한다. 그래서 이 compose 파일에 Zookeeper 서비스가 없다.**

**"이 노드가 무엇인가" 묶음**:
| 변수 | 뜻 |
|---|---|
| `KAFKA_NODE_ID: 1` | **이 노드의 고유 식별자** |
| **`KAFKA_PROCESS_ROLES: broker,controller`** | **이 노드가 Broker이자 controller** |
| **`CLUSTER_ID`** | **클러스터의 고유 식별자** |

**`KAFKA_CONTROLLER_QUORUM_VOTERS: 1@kafka:29093`도 같은 묶음**이다 — **ID 1인 단일 controller가 `kafka:29093`에서 듣는다.**

**이 사실이 Q4의 함정으로 이어진다** — **Zookeeper가 없는데 Figure 12.5의 화면은 Zookeeper 설정을 보여 준다.**

---

## Q2. `LISTENERS`와 `ADVERTISED_LISTENERS`가 둘 다 필요한 이유

**컨테이너 안팎의 주소가 다르기 때문이다.**

| 변수 | **뜻** |
|---|---|
| **`KAFKA_LISTENERS`** | **Kafka가 연결을 받는 내부·외부 endpoint** — "내가 어디서 듣는가" |
| **`KAFKA_ADVERTISED_LISTENERS`** | **클라이언트가 연결할 때 쓸 주소** — "클라이언트에게 어디로 오라고 알릴까" |

```
컨테이너 안:  kafka:29092
컨테이너 밖:  localhost:9092
        ↓
브로커가 클라이언트에게 "나한테 오려면 이 주소로 와"라고 알려 주는 것이 ADVERTISED_LISTENERS
```

> **이 둘이 어긋나면 연결은 되는데 이후 통신이 실패하는 전형적인 Kafka 함정이 생긴다.**

**왜 그런 증상인가**: **첫 연결(bootstrap)은 우리가 준 주소로 가지만**, 그다음 **브로커가 "실제 리더는 이 주소다"라고 돌려주는 값이 `ADVERTISED_LISTENERS`**다. 그것이 잘못되면 **연결은 성공하고 이후 produce/consume이 실패**한다.

**§6의 경고**: **`ADVERTISED_LISTENERS`를 대충 두지 않는다.** **Kafka 연결 문제의 대부분이 여기서 온다.**

**함께 있는 변수들**: `KAFKA_INTER_BROKER_LISTENER_NAME`(브로커 간 통신), `KAFKA_CONTROLLER_LISTENER_NAMES`(controller 통신), `ports: 9092:9092`(호스트 노출).

---

## Q3. `REPLICATION_FACTOR: 1`이 드러내는 성격

**브로커가 하나라 복제가 불가능하다 — 로컬 학습용 구성이다.**

> **production에서는 이 값이 최소 3이다.**

**뜻하는 것**: **브로커가 죽으면 데이터가 사라진다.** **[[03-apache-kafka-fundamentals]]가 말한 "복제를 통한 내결함성"이 이 구성에는 없다.**

**같은 성격의 다른 표시들**:
| 설정 | 로컬 전용임을 드러내는 이유 |
|---|---|
| `KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: …PLAINTEXT` | **전부 PLAINTEXT — 암호화도 인증도 없다.** **로컬 개발을 단순하게 유지하려는 것** |
| `KAFKA_CONTROLLER_QUORUM_VOTERS: 1@…` | **단일 controller** |
| `KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1` | 복제 없음 |

**§6의 경고**: **이 compose 파일을 production에 쓰지 않는다.** **브로커 1대, 복제 없음, 인증 없음.** **PLAINTEXT는 로컬 전용이고 production에서는 SASL/SSL을 쓴다.**

**비유의 깨짐이 이것이다** — **진짜 우체국은 지점이 여럿이라 하나가 멈춰도 되지만 이 구성은 브로커가 하나**다.

---

## Q4. Figure 12.5를 그대로 따라 하면 막히는 이유

**화면이 Zookeeper 연결을 설정하는데 이 구성에는 Zookeeper가 없다.**

> **책 p.328의 연결 설정 화면에는 `Enable Zookeeper access`가 체크되고 Port `2181`이 설정돼 있으며 `Kafka Cluster Version`이 `0.11`로 잡혀 있다. 그런데 이 장의 `docker-compose.yml`은 KRaft 모드라 Zookeeper가 아예 없고, 이미지는 `cp-kafka:7.8.8`이다.**

**세 가지가 어긋난다**:
| 화면 | 실제 구성 |
|---|---|
| **Zookeeper access 체크, port 2181** | **Zookeeper 없음** (KRaft, Q1) |
| **Cluster Version `0.11`** | **`cp-kafka:7.8.8`** |
| — | Bootstrap `localhost:9092`, PLAINTEXT |

> **본문이 설명하는 세 항목(Cluster Name·Bootstrap Servers·Security)은 이 불일치를 언급하지 않는다. 화면을 그대로 따라 하면 Zookeeper 연결에서 막힌다.**

**올바른 설정**: **Zookeeper access를 끄고, Bootstrap Servers에 `localhost:9092`, Security는 PLAINTEXT**, 클러스터 버전은 이미지에 맞춘다.

**§6의 지침**: **Offset Explorer 화면을 그대로 따라 하지 않는다.**

**이 도구 자체는 선택 사항**이지만 **애플리케이션을 만드는 동안 이벤트가 시스템을 어떻게 흐르는지에 대한 가시성**을 준다 — [[01a-core-components-of-event-driven-systems]]에서 **"흐름 추적이 어려워진다"**고 한 문제에 대한 **가장 소박한 대응**이다.

**함께 알아 둘 것 — 새 의존성은 하나뿐이다**: **Spring for Apache Kafka**가 **`KafkaTemplate`**(발행)과 **`@KafkaListener`**(소비) 두 추상을 주고, **Spring Boot가 필요한 인프라 대부분을 auto-configure**한다. **연결 관리, 직렬화 배선, consumer 폴링 루프를 우리가 쓰지 않는다** — 그것이 이 장의 나머지가 짧은 이유다.

---

## 재출제 문항

1. compose 파일에 Zookeeper가 없다. 어떻게 가능한가?
2. Kafka에 연결은 되는데 produce가 실패한다. 어느 설정을 의심하는가?
3. 컨테이너 안과 밖의 주소가 같다면 `ADVERTISED_LISTENERS`가 필요한가?
4. 이 구성에서 브로커가 죽으면 데이터는?
5. Offset Explorer로 연결하려는데 계속 실패한다. 무엇을 끄는가?
6. Spring for Apache Kafka가 없다면 우리가 직접 써야 할 것 세 가지는?

# 모범답안 — 03a 로깅 인프라 세우기

> **먼저 답하고 나서 열 것.** [[03a-setting-up-the-logging-infrastructure]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 4317과 4318

**같은 OTLP의 두 전송 방식이다** — **4317은 gRPC, 4318은 HTTP.**

> **두 포트를 다 여는 이유가 있다. 같은 OTLP라도 전송 방식이 둘이고, 클라이언트마다 편한 쪽이 다르다. 이 장의 애플리케이션은 HTTP(4318)를 쓴다.**

**"4317과 4318 중 하나만 열면 된다"**(§5) — **클라이언트가 어느 쪽을 쓸지에 달렸다.** **둘 다 열어 두면 선택의 여지가 생긴다.**

**세 서비스와 포트**:
| 서비스 | 포트 | 역할 |
|---|---|---|
| **Loki** | **3100** | 로그 저장·색인. **Collector가 push하고 Grafana가 질의** |
| **Collector** | **4317, 4318** | 텔레메트리 수신·가공·전달 |
| **Grafana** | **3000** | 시각화 |

**볼륨 마운트**가 두 곳에 있고 **`:ro`는 읽기 전용**이다 — **이미지를 다시 만들지 않고 설정만 바꿔 재시작**할 수 있다.

**`depends_on`은 기동 순서를 정한다** — **"컨테이너가 시작됐다"까지만 보장하고 "서비스가 요청을 받을 준비가 됐다"를 보장하지는 않는다**(§5·§6). [[../../part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/04c-running-the-setup-with-docker-compose|Ch7]]에서 본 그 성질이다.

> **원문 오류**: grafana의 볼륨 경로가 **`/etc/grafana/provisioning//datasources/datasources.yml`로 슬래시가 중복**돼 있고, **마지막 `depends_on:` 아래 항목이 잘려 있다.**

---

## Q2. Collector 설정의 네 부분

| 부분 | **답하는 질문** | **이 설정에서** |
|---|---|---|
| **리시버** | **어떻게 받나** | **OTLP를 gRPC·HTTP 양쪽으로** |
| **프로세서** | **무엇을 바꾸나** | **리소스 속성 추가 + 배칭** |
| **익스포터** | **어디로 보내나** | **Loki + 콘솔** |
| **파이프라인** | **어떻게 잇나** | **logs 파이프라인 하나** |

**이 구조가 [[02-designing-an-observability-architecture]]의 네 이유를 코드로 구현한 것이다** — **배칭(`batch`), 필터링(프로세서), 강화(`resource`), 라우팅(`exporters`).**

**§6의 경계**: **Collector 설정 파일이 계속 자라난다.** **이 절에서는 logs 파이프라인 하나지만 [[04a-setting-up-prometheus-for-metrics]]와 [[05a-setting-up-grafana-tempo]]에서 metrics·traces가 더해진다.**

---

## Q3. `0.0.0.0`으로 바인딩하는 이유

**컨테이너 안에서 모든 네트워크 인터페이스로 들어오는 요청을 받기 위해서다.**

> **`localhost`로 두면 컨테이너 밖에서 도달할 수 없다.**

```
localhost (127.0.0.1):  컨테이너 자신의 루프백만 → 밖에서 못 온다
0.0.0.0:                모든 인터페이스 → 포트 매핑을 통해 호스트에서 온다
```

**[[../../part-4-scaling-an-application-with-spring-boot/chapter-12-messaging-and-asynchronous-communication-in-spring-boot-4/04-building-event-driven-services|Ch12]]의 Kafka `ADVERTISED_LISTENERS` 문제와 같은 층이다** — **컨테이너 안과 밖의 네트워크 관점이 다르다.**

**[[../../part-4-scaling-an-application-with-spring-boot/chapter-9-writing-reactive-web-controllers/06-building-reactive-hypermedia-apis|Ch9]]에서도** 컨테이너 안 `localhost`가 자기 자신을 가리킨다는 성질이 나왔다. **같은 함정이 반복된다.**

---

## Q4. `loki.resource.labels`가 다른 두 항목과 다른 점

| key | action | **하는 일** |
|---|---|---|
| `service.name` | `upsert` | **메타데이터를 붙인다**(있으면 덮고 없으면 추가) |
| `deployment.environment` | `upsert` | 배포 환경 표시 |
| **`loki.resource.labels`** | **`insert`** | **앞의 두 속성을 Loki의 색인 라벨로 승격하라는 지시** |

**성격의 차이**: **앞의 둘은 데이터**(무엇을 붙일지), **세 번째는 지시**(그중 무엇을 색인할지)다.

**"리소스 속성을 추가하면 자동으로 라벨이 된다"는 오해다**(§5) — **되지 않는다.** **`loki.resource.labels`에 명시한 것만 승격된다.**

**왜 자동이 아닌가** → Q5.

**`action`이 다른 것도 의미가 있다** — `upsert`는 **덮어쓰기 허용**(우리가 정한 값이 이겨야 한다), `insert`는 **이미 있으면 두기**(설정 지시는 중복 적용할 필요가 없다).

---

## Q5. 승격할 라벨을 두 개만 고른 것이 판단인 이유

**라벨 조합마다 스트림이 하나씩 생기기 때문이다.**

> **"라벨은 많을수록 좋다" — 반대다. 라벨 조합마다 스트림이 생기므로 고유 값이 많은 속성을 올리면 Loki가 무너진다.**

```
service.name (3개) × deployment.environment (2개) = 스트림 6개   ← 감당 가능
+ requestId (요청마다 다름)                       = 스트림 수백만 ← 무너진다
```

**[[03-structured-logging-with-loki-and-grafana]]의 "라벨만 색인한다"는 선택의 대가가 여기 있다** — **색인이 싸진 대신 색인 대상을 신중히 골라야** 한다.

**고르는 기준**: **값의 가짓수가 적고**(카디널리티가 낮고), **질의에서 범위를 좁히는 데 쓰는** 속성. `service.name`과 `deployment.environment`가 둘 다 만족한다.

**본문 검색으로 충분한 것은 라벨로 올리지 않는다** — [[03c-verifying-logs-in-grafana]]의 `|= "employee"`가 그 자리다.

---

## Q6. `access: proxy`가 아니면

**브라우저가 `http://loki:3100`을 해석하지 못한다.**

> **브라우저가 직접 `http://loki:3100`에 접근한다면 그 이름은 브라우저 쪽에서 해석되지 않는다. Docker 네트워크 안의 이름이기 때문이다. Grafana 서버가 대신 요청하므로 컨테이너 이름이 통한다.**

| 항목 | **뜻** |
|---|---|
| **`access: proxy`** | **브라우저가 아니라 Grafana 서버가 Loki에 요청한다** |
| `url: http://loki:3100` | **컨테이너 이름으로 접근** — Docker 네트워크 안의 이름 |
| `isDefault: true` | Explore를 열면 자동 선택 |
| `editable: true` | UI에서 나중에 고칠 수 있다 |

**Q3의 문제와 같은 뿌리다** — **컨테이너 이름은 Docker 네트워크 안에서만 유효**하다.

**데이터소스 프로비저닝**: **Grafana가 기동할 때 설정 파일을 읽어 데이터 소스를 자동 등록하는 것.**

**실질적 이점**: **스택을 띄울 때마다 손으로 설정할 필요가 없다.** **팀원이 저장소를 받아 `docker compose up` 한 번이면 같은 환경이 선다.**

---

## Q7. `debug` 익스포터가 진단에 쓰이는 상황

**Grafana에 로그가 안 보일 때 "어디까지 왔는지"를 가른다.**

```
애플리케이션 → Collector → Loki → Grafana

debug 익스포터가 콘솔에 찍힌다  → Collector 까지는 왔다 → Loki 또는 Grafana 문제
아무것도 안 찍힌다              → 애플리케이션이 안 보내고 있다
```

> **`debug` 익스포터는 지워도 동작하지만, 파이프라인이 도는지 확인할 수단을 잃는다. 로컬 개발에서는 남겨 두는 편이 낫다.**

**`exporters: [loki, debug]`처럼 둘을 나란히 두면 같은 데이터가 양쪽으로 간다** — **하나는 저장용, 하나는 확인용**이다.

**이것이 관측 파이프라인 자체를 관측하는 방법**이다. **파이프라인이 고장 나면 그 고장을 알려 줄 신호도 함께 사라지므로**, 별도의 확인 경로가 필요하다.

---

## Q8. 컨베이어 라인 비유가 깨지는 지점

**비유**: Collector 설정은 **"공장의 컨베이어 라인"** — **투입구(리시버), 가공 공정(프로세서), 출하구(익스포터)가 벨트(파이프라인)로 이어진다.**

**깨지는 지점**: **같은 물건이 여러 출하구로 동시에 나간다는 점을 담지 못한다.**

> **`exporters: [loki, debug]`처럼 하나의 파이프라인이 복수의 목적지로 복제해서 보낸다. 공장이라기보다 방송에 가까운 구조다.**

```
공장:  물건 하나 → 출하구 하나 (배분)
방송:  신호 하나 → 모든 수신기 (복제)
```

**Q7의 진단 방법이 이 성질에 의존한다** — **복제되므로** debug 출력이 **Loki로 가는 데이터와 같은 것**임이 보장된다. 배분이었다면 **샘플만 보는 셈**이라 진단 근거가 약해진다.

**비유가 맞는 부분은 남는다** — **단계가 순서대로 이어지고 각 단계가 한 가지 일을 한다**(Q2). 깨지는 것은 **출력의 분기 방식**이다.

**§6의 경계**: **이 구성은 로컬 개발용이다** — **Grafana 자격 증명이 `admin/admin`이고 Loki가 단일 노드 로컬 설정**이다.

---

## 재출제 문항

1. 클라이언트가 gRPC만 지원한다. 어느 포트를 여는가?
2. Collector 설정에 metrics를 추가하려면 네 부분 중 무엇이 늘어나는가?
3. Collector를 `localhost:4318`로 바인딩했다. 무슨 일이 생기는가?
4. `service.name` 속성을 추가했는데 Loki에서 라벨로 안 보인다. 왜인가?
5. `requestId`를 라벨로 올렸다. 어떤 규모의 문제가 생기는가?
6. Grafana 데이터소스 URL을 `http://localhost:3100`으로 바꿨다. 되는가?
7. Grafana에 로그가 안 보인다. 어디까지 왔는지 어떻게 가르는가?
8. `exporters: [loki, debug]`가 배분이 아니라 복제인 것이 왜 중요한가?

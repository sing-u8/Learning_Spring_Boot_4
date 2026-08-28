# 모범답안 — 04a 메트릭용 Prometheus 설정

> **먼저 답하고 나서 열 것.** [[04a-setting-up-prometheus-for-metrics]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다.

---

## Q1. 방향이 뒤집히는 지점

**Collector → Prometheus 구간이다.**

```
로그:    앱 --push--> Collector --push--> Loki
메트릭:  앱 --push--> Collector <--pull-- Prometheus
                                 ↑ 여기서 뒤집힌다
```

> **Prometheus는 데이터를 받지 않는다. 가지러 온다.**

**스크레이프**: **Prometheus가 대상의 메트릭 엔드포인트를 주기적으로 긁어 오는 동작.** **대상이 보내는 게 아니라 Prometheus가 가지러 간다.**

**두 모델이 만나는 지점이 9464 포트다** — Collector가 **왼쪽에서는 OTLP를 push로 받고, 오른쪽에서는 Prometheus 형식으로 노출해 pull당한다**(Q3).

**"Prometheus가 애플리케이션을 직접 긁는다"는 오해다**(§5) — **이 구성에서는 Collector를 긁는다.** **애플리케이션은 Collector로 push한다.**

---

## Q2. pull 모델의 이점

**① 대상이 죽었다는 사실 자체가 정보다.**
> **수집기가 대상 목록을 알고 있으므로 어떤 대상이 응답하지 않는지 곧바로 알 수 있다.**

push 모델에서는 **"안 보내는 것"과 "죽은 것"을 구분할 수 없다.**

**② 수집 주기를 수집기 쪽에서 일괄 조절할 수 있다.**

push라면 **모든 애플리케이션의 설정을 고쳐야** 주기가 바뀐다.

**대가**(§6): **pull 모델은 방화벽을 탄다.** **Prometheus가 대상에 접근할 수 있어야 하므로, 네트워크 경계를 넘는 구성에서는 push gateway 같은 우회가 필요하다.**

**그리고 `static_configs`는 대상이 고정일 때만 쓴다** — **인스턴스가 늘고 주는 환경에서는 서비스 디스커버리가 필요하다.**

---

## Q3. Collector가 "번역기"라는 뜻

**두 수집 모델 사이를 잇는다.**

```
왼쪽(입구):   OTLP push 로 받는다        ← 애플리케이션의 방식
오른쪽(출구): Prometheus 형식으로 노출   ← Prometheus 의 방식
              9464 포트에서 기다린다
```

**형식과 방향을 동시에 바꾼다** — **OTLP → Prometheus 형식**(형식), **push → pull**(방향).

**"익스포터니까 어디론가 보낸다"는 오해다**(§5) — **Prometheus 익스포터는 포트를 열고 기다린다.** **이름과 동작이 어긋나는 드문 경우다** → Q5.

**이 번역 덕분에 애플리케이션은 Prometheus를 모른다** — [[02-designing-an-observability-architecture]]의 **"결합을 한 지점으로 모은다"**가 여기서 값을 낸다. 시계열 DB를 바꿔도 **애플리케이션은 그대로 OTLP push**다.

**컨테이너 설정**: `depends_on: otel-collector`가 로그 때(`depends_on: loki`)와 **방향이 같다** — **데이터 출처가 먼저 떠야 한다.** **Prometheus에게 Collector는 스크레이프 대상이므로 출처다.**

---

## Q4. `resource` 프로세서를 재사용하는 것

**메트릭에도 `service.name`·`deployment.environment` 같은 리소스 속성이 붙는다.**

```yaml
pipelines:
  logs:    { receivers: [otlp], processors: [resource, batch], exporters: [loki] }
  metrics: { receivers: [otlp], processors: [resource, batch], exporters: [prometheus] }
                                            └───┬───┘
                                        같은 프로세서를 재사용
```

**나중에 가능해지는 것**: **로그와 메트릭이 같은 `service.name`을 갖는다** → **[[06-correlating-logs-metrics-and-traces]]에서 두 신호를 같은 서비스로 묶을 수 있다.**

**[[03b-instrumenting-the-application-for-logging]]의 `service.name: ${spring.application.name}`과 짝을 이룬다** — **애플리케이션에서 한 번 선언하고, Collector에서 모든 파이프라인이 같은 프로세서를 쓴다.** 어긋날 여지가 두 번 줄어든다.

**구조가 [[03a-setting-up-the-logging-infrastructure]]와 같다** — **익스포터 하나와 파이프라인 하나를 더한다.** receivers는 **`[otlp]`로 동일**하다.

---

## Q5. Prometheus 익스포터가 다른 익스포터와 다른 점

**보내지 않고 포트를 열어 기다린다.**

| | 일반 익스포터(loki, debug) | **Prometheus 익스포터** |
|---|---|---|
| 동작 | **목적지로 push** | **`0.0.0.0:9464`에서 노출하고 대기** |
| 설정 항목 | `endpoint`(보낼 주소) | **`endpoint`(열 주소)** |
| 이름과 동작 | 일치 | **어긋난다** |

> **이름과 동작이 어긋나는 드문 경우다.**

**혼동하기 쉬운 이유**: 같은 `endpoint` 키인데 **의미가 반대**다. loki는 **"이 주소로 보내라"**, prometheus는 **"이 주소에서 열어라"**.

**`0.0.0.0`인 것도 그래서다** — [[03a-setting-up-the-logging-infrastructure]]의 리시버와 같은 이유로, **컨테이너 밖에서 도달할 수 있게** 모든 인터페이스에 바인딩한다. **보내는 쪽이라면 이 값이 의미가 없다.**

**"9464도 호스트에서 열려 있다"는 오해다**(§5) — **`docker-compose.yml`에 노출 설정이 없어 컨테이너 네트워크 안에서만 보인다.** Prometheus 컨테이너가 같은 네트워크에 있으므로 **그것만 접근한다.**

---

## Q6. `step`과 `scrape_interval`이 어긋나면

| 상황 | **결과** |
|---|---|
| **`step` < `scrape_interval`** | **Prometheus가 긁기 전에 값이 여러 번 갱신된다 — 중간값이 사라진다** |
| **`step` > `scrape_interval`** | **Prometheus가 같은 값을 여러 번 긁는다 — 저장 낭비** |
| **같음** | **대체로 1:1 대응** |

| 설정 | 뜻 |
|---|---|
| `step: 5s` | **앱이 Collector로 내보내는 주기** |
| `scrape_interval: 5s` | **Prometheus가 Collector를 긁는 주기** |

> **둘 다 5초인 것은 우연이 아니라 맞춘 것이다.**

**"아무 값이나 된다"는 오해다**(§5) — **어긋나면 값이 사라지거나 중복 저장된다. 맞추는 것이 기본이다.**

**§6의 경계**: **`5s`는 로컬용이다.** **운영에서 이렇게 짧으면 시계열 저장량과 부하가 크다. 보통 15–60초를 쓴다.** 그리고 **[[04-metrics-with-micrometer-prometheus-and-grafana]]의 Q6대로 주기가 길수록 짧은 스파이크를 놓친다.**

**`job_name`도 그냥 이름이 아니다** — **메트릭에 `job` 라벨로 붙는다.** [[04c-verifying-metrics-in-prometheus-and-grafana]]의 질의 결과에 `job="otel-collector"`가 나온다.

---

## Q7. 이 구성에서 `/actuator/metrics`의 역할

**사람이나 도구가 직접 조회하는 엔드포인트일 뿐, 파이프라인과 무관하다.**

> **`/actuator/metrics`를 여는 것과 OTLP 내보내기는 별개다.** **앞은 사람이나 도구가 직접 조회하는 엔드포인트이고, 뒤는 파이프라인으로 나가는 경로다.** **이 예제의 Prometheus는 Actuator가 아니라 Collector를 긁는다.**

```
/actuator/metrics  →  브라우저·curl 로 직접 확인
OTLP export        →  Collector → Prometheus  ← 실제 파이프라인
```

**"`/actuator/metrics`를 열어야 Prometheus가 볼 수 있다"는 오해다**(§5) — **이 구성에서는 무관하다.**

**다른 구성에서는 관계가 있을 수 있다** — Actuator의 Prometheus 엔드포인트를 직접 스크레이프하는 방식도 흔하다. **이 장은 Collector를 거치는 쪽을 택했다.**

**[[03b-instrumenting-the-application-for-logging]]에서 꺼 뒀던 것을 이제 켠다**:
| 설정 | 하는 일 |
|---|---|
| `exposure.include`에 `metrics` 추가 | Actuator 엔드포인트를 연다 |
| `otlp.metrics.export.enabled: true` | **OTLP 메트릭 내보내기 켜기** |
| `otlp.metrics.export.url` | **`/v1/metrics`** — 로그의 `/v1/logs`와 **경로만 다르다** |
| `step: 5s` | 5초마다 Collector로 |

---

## Q8. 우편함/게시판 비유가 깨지는 지점

**비유**: Collector의 두 얼굴은 **"우편함이자 게시판"** — **한쪽에서는 편지를 받고(push), 다른 쪽에서는 붙여 둔 것을 누가 와서 읽어 간다(pull).**

**깨지는 지점**: **게시판의 내용이 계속 갱신된다는 점을 흐린다.**

> **실제로 Prometheus가 긁어 가는 것은 "그 순간의 누적값"이고, 긁지 않은 사이의 변화 과정은 남지 않는다. 게시물이 쌓이는 게 아니라 하나가 계속 고쳐 쓰이는 쪽에 가깝다.**

```
게시판:  게시물이 쌓인다 → 나중에 와도 다 볼 수 있다
9464:    현재값 하나 → 안 긁은 사이의 변화는 사라진다
```

**Q6의 `step` < `scrape_interval` 문제가 이 성질에서 나온다** — **중간값이 사라지는 것**은 게시물이 쌓이지 않기 때문이다.

**그리고 [[04-metrics-with-micrometer-prometheus-and-grafana]]의 "5초 주기가 짧은 스파이크를 놓친다"와 같은 사실**이다 — **접힌 값만 남는다.**

**비유가 맞는 부분은 남는다** — **한쪽은 받고 한쪽은 읽어 간다**(Q1의 방향 전환). 깨지는 것은 **누적 여부**다.

---

## 재출제 문항

1. 애플리케이션이 죽었다. push 모델과 pull 모델에서 각각 어떻게 알게 되는가?
2. 수집 주기를 30초로 바꾸려 한다. push라면 몇 군데를 고치는가?
3. Prometheus를 다른 시계열 DB로 바꾼다. 애플리케이션을 고치는가?
4. 로그와 메트릭이 같은 `service.name`을 갖는 것이 나중에 왜 중요한가?
5. `exporters.prometheus.endpoint`와 `exporters.loki.endpoint`의 의미가 어떻게 다른가?
6. `step: 1s`, `scrape_interval: 15s`로 뒀다. 무엇을 잃는가?
7. `/actuator/metrics`를 닫았다. 파이프라인이 멈추는가?
8. Prometheus가 5초마다 긁는다. 그 사이의 값은 어디에 있는가?

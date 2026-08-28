# 모범답안 — 07b AI와 관측 가능성

> **먼저 답하고 나서 열 것.** [[07b-ai-and-observability]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. p95 4.2초를 네 metric으로 분해

**한 요청에 최소 다섯 가지가 들어 있다**:
```
1. 질문을 임베딩으로 변환 (임베딩 API 호출)
2. pgvector 유사도 검색
3. 대화 메모리 조회
4. model 호출
5. 도구가 있었다면 도구 실행 + 두 번째 model 호출
```

| metric | **설명하는 구간** |
|---|---|
| **`gen_ai.client.operation`** | **4·5의 model 호출 지연** — label로 provider·요청 model·응답 model |
| **`gen_ai.client.token.usage`** | 지연이 아니라 **소비량** — input/output/total |
| **`db.vector.client.operation`** | **1·2의 벡터 스토어 연산** — add·delete·query |
| **`spring.ai.tool_call`** | **5의 도구 실행** — 도구 이름 label |

> **한 덩어리 4.2초로는 아무 결정도 못 한다.** **벡터 검색이면 인덱스, model 호출이면 모델 교체나 prompt 축소, 도구면 그 외부 API 문제**다.

**자동 계측**: **Spring Boot Actuator가 classpath에 있으면** `ChatClient`·`ChatModel`·`EmbeddingModel`·`VectorStore`·도구 실행이 **자동으로** metric과 분산 trace로 잡힌다. **수동 계측 코드가 필요 없다.**

**가능한 이유**: **[[05c-building-the-rag-pipeline-with-advisors]]의 어드바이저 구조와 같다** — **호출 경로에 이미 가로챌 자리가 있으므로 그 자리에서 관측을 시작하고 끝낸다.**

**Micrometer Observation**은 **[[../../part-5-observing-spring-boot-4-applications/chapter-13-observing-spring-boot-4-applications/02-designing-an-observability-architecture|Ch13]]에서 본 그 추상**이다 — **AI 전용 관측 스택을 새로 배우지 않아도 된다.**

---

## Q2. `gen_ai.request.model`과 `gen_ai.response.model`을 따로 두는 이득

**요청한 model과 실제 응답한 model의 차이가 보인다.**

> **`gpt-4o-mini`를 요청했는데 provider가 `gpt-4o-mini-2024-07-18`로 응답하면 그 버전 차이가 보인다.**

**왜 중요한가**:
- **provider가 뒤에서 model 버전을 바꾸면** 응답 품질이 달라질 수 있는데 **우리 설정은 그대로**다
- **응답 품질 회귀가 우리 코드 변경 때문이 아닐 수 있다** — [[07a-evaluating-llm-response-quality]]의 평가가 갑자기 실패하면 이 label을 본다
- **비용 단가도 버전마다 다를 수 있다**

**다른 metric들의 label도 같은 역할을 한다**:
- **`gen_ai_token_type`**(input·output·total) — **단가가 다르기 때문에** 나눈다
- **`db_system`**(pgvector인지 다른 것인지), **`db_operation_name`** — **[[05b-ingesting-documents-with-the-etl-pipeline]]의 색인과 [[05c-building-the-rag-pipeline-with-advisors]]의 검색이 여기서 갈린다**
- **도구 이름** — **[[04b-tool-calling]]에서 "model이 도구를 고른다"고 했는데 정말로 고르고 있는지를 확인할 유일한 방법.** **만들어 놓고 한 번도 안 불린 도구가 여기서 드러난다**

---

## Q3. PromQL이 빈 결과를 낼 때

**metric 이름이 Prometheus 규칙으로 변환됐는지 먼저 본다.**

```
Spring AI:    gen_ai.client.token.usage
Prometheus:   gen_ai_client_token_usage_total
              └ 점이 밑줄, 카운터에 _total 접미
```

> **대시보드를 짤 때 Spring 쪽 이름을 그대로 쓰면 결과가 비어 나온다.**

**[[../../part-5-observing-spring-boot-4-applications/chapter-13-observing-spring-boot-4-applications/04c-verifying-metrics-in-prometheus-and-grafana|Ch13]]에서 본 그 변환**이다.

**두 번째로 의심할 것**: **"자동 계측이니 설정이 필요 없다"는 오해**(§5) — **계측은 자동이지만 내보내기는 아니다.** **Prometheus로 노출하려면 Actuator endpoint를 열고 registry 의존성**을 넣어야 한다.

> **원문의 metric 이름 불일치**(§5): 책 p.460은 token metric을 **`gen_ai.client.token.usage`**(label `gen_ai_token_type`)로 소개하는데, **p.465 마지막 문장은 같은 대상을 `gen_ai.usage.input_tokens`·`gen_ai.usage.output_tokens`**로 부른다. **앞의 것이 Spring AI가 실제로 방출하는 이름**이고 뒤는 **OpenTelemetry GenAI 규약의 속성 이름** 쪽에 가깝다. **쓰는 버전에서 실제로 나오는 이름을 `/actuator/metrics`로 확인**하는 편이 안전하다.

**비용 대시보드 쿼리 읽는 법**(안쪽부터):
```promql
sum by (gen_ai_request_model) (gen_ai_client_token_usage_total{gen_ai_token_type='input'})
                                └─ 1. token 사용량 카운터
                                   └─ 2. 입력 token 만 남긴다
└─ 3. model 별로 합친다
```
**결과는 어느 model과 어느 endpoint가 비용을 만들고 있는지의 실시간 그림**이다.

---

## Q4. 요청 수는 그대로인데 token이 늘었다면

**`gen_ai.client.token.usage`의 `gen_ai_token_type='input'`을 먼저 본다.**

**이유**: [[07-operating-llm-applications]]의 분석대로 **대화 이력과 RAG 청크가 쌓이는 것은 전부 입력 쪽**이다. **출력은 model이 만드는 양이라 크게 안 변한다.**

**그다음**:
1. **input이 늘었는지 output이 늘었는지** 확인
2. **input이면** — 이력·RAG 청크·도구 정의 중 무엇인지는 **trace**를 봐야 안다
3. **`db.vector.client.operation`의 query 횟수**도 함께 본다 — top-K를 늘렸다면 여기 흔적이 있다

**"metric과 trace는 다른 질문에 답한다"**(§5) — **metric은 "얼마나·몇 번", trace는 "이 한 요청에서 무슨 순서로".** **4.2초의 내역을 보려면 trace가 필요**하다.

**비유의 깨짐이 이것이다** — 자동차 계기판에서 **token metric은 연료계**로 **요청 수(주행 횟수)가 아니라 실제 소모량**을 보여 준다. **깨지는 지점 둘**:
- **계기판은 연료가 왜 빨리 주는지를 말해 주지 않는다** — **대화 이력 때문인지 RAG 청크 때문인지는 trace를 봐야** 안다
- **계기판을 본다고 연비가 좋아지지는 않는다** — **관측은 문제를 드러낼 뿐이고, 줄이는 것은 [[07c-reducing-api-costs]]의 일**이다

**§6의 경계**: **prompt·응답 본문을 로그와 trace에 담지 않는다** — **기본적으로 꺼져 있고, 켜면 사용자 질문과 생성 응답이 관측 백엔드에 남는다**([[07d-security-best-practices-for-ai-applications]]). **count만 담는 token metric은 안전하다.** · **카디널리티를 주의한다** — **`conversationId`나 사용자 ID를 label로 붙이면 시계열이 폭발**한다 · **평가 결과는 metric이 아니다.**

---

## 재출제 문항

1. 4.2초 중 벡터 검색이 얼마인지 알고 싶다. 어느 metric인가?
2. 어제와 같은 코드인데 답 품질이 나빠졌다. 어느 label을 보는가?
3. 만들어 둔 도구가 실제로 불리는지 어떻게 확인하는가?
4. PromQL이 빈 결과를 낸다. 두 가지 원인 후보는?
5. token이 늘었다. input인지 output인지가 왜 중요한가?
6. 사용자 ID를 metric label로 붙이려 한다. 무엇이 문제인가?

# 모범답안 — 05a 임베딩과 벡터 스토어

> **먼저 답하고 나서 열 것.** [[05a-embeddings-and-vector-stores]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `vehicle malfunction`으로 `car broke down`을 찾는 이유

**의미를 좌표로 바꿔 거리를 재기 때문이다.**

```
"What is the return policy?"  →  [0.36, -0.21, 0.78, ...]   (1536개)
"환불 정책이 어떻게 되나요?"      →  [0.34, -0.19, 0.81, ...]   ← 가깝다
"배송비는 얼마인가요?"           →  [-0.55, 0.62, -0.11, ...]  ← 멀다
```

> **의미가 비슷한 두 text는 같은 단어를 쓰지 않아도 가까운 벡터가 된다.** **임베딩 model이 "비슷한 맥락에서 쓰이는 표현은 비슷한 좌표를 갖도록" 학습됐기 때문이다.**

**전통적 방식이 못 하는 이유**: **`LIKE '%vehicle%'`도, 전문 검색 인덱스도 이 둘을 잇지 못한다 — 글자가 하나도 안 겹치기 때문이다.**

**동의어 사전도 안 된다** — **언어의 모든 표현 쌍을 손으로 등록해야** 하고, **"환불되나요"와 "돈 돌려받을 수 있어요?"와 "반품하면 결제 취소돼요?"는 여전히 안 잡힌다.**

**이것이 시맨틱 검색이다** — **단어 일치가 아니라 의미 근접성으로 찾는 검색.**

**중요한 전제**: **색인 때 쓴 것과 같은 임베딩 model이 질문을 벡터로 바꿔야** 한다 — **다른 model은 다른 좌표계를 쓰기 때문**이다. **같은 문장도 다른 위치에 놓인다** → Q2.

---

## Q2. 임베딩 model을 바꾸면

**차원 설정을 함께 바꿔야 하고, 기존 데이터는 전부 재색인해야 한다.**

> **임베딩 model을 바꾸면 전부 재색인해야 한다.**

**함께 바꿀 것**: **`spring.ai.vectorstore.pgvector.dimensions`** — `text-embedding-3-small`은 1536차원이고 `-large`는 다르다. **차원이 안 맞으면 저장·검색이 실패**한다.

**기존 데이터**: **못 쓴다.** Q1의 이유 그대로 — **다른 model은 다른 좌표계**이므로, **옛 벡터와 새 질의 벡터를 비교하는 것이 무의미**하다.

> **차원·model·거리 척도는 한 세트다. 셋 중 하나를 바꾸면 재색인을 계획에 넣는다**(§6).

**"임베딩 model ≠ chat model"도 함께**(§5) — **`spring.ai.openai.chat.options.model`이 답을 만들고, `spring.ai.openai.embedding.options.model`이 벡터를 만든다.** **chat model을 바꿔도 벡터는 그대로**지만 **임베딩 model을 바꾸면 전부 재색인**이다.

**이것이 [[05-implementing-rag-with-vector-stores-and-advisors]]의 "model 교체와 독립적이다"에 붙는 단서**다 — **chat model에 대해서만** 독립적이다.

**코사인 거리를 쓰는 이유도 함께**: **벡터의 크기가 아니라 방향만 비교한다. 문장 길이에 덜 휘둘린다.** **유클리드는 방향과 크기를 함께 보므로**(§5), **문서 길이가 제각각인 text 검색에서는 코사인이 일반적**이다.

---

## Q3. HNSW가 "근사"인데도 문제가 안 되는 이유

**RAG에서는 top-K를 넉넉히 잡아 흡수하기 때문이다.**

> **둘 다 근사다. 전수 비교보다 훨씬 빠른 대신 아주 드물게 진짜 최근접을 놓칠 수 있다 — RAG에서는 top-K를 넉넉히 잡아 흡수한다.**

**RAG의 성질이 근사를 허용한다**:
- **정확한 1등이 필요하지 않다** — **관련 있는 조각 몇 개**면 된다
- **top-K가 5라면 5개 중 하나를 놓쳐도 나머지 4개로 답할 수 있다**
- **애초에 "가장 가까운"이 "가장 유용한"과 정확히 같지도 않다**

**대조**: **정확한 최근접이 필요한 용도**(중복 탐지, 정확 매칭)에서는 근사가 문제가 된다. **RAG는 그런 용도가 아니다.**

**두 인덱스**:
| 인덱스 | **원리** | **언제** |
|---|---|---|
| **HNSW** | **계층 그래프를 타고 내려가며 가까운 이웃을 좁혀 간다** | **고속 근사 검색. 이 장의 선택** |
| **IVFFlat** | **벡터를 군집으로 나누고 질의와 가까운 군집만 뒤진다** | 대규모 유사도 질의 가속 |

**§6의 경계**: **정확한 문자열·ID 조회에는 부적합하다** — **주문번호 `A-2026-0417`을 시맨틱 검색으로 찾지 않는다. 그건 `WHERE`의 일**이다.

---

## Q4. `initialize-schema=true`를 production에서 끄는 이유

**애플리케이션이 DDL 권한을 갖지 않아도 되기 때문이다.**

> **production에서는 스키마를 마이그레이션 도구로 관리하고 이 값을 끄는 편이 안전하다.**

**`initialize-schema=true`가 하는 일**: **시작 시 `vector_store` 테이블을 만들고 `pgvector`·`hstore`·`uuid-ossp` 확장을 설치한다.**

**production에서 위험한 이유**:
- **애플리케이션 계정에 DDL 권한**이 필요하다 — 침해 시 피해 범위가 커진다
- **스키마 변경 이력이 남지 않는다**
- **인스턴스가 여럿이면 동시에 DDL을 시도**한다

**[[../../part-4-scaling-an-application-with-spring-boot/chapter-10-working-with-data-reactively/04-loading-data-with-r2dbcentitytemplate|Ch10]]과 [[../../part-3-releasing-an-application-with-spring-boot/chapter-7-releasing-an-application-with-spring-boot/04c-running-the-setup-with-docker-compose|Ch7]]이 같은 말을 했다** — **Flyway·Liquibase 같은 마이그레이션 도구**를 쓴다.

**pgvector를 고른 이유도 함께**: **이미 PostgreSQL을 쓰고 있다면 인프라를 하나 더 늘리지 않아도 된다.** **`pgvector/pgvector:pg17`은 확장이 미리 설치된 공식 이미지**라 **직접 컴파일·설치하지 않아도** 된다.

**§6의 경계**: **초대형·고QPS 환경에서는 전용 벡터 DB(Pinecone·Qdrant 등)를 검토한다.** **pgvector는 "이미 있는 PostgreSQL을 재사용한다"는 장점으로 선택**하는 것이다. 그리고 **소량 문서에는 과하다** — **열 문단짜리 정책은 시스템 프롬프트에 넣는 편이 단순하고 정확**하다.

> **원문 표기 문제**(§5): 책 p.436의 `spring-ai-rag` 의존성 블록은 **`<artifactId>`를 `<groupId>`보다 먼저** 쓴다. **Maven이 순서를 강제하지 않아 동작은 하지만 책의 다른 모든 의존성 블록과 순서가 다르다.**

**그 의존성이 필요한 이유**: **Initializr 목록에 없어 손으로 넣어야** 하고, **`RetrievalAugmentationAdvisor`와 `VectorStoreDocumentRetriever`를 제공**한다 — [[05c-building-the-rag-pipeline-with-advisors]]에서 쓰는 것들이다. 그리고 **`spring-boot-starter-jdbc`가 필수**인 이유는 **pgvector 벡터 스토어 auto-configuration이 `JdbcTemplate`을 요구**하기 때문이다.

---

## 재출제 문항

1. "돈 돌려받을 수 있어요?"로 "return policy" 문서를 찾는다. 어떤 기계가 작동했는가?
2. 임베딩 model만 바꿨다. 기존 벡터를 그대로 쓸 수 있는가?
3. chat model을 바꿨다. 재색인이 필요한가?
4. HNSW가 진짜 최근접을 놓쳤다. RAG에서 문제가 되는가?
5. 주문번호로 조회하려 한다. 시맨틱 검색을 쓰는가?
6. production에서 `initialize-schema=true`를 켜 뒀다. 어떤 권한이 필요해지는가?

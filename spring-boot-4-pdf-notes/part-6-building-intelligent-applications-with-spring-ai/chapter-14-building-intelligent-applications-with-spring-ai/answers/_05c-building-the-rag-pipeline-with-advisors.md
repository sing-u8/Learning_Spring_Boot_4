# 모범답안 — 05c 어드바이저로 RAG 파이프라인 구축

> **먼저 답하고 나서 열 것.** [[05c-building-the-rag-pipeline-with-advisors]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. advisor가 없애 주는 중복

**손으로 짜면 네 단계가 controller마다 복사된다** — 질문 임베딩, 유사도 검색, 문자열 이어 붙이기, prompt 조립.

> **챗봇 endpoint, 검색 endpoint, 요약 endpoint에 같은 코드가 세 벌 생긴다. top-K를 바꾸려면 세 곳을 고치고, context를 시스템 메시지에 넣을지 사용자 메시지에 넣을지 실험하려면 또 세 곳을 고친다.**

**advisor로 바꾸면**: **`.advisors(...)` 한 덩어리**가 그 넷을 대신하고, **설정이 한 곳에 모인다.**

> **이건 익숙한 문제다. 요청마다 반복되는 관심사를 요청 경로 바깥으로 빼는 것 — servlet filter, `HandlerInterceptor`, AOP가 하는 일이다.**

**어드바이저**: **`ChatClient` 요청·응답 주위를 감싸 횡단 관심사를 끼워 넣는 구성 요소.**

**같은 자리에 다른 관심사도 붙는다**:
| advisor | 하는 일 |
|---|---|
| `RetrievalAugmentationAdvisor` | RAG 검색·주입 |
| `MessageChatMemoryAdvisor` | **대화 이력 주입** → [[05d-conversation-memory-with-chat-memory-advisor]] |
| `SimpleLoggerAdvisor` | prompt·응답 로깅 |
| `SafeGuardAdvisor` | **안전 필터링** → [[07d-security-best-practices-for-ai-applications]] |

> **이 통일성이 설계의 이득이다. 새 관심사를 붙일 때 `ChatClient` 호출 코드를 고치지 않고 advisor 하나를 추가한다.**

---

## Q2. advisor와 retriever를 두 층으로 나눈 이득

> **retriever는 "무엇을 어떻게 찾을까", advisor는 "찾은 것을 요청에 어떻게 끼울까"를 맡는다. 그래서 retriever를 바꾸면(예: 웹 검색 기반) advisor는 그대로 쓸 수 있다.**

```
RetrievalAugmentationAdvisor   ← 증강 단계 (prompt 에 어떻게 넣을까)
  └ VectorStoreDocumentRetriever ← 검색 단계 (어디서 무엇을 찾을까)
      └ vectorStore, topK(4)
```

**[[05-implementing-rag-with-vector-stores-and-advisors]]의 세 단계와 대응**한다 — **검색 단계 = retriever, 증강 단계 = advisor, 생성 단계 = model.**

**교체 가능성이 양방향이다**:
- **retriever를 바꾼다** — 웹 검색, 다른 벡터 스토어, 하이브리드 검색
- **advisor를 바꾼다** — 주입 위치(system vs user), 형식, 인용 표시

**실행 순서**:
```
1. advisor 체인이 요청을 가로챈다
2. RetrievalAugmentationAdvisor 가 retriever 에 질문을 넘긴다
3. retriever 가 임베딩 → 유사도 검색
4. 상위 4개 청크
5. advisor 가 청크를 prompt 에 주입
6. 그제서야 요청이 model 로 나간다        ← 핵심
7. 응답이 advisor 체인을 역순으로 통과
```

> **6번이 핵심이다 — model은 증강된 prompt만 본다. 벡터 스토어의 존재도, 검색이 있었다는 사실도 모른다.**

**advisor 순서가 의미를 갖는다**(§5) — **요청은 등록 순서대로, 응답은 역순으로 통과**한다. **메모리 주입과 RAG 주입이 같이 있을 때 어느 쪽이 먼저 prompt를 만지는지가 결과에 영향**을 준다.

---

## Q3. 색인 실패로 벡터 스토어가 비었을 때

**advisor는 아무것도 주입하지 못하고, model은 RAG 없는 상태로 답한다 — 그런데 에러는 나지 않는다.**

> **색인이 실패했는데 조용히 일반 답변이 나가는 상황을 조심해야 한다.**

**왜 위험한가**:
```
정상:  "30일 이내 원래 포장 상태로 반품 가능" (product-faq.txt 그대로)
실패:  "일반적으로 전자상거래에서는 30일 이내..." (그럴듯하고, 우리 정책과 다르고, 틀렸다는 신호가 없다)
```

**[[01-introducing-llms-and-spring-ai]]의 세 실패 중 가장 위험한 것으로 되돌아간다** — **"환불 정책이 어떻게 되나요?"에 그럴듯한 답이 나오는** 그 상황이다.

**그리고 겉으로는 정상 동작**이다 — HTTP 200, 응답 있음, 로그에 오류 없음.

**대응**: **검색 결과 개수를 로깅**하거나 **0건이면 명시적으로 거부**한다. [[07a-evaluating-llm-response-quality]]의 평가가 이런 회귀를 잡는 자리이기도 하다.

**검증 성공 시의 모습**: `curl`로 `What is the return policy`를 물으면 **`product-faq.txt`에 적힌 내용 그대로** 나온다 — **그라운딩이 성공한 모습**이다.

> **원문 표기 오류 두 가지**(§5): (1) 책 p.442 항목 설명이 **`.User(question)`으로 대문자 U** — 코드 블록은 소문자이므로 **설명 항목만의 오타**([[03-reactive-streaming-with-chatclient]]의 `.Stream()`, [[04b-tool-calling]]의 `.Call()`과 같은 종류). (2) 책 p.443이 응답을 **`{"reply": ...}` JSON**으로 보여 주는데 **`rag(...)`의 반환형은 `String`**이라 **실제 응답은 평문**이다.

---

## Q4. `topK(4)`를 `topK(20)`으로

| | **비용** | **정확도** | **지연** |
|---|---|---|---|
| topK 증가 | **prompt token이 5배 → 비용 증가** | **관련 조각을 놓칠 확률↓ / 무관한 조각이 주의를 흩뜨림↑** | **검색은 비슷, prompt 생성·전송이 늘어 소폭 증가** |

> **prompt가 커져 비용이 오르고, 무관한 청크가 model의 주의를 흩뜨린다.**

**정확도가 양방향인 것이 핵심**이다 — **더 넣는다고 더 정확해지지 않는다.** [[05-implementing-rag-with-vector-stores-and-advisors]]도 같은 말을 한다.

**적정값은 문서 구조와 청크 크기에 달렸다** — 청크가 800토큰이면 20개는 **16,000토큰**이고, 컨텍스트 윈도의 상당 부분이다([[01-introducing-llms-and-spring-ai]]의 예산 문제).

**§6의 나머지 경계**:
- **검색 근거를 사용자에게 보여야 하면** advisor가 주입한 문서를 따로 꺼낸다 — **응답 metadata의 `DOCUMENT_CONTEXT` key**에 담겨 있고 [[07a-evaluating-llm-response-quality]]가 그 값을 쓴다
- **스트리밍과 함께 쓸 때 주의한다** — **검색은 응답 시작 전에 끝나야 하므로 첫 바이트까지의 시간에 검색 지연이 그대로 더해진다**([[03-reactive-streaming-with-chatclient]]의 이득이 줄어든다)

**advisor가 붙는 위치도 선택이다**(§5) — **요청마다 `.advisors(...)`** vs **builder의 `defaultAdvisors(...)`**. **요청별로 검색 대상이 달라야 하면 전자, 애플리케이션 전체가 같은 지식 베이스를 쓰면 후자**다.

**비유로 보면** 시험장 감독관 — **문 앞에서 참고 자료를 손에 쥐여 준다.** **깨지는 지점 셋**:
- **감독관은 자료가 안 맞으면 다시 찾아보지만 이 advisor는 한 번 검색하고 끝**이다
- **학생은 "자료에 없는데요"라고 말할 수 있지만 model은 그럴듯하게 채워 넣을 수 있다**
- **감독관이 엉뚱한 지시가 적힌 종이를 골라 주면 학생이 그 지시를 따를 수도 있다** — 간접 프롬프트 인젝션

---

## 재출제 문항

1. RAG endpoint가 셋이다. top-K를 바꾸려면 손으로 짠 코드에서 몇 곳을 고치는가?
2. 벡터 스토어를 웹 검색으로 바꾸려 한다. 무엇을 교체하는가?
3. model은 검색이 있었다는 것을 아는가?
4. 색인이 실패했다. endpoint는 어떤 HTTP 상태를 반환하는가?
5. topK를 20으로 늘렸더니 답이 더 나빠졌다. 왜일 수 있는가?
6. RAG와 스트리밍을 함께 쓰면 첫 바이트 시간이 어떻게 되는가?

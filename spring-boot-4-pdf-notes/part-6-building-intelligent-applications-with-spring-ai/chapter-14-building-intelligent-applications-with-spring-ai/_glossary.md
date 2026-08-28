# Chapter 14 용어집

> *Learning Spring Boot 4*, Ch. 14 *Building Intelligent Applications with Spring AI* (책 pp. 401–465 / PDF pp. 426–490)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## LLM (Large Language Model)

방대한 text·book·article·website·source code로 학습해 **언어의 통계 패턴**을 익힌 AI system. 지식을 사실 목록으로 저장하는 것이 아니라, 주어진 prompt 다음에 올 token sequence의 확률을 계산해 답을 만든다.

## 토큰 (token)

model이 입력과 출력을 계산하는 최소 text 단위. 한 단어일 수도, 단어의 조각일 수도, 구두점이나 공백일 수도 있다. 과금·context 한도·latency가 모두 이 단위로 매겨진다.

## 컨텍스트-윈도 (context window)

한 번의 상호작용에서 model이 다룰 수 있는 최대 text량. **prompt와 생성될 응답이 같은 예산을 나눠 쓴다.** 넓을수록 대화 이력·검색 문서를 더 넣을 수 있지만 token 소비와 비용도 같이 커진다.

## temperature (temperature)

출력 token 선택의 무작위성을 조절하는 parameter. 낮으면 같은 질문에 같은 답이 나오기 쉽고, 높으면 다양하고 창의적이지만 환각 확률이 올라간다.

## 환각 (hallucination)

그럴듯하고 확신에 찬 문장으로 제시되지만 사실과 다르거나, 지어낸 것이거나, 주어진 context로 뒷받침되지 않는 model 응답.

## 토큰-사용량 (token usage)

한 요청이 소비한 입력·출력 token의 수. provider가 보통 token 단위로 과금하므로 비용·성능·확장성의 공통 척도가 된다.

## 추상화-계층 (abstraction layer)

application code와 여러 provider 구현 사이에 두는 공통 interface 층. Spring AI에서는 `ChatModel`·`EmbeddingModel`·`VectorStore`·`ChatClient`가 이 층을 이룬다.

## ChatModel (ChatModel)

provider 중립적인 **저수준** chat model abstraction. starter가 자기 provider API로 이것을 구현하고, auto-configuration이 bean으로 등록한다.

## EmbeddingModel (EmbeddingModel)

text를 벡터로 바꾸는 model의 provider 중립 abstraction. RAG의 색인·질의 양쪽에서 같은 것을 써야 벡터 공간이 일치한다.

## VectorStore (VectorStore)

임베딩 벡터를 저장하고 유사도 검색을 수행하는 저장소의 abstraction. Spring AI에서는 `DocumentWriter`도 함께 구현하므로 ETL의 종착점 역할을 겸한다.

## ChatClient (ChatClient)

prompt 구성 → 실행 → 응답 소비를 이어 쓰는 **fluent 고수준 client**. `WebClient`와 비슷한 사용감을 목표로 하며, advisor·tool·structured output이 모두 이 API를 통해 붙는다.

## Spring-AI-starter (Spring AI starter)

특정 provider용 구현과 auto-configuration을 담은 의존성. classpath에 어떤 starter가 있는지가 어떤 `ChatModel` bean이 만들어질지를 결정한다.

## fluent-API (fluent API)

메서드를 연달아 이어 붙여 하나의 요청을 조립하는 API 양식. 각 단계가 자기 자신 또는 다음 단계 builder를 돌려주어 `prompt().user(...).call().content()`처럼 읽힌다.

## 시스템-메시지 (system message)

model의 역할·톤·행동·제약을 정하는 메시지. 사용자 입력과 분리되어 있고, 보통 중앙에서 한 번 설정해 모든 요청에 자동 적용한다.

## 사용자-메시지 (user message)

실제 요청이나 질문을 담는 메시지. 호출마다 달라지는 동적 부분이다.

## ChatResponse (ChatResponse)

model 호출의 **완전한** 결과 객체. 생성된 text뿐 아니라 model 이름·요청 id·token 사용량·rate limit·종료 사유 같은 metadata를 함께 담는다.

## 구조화-응답 (structured response)

model 출력을 곧바로 Java record나 POJO로 매핑해 받는 방식. 수동 파싱 없이 타입 안전하게 business logic에 넘길 수 있다.

## StructuredOutputConverter (StructuredOutputConverter)

응답 형식과 파싱을 세밀하게 제어하는 Spring AI 구성 요소. 중첩 구조·검증·custom 매핑이 필요할 때 `entity(...)` 대신 쓴다.

## ParameterizedTypeReference (ParameterizedTypeReference)

`List<AiAnswer>`처럼 제네릭 타입 정보를 런타임까지 보존해 넘기기 위한 Spring의 타입 토큰. 제네릭 소거 때문에 `List.class`로는 원소 타입을 알릴 수 없어서 필요하다.

## 스트리밍-응답 (streaming response)

model이 생성하는 대로 부분 결과를 먼저 흘려보내는 응답 방식. 전체 완성을 기다리지 않아 **체감 지연**이 크게 줄어든다.

## Flux (Flux)

Project Reactor에서 0개 이상의 값을 시간에 걸쳐 방출하는 reactive 타입. Spring AI의 `.stream().content()`가 이 타입으로 text 조각을 흘려보낸다.

## SSE (Server-Sent Events)

서버가 하나의 HTTP 연결 위에서 client로 데이터를 조각조각 밀어 주는 단방향 streaming 메커니즘. 각 조각이 `data:` 접두로 전송된다.

## 프롬프트-엔지니어링 (prompt engineering)

model이 일관되고 정확하며 형식이 맞는 출력을 내도록 입력을 설계하는 실천. 지시·context·제약·사용자 입력을 어떻게 조합하느냐의 문제다.

## 시스템-프롬프트 (system prompt)

시스템 메시지로 전달되는 프롬프트 층. 역할·범위·금지 사항을 정해 모든 상호작용의 기본 행동을 고정한다.

## 인라인-파라미터화 (inline prompt parameterization)

prompt 문자열에 `{name}` 자리표시자를 두고 `.param(...)`으로 런타임 값을 채우는 방식. 짧고 국소적인 prompt에 적합하다.

## StringTemplate (StringTemplate)

`.st` 확장자를 쓰는 template 형식. Spring AI는 이 파일을 classpath resource로 읽어 prompt로 만든다.

## PromptTemplate (PromptTemplate)

template 문자열이나 resource로부터 자리표시자를 채워 완성된 prompt를 만드는 Spring AI 타입. `create(Map)`으로 값을 주입한다.

## 툴-콜링 (tool calling)

model이 스스로 답을 만드는 대신 **application의 method 실행을 요청**하고, 그 결과를 받아 최종 답에 반영하게 하는 방식.

## @Tool (@Tool)

평범한 Java method를 model이 호출할 수 있는 도구로 노출하는 annotation. `description`이 model의 선택 근거가 되고, `name`을 생략하면 method 이름이 도구 이름이 된다.

## ToolCallback (ToolCallback)

도구 하나를 프로그래밍 방식으로 표현하는 Spring AI 타입. 동적·조건부로 도구를 구성하거나, MCP로 발견한 원격 도구를 지역 도구처럼 등록할 때 쓴다.

## FunctionCallback (FunctionCallback)

Spring AI 1.x에서 도구를 등록하던 옛 API. 현재는 `ToolCallback` 계열로 대체됐고 `functions(...)`도 `tools(...)`로 바뀌었다.

## RAG (Retrieval-Augmented Generation)

model을 재학습하지 않고, **질의 시점에** 외부 지식에서 관련 조각을 찾아 prompt에 넣어 답을 근거 있게 만드는 아키텍처 패턴.

## 검색-단계 (Retrieval)

RAG의 첫 단계. 사용자 질문을 임베딩으로 바꾸고 벡터 스토어에서 의미적으로 가장 가까운 top-K 조각을 찾는다.

## 증강-단계 (Augmentation)

RAG의 두 번째 단계. 찾아온 조각을 시스템 메시지나 사용자 메시지의 일부로 prompt에 끼워 넣는다.

## 생성-단계 (Generation)

RAG의 마지막 단계. 증강된 prompt를 받은 model이 학습 지식이 아니라 **주어진 근거**에 기대어 답을 만든다.

## 그라운딩 (grounding)

응답이 주어진 근거 문서에 실제로 기반하도록 만드는 것. grounded 응답은 출처를 되짚어 검증할 수 있다.

## top-K (top-K)

유사도 검색이 돌려줄 상위 결과의 개수. 키우면 context가 풍부해지지만 prompt 크기와 token 비용이 같이 커진다.

## 임베딩 (embedding)

text 조각의 의미를 담은 고정 길이 실수 배열. 의미가 가까운 두 text는 단어가 달라도 가까운 벡터가 된다.

## 벡터-스토어 (vector store)

임베딩 벡터를 저장하고 유사도 기준으로 검색하도록 최적화된 데이터베이스.

## 유사도-검색 (similarity search)

질의 벡터와 저장된 벡터 사이의 거리를 계산해 가장 가까운 것들을 돌려주는 연산.

## 시맨틱-검색 (semantic search)

단어 일치가 아니라 **의미 근접성**으로 문서를 찾는 검색. `vehicle malfunction`으로 `car broke down` 문서를 찾아낸다.

## pgvector (pgvector)

PostgreSQL에 벡터 column 타입과 유사도 연산자·인덱스를 추가하는 확장. 기존 관계형 DB를 그대로 벡터 스토어로 쓰게 해 준다.

## HNSW (Hierarchical Navigable Small World)

그래프 기반 근사 최근접 이웃 인덱스. 정확한 전수 비교 대신 그래프를 타고 내려가 **빠른 근사 검색**을 제공한다.

## IVFFlat (Inverted File Flat)

벡터를 클러스터로 나눈 뒤 질의와 가까운 클러스터만 뒤지는 인덱스. 대규모 유사도 질의를 가속한다.

## 코사인-거리 (COSINE_DISTANCE)

두 벡터가 이루는 각도로 유사도를 재는 척도. 벡터의 길이(크기)가 아니라 방향만 비교한다.

## 임베딩-차원 (dimensions)

임베딩 벡터의 길이. 벡터 column의 차원과 임베딩 model의 출력 차원이 다르면 PostgreSQL이 insert를 거부한다.

## text-embedding-3-small (text-embedding-3-small)

이 장에서 쓰는 OpenAI 임베딩 model. 기본 1536차원을 내며, 구형 `text-embedding-ada-002`보다 권장된다.

## ETL-파이프라인 (ETL pipeline)

Read → Transform → Load 흐름으로 문서를 읽고 쪼개고 저장하는 데이터 처리 경로. Spring AI는 RAG의 색인 단계를 이 형태로 제공한다.

## DocumentReader (DocumentReader)

원본을 읽어 `Document` 객체 목록으로 바꾸는 ETL의 첫 단계. 내부적으로 Java `Supplier` 패턴을 따른다.

## DocumentTransformer (DocumentTransformer)

저장 전에 문서를 가공하는 ETL의 중간 단계. 내부적으로 Java `Function` 패턴을 따른다.

## DocumentWriter (DocumentWriter)

가공된 문서를 목적지에 쓰는 ETL의 마지막 단계. 내부적으로 Java `Consumer` 패턴을 따르고, `VectorStore`가 이를 구현한다.

## TokenTextSplitter (TokenTextSplitter)

긴 문서를 지정한 token 크기 근처의 조각으로 쪼개는 `DocumentTransformer` 구현.

## 청크 (chunk)

임베딩과 검색의 단위가 되도록 잘라 놓은 문서 조각. 작으면 검색 정밀도가, 크면 문맥 보존이 유리하다.

## TextReader (TextReader)

평문 파일을 읽는 `DocumentReader` 구현. PDF·Markdown·DOCX·JSON용 reader가 따로 있고, reader만 바꾸면 나머지 pipeline은 그대로다.

## 문서-메타데이터 (document metadata)

각 `Document`에 붙는 key-value 정보. 검색 시 필터링, 출처 추적, 디버깅에 쓰인다.

## 어드바이저 (Advisor)

`ChatClient` 요청과 응답 주위를 감싸 memory·RAG·logging·안전 필터 같은 횡단 관심사를 끼워 넣는 구성 요소. servlet filter나 AOP interceptor와 같은 자리다.

## RetrievalAugmentationAdvisor (RetrievalAugmentationAdvisor)

RAG의 증강 단계를 담당하는 advisor. 요청이 model에 닿기 전에 문서를 검색해 prompt에 주입한다.

## VectorStoreDocumentRetriever (VectorStoreDocumentRetriever)

RAG의 검색 단계 구현. 질문을 임베딩으로 바꾸고 벡터 스토어에 유사도 검색을 걸어 상위 조각을 돌려준다.

## DOCUMENT_CONTEXT (DOCUMENT_CONTEXT)

`RetrievalAugmentationAdvisor`가 응답 metadata에 채워 두는 key. 이번 요청에서 실제로 검색된 문서 조각이 담겨 있어 평가·디버깅에 쓸 수 있다.

## 대화-메모리 (chat memory)

이전 turn의 메시지를 보관했다가 다음 요청의 prompt에 다시 넣어 주는 장치. LLM 자체는 turn 사이에 아무것도 기억하지 않는다.

## MessageChatMemoryAdvisor (MessageChatMemoryAdvisor)

`ChatClient`와 대화 메모리를 잇는 advisor. 요청마다 이전 메시지를 꺼내 주입하고 새 교환을 다시 저장한다.

## MessageWindowChatMemory (MessageWindowChatMemory)

최근 메시지만 남기는 **슬라이딩 윈도** 방식의 대화 메모리 구현. 이력이 무한히 늘어나 컨텍스트 윈도를 잡아먹는 것을 막는다.

## InMemoryChatMemoryRepository (InMemoryChatMemoryRepository)

대화 이력을 실행 중인 프로세스의 메모리에 담는 저장소 구현. 개발·시연용이며 재시작하면 사라진다.

## conversationId (conversationId)

대화 세션을 식별하는 키. 같은 키를 쓰는 요청끼리만 이력을 공유하므로 사용자·창별로 대화가 격리된다.

## SimpleLoggerAdvisor (SimpleLoggerAdvisor)

주고받은 prompt와 응답을 로그로 남기는 advisor. 개발 중 실제로 어떤 prompt가 전송됐는지 확인할 때 쓴다.

## 스테이트리스 (stateless)

각 요청이 이전 요청을 기억하지 않는 성질. `ChatClient`의 기본 동작이며, 대화 메모리는 이 성질을 애플리케이션 쪽에서 보완한 것이다.

## MCP (Model Context Protocol)

AI application이 외부 능력을 **발견하고 호출**하는 방식을 표준화한 vendor 중립 프로토콜. 프레임워크·언어·벤더가 달라도 같은 도구를 공유할 수 있다.

## McpClient (McpClient)

원격 MCP server의 도구·리소스·prompt를 발견하고 연결을 관리하는 쪽.

## McpServer (McpServer)

자기 도구·리소스·prompt를 원격 MCP client에게 노출하는 쪽.

## McpSession (McpSession)

MCP 상호작용의 생명주기를 관리하는 층. capability 협상, 메시지 조율, 세션 상태, 오류 처리를 맡는다.

## @McpTool (@McpTool)

Java method를 MCP 프로토콜로 노출되는 도구로 만드는 annotation. `@Tool`과 문법은 닮았지만 **노출 범위가 프로세스 밖**이다.

## MCP-리소스 (MCP Resources)

URI로 접근하는 읽기 전용 context. 파일, DB record, API 응답처럼 실행이 아니라 조회의 대상이다.

## MCP-프롬프트 (MCP Prompts)

server가 공개하는 재사용 가능한 prompt template. client가 목록을 조회해 그대로 쓸 수 있다.

## STDIO (STDIO)

프로세스의 표준 입출력 파이프를 통신로로 쓰는 MCP transport. CLI로 띄우는 지역 server에 흔하다.

## Streamable-HTTP (Streamable HTTP)

요청/응답 의미를 유지하면서 HTTP streaming을 쓰는 MCP transport. 사양이 원격 server의 권장 transport로 이동한 방식이다.

## SyncMcpToolCallbackProvider (SyncMcpToolCallbackProvider)

설정된 MCP server들이 노출한 도구를 발견해 `ToolCallback` 목록으로 바꿔 주는 bean. 이 목록을 `ChatClient`에 등록하면 원격 도구가 지역 도구처럼 쓰인다.

## 동적-도구-발견 (dynamic tool discovery)

server에 도구가 추가되면 client 재배포나 코드 변경 없이 곧바로 쓸 수 있게 되는 성질. MCP의 핵심 이점이다.

## LLM-as-a-Judge (LLM-as-a-Judge)

한 model의 응답을 **다른 model이 평가**하게 하는 방식. 정답 문자열 비교가 불가능한 자연어 출력의 품질을 판정한다.

## RelevancyEvaluator (RelevancyEvaluator)

생성된 응답이 질문 및 검색된 context와 의미적으로 맞는지 판정하는 Spring AI 평가기.

## FactCheckingEvaluator (FactCheckingEvaluator)

응답의 주장이 제공된 문서로 뒷받침되는지 확인해 환각을 잡아내는 Spring AI 평가기.

## EvaluationRequest (EvaluationRequest)

질문·context 문서·생성된 답을 한데 묶어 평가기에 넘기는 요청 객체.

## EvaluationResponse (EvaluationResponse)

평가기의 판정 결과. `isPass()`로 통과 여부를 읽는다.

## Bespoke-Minicheck (Bespoke-Minicheck)

사실 확인에 특화된 경량 model. YES/NO 수준의 짧은 출력만 내므로 Ollama로 지역 실행하면 평가 비용이 사실상 0이 된다.

## Micrometer-Observation (Micrometer Observation)

한 번의 계측 선언에서 metric과 trace를 동시에 만들어 내는 Spring의 관측 추상. Spring AI가 이것으로 AI 연산을 자동 계측한다.

## gen_ai.client.operation (gen_ai.client.operation)

모든 `ChatClient`·`ChatModel` 호출의 지연 시간을 기록하는 metric. `gen_ai.system`·`gen_ai.request.model`·`gen_ai.response.model` label이 붙는다.

## gen_ai.client.token.usage (gen_ai.client.token.usage)

token 소비량을 기록하는 metric. `gen_ai_token_type` label이 `input`·`output`·`total`을 구분하며, API 사용량과 비용 추적의 토대다.

## db.vector.client.operation (db.vector.client.operation)

벡터 스토어의 add·delete·query 연산을 기록하는 metric. `db_system`·`db_operation_name` label이 붙는다.

## spring.ai.tool_call (spring.ai.tool_call)

도구 호출 하나하나를 기록하는 metric. 도구 이름으로 label이 붙어 어떤 도구가 얼마나 불리는지 보인다.

## PromQL (PromQL)

Prometheus의 질의 언어. `sum by (...)` 같은 집계로 label별 시계열을 묶어 대시보드 패널을 만든다.

## 프롬프트-캐싱 (prompt caching)

여러 요청이 **같은 prompt 접두부**를 공유할 때 이미 처리한 token을 서버가 재사용하는 provider 기능. 지연과 비용을 함께 줄인다.

## Usage-API (Usage API)

`ChatResponse` metadata에서 입력·출력 token 수와 캐시 적중·저장 token 수를 읽는 API.

## 로컬-모델 (local model)

원격 API 대신 자기 장비에서 돌리는 model. 분류·의도 탐지·짧은 요약처럼 가벼운 작업을 넘겨 비용을 낮춘다.

## Ollama (Ollama)

로컬 model을 내려받아 실행하고 API로 노출하는 런타임. Spring AI는 이것도 같은 `ChatClient` abstraction으로 다룬다.

## Docker-Model-Runner (Docker Model Runner)

Docker Desktop에 통합된 GPU 가속 로컬 추론 기능. Ollama 기반 Spring AI 설정과 호환된다.

## 프롬프트-인젝션 (prompt injection)

악의적 입력으로 application의 시스템 프롬프트를 덮어써 model의 의도된 행동을 바꾸려는 공격.

## 간접-프롬프트-인젝션 (indirect prompt injection)

공격 지시를 사용자 입력이 아니라 **검색될 문서 안에** 심어 두는 변형. RAG가 그 문서를 끌어와 prompt에 넣는 순간 지시가 주입된다.

## SafeGuardAdvisor (SafeGuardAdvisor)

생성된 응답을 검사해 민감 정보 노출이나 규칙 위반 내용을 차단하는 advisor.

## 시크릿-매니저 (secrets manager)

자격 증명을 코드·저장소 밖에서 암호화 보관하고 접근을 통제·감사하는 전용 시스템. AWS Secrets Manager, HashiCorp Vault, Azure Key Vault 등.

## 관측-프라이버시-프로퍼티 (observation privacy properties)

prompt·응답·검색 결과·도구 인자를 로그와 trace에 포함할지 정하는 Spring AI 설정. `spring.ai.chat.observations.log-prompt` 등이며 production에서는 꺼 둔다.

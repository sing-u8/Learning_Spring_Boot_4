# 07-ai 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 스프링-에이아이 (spring ai)
특정 인공지능 제공업체(OpenAI, Anthropic, Ollama 등)에 종속되지 않고 Spring의 객체 지향 추상화와 DI를 통해 대규모 언어 모델(LLM)을 애플리케이션에 통합하는 공식 프레임워크 (`spring-ai-starter`).
- 처음 나온 곳: [[01-spring-ai-architecture-and-chatclient]]
- 섞이는 말: [[챗-클라이언트]], [[프롬프트-템플릿]]

## 챗-클라이언트 (chat client)
유려한(Fluent) 빌더 API를 통해 시스템 프롬프트, 사용자 입력, RAG 어드바이저, 툴 콜링을 조합하여 LLM과 직관적으로 대화하는 Spring AI의 핵심 클라이언트 (`ChatClient`).
- 처음 나온 곳: [[01-spring-ai-architecture-and-chatclient]]
- 섞이는 말: [[스프링-에이아이]], [[프롬프트-템플릿]]

## 프롬프트-템플릿 (prompt template)
정적 프롬프트 문자열 내에 `{input}`, `{context}` 등의 변수 플레이스홀더를 두고 런타임에 동적으로 안전하게 값을 치환하여 LLM에 전달하는 템플릿 컴포넌트 (`PromptTemplate`).
- 처음 나온 곳: [[02-prompt-engineering-and-templates]]
- 섞이는 말: [[구조화된-출력-변환기]], [[챗-클라이언트]]

## 구조화된-출력-변환기 (structured output converter)
LLM의 자유 형식 텍스트 응답을 JSON 스키마를 통해 검증하고 자바의 불변 `record`나 POJO DTO 객체로 완벽히 타입 세이프하게 역직렬화하는 변환기 (`BeanOutputConverter`).
- 처음 나온 곳: [[02-prompt-engineering-and-templates]]
- 섞이는 말: [[프롬프트-템플릿]]

## 툴-호출 (tool calling)
LLM이 자체 지식만으로 답할 수 없는 실시간 데이터 조회나 외부 API 실행이 필요할 때, 개발자가 작성한 자바 메서드를 에이전트가 자율적으로 호출(Function Calling)하여 결과를 얻는 기능 (`@Tool`).
- 처음 나온 곳: [[03-tool-calling-and-function-callbacks]]
- 섞이는 말: [[모델-컨텍스트-프로토콜]], [[검색-증강-생성]]

## 검색-증강-생성 (retrieval augmented generation)
LLM의 사전 학습 데이터에 없는 최신 내부 비즈니스 문서나 비공개 지식을 벡터 DB에서 의미 기반(Semantic)으로 검색하여 프롬프트 컨텍스트에 동적으로 주입하는 인공지능 아키텍처 (RAG).
- 처음 나온 곳: [[04-rag-architecture-and-vector-stores]]
- 섞이는 말: [[벡터-저장소]], [[임베딩-모델]]

## 벡터-저장소 (vector store)
문서 청크의 텍스트를 고차원 숫자 벡터(임베딩)로 변환하여 저장하고, 사용자 질문 벡터와의 코사인 유사도(Cosine Similarity)를 통해 가장 관련성이 높은 문서를 초고속 인출하는 특수 데이터베이스 (`VectorStore`, PGVector).
- 처음 나온 곳: [[04-rag-architecture-and-vector-stores]]
- 섞이는 말: [[임베딩-모델]], [[검색-증강-생성]]

## 임베딩-모델 (embedding model)
자연어 텍스트를 문맥적 의미가 보존된 수백~수천 차원의 부동소수점 숫자 배열(Vector)로 변환해 주는 전용 딥러닝 모델 (`EmbeddingModel`).
- 처음 나온 곳: [[04-rag-architecture-and-vector-stores]]
- 섞이는 말: [[벡터-저장소]], [[검색-증강-생성]]

## 모델-컨텍스트-프로토콜 (model context protocol)
Anthropic이 제정한 오픈 표준으로, 다양한 AI 애플리케이션과 엔터프라이즈 도구/데이터 소스를 표준 JSON-RPC 프로토콜을 통해 플러그앤플레이(Plug-and-play)로 연결하는 차세대 규격 (MCP).
- 처음 나온 곳: [[05-model-context-protocol-mcp]]
- 섞이는 말: [[툴-호출]], [[스프링-에이아이]]

## 인공지능-가드레일 (ai guardrails)
프롬프트 인젝션(Prompt Injection) 공격, 환각(Hallucination), 민감 개인정보(PII) 유출 및 비도덕적 유해 출력을 필터링하여 엔터프라이즈 AI의 안전성과 신뢰성을 보장하는 다층 방어 체계.
- 처음 나온 곳: [[06-ai-security-and-responsible-guardrails]]
- 섞이는 말: [[스프링-에이아이]], [[프롬프트-템플릿]]

## 대화-메모리 (conversation memory)
상태가 없는(Stateless) HTTP 요청 환경에서 이전 질의응답 히스토리를 세션별/사용자별로 보관하고 다음 프롬프트에 자동으로 주입하여 멀티턴(Multi-turn) 대화 맥락을 유지하는 컴포넌트 (`ChatMemory`, `MessageChatMemoryAdvisor`).
- 처음 나온 곳: [[07-conversation-memory-chat-memory]]
- 섞이는 말: [[챗-클라이언트]], [[스프링-에이아이]]

## 인공지능-평가 (ai evaluation)
LLM이 생성한 응답의 관련성(Relevance), 사실성(Factuality), 환각 여부를 또 다른 고성능 심판 모델(LLM-as-a-Judge)을 통해 프로그래밍 방식으로 자동 채점하고 품질을 보증하는 평가 프레임워크 (`Evaluator`).
- 처음 나온 곳: [[08-llm-evaluation-and-cost-optimization]]
- 섞이는 말: [[프롬프트-캐싱]], [[스프링-에이아이]]

## 프롬프트-캐싱 (prompt caching)
반복적으로 전송되는 고정 시스템 프롬프트나 대규모 컨텍스트 문서를 AI 제공자 서버의 KV 캐시에 보관하여 응답 지연 시간과 API 토큰 비용을 최대 80% 절감하는 최적화 기법.
- 처음 나온 곳: [[08-llm-evaluation-and-cost-optimization]]
- 섞이는 말: [[인공지능-평가]], [[프롬프트-템플릿]]

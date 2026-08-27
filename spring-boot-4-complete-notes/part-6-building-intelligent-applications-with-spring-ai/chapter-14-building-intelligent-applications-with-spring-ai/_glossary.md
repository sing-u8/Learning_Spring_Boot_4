# Building Intelligent Applications with Spring Ai 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## spring-ai
AI 모델 벤더(Vendor)들의 서로 다른 API 스펙을 하나의 공통 자바 인터페이스로 추상화하여, 벤더 종속성 없이 AI 애플리케이션을 개발할 수 있게 해주는 스프링 생태계 프로젝트
- 처음 나온 곳: [[01-introducing-llms-and-spring-ai]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## hallucination
LLM이 자신이 모르는 내용이거나 사실이 아닌 정보에 대해 마치 100% 진실인 것처럼 그럴듯하게 거짓말을 지어내는 현상
- 처음 나온 곳: [[01-introducing-llms-and-spring-ai]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## context-window
LLM이 한 번의 상호작용(프롬프트 + 응답)에서 컨텍스트를 잃지 않고 인지하고 처리할 수 있는 최대 텍스트(토큰) 허용량
- 처음 나온 곳: [[01-introducing-llms-and-spring-ai]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## chat-client
외부 API 호출을 돕는 RestClient처럼, 복잡한 LLM 호출 과정을 빌더 패턴과 체이닝으로 단순화시킨 Spring AI의 핵심 통신 컴포넌트
- 처음 나온 곳: [[02-building-llm-integrations-with-chatclient]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## structured-response
LLM이 생성한 자연어 텍스트를 애플리케이션이 다루기 쉬운 JSON이나 자바 객체(Record 등) 형태로 강제 변환하여 반환받는 기법
- 처음 나온 곳: [[02-building-llm-integrations-with-chatclient]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## sse
Server-Sent Events. HTTP 연결을 끊지 않고 유지한 상태에서, 서버가 클라이언트(브라우저) 쪽으로 스트리밍 데이터(AI 응답 토큰 등)를 실시간으로 계속 밀어내는(Push) 웹 기술
- 처음 나온 곳: [[02-building-llm-integrations-with-chatclient]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## prompt-template
하드코딩된 프롬프트 문자열 대신, {language} 같은 플레이스홀더를 가진 외부 파일(.st)을 정의하고 런타임에 Map 데이터와 치환하여 완성된 프롬프트를 찍어내는 템플릿 엔진
- 처음 나온 곳: [[03-designing-prompts-and-tool-calling]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## tool-calling
모델 스스로 해결할 수 없는 문제(실시간 데이터 조회, 외부 API 통신 등)를 마주했을 때, 사전에 제공받은 개발자의 함수(Tool)를 역으로 호출하여 결괏값을 받아낸 뒤 답변을 완성하는 AI 추론 기법
- 처음 나온 곳: [[03-designing-prompts-and-tool-calling]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## rag
Retrieval-Augmented Generation. AI에게 질문할 때 질문 내용만 보내는 것이 아니라, 관련된 프라이빗 문서를 검색(Retrieval)해서 프롬프트에 추가(Augmented)하여 답변을 생성(Generation)하는 기술
- 처음 나온 곳: [[04-implementing-rag-with-vector-stores-and-advisors]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## vector-store
텍스트의 의미적 특성을 실수 배열(벡터) 형태로 저장하고, 유저의 질문과 수학적 거리가 가장 가까운(유사한) 문서를 빠르게 찾을 수 있도록 최적화된 데이터베이스 (예: pgvector, Chroma)
- 처음 나온 곳: [[04-implementing-rag-with-vector-stores-and-advisors]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## advisor
Spring AI에서 ChatClient의 요청 전/후를 가로채어 공통된 부가 기능(문서 검색 후 프롬프트 주입, 대화 기록 로깅, 이전 대화 내용 주입 등)을 끼워 넣을 수 있게 해주는 인터셉터 패턴 객체
- 처음 나온 곳: [[04-implementing-rag-with-vector-stores-and-advisors]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## message-window-chat-memory
이전 대화 내역 전체를 무한정 저장하지 않고, 가장 최근에 주고받은 특정 갯수(또는 크기)의 윈도우(Window)만큼만 잘라서 메모리에 유지하는 챗봇 컨텍스트 관리 기법
- 처음 나온 곳: [[05-building-chatbots-and-mcp-integration]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## mcp
Model Context Protocol. 서로 다른 프레임워크나 언어로 만들어진 AI 애플리케이션 간에 툴(도구)과 데이터 리소스를 표준화된 규격으로 공유하고 호출할 수 있게 해주는 공용 프로토콜
- 처음 나온 곳: [[05-building-chatbots-and-mcp-integration]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## llm-as-a-judge
문자열 매칭 기반의 기존 테스트 방식이 통하지 않는 AI의 답변 품질(환각 여부, 연관성)을 평가하기 위해, 또 다른 LLM을 심사위원으로 사용하여 검증하는 테스트 자동화 패턴
- 처음 나온 곳: [[06-operating-llm-applications-security-and-evaluation]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## prompt-injection
시스템의 본래 목적을 무력화시키고 탈취하기 위해, 악의적인 사용자가 입력창에 교묘한 지시어("이전 지시 무시해")를 삽입하여 AI가 의도치 않은 동작을 수행하게 만드는 보안 공격 기법
- 처음 나온 곳: [[06-operating-llm-applications-security-and-evaluation]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## prompt-caching
여러 번의 API 요청에 걸쳐 반복적으로 등장하는 앞부분 텍스트(예: 거대한 시스템 프롬프트, 컨텍스트용 긴 문서)의 연산 결과를 서버 측에 저장해두고 재사용하여 응답 속도를 높이고 API 비용을 아끼는 기술
- 처음 나온 곳: [[06-operating-llm-applications-security-and-evaluation]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

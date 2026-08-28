# 모범답안 — 06a 애플리케이션 도구를 MCP 서버로 노출

> **먼저 답하고 나서 열 것.** [[06a-exposing-application-tools-as-an-mcp-server]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-29
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `@Tool`과 `@McpTool`의 차이 — 누가 볼 수 있는가

> **`@Tool`과 `@McpTool`의 차이는 문법이 아니라 누가 볼 수 있는가다. 앞의 것은 이 `ChatClient`만, 뒤의 것은 프로토콜에 연결한 아무 client나.**

```java
@Tool(description = "...")     → 이 프로세스의 ChatClient 만
@McpTool(description = "...")  → MCP 로 연결한 모든 client
```

**[[04b-tool-calling]]의 `ProductTools`와 나란히 놓으면 문법이 거의 같다** — **평범한 `@Component`, 평범한 메서드, 그리고 annotation 하나.**

**`@McpTool`**: **Java method를 MCP 프로토콜로 노출되는 도구로 만드는 annotation** — **`@Tool`이 프로세스 안에서 하던 일을 프로토콜 너머로 확장**한다.

**`description`의 역할도 같다** — **AI model이 언제 어떻게 쓸지 판단하는 근거**이고 **모호한 설명은 안 불리거나 잘못 불린다.** **`name`을 생략하면 메서드 이름이 도구 이름**이 되는 것도 같다.

**둘 다 붙일 수 있나**(§5) — **개념상 가능하다.** 다만 **그 순간 노출 범위가 넓어진다**는 사실을 의식해야 한다. **이 장의 예제는 도구 클래스를 따로 두어 범위를 명시적으로 갈랐다.**

---

## Q2. `annotation-scanner.enabled=false`로 두면

**`@McpTool`이 붙은 메서드를 찾아 노출하는 단계 자체가 돌지 않는다.**

> **세 번째 줄이 없으면 `@McpTool`이 붙은 메서드를 찾아 노출하는 단계 자체가 돌지 않기 때문이다.**

**증상**: **서버는 뜨고 `/sse`도 열리는데 도구 목록이 비어 있다.** client가 붙어도 **아무것도 발견하지 못한다.** **오류는 안 난다.**

**설정 세 줄**:
| property | 하는 일 | **왜** |
|---|---|---|
| `type=SYNC` | **동기 실행. Servlet 스택 사용** | **도구 메서드가 블로킹이어도 된다** |
| `protocol=SSE` | **SSE로 MCP endpoint 노출** | **기존 MCP client와의 호환** |
| **`annotation-scanner.enabled=true`** | **Spring bean에서 MCP annotation을 자동 스캔** | **도구를 수동 등록하지 않아도 된다** |

**`type=SYNC`와 `protocol=SSE`는 다른 축이다**(§5) — **전자는 서버 내부 실행 모델(동기/비동기), 후자는 네트워크 전송 방식**이다. **둘 다 `spring.ai.mcp.server.*` 아래 있어서 더 헷갈린다.**

**starter 이름의 `-webmvc`도 짝을 이룬다** — **Servlet 스택 위에 얹힌다는 뜻이고, 그래서 `type=SYNC`와 짝**이 된다.

> **`protocol`에 대한 단서**: **SSE는 여전히 지원되지만 MCP 사양은 원격 서버의 권장 transport를 Streamable HTTP로 옮겼다.** **새로 만드는 원격 MCP 서버라면 `protocol=STREAMABLE`을 고려**한다(§6).

---

## Q3. 도구 셋이 전부 읽기 전용인 것

**노출된 도구는 우리가 모르는 client가 부르기 때문이다.**

> **창구 직원은 "그건 곤란합니다"라고 거절하지만, 노출된 도구는 호출되면 그냥 실행된다. 그래서 MCP로 내보내는 도구는 `@Tool`보다 더 좁게 설계해야 한다 — 이 예제의 셋이 전부 읽기 전용인 것은 우연이 아니다.**

**셋**: `getProductPrice`(조회), `getCurrentDateTime`(조회), `getReturnPolicy`(조회).

**§6의 지침**: **부수효과가 있는 도구를 신중히 고른다.** **조회는 노출하되 `deleteOrder`·`refundPayment` 같은 것은 다시 생각한다.**

**`@Tool`과의 차이가 여기서 실질적이 된다** — **[[04b-tool-calling]]에서도 부수효과 도구를 조심하라고 했지만**, 거기서는 **우리 애플리케이션이 유일한 호출자**였다. **MCP는 호출자가 통제 밖**이다.

**그리고 인증이 없다**(§6) — **이 예제의 MCP 서버에는 인증이 없다. `curl -N`으로 아무나 붙는다.** **학습용 구성이고, 실제로는 인증·인가·rate limit을 앞에 세워야** 한다.

**비유의 깨짐이 그 둘이다** — 사내 파트너용 창구 — **실제 창구에는 신분 확인이 있고, 창구 직원은 거절할 수 있다.**

---

## Q4. `description` 변경이 API 변경에 준하는 이유

**외부 client의 model이 그 설명을 근거로 도구를 고르므로, 설명을 바꾸면 호출 패턴이 바뀐다.**

> **도구 이름·설명을 계약처럼 다룬다. API 시그니처를 바꾸는 것과 같은 무게로 다뤄야 한다.**

```
"Returns the current price of a TechStore product by SKU."
        ↓ "Returns product info." 로 바꾸면
파트너사의 model 이 이 도구를 덜 고르거나 엉뚱할 때 고른다
        ↓
우리는 배포했을 뿐인데 남의 챗봇 동작이 바뀐다
```

**REST API와 다른 점**: REST는 **시그니처가 바뀌어야** client가 깨지지만, MCP 도구는 **설명만 바뀌어도 동작이 바뀐다.** **자연어가 계약의 일부**이기 때문이다.

**그리고 그 변화가 조용하다** — **컴파일 오류도, 404도 없다.** **호출 빈도와 정확도만 달라진다.**

**대응**: 설명 변경을 **버전 관리하고, 변경 시 알리고, 가능하면 기존 표현을 유지**한다. [[04b-tool-calling]]의 "설명이 도구 선택을 결정한다"가 **외부 계약 층으로 올라온 것**이다.

**확인 방법도 함께**: 서버는 **`http://localhost:8080/sse`**에 뜨고, **`curl -N`**의 `-N`(= `--no-buffer`)이 필요한 이유는 [[03-reactive-streaming-with-chatclient]]와 같다 — **SSE는 연결을 열어 둔 채 이벤트를 흘리므로 curl이 버퍼링하면 아무것도 안 보인다.**

**다만 `/sse`가 도구 목록 endpoint가 아니다**(§5) — **MCP는 JSON-RPC 프로토콜이고 `/sse`는 그 메시지가 흐르는 통로**다. **`curl -N`으로 보이는 것은 연결이 살아 있다는 신호**이지 사람이 읽으라고 만든 목록이 아니다. **그래서 MCP Inspector**(`@modelcontextprotocol/inspector`)**가 유용**하다 — **브라우저 UI로 붙어 도구 목록을 발견하고 직접 호출**해 볼 수 있다.

---

## 재출제 문항

1. 같은 메서드에 `@Tool`과 `@McpTool`을 둘 다 붙였다. 무엇이 달라지는가?
2. MCP 서버는 떴는데 client가 도구를 못 찾는다. 어느 설정을 보는가?
3. `type`과 `protocol`은 각각 무엇을 정하는가?
4. `refundPayment`를 MCP로 노출하려 한다. `@Tool`일 때와 무엇이 다른가?
5. 도구 설명의 문구만 다듬었다. 파트너사에 알려야 하는가?
6. `curl -N http://localhost:8080/sse`로 도구 목록을 보려 했다. 왜 안 보이는가?

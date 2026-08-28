# 모범답안 — 07a Spring Boot에서 AOT 캐시 켜기

> **먼저 답하고 나서 열 것.** [[07a-enabling-aot-cache-for-spring-boot]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. `-Dspring.context.exit=onRefresh`가 없으면

**서버가 계속 살아 있어서 training run이 끝나지 않는다.**

```bash
java -XX:AOTCacheOutput=app.aot -Dspring.context.exit=onRefresh -jar target/ch8-...jar
                                 └──────────────┬──────────────┘
                             context refresh 가 끝나면 JVM 을 종료한다
```

> **training run은 "떠 보는 것"이 목적이다. 안 끄면 서버가 계속 살아 있다.**

**그리고 캐시 파일이 안 나온다** — `AOTCacheOutput`은 **JVM이 종료될 때** 산출물을 쓴다. 프로세스가 안 죽으면 **파일이 생기지 않거나** 사람이 `Ctrl-C`로 죽여야 하는데, 그러면 **CI 자동화가 불가능**하다.

**`spring.context.exit`**: **`onRefresh`를 주면 refresh 직후 JVM을 종료시키는 Spring Framework 속성.** **6.1부터 있고 `DefaultLifecycleProcessor`가 구현한다.**

> **이 속성 덕에 "애플리케이션을 완전히 초기화해 보되 서비스는 시작하지 않는" 실행이 가능해진다.**

**이것이 "AOT cache는 Spring 기능이 아니다"에도 Spring 이야기가 끼는 이유 중 하나다** — 가장 단순한 형태로는 **JVM 옵션만으로** 쓰지만, **"떴다가 바로 끄는" 스위치를 Spring이 제공**한다.

**옵션 이름 혼동 주의**: **`Output`이 붙으면 쓰기(training), 없으면 읽기(사용)** — `-XX:AOTCache=app.aot`.

---

## Q2. 공식 문서가 `jarmode=tools extract`를 먼저 시키는 이유

**uber JAR의 중첩 JAR 로딩 구조가 AOT cache 친화적이지 않기 때문이다.**

```bash
java -Djarmode=tools -jar my-app.jar extract --destination application
cd application
java -XX:AOTCacheOutput=app.aot -Dspring.context.exit=onRefresh -jar my-app.jar
```

**문서가 밝히는 이유**: **풀어낸 JAR은 애플리케이션 코드와 추출된 JAR 참조만 담아 "시작이 효율적이고 AOT cache 친화적인 배치"**이기 때문이다.

**uber JAR 구조와 대조하면**([[../chapter-7-releasing-an-application-with-spring-boot/01-creating-an-uber-jar|Ch7]]):
```
uber JAR:  BOOT-INF/lib/*.jar  ← JAR 안의 JAR. Spring Boot 로더가 읽는다
extract:   application/lib/*.jar ← 평범한 파일. 표준 클래스로더가 읽는다
```

**중첩 JAR을 읽으려면 커스텀 클래스로더가 필요**한데, **AOT 캐시가 기록하는 클래스 로딩·링크 결과가 그 경로에 잘 맞지 않는다.** 풀어내면 **표준 경로**가 되어 캐시가 제대로 작동한다.

> **책이 빠뜨린 단계다** — 책은 training run을 **uber JAR에 직접** 건다. **공식 Dockerfile 예제도 extract 순서**다. **책 절차를 그대로 따라도 캐시는 만들어지지만, 공식 절차만큼의 효과는 기대하기 어렵다.**

> **또 하나 책이 언급하지 않는 함정 — 힙이 두 배 필요하다.** `-XX:AOTCacheOutput`의 one-step 워크플로는 **캐시를 만드는 하위 호출이 training run과 같은 크기의 자기 힙을 따로 쓴다.** `-Xms4g -Xmx4g`와 함께 쓰면 **환경에 8GB가 필요하다.** **컨테이너에서 메모리 상한을 걸고 CI에서 캐시를 굽다가 원인 불명으로 죽는다면 여기를 먼저 본다.**

---

## Q3. "대표적 동작"과 "refresh 후 종료"의 충돌

**`spring.context.exit=onRefresh`는 refresh 직후 끄므로, 로그인·API 호출·DB 질의를 할 시간이 없다.**

**책이 요구하는 것**: **training run에서 현실적이고 대표적인 동작을 시켜야 한다** —
- 로그인해 보기
- API 호출 돌려 보기
- DB 질의 실행하기
- 자주 쓰는 endpoint 접근하기

**이유**: **밟지 않은 경로는 캐시에 없다.** **로그인 코드를 한 번도 실행하지 않으면 그 부분의 컴파일 산출물이 기록되지 않고, 실제 운영에서 첫 로그인은 여전히 cold다.**

**충돌**:
```
onRefresh 종료  →  context 초기화까지만 훈련된다
대표적 동작     →  endpoint 를 실제로 밟아야 한다
                    ↑ 한 명령으로는 둘 다 못 한다
```

> **책은 둘을 같은 절에 나란히 적어 놓았지만 한 명령으로는 둘 다 못 한다.**

**해결**: **깊은 훈련이 필요하면 종료를 미루고 부하를 거는 별도 절차를 짜야 한다** — `spring.context.exit`를 빼고, 부하 스크립트를 돌린 뒤, **정상 종료 신호**를 보내 캐시를 쓰게 한다.

**즉 책의 명령은 "context 초기화까지만" 훈련하는 가장 단순한 형태**다. 그것만으로도 **bean 생성·자동 구성·프록시 생성 경로**가 캐시되므로 이득이 있지만, **요청 처리 경로는 안 담긴다.**

**[[06-using-buildpacks-with-java-aot-cache]]에도 같은 한계가 있다** — **빌드 중 실행이라 DB 같은 외부 의존성에 붙지 못할 수 있고, 그러면 밟는 경로가 얕아진다.**

---

## Q4. `app.aot`를 재생성해야 하는 세 조건

> **`app.aot` 파일은 정확히 같은 애플리케이션 빌드와 JVM 버전에 맞아야 한다.**

| 바뀐 것 | **왜** |
|---|---|
| **애플리케이션 재빌드** | **클래스가 달라졌다** |
| **의존성 변경** | **로드되는 클래스 집합이 달라졌다** |
| **JDK 버전 변경** | **컴파일 산출물의 형식·전제가 달라졌다** |

**CI/CD에 주는 함의가 크다** — **캐시 생성을 빌드 파이프라인에 넣어야 한다.** **손으로 한 번 만들어 두고 재사용하는 방식은 곧 어긋난다.**

**어긋나면 어떻게 되나**: **경고 후 평소대로 시작한다.** **배포가 깨지지 않는다** — **AOT 캐시는 정확성에 관여하지 않는다.**

**그래서 위험이 "실패"가 아니라 "조용한 무효화"다** — 캐시가 안 맞아도 **아무도 모른 채 개선이 사라진다.** 성능 회귀로만 나타나므로 **모니터링이 없으면 발견이 늦다.**

**비유로 보면** 시험 전 모의고사 — **거기서 푼 유형은 본시험에서 빨리 풀린다.** **깨지는 지점 둘**:
- **모의고사는 범위가 조금 달라도 도움이 되지만 AOT 캐시는 빌드가 한 글자만 달라도 통째로 무효**다
- **학생은 모의고사를 안 봐도 시험을 칠 수 있고 결과만 나쁘다** — **캐시도 없으면 그냥 느릴 뿐 실패하지 않는다**

**두 번째가 도입 리스크가 낮은 이유이고, 첫 번째가 파이프라인 통합이 필수인 이유다.**

**§6의 나머지 지침**: **컨테이너에서는 buildpack이 더 간단하다**([[06-using-buildpacks-with-java-aot-cache]]가 이 절차를 대신 해 준다) · **Java 24 미만에서는 못 쓴다** · **개선 폭을 미리 약속하지 않는다** — **애플리케이션과 하드웨어에 따라 크게 다르므로 측정이 먼저다.**

---

## 재출제 문항

1. training run을 돌렸는데 `app.aot`가 안 생긴다. 무엇이 빠졌는가?
2. `-XX:AOTCache`와 `-XX:AOTCacheOutput`을 바꿔 썼다. 어느 쪽이 training인가?
3. uber JAR에 직접 training을 걸면 왜 효과가 덜한가?
4. CI에서 캐시 굽기가 원인 불명으로 죽는다. 메모리 관련해 무엇을 의심하는가?
5. 로그인 경로가 여전히 느리다. training run에서 무엇을 안 했는가?
6. 의존성 하나를 올렸는데 startup이 다시 느려졌다. 배포는 깨졌는가?

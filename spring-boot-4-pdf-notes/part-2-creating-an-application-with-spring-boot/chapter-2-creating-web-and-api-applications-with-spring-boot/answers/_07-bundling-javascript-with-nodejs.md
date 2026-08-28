# 모범답안 — 07 Node.js로 JavaScript 번들링하기

> **먼저 답하고 나서 열 것.** [[07-bundling-javascript-with-nodejs]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다. `§2.3`이 이미 경로 문제를 다이어그램으로 풀어 두었다.

---

## Q1. `<script>` 태그로 하나씩 부르는 방식이 무너지는 네 지점

1. **순서를 사람이 관리해야 한다.** `App.js`가 `ListOfVideos.js`보다 먼저 로드되면 깨진다. 파일이 늘수록 이 목록이 지뢰밭이 된다.
2. **`import`/`export`가 그대로는 안 돈다.** `import React from "react"`의 `"react"`는 **URL이 아니다.** 브라우저가 패키지 이름을 해석하지 못한다.
3. **JSX는 브라우저가 이해하지 못한다.** `<App />`은 JavaScript가 아니다. **누군가 변환해야 한다.**
4. **요청이 파일 수만큼 늘어난다.** 의존성까지 합치면 수십·수백 개다.

**1과 4는 "합치기"로, 2와 3은 "변환"으로 풀린다.** 번들러가 둘 다 한다 — 그래서 "번들러"라는 이름이 실제 역할의 **절반만** 담고 있다.

---

## Q2. Parcel을 `--save-dev`로 설치하는 이유

> **판별 질문: "사용자의 브라우저에서 이 코드가 실행되는가?"**

**아니다. 번들러는 번들을 만드는 도구이지 번들 안에 들어가는 코드가 아니다.** 사용자의 브라우저는 Parcel을 실행하지 않는다.

| | `--save-dev` | `--save` |
|---|---|---|
| 뜻 | **개발 의존성** — 빌드·테스트에만 필요 | 앱 코드가 실제로 쓰는 것 |
| 배포물에 | 들어가지 않는다 | 들어간다 |
| 예 | **Parcel** | **React** ([[07a-creating-a-reactjs-app]]) |

**Maven에 대응시키면** `provided`나 `test` scope와 같은 발상이다. 빌드에는 필요하지만 배포 산출물에는 없어야 하는 것.

**구분을 안 하면**: 번들러가 앱 의존성으로 잡히면 배포물이 불필요하게 커지고, 보안 스캔 대상도 늘어난다. 무엇보다 **"이 프로젝트가 실제로 무엇을 쓰는가"를 `package.json`만 보고 알 수 없게 된다.**

---

## Q3. `source`를 하나만 지정해도 되는 이유

**번들러가 엔트리 포인트에서 `import` 그래프를 따라가기 때문이다.**

```json
"source": "src/main/javascript/index.js"
```

Parcel은 이 파일을 읽고, 그 안의 `import`를 따라가고, 그 파일들의 `import`를 또 따라간다. **도달 가능한 모듈을 전부 모은다.** 시작점 하나만 알려 주면 나머지는 자동으로 발견된다.

**반대로 말하면**: **어디서도 import되지 않는 파일은 번들에 들어가지 않는다.** 파일을 만들어 두고 아무 데서도 안 불렀으면 그냥 없는 것과 같다.

**이 성질의 부수 효과 두 가지**:
- **죽은 코드가 자동으로 빠진다.** 안 쓰는 모듈이 번들 크기를 늘리지 않는다.
- **"파일을 만들었는데 안 돈다"의 원인이 대개 이것이다.** import 사슬에 연결하지 않았기 때문이다.

Q1의 1번(순서 관리)이 여기서 사라지는 이유이기도 하다 — **의존 관계가 곧 순서**이므로 사람이 나열할 필요가 없다.

---

## Q4. 출력 경로가 `target/classes/static`인 두 이유

**① Maven clean과 함께 지워진다.** 책이 명시하는 이유다. `target/`은 빌드 산출물 디렉터리이므로 `mvn clean`이 통째로 지운다. 옛 번들이 남아 혼란을 주는 일이 없다.

**② 소스와 산출물이 섞이지 않는다.** `src/main/resources/static`에 두면 손으로 쓴 파일과 빌드가 만든 파일이 한 폴더에 섞이고, `.gitignore`가 지저분해진다. `target/` 아래에 바로 만들면 **그 문제가 애초에 없다.**

**둘 다 같은 원리의 두 얼굴이다** — 생성물은 생성물 자리에 둔다.

---

## Q5. "`src/main/resources/static`에 두면 서빙된다"와 "Parcel은 `target/classes/static`에 쓴다"

**모순이 아니다. 둘은 최종적으로 같은 자리에 도착한다.**

```text
Maven의 process-resources 단계:
  src/main/resources/**  ──복사──▶  target/classes/**

런타임에 클래스패스 루트로 쓰이는 것은 target/classes/ 다.

  src/main/resources/static/logo.png  ─복사─▶ target/classes/static/logo.png → GET /logo.png
  (Parcel이 직접 생성)                        target/classes/static/index.js  → GET /index.js
```

**차이는 도착 방법뿐이다** — 하나는 **복사되어** 오고 하나는 **생성되어** 온다.

"`src/main/resources/static`에 두면 서빙된다"는 말은 정확히는 **"거기 둔 파일이 `target/classes/static`으로 복사되고, 거기 있는 것이 서빙된다"**의 줄임이다. 중간 단계를 생략한 표현이라 모순처럼 들릴 뿐이다.

**실무 규칙**: **손으로 두는 파일은 `src/` 쪽에, 빌드가 만드는 파일은 `target/` 쪽에.**

---

## Q6. execution 세 개의 실행 순서를 무엇이 보장하는가

**Maven의 규칙이다 — 같은 생명주기 단계에 묶인 execution들은 `pom.xml`에 선언된 순서대로 실행된다.**

| 순서 | id | goal | 하는 일 | 왜 이 순서여야 하나 |
|---:|---|---|---|---|
| 1 | (기본) | `install-node-and-npm` | Node·npm·npx를 `node/`에 설치 | **뒤의 두 단계를 실행할 도구**가 있어야 하므로 |
| 2 | `npm install` | `npm` | 의존성을 `node_modules/`에 설치 | **Parcel이 있어야** 빌드가 가능하므로 |
| 3 | `npx run` | `npx` | `parcel build` 실행 | 앞 두 단계의 **결과물을 소비**하므로 |

**각 단계가 앞 단계의 산출물을 필요로 한다.** 1이 없으면 2를 실행할 npm이 없고, 2가 없으면 3이 실행할 Parcel이 없다.

**그리고 셋 모두 `generate-resources`에서 돈다** — `compile`·`package`보다 앞이므로 번들이 최종 JAR에 들어간다 ([[06-integrating-nodejs-with-a-spring-boot-web-app]] Q3).

**주의**: 이 순서 보장은 **선언 순서에 의존한다.** `pom.xml`에서 execution 블록의 위치를 바꾸면 실행 순서가 바뀐다. 명시적인 의존 선언이 아니라 **암묵적인 텍스트 순서**라는 점이 취약하다.

---

## Q7. `npm`과 `npx`의 차이

> **`npm`은 가져오는 도구, `npx`는 돌리는 도구다.**

책의 구분 — "`npm`이 패키지를 내려받고 설치하는 Node.js의 도구라면, `npx`는 **명령을 실행하는** Node.js의 도구다."

**Maven 개념에 대응시키면**:

| Node | Maven | 하는 일 |
|---|---|---|
| `npm install` | `mvn dependency:resolve` — 의존성을 로컬에 확보 | **가져오기** |
| `npx parcel build` | `mvn exec:java` / 플러그인 goal 실행 | **돌리기** |
| `package.json`의 `dependencies` | `pom.xml`의 `<dependencies>` | 무엇이 필요한지 선언 |
| `node_modules/` | `~/.m2/repository` | 받아 둔 것들 |

`npx`가 따로 존재하는 이유는 **설치된 패키지의 실행 파일 경로를 알아서 찾아 주기 때문**이다. `node_modules/.bin/parcel`을 직접 치지 않아도 된다.

이 구분이 execution 두 개(`npm install` / `npx parcel build`)로 그대로 대응한다.

---

## Q8. 번들이 안 만들어졌을 때 어느 execution부터 의심하나

**3번(`npx run`)부터다.** 실제로 번들을 만드는 유일한 단계이기 때문이다.

**여기가 책의 표현이 헷갈리게 만드는 지점이다.** 책은 2번 execution을 "우리 JavaScript 번들을 빌드할 명령인 `npm install`을 실행하도록 구성한다"고 적는데, 엄밀히는 `npm install`은 **의존성을 채우는** 단계다. **번들을 만드는 것은 `npx parcel build`다.**

**진단 순서**는 역방향으로 올라간다.

1. **3번이 실행됐는가?** 로그에 `parcel build`가 보이는가. `<phase>`가 빠지거나 잘못됐으면 아예 안 돈다.
2. **`source` 경로가 맞는가?** `src/main/javascript/index.js`가 실제로 있는가. 없으면 Parcel이 시작점을 못 찾는다.
3. **`distDir`이 맞는가?** 번들이 다른 곳에 생겼을 수 있다.
4. **2번이 성공했는가?** Parcel이 `node_modules/`에 없으면 3번이 실패한다.
5. **1번이 성공했는가?** npm 자체가 없으면 2번이 실패한다.

**그리고 "안 만들어졌다"와 "만들어졌는데 서빙이 안 된다"를 먼저 갈라야 한다.** `target/classes/static/`을 직접 열어 보면 5초에 판별된다. 파일이 있으면 번들링 문제가 아니라 경로·서빙 문제다.

---

## 재출제 문항

1. JS 파일을 새로 만들었는데 번들에 안 들어간다. 무엇을 안 했겠는가?
2. `pom.xml`에서 execution 블록의 순서를 바꿨다. 무슨 일이 일어나는가? 이 취약성을 어떻게 볼 것인가?
3. React를 `--save-dev`로 설치했다. 무엇이 잘못되는가?
4. `distDir`을 `src/main/resources/static`으로 바꾸면 동작하는가? 왜 권하지 않는가?
5. 번들이 `target/classes/static/`에 있는데 `GET /index.js`가 404다. 어디를 보겠는가?
6. `npm`과 `npx`를 Maven으로 설명해 보라.

---
category: frontend-integration
concept: javascript-bundling-react
title: "JavaScript 번들링과 React 앱 구성"
source: "Learning Spring Boot 4, Ch. 2, pp. 50-58 (PDF pp. 75-83)"
terms: [Parcel, bundle, React, JSX, component state, fetch API]
status: seed
---

# JavaScript 번들링과 React 앱 구성

## 한눈에 보기

책은 Parcel을 개발 의존성으로 설치하고 `src/main/javascript/index.js`를 `target/classes/static`에 번들링한다. React는 Mustache가 제공한 `<div id="app">`에 마운트되고, `fetch`로 `/api/videos`를 조회·생성한다.

## 1. 왜 이게 필요한가

간단한 서버 렌더링 화면은 Mustache가 충분하지만, 화면 상태에 따라 여러 컴포넌트가 자주 바뀌는 UI는 클라이언트 렌더링이 편하다. 번들러는 모듈·JSX·의존성을 브라우저가 로드할 산출물로 바꾼다.

## 2. 어떻게 동작하는가

1. npm으로 Parcel과 `react`, `react-dom`을 설치한다.
2. `package.json`에서 진입 파일과 출력 디렉터리를 정하고 Maven이 `npm install`, `npx parcel build`를 호출한다.
3. `index.js`가 DOM의 `app` 요소를 찾아 React root와 `<App/>`을 렌더링한다.
4. 목록 컴포넌트는 마운트 후 GET API를 호출하고 응답을 내부 state에 저장한다.
5. 폼 컴포넌트는 입력 state를 관리하다 제출 시 JSON POST를 보낸다.
6. state가 변하면 React가 가상 표현과 실제 DOM 차이를 계산해 필요한 부분을 갱신한다.

책의 코드에는 개념 설명용 단순화가 있다. 실제 프로젝트라면 로딩·오류 상태, 목록 key, 비동기 응답 검사, CSRF와 인증을 함께 다뤄야 한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart TD
    J[src/main/javascript] --> P[Parcel]
    P --> B[index.js bundle]
    B --> R[React App]
    R --> L[ListOfVideos state]
    R --> F[NewVideo form state]
    L -->|GET| A[/api/videos]
    F -->|POST JSON| A
    A --> L
```

## 4. 이 노트에 나온 용어

- **bundle**: 소스 모듈과 의존성을 브라우저 배포용 파일로 결합·변환한 산출물.
- **JSX**: JavaScript 안에서 UI 구조를 선언하는 React 문법 확장.
- **component state**: 컴포넌트 내부에서 변하며 재렌더링을 일으키는 데이터.
- **fetch API**: 브라우저가 HTTP 요청을 보내는 표준 비동기 API.

## 7. 연결

- [[06-integrating-nodejs-with-a-spring-boot-web-app]] — Maven과 Node 도구를 연결하는 앞 단계다.
- [[05-creating-json-based-apis]] — React의 데이터 소스와 변경 대상이다.
- [[chapter-4-securing-an-application-with-spring-boot/04-csrf-or-not-to-csrf|CSRF]] — 브라우저 기반 변경 요청은 보안 토큰 전략이 필요하다.

## 8. 스스로 확인

- 전체 1차 정리 후: React의 state 변화가 API 응답에서 DOM 갱신까지 이어지는 과정을 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



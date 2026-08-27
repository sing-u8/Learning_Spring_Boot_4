---
category: deployment
concept: native-buildpack-image
title: "GraalVM Native Container Image 만들기"
source: "Learning Spring Boot 4, Ch. 8, pp. 240-241 (PDF pp. 265-266)"
terms: [native image buildpack, BP_NATIVE_IMAGE, builder image, run image, Spring Native, reachability metadata]
status: seed
---

# GraalVM Native Container Image 만들기

## 한눈에 보기

`BP_NATIVE_IMAGE=true ./mvnw spring-boot:build-image`는 Buildpack builder 안에서 native executable을 compile하고 작은 run image에 넣는다. Local machine에 GraalVM을 직접 설치하지 않아도 target Linux container image를 만들 수 있다.

## 1. 왜 이게 필요한가

Native compiler와 C toolchain 설치는 OS마다 다르고 산출물도 platform-specific이다. Builder image가 build environment를 고정하면 개발자와 CI가 같은 toolchain으로 repeatable image를 만든다.

## 2. 어떻게 동작하는가

Boot plugin이 Paketo builder에 native-image buildpack option을 전달한다. Builder가 Spring AOT output과 reachability metadata를 사용해 Linux executable을 생성하고 JVM이 없는 run image에 layer로 배치한다. Runtime image는 작지만 build time/resource는 JVM image보다 커질 수 있다.

과거 experimental `Spring Native` 프로젝트는 Boot 2 시대의 bridge였다. Boot 4/Framework 7에서는 AOT와 native support가 mainstream이므로 별도 framework를 추가하는 개념이 아니다. “GraalVM Native Support” 선택은 build tooling과 metadata integration을 추가한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    A[Boot artifact + AOT metadata] --> B[Native builder image]
    B --> C[GraalVM compile]
    C --> N[Linux native executable]
    N --> R[small run image]
    R --> D[container registry/runtime]
```

## 4. 이 노트에 나온 용어

- **builder image**: compile toolchain과 buildpacks가 들어 있는 build-time container.
- **run image**: 최종 application process에 필요한 최소 runtime filesystem.
- **reachability metadata**: native analysis가 동적 접근 대상을 보존하도록 주는 정보.

## 7. 연결

- [[chapter-7-releasing-an-application-with-spring-boot/02-building-a-docker-container|JVM Buildpack image]] — 같은 plugin에서 다른 runtime model을 선택한다.
- [[03-building-and-running-a-native-application]] — local native compile의 containerized 대안이다.
- [[05-configuring-reflection-and-runtime-hints]] — builder도 동일 hints를 사용한다.

## 8. 스스로 확인

- 전체 1차 정리 후: native builder image와 final run image가 분리되는 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



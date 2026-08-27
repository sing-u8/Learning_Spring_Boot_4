---
category: spring-aot
concept: runtime-hints
title: "Reflection과 Runtime Hints 구성"
source: "Learning Spring Boot 4, Ch. 8, pp. 241-243 (PDF pp. 266-268)"
terms: [runtime hint, RegisterReflectionForBinding, RuntimeHintsRegistrar, ImportRuntimeHints, MemberCategory, reflection metadata]
status: seed
---

# Reflection과 Runtime Hints 구성

## 한눈에 보기

Spring AOT가 custom reflection·serialization·resource access를 추론하지 못하면 `@RegisterReflectionForBinding` 또는 `RuntimeHintsRegistrar`로 보존할 type과 member category를 명시한다. Hint는 build 시 native image metadata에 포함된다.

## 1. 왜 이게 필요한가

코드에 직접 constructor 호출이 없고 framework가 class name으로 binding하면 static call graph에서는 사용되지 않는 것처럼 보인다. 필요한 metadata가 제거되면 compile은 성공해도 runtime에서 constructor/method/resource를 찾지 못한다.

## 2. 어떻게 동작하는가

Data binding만 필요하면 configuration에 `@RegisterReflectionForBinding(VideoEntity.class)`를 붙인다. 정교한 경우 registrar가 `hints.reflection().registerType`에 `INVOKE_DECLARED_CONSTRUCTORS`, `INVOKE_PUBLIC_METHODS` 같은 category를 등록하고 `@ImportRuntimeHints`로 연결한다. Resource, proxy, serialization도 corresponding API가 있다.

Hint는 빠진 물건을 packing list에 추가하는 escape hatch다. 무차별적으로 모든 member를 등록하면 image 크기와 attack surface가 늘고 closed-world 최적화 이점이 줄어든다. 실제 failure와 usage에 맞춘 최소 hint를 선호한다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    D[동적 binding/reflection] --> H[RuntimeHintsRegistrar]
    H --> T[type + member categories]
    T --> A[Spring AOT metadata]
    A --> N[native image에 보존]
    N --> R[runtime reflective access]
```

## 4. 이 노트에 나온 용어

- **runtime hint**: AOT analysis가 동적 사용을 보존하도록 주는 build metadata.
- **RuntimeHintsRegistrar**: reflection/resource/proxy hints를 programmatic하게 등록하는 SPI.
- **MemberCategory**: 보존할 constructor·method·field 접근 범주.

## 7. 연결

- [[02-adapting-an-application-for-native-image]] — hint가 필요한 closed-world 원인이다.
- [[03-building-and-running-a-native-application]] — hint가 consume되는 build 단계다.
- [[04-building-native-container-images]] — container builder에서도 같은 metadata가 적용된다.

## 8. 스스로 확인

- 전체 1차 정리 후: reflection을 전부 등록하는 것이 좋은 해결이 아닌 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



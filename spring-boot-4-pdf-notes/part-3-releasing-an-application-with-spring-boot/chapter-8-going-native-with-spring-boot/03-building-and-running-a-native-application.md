---
category: spring-aot
concept: native-maven-build
title: "Native Spring Boot 애플리케이션 Build와 실행"
source: "Learning Spring Boot 4, Ch. 8, pp. 235-240 (PDF pp. 260-265)"
terms: [GraalVM JDK, native-image, native Maven profile, native compile, platform-specific executable, AOT processing]
status: seed
---

# Native Spring Boot 애플리케이션 Build와 실행

## 한눈에 보기

GraalVM JDK 25와 native-image toolchain을 선택하고 `./mvnw -Pnative clean native:compile`로 Spring AOT와 GraalVM compile을 실행한다. 결과는 JAR가 아니라 build OS/architecture 전용 실행 파일이며 JRE 없이 직접 시작된다.

## 1. 왜 이게 필요한가

표준 JDK는 bytecode JAR를 만들 수 있지만 reachability analysis와 native linking toolchain은 제공하지 않을 수 있다. Native profile이 Spring-generated metadata, native Maven plugin, compiler option을 일관되게 연결한다.

## 2. 어떻게 동작하는가

SDKMAN 등으로 standard JDK와 GraalVM distribution을 전환하고 `java -version`, `native-image`를 확인한다. Maven native profile은 context를 AOT 처리한 뒤 call graph를 분석하고 target platform binary를 link한다. Windows는 GraalVM뿐 아니라 C++ compiler와 Windows SDK도 요구한다.

Native build는 JVM package보다 오래 걸리고 더 많은 memory를 쓸 수 있다. 생성 binary를 `file`로 검사하면 Mach-O/ELF와 architecture가 보인다. “write once, run anywhere” bytecode 이식성은 사라지므로 CI matrix나 target platform builder가 필요하다.

## 3. 그림으로 보기

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    S[Spring Boot source] --> A[Spring AOT processing]
    A --> G[GraalVM native-image]
    G --> L[native link]
    L --> E[target OS/CPU executable]
    E --> R[direct process start]
```

## 4. 이 노트에 나온 용어

- **native Maven profile**: Spring AOT와 GraalVM build plugin을 활성화하는 Maven profile.
- **native linking**: machine code와 native libraries를 target executable로 결합하는 단계.
- **platform-specific executable**: 특정 OS와 CPU architecture에서만 직접 실행 가능한 binary.

## 7. 연결

- [[02-adapting-an-application-for-native-image]] — build 전에 만족해야 할 analysis model이다.
- [[04-building-native-container-images]] — host toolchain 없이 builder container에서 compile한다.
- [[05-configuring-reflection-and-runtime-hints]] — runtime 누락이 발생할 때 build metadata를 보강한다.

## 8. 스스로 확인

- 전체 1차 정리 후: native binary가 일반 JAR처럼 어디서나 실행되지 않는 이유를 설명한다.

<!-- ==== 아래는 내 영역 · 스킬 수정 금지 ==== -->

## 내 설명 시도


## 막혔던 지점


## 리뷰 이력



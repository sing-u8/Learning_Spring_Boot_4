# Chapter 7 지도 — Releasing an Application

```mermaid
%%{init: {'theme': 'base', 'themeVariables': {'background': '#ffffff', 'primaryColor': '#e8f1ff', 'primaryTextColor': '#172033', 'primaryBorderColor': '#5b7db1', 'lineColor': '#52647a', 'secondaryColor': '#f7fbff', 'tertiaryColor': '#fff7df'}}}%%
flowchart LR
    J[01 Executable JAR] --> I[02 Buildpack image]
    I --> R[03 Registry]
    R --> S[04 여러 instance]
    C[외부 config] --> S
    D[Shared DB] --> S
```

## 산출물 축

`source → tested executable JAR → layered OCI image → registry digest → configured runtime instances`

## 운영 책임 축

Boot가 packaging과 sensible image build를 단순화하지만 registry 보안, rollout, health/readiness, DB migration, secret과 관측은 배포 시스템이 계속 관리한다.


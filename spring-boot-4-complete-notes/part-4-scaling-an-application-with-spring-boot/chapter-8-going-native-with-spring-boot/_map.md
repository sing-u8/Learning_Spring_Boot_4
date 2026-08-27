# Chapter 8. Going Native with Spring Boot 개념 지도

> 목차가 아니라 관계 지도다. 어떤 문제에서 시작해 구현과 운영 경계로 이동하는지 본다.

## 축 1: 책의 실행 흐름

핵심 질문: 앞 절의 결과가 다음 절의 어떤 입력 또는 전제가 되는가?

[[01-what-is-graalvm]] → [[02-retrofitting-for-graalvm]] → [[03-running-native-spring-boot]] → [[04-baking-a-docker-container-with-graalvm]] → [[05-configuring-reflection-and-runtime-hints]] → [[06-using-buildpacks-with-java-aot-cache]] → [[07-java-25-aot-cache]]

## 축 2: 기반 개념과 선택 기준

핵심 질문: 이 장의 기능을 사용하기 전에 어떤 모델과 트레이드오프를 먼저 알아야 하는가?

- [[01-what-is-graalvm]] — What is GraalVM and why do we care?
- [[02-retrofitting-for-graalvm]] — Retrofitting our application for GraalVM
- [[03-running-native-spring-boot]] — Running our native Spring Boot application inside GraalVM

## 축 3: 구현·검증·운영 경계

핵심 질문: 예제가 동작한 뒤 실제 운영에서 무엇을 추가로 검증해야 하는가?

- [[04-baking-a-docker-container-with-graalvm]] — Baking a Docker container with GraalVM
- [[05-configuring-reflection-and-runtime-hints]] — Configuring Reflection and Runtime Hints
- [[06-using-buildpacks-with-java-aot-cache]] — Using Buildpacks with Java AOT Cache
- [[07-java-25-aot-cache]] — Using Java 25 AOT Cache to reduce startup times

## 나의 취약 엣지

- 아직 인출 연습 전. `[[_global/gaps]]`에 세션 중 발견한 연결 약점을 기록한다.

## 관련 카테고리

- 이전 Chapter의 결과는 이 장의 입력이 되고, 다음 Chapter는 이 장의 결과를 확장한다.
- 전역 연결은 `[[_global/cross-bridges]]`에서 관리한다.

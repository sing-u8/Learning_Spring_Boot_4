# Virtual Threads In Java and Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## virtual-threads
OS 스레드와 1:1로 매핑되지 않고, JVM이 효율적으로 관리하여 블로킹 시 자원을 즉시 양보하는 자바 21의 초경량 스레드
- 처음 나온 곳: [[01-understanding-virtual-threads]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## project-loom
자바 언어의 동시성 모델을 혁신하기 위해 가상 스레드와 구조적 동시성(Structured Concurrency)을 도입한 OpenJDK 프로젝트
- 처음 나온 곳: [[01-understanding-virtual-threads]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## carrier-thread
JVM 내부에서 가상 스레드를 얹어서 실제 CPU에서 실행시켜 주는 토대 역할을 하는 진짜(플랫폼) 스레드
- 처음 나온 곳: [[01-understanding-virtual-threads]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## isvirtual
자바 21의 Thread 클래스에 새로 추가된 메서드로, 현재 스레드가 플랫폼 스레드인지 가상 스레드인지를 boolean 값으로 반환한다
- 처음 나온 곳: [[02-enabling-virtual-threads]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## fork-join-pool
복잡한 작업을 쪼개서 병렬 처리하기 위한 자바의 내장 스레드 풀로, 가상 스레드 아키텍처에서는 가상 스레드를 마운트(Mount)하여 실행시키는 캐리어 스레드들의 집합소 역할을 한다
- 처음 나온 곳: [[02-enabling-virtual-threads]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## task-executor
스프링 프레임워크에서 java.util.concurrent.Executor를 추상화하여 비동기 작업을 스레드 풀에 제출하기 위한 핵심 인터페이스
- 처음 나온 곳: [[03-integrating-with-taskexecutor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## fire-and-forget
메서드를 호출하여 작업을 지시한 후, 그 작업의 완료 여부나 반환값을 기다리지 않고 곧바로 자신의 다음 로직을 진행하는 비동기 패턴
- 처음 나온 곳: [[03-integrating-with-taskexecutor]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## rest-client
Spring Framework 6.1부터 도입된 모던하고 유창한(Fluent) API 방식의 동기식 HTTP 클라이언트로, 구형 RestTemplate의 완벽한 대체재다
- 처음 나온 곳: [[04-restclient-and-http-proxies]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## http-interface-proxy
HTTP 요청의 URL, 파라미터, 헤더 등을 애노테이션(@GetExchange 등)이 달린 Java 인터페이스로 선언하기만 하면 프레임워크가 런타임에 구현체를 생성해주는 선언적 클라이언트 기술
- 처음 나온 곳: [[04-restclient-and-http-proxies]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## web-client
Spring WebFlux 모듈에 포함된 비동기/논블로킹 전용 리액티브 HTTP 클라이언트. 가상 스레드 도입 이후 동기식 애플리케이션에서는 잘 쓰지 않게 되었다
- 처음 나온 곳: [[04-restclient-and-http-proxies]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## completable-future
비동기 연산의 결과를 나중에 반환받거나, 여러 비동기 작업들을 조합(체이닝)하고 예외를 선언적으로 처리할 수 있도록 돕는 자바의 동시성 유틸리티 클래스
- 처음 나온 곳: [[05-error-handling-in-concurrent-tasks]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## structured-concurrency
비동기 스레드 작업들이 아무렇게나 고아(Orphan) 스레드가 되어 떠돌지 않도록, 하나의 범위를 지정해 자식 작업의 성공/실패 수명 주기를 부모와 묶어 안전하게 관리하는 최신 동시성 패러다임
- 처음 나온 곳: [[05-error-handling-in-concurrent-tasks]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

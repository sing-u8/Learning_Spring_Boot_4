# 06-ops-native 용어집

> 이 카테고리에서 쓰는 말의 뜻. 정의는 여기 한 곳에만 둔다.

## 우버-자르 (uber jar)
애플리케이션의 모든 컴파일된 클래스와 외부 의존성 라이브러리(Jar), 그리고 내장 톰캣 서버까지 단 하나의 단독 실행 가능한 파일로 패키징한 실행 파일 (`Executable Fat JAR`).
- 처음 나온 곳: [[01-uber-jar-and-buildpacks-container]]
- 섞이는 말: [[클라우드-네이티브-빌드팩]]

## 클라우드-네이티브-빌드팩 (cloud native buildpacks)
개발자가 수작업으로 Dockerfile을 작성하지 않아도, 소스 코드를 자동으로 감지하여 보안 패치가 적용된 계층형 OCI 컨테이너 이미지로 구워주는 CNCF 표준 빌드 도구 (`bootBuildImage`).
- 처음 나온 곳: [[01-uber-jar-and-buildpacks-container]]
- 섞이는 말: [[우버-자르]], [[도커-컴포즈]]

## 도커-컴포즈 (docker compose)
애플리케이션 컨테이너, 데이터베이스(PostgreSQL), 메시지 브로커(Kafka), 모니터링 스택(Prometheus/Loki) 등 다중 컨테이너 환경을 단일 YAML 파일로 정의하고 일괄 구동하는 도구.
- 처음 나온 곳: [[02-docker-compose-production-scaling]]
- 섞이는 말: [[클라우드-네이티브-빌드팩]]

## 그랄브이엠 (graalvm)
자바 바이트코드를 운영체제 네이티브 기계어 바이너리로 사전 컴파일(AOT)하여 밀리초 단위 기동 속도와 극소 메모리 점유율을 달성하게 해주는 고성능 다국어 지원 런타임.
- 처음 나온 곳: [[03-graalvm-native-image-and-runtime-hints]]
- 섞이는 말: [[에이오티-컴파일]], [[런타임-힌트]]

## 에이오티-컴파일 (ahead of time compilation)
런타임 JIT(Just-In-Time) 컴파일과 동적 클래스 로딩 대신, 빌드 타임에 전체 애플리케이션의 클래스패스와 닫힌 세계(Closed-World)를 정적 분석하여 머신 코드로 빌드하는 컴파일 기법 (AOT).
- 처음 나온 곳: [[03-graalvm-native-image-and-runtime-hints]]
- 섞이는 말: [[그랄브이엠]], [[에이오티-캐시]]

## 런타임-힌트 (runtime hints)
GraalVM AOT 컴파일러가 정적 분석 중에 감지하기 어려운 자바 동적 리플렉션, 직렬화, 프록시, 리소스 번들 등의 접근 대상을 명시적으로 알려주는 스프링 부트 메타데이터 인터페이스 (`RuntimeHintsRegistrar`).
- 처음 나온 곳: [[03-graalvm-native-image-and-runtime-hints]]
- 섞이는 말: [[그랄브이엠]], [[에이오티-컴파일]]

## 에이오티-캐시 (aot cache)
Java 25와 Spring Boot 4에서 도입된 기능으로, 네이티브 이미지 변환 없이도 표준 HotSpot JVM 환경에서 클래스 로딩과 사전 컴파일 메타데이터를 캐싱하여 기동 시간을 대폭 단축하는 경량 최적화 기술.
- 처음 나온 곳: [[04-java25-aot-cache-and-runtime-comparison]]
- 섞이는 말: [[에이오티-컴파일]], [[그랄브이엠]]

## 옵저버빌리티 (observability)
시스템 내부의 상세 코드를 직접 열어보지 않고도, 외부로 방출되는 로그(Logs), 메트릭(Metrics), 트레이스(Traces)의 3대 신호를 수집하여 시스템의 현재 건강 상태와 장애 원인을 추론해 내는 능력.
- 처음 나온 곳: [[05-observability-three-pillars-architecture]]
- 섞이는 말: [[마이크로미터]], [[오픈텔레메트리]], [[분산-추적]]

## 마이크로미터 (micrometer)
다양한 모니터링 시스템(Prometheus, Datadog 등)에 종속되지 않고 애플리케이션의 커스텀 비즈니스 타이머, 카운터, 게이지 메트릭을 수집할 수 있게 해주는 벤더 중립적 메트릭 파사드 라이브러리.
- 처음 나온 곳: [[07-metrics-micrometer-prometheus]]
- 섞이는 말: [[옵저버빌리티]], [[오픈텔레메트리]]

## 오픈텔레메트리 (opentelemetry)
클라우드 네이티브 환경에서 로그, 메트릭, 분산 트레이스를 수집, 변환, 전송하기 위한 CNCF 표준 관측성 프레임워크 규격 (OTel).
- 처음 나온 곳: [[05-observability-three-pillars-architecture]]
- 섞이는 말: [[옵저버빌리티]], [[분산-추적]]

## 분산-추적 (distributed tracing)
단일 클라이언트 요청이 여러 마이크로서비스와 메시지 브로커를 거쳐 처리되는 전 구간의 경로와 지연 시간을 `traceId`와 `spanId`를 통해 시각적으로 추적하는 기법.
- 처음 나온 곳: [[08-distributed-tracing-tempo-correlation]]
- 섞이는 말: [[옵저버빌리티]], [[오픈텔레메트리]]

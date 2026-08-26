# 06-ops-native 개념 맵

```
01-uber-jar-and-buildpacks-container (Uber JAR 패키징 & Buildpacks OCI 컨테이너)
  │
  ├──▶ 02-docker-compose-production-scaling (Docker Compose 다중 컨테이너 스케일링)
  │
  ├──▶ 03-graalvm-native-image-and-runtime-hints (GraalVM Native Image & RuntimeHints)
  │      │
  │      └──▶ 04-java25-aot-cache-and-runtime-comparison (Java 25 AOT Cache & 런타임 비교)
  │
  └──▶ 05-observability-three-pillars-architecture (옵저버빌리티 3대 기둥 & OTel 아키텍처)
         │
         ├──▶ 06-structured-logging-loki-grafana (구조화된 JSON 로깅 & Grafana Loki)
         │
         ├──▶ 07-metrics-micrometer-prometheus (Micrometer 커스텀 메트릭 & Prometheus)
         │
         └──▶ 08-distributed-tracing-tempo-correlation (Grafana Tempo 분산 추적 & 3대 신호 교차 분석)
```

## 핵심 개념 목록
- [[01-uber-jar-and-buildpacks-container]] — Executable JAR 패키징과 Cloud Native Buildpacks 컨테이너화
- [[02-docker-compose-production-scaling]] — Docker Compose 다중 컨테이너 운영과 공유 DB 스케일링
- [[03-graalvm-native-image-and-runtime-hints]] — GraalVM Native Image와 RuntimeHints AOT 최적화
- [[04-java25-aot-cache-and-runtime-comparison]] — Java 25 AOT Cache와 4대 자바 런타임 성능 비교
- [[05-observability-three-pillars-architecture]] — 옵저버빌리티 3대 기둥과 OpenTelemetry 아키텍처
- [[06-structured-logging-loki-grafana]] — 구조화된 JSON 로깅과 Grafana Loki 중앙 수집
- [[07-metrics-micrometer-prometheus]] — Micrometer 커스텀 비즈니스 메트릭과 Prometheus 수집
- [[08-distributed-tracing-tempo-correlation]] — Grafana Tempo 분산 추적과 3대 신호 교차 상관관계 분석

# Chapter 13 용어집

> *Learning Spring Boot 4*, Ch. 13 *Observability with Spring Boot 4* (책 pp. 347–397 / PDF pp. 372–422)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 모니터링 (monitoring)

미리 정해 둔 신호(CPU 사용률, 메모리, 가동 시간 등)를 지속적으로 지켜보는 일. **무엇을 볼지 미리 알고 있어야** 성립하므로, 예상하지 못한 종류의 문제 앞에서는 답을 주지 못한다.

## 관측-가능성 (observability)

시스템의 **외부 출력만 보고 내부 상태를 이해할 수 있는 능력**. 미리 정한 질문이 아니라 실행 중에 떠오른 질문에 답할 수 있느냐가 기준이다.

## 텔레메트리 (telemetry)

실행 중인 시스템이 자기 상태에 대해 내보내는 데이터 전체. 로그·메트릭·트레이스가 여기 속한다.

## 시그널 (signal)

텔레메트리의 한 종류를 가리키는 말. 이 장에서는 로그·메트릭·트레이스 셋을 시그널이라 부른다.

## 로그 (logs)

**사건의 기록.** "무언가가 일어났다"를 알려 준다. 특정 시점의 구체적인 세부(예외 메시지, 파라미터 값)를 보존하므로 디버깅에 쓰인다.

## 메트릭 (metrics)

**시간에 따라 수집되는 수치 측정값.** 요청 수, 오류율, 응답 시간, 자원 사용량처럼 "얼마나 자주, 얼마나 오래"에 답한다.

## 트레이스 (traces)

**요청 하나가 시스템을 지나간 경로.** 서비스와 컴포넌트를 가로지르는 연산들을 인과 순서로 이어 붙여, 시간이 어디에서 쓰였는지 보여 준다.

## 지속적-프로파일링 (continuous profiling)

CPU·메모리 같은 성능 데이터를 실행 중에 계속 수집·분석해 **코드 수준의 병목**을 찾는 방법. Grafana Pyroscope 같은 전용 백엔드와 프로파일러 에이전트가 필요해, 이 책은 선택적 확장으로 다룬다.

## Micrometer (Micrometer)

Spring 생태계의 계측 파사드. 특정 모니터링 시스템에 묶이지 않고 메트릭을 기록할 수 있게 해 주며, Spring Boot 4에서는 관측의 단일 진입점 역할을 한다.

## Observation-API (Observation API)

"작업 단위 하나"를 나타내는 Micrometer의 추상. **하나의 관측에서 메트릭·트레이스·로그 상관관계 데이터가 함께 파생된다**는 것이 이 API의 핵심 아이디어다.

## ObservationRegistry (ObservationRegistry)

관측을 만들고 관리하는 레지스트리. 커스텀 관측을 만들 때 이 객체를 주입받아 넘긴다.

## OpenTelemetry (OpenTelemetry)

텔레메트리의 데이터 모델·의미 규약·API를 정의하는 벤더 중립 표준. 어떤 백엔드를 쓰든 같은 형태로 신호를 표현하게 해 준다.

## OTLP (OpenTelemetry Protocol)

OpenTelemetry가 정의한 전송 프로토콜. gRPC(4317)와 HTTP(4318) 두 방식으로 텔레메트리를 내보낸다.

## OpenTelemetry-Collector (OpenTelemetry Collector)

애플리케이션과 백엔드 사이에 놓여 텔레메트리를 받고, 배칭·필터링·강화·라우팅한 뒤 내보내는 독립 프로세스. 선택 사항이지만 애플리케이션을 백엔드로부터 분리해 준다.

## 벤더-중립 (vendor-neutral)

특정 제품에 종속되지 않는 성질. 애플리케이션이 OTLP로만 내보내면 뒤에 있는 저장소를 바꿔도 애플리케이션 코드는 그대로다.

## Prometheus (Prometheus)

메트릭을 시계열로 저장하고 질의하는 오픈 소스 시스템. 대상이 노출한 엔드포인트를 주기적으로 긁어 오는 **pull 모델**로 동작한다.

## Loki (Loki)

Grafana Labs의 로그 저장·색인 시스템. 로그 본문 전체가 아니라 **라벨만 색인**해 비용을 낮춘다.

## Tempo (Grafana Tempo)

Grafana Labs의 분산 트레이스 저장·질의 백엔드. OTLP로 트레이스를 받아 저장하고 Grafana가 조회한다.

## Grafana (Grafana)

여러 데이터 소스를 한 화면에서 탐색·시각화·경보하는 도구. 이 장에서는 Loki·Prometheus·Tempo를 하나로 묶는 통합 인터페이스 역할을 한다.

## 시계열-데이터베이스 (time-series database)

"시각 → 수치" 쌍을 대량으로 저장하고 구간 질의·집계에 최적화된 저장소. 메트릭에는 로그 저장소가 아니라 이런 저장소가 필요하다.

## Logback (Logback)

Spring Boot의 기본 로깅 구현체. 어떤 형식으로 어디에 로그를 쓸지를 appender와 설정 파일로 정한다.

## SLF4J (Simple Logging Facade for Java)

로깅 구현체를 감추는 자바 표준 파사드. 애플리케이션 코드는 SLF4J API만 부르고 실제 구현은 Logback이 담당한다.

## 로그-appender (appender)

Logback이 로그 이벤트를 실제로 내보내는 출구. 콘솔·파일·네트워크 등 목적지마다 하나씩 둔다.

## 구조화-로깅 (structured logging)

로그를 사람이 읽는 문장이 아니라 **기계가 파싱할 수 있는 필드 집합**(주로 JSON)으로 쓰는 방식. 색인·검색·집계가 가능해진다.

## logstash-포맷 (logstash format)

Spring Boot가 지원하는 구조화 로그 형식 중 하나. `ecs`(Elastic Common Schema), `gelf`(Graylog Extended Log Format)도 있으며 수집·분석 플랫폼에 맞춰 고른다.

## 파라미터-플레이스홀더 (parameter placeholder)

`log.info("employee {} created", id)`처럼 `{}`로 값을 끼워 넣는 SLF4J 문법. 문자열 연결과 달리 **로그 레벨이 꺼져 있으면 문자열을 만들지도 않는다.**

## MDC (Mapped Diagnostic Context)

현재 실행 컨텍스트에 붙는 key-value 저장소. 요청 단위 정보를 로그 문장에 일일이 넘기지 않고도 모든 로그에 실을 수 있게 해 준다.

## traceId (traceId)

요청 하나 전체를 식별하는 값. 그 요청이 만든 모든 span이 같은 값을 공유하므로, 흩어진 로그를 한 흐름으로 다시 묶을 수 있다.

## spanId (spanId)

트레이스 안의 작업 단위 하나를 식별하는 값. 같은 traceId 안에서 span마다 다르다.

## span (span)

트레이스를 이루는 작업 단위 하나. 시작·종료 시각, 이름, 속성, 부모 span을 갖는다.

## 전파-경계 (propagation boundary)

트레이스 컨텍스트가 프로세스나 스레드를 넘어가야 하는 지점. HTTP 헤더나 Kafka 메시지 헤더에 traceId를 실어 보내야 그 너머에서도 같은 트레이스가 이어진다.

## 컨텍스트-전파 (context propagation)

traceId·spanId 같은 실행 맥락을 호출 경계 너머로 실어 나르는 일. 이것이 없으면 비동기 구간이 별개의 트레이스로 끊긴다.

## waterfall (waterfall view)

span들을 시작 시각과 지속 시간에 맞춰 가로 막대로 늘어놓은 화면. 어느 구간이 시간을 잡아먹었는지 한눈에 드러난다.

## 계측 (instrumentation)

애플리케이션이 텔레메트리를 생산하도록 코드나 설정을 더하는 일. 자동 계측(프레임워크가 대신 해 주는 것)과 수동 계측(직접 관측·메트릭을 심는 것)이 있다.

## Actuator (Spring Boot Actuator)

헬스 체크, 메트릭 노출, 관측 자동 설정 같은 운영용 기능을 모아 둔 Spring Boot 모듈. `/actuator/health` 같은 엔드포인트를 제공한다.

## ApplicationRunner (ApplicationRunner)

애플리케이션 컨텍스트가 준비된 직후 한 번 실행되는 콜백 인터페이스. 기동 시점의 배선 작업에 쓴다.

## alpha-릴리스 (alpha release)

API가 아직 바뀔 수 있는 초기 배포판. 버전을 고정하고 자동 업그레이드 도구가 손대지 못하게 막아야 한다.

## 리소스-속성 (resource attributes)

"이 텔레메트리를 누가 만들었는가"를 나타내는 메타데이터. 서비스 이름·버전·배포 환경처럼 **그 프로세스의 모든 신호에 공통으로 붙는** 값이다.

## Docker-Compose (Docker Compose)

여러 컨테이너를 한 파일에 선언해 함께 띄우는 도구. 관측 스택처럼 서로 의존하는 서비스 묶음에 쓴다.

## 볼륨-마운트 (volume mount)

호스트의 파일이나 디렉터리를 컨테이너 안 경로에 연결하는 것. 이미지를 다시 만들지 않고 설정 파일을 바꿀 수 있게 해 준다.

## 리시버 (receiver)

OpenTelemetry Collector가 데이터를 **받아들이는** 입구. 어떤 프로토콜·포트로 받을지 정한다.

## 프로세서 (processor)

Collector가 받은 데이터를 내보내기 전에 **가공하는** 단계. 속성 추가, 배칭, 필터링이 여기서 일어난다.

## 익스포터 (exporter)

Collector가 데이터를 **내보내는** 출구. 어느 백엔드로 어떤 형식으로 보낼지 정한다.

## 파이프라인 (pipeline)

리시버·프로세서·익스포터를 하나로 이어 붙인 처리 경로. 신호 종류(logs·metrics·traces)마다 따로 정의한다.

## 배칭 (batching)

여러 건을 모아 한 번에 내보내는 것. 네트워크 왕복과 오버헤드를 줄인다.

## 라벨-승격 (label promotion)

리소스 속성 중 일부를 로그 저장소의 **색인 대상 라벨**로 올리는 것. 색인된 라벨로는 빠르게 질의할 수 있지만 라벨이 많아지면 저장소 비용이 급증한다.

## 데이터소스-프로비저닝 (datasource provisioning)

Grafana가 기동할 때 설정 파일을 읽어 데이터 소스를 자동 등록하게 하는 것. 스택을 띄울 때마다 UI에서 손으로 연결하지 않아도 된다.

## Explore (Grafana Explore)

Grafana에서 대시보드를 만들지 않고 즉석으로 질의를 던져 보는 화면. 장애 조사에 주로 쓴다.

## LogQL (LogQL)

Loki의 질의 언어. `{service_name="employee-service"}`처럼 라벨로 스트림을 고르고 `|=` 등으로 본문을 거른다.

## PromQL (PromQL)

Prometheus의 질의 언어. 시계열을 고르고 `sum by`·`rate` 같은 함수로 집계한다.

## 스크레이프 (scrape)

Prometheus가 대상의 메트릭 엔드포인트를 주기적으로 **긁어 오는** 동작. 대상이 밀어 보내는 push 모델과 반대다.

## scrape_interval (scrape_interval)

Prometheus가 대상을 얼마나 자주 긁을지 정하는 설정. 짧을수록 해상도가 높아지고 저장 비용이 커진다.

## MeterRegistry (MeterRegistry)

Micrometer에서 메트릭을 만들고 등록하고 보관하는 중심 객체. 커스텀 메트릭을 기록하려면 이것을 주입받는다.

## Counter (Counter)

**단조 증가만 하는** 누적 수치. 발생 횟수를 세는 데 쓰며, 줄어들지 않는다.

## Timer (Timer)

어떤 작업이 얼마나 걸렸는지를 기록하는 메트릭. 총 소요 시간과 실행 횟수를 함께 쌓아 두어 평균을 계산할 수 있다.

## 메트릭-태그 (metric tag)

메트릭에 붙이는 key-value 라벨. 같은 메트릭을 태그별로 쪼개 보게 해 주며, Prometheus에서는 질의 가능한 차원이 된다.

## 인프라-메트릭 (infrastructure metrics)

CPU·메모리·요청률·지연 시간처럼 **시스템 자원과 기술 계층**을 재는 메트릭.

## 비즈니스-메트릭 (business metrics)

생성된 직원 수, 실패한 알림 수처럼 **도메인 사건**을 재는 메트릭. 인프라가 멀쩡한데 비즈니스가 망가진 상황을 잡아낸다.

## rate (rate)

시계열의 **초당 증가율**을 계산하는 PromQL 함수. 누적 카운터를 "지금 얼마나 빠르게 일어나고 있는가"로 바꿔 준다.

## 대시보드 (dashboard)

여러 질의 결과를 패널로 배치해 한 화면에서 보게 만든 것. 추세 비교와 이상 감지에 쓴다.

## 샘플링 (sampling)

모든 요청이 아니라 일부만 트레이스로 남기는 것. 트레이스는 요청마다 데이터를 만들기 때문에 전량 수집은 비용이 크다.

## 샘플링-확률 (sampling probability)

요청 하나가 트레이스로 기록될 확률. `1.0`이면 전부, `0.1`이면 약 10%다.

## contextualName (contextualName)

관측에 붙이는 사람이 읽기 좋은 이름. 트레이싱 백엔드의 span 이름으로 나타나 waterfall을 읽기 쉽게 만든다.

## 저-카디널리티 (low cardinality)

가질 수 있는 값의 가짓수가 **작고 정해져 있는** 속성. `status=SUCCESS|FAILED`처럼 안전하게 집계·색인할 수 있다.

## 고-카디널리티 (high cardinality)

값의 가짓수가 **거의 무한한** 속성. `userId`, `email`, `orderId`가 그렇다. 특정 요청을 추적할 때는 유용하지만 메트릭 라벨로 쓰면 시계열이 폭발한다.

## WAL (write-ahead log)

데이터를 최종 저장소에 쓰기 전에 먼저 순차 기록해 두는 로그. 중간에 죽어도 유실을 막는다.

## 컴팩션 (compaction)

작게 흩어진 데이터 블록을 모아 큰 블록으로 합치는 작업. 저장 효율과 질의 성능을 높인다.

## 보존-기간 (retention)

데이터를 얼마나 오래 두었다가 지울지 정하는 기간. 트레이스는 양이 많아 짧게 잡는 경우가 흔하다.

## 상관관계 (correlation)

서로 다른 신호를 **같은 요청·같은 시각**으로 이어 붙여 한 흐름으로 오갈 수 있게 만드는 것. 데이터가 관련돼 있는 것과 사용자가 오갈 수 있는 것은 다르다.

## derivedFields (derived fields)

Loki 데이터 소스에서 로그 본문을 정규식으로 훑어 값을 뽑아내고, 그 값으로 다른 데이터 소스로 가는 링크를 만드는 Grafana 기능.

## tracesToLogsV2 (tracesToLogsV2)

Tempo 데이터 소스에서 span을 보고 있을 때 관련 로그로 이동하는 링크를 만드는 Grafana 설정.

## tracesToMetrics (tracesToMetrics)

Tempo 데이터 소스에서 span을 보고 있을 때 관련 메트릭 질의로 이동하는 링크를 만드는 Grafana 설정. 질의 목록을 미리 이름 붙여 등록해 둔다.

## exemplar (exemplar)

메트릭 데이터 포인트 하나에 붙는 **대표 트레이스의 식별자**. "이 지연 시간 값을 만든 실제 요청"으로 곧장 넘어갈 수 있게 해 준다.

## uid (datasource uid)

Grafana 데이터 소스의 고유 식별자. 링크 설정에서 다른 데이터 소스를 가리킬 때 이 값을 쓴다.

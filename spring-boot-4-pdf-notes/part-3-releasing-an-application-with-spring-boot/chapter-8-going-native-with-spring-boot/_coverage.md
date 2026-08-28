# Chapter 8 원문 커버리지

> 기준 원문: *Learning Spring Boot 4*, Ch. 8 *Going Native with Spring Boot*, 책 pp. 229–248 / PDF pp. 254–273. PDF를 `pdftotext -layout -f 254 -l 272`로 새로 추출해 846줄 전체를 읽고, 요약이 다음 쪽까지 이어져 `-f 273 -l 275`를 추가로 확인했다. 책 쪽과 PDF 쪽의 offset은 `+25`다.

## 0. 노트 분할 근거

인쇄된 상위 절은 **7개**, 2단계 하위 제목은 **5개**, 3단계는 **없다**. 상위 절 7개 중 3개(`03`·`04`·`07`)가 독립적으로 성립하는 하위 제목을 품고 있어 **인쇄된 하위 제목을 기준으로만** 쪼개 7 → **12개**로 늘렸다.

하위 제목 5개를 모두 분리한 이유는 각각이 **다른 질문에 답하기** 때문이다. `Why do we want GraalVM again?`은 "이 고생을 왜 하나"라는 비용 논증(1,000 인스턴스 × 20초 = 5.6시간)이고, `From Spring Native to Spring Boot 4 native images`는 "Spring Native를 따로 넣어야 하나"라는 흔한 오해를 푸는 것이며, `GraalVM and other libraries`는 "내 서드파티 의존성이 돌아가나"라는 실무의 최대 걸림돌이다. `Enabling AOT Cache…`는 명령 절차, `Comparing…`은 네 전략의 선택 기준이다.

**기존 초안 7개 중 6개는 파일 이름을 유지했고, 하나만 rename했다.** `07-java-25-aot-cache-and-crac-comparison.md` → `07-using-java-25-aot-cache.md`. CRaC 비교가 하위 제목 `07b`로 분리되면서 원래 이름이 실제 내용과 어긋나게 됐기 때문이다. rename 전에 저장소 전체를 읽기 전용으로 확인해 **Ch8 밖의 inbound 링크가 0건**임을 확인했다(참조 4건은 모두 이번에 전면 재작성하는 Ch8 자신의 노트와 glossary였다).

| 노트 | 원문 절 (인쇄된 제목) | 책 쪽 | PDF 쪽 |
|---|---|---:|---:|
| [[01-why-graalvm-native-image]] | What is GraalVM and why do we care? | 230–231 | 255–256 |
| [[02-adapting-an-application-for-native-image]] | Retrofitting our application for GraalVM | 231–235 | 256–260 |
| [[03-building-and-running-a-native-application]] | Running our native Spring Boot application inside GraalVM | 235–239 | 260–264 |
| [[03a-why-native-images-pay-off]] | Why do we want GraalVM again? | 239–240 | 264–265 |
| [[04-building-native-container-images]] | Baking a Docker container with GraalVM | 240 | 265 |
| [[04a-from-spring-native-to-mainstream]] | From Spring Native to Spring Boot 4 native images | 240–241 | 265–266 |
| [[04b-graalvm-and-third-party-libraries]] | GraalVM and other libraries | 241 | 266 |
| [[05-configuring-reflection-and-runtime-hints]] | Configuring reflection and runtime hints | 241–243 | 266–268 |
| [[06-using-buildpacks-with-java-aot-cache]] | Using buildpacks with Java AOT Cache | 243–244 | 268–269 |
| [[07-using-java-25-aot-cache]] | Using Java 25 AOT Cache to reduce startup times | 244–245 | 269–270 |
| [[07a-enabling-aot-cache-for-spring-boot]] | Enabling AOT Cache for a Spring Boot 4 application | 245–246 | 270–271 |
| [[07b-comparing-four-execution-strategies]] | Comparing Standard JVM, AOT Cache, Native Image, and CRaC | 246–247 | 271–272 |

## 1. 본문 절 → 노트 매핑

| 책 쪽 | PDF 쪽 | 원문 절·내용 | 정리 노트 | 상태 |
|---:|---:|---|---|---|
| 229 | 254 | 장 도입 — 앞 장에서 배포·튜닝을 배웠고, 이제 **성능을 11까지 올리는** bleeding-edge 플랫폼으로 간다. 다룰 7개 주제 | [[_map]] | 반영 |
| 229 | 254 | Note: 소스는 저장소 `ch8` 폴더 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 230 | 255 | 이 장의 초점은 **애플리케이션 작성이 아니라 컴파일 형식**이다. 새 코드를 쓸 필요가 없고, `ch8` 코드는 앞 장 코드의 복사본이며 **build 파일만 다르다** | [[02-adapting-an-application-for-native-image]] | 반영 |
| 230 | 255 | Java가 오래 받아 온 성능 비판, 그중에서도 **startup time**. 웹 앱은 uptime이 길어 문제되지 않았다 | [[01-why-graalvm-native-image]] | 반영 |
| 230 | 255 | 새 전선 — 하루에 여러 번 교체되는 10,000 인스턴스의 지속 배포, 그리고 **AWS Lambda 같은 실행 가능 함수**. 여기서는 startup time이 기술 선택을 강하게 좌우한다 | [[01-why-graalvm-native-image]] | 반영 |
| 230 | 255 | GraalVM 정의 — Oracle의 새 VM으로 Java·JavaScript·Python·Ruby·R·C·C++를 겨냥한 고성능 런타임. "JAR을 JVM 말고 GraalVM에서 돌려라" | [[01-why-graalvm-native-image]] | 반영 |
| 230–231 | 255–256 | 2019년 실험 프로젝트 **Spring Native**의 탄생과, 그 뒤 Spring 포트폴리오 거의 전 영역의 조정 | [[01-why-graalvm-native-image]] · [[04a-from-spring-native-to-mainstream]] | 반영 |
| 231 | 256 | 네이티브 애플리케이션을 만드는 두 길 — 새로 만들기 vs 기존 것 고치기. Boot 4.0의 지원 덕에 후자가 쉽다 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 231 | 256 | Note: bytecode·JVM·**write once, run anywhere**·JIT 속도 개선의 역사 | [[01-why-graalvm-native-image]] | 반영 |
| 231 | 256 | "왜 모든 앱을 GraalVM으로 컴파일하지 않나" → **trade-off** 때문. 포기하는 것 4가지(reflection 제한·dynamic proxy 제한·외부 resource 특수 취급·조건과 구조의 build-time 평가) | [[02-adapting-an-application-for-native-image]] | 반영 |
| 231 | 256 | **reachability** — `main` 메서드·reflection hint·resource 설정·프레임워크 metadata를 진입점으로 call graph를 정적 추적하고, **도달하지 못하는 것은 최종 이미지에서 잘라낸다** | [[02-adapting-an-application-for-native-image]] | 반영 |
| 232 | 257 | reflection은 여전히 가능하지만 추가 설정이 필요하다. proxy는 **native image build 시점에 생성**되어야 한다. 잘못하면 앱의 일부가 잘려 나간다 | [[02-adapting-an-application-for-native-image]] · [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 232 | 257 | Note: "reflection과 proxy가 지원되지 않는다"는 일부 기사 서술은 **거짓**이다. 지원되되 등록이 필요하고, proxy는 build 시점 생성이어야 한다 — 사용의 제약이지 지원의 부재가 아니다 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 232 | 257 | Spring Framework가 reflection 의존을 줄이고 Boot가 bean 정의를 담은 configuration class의 proxy를 피하는 이유 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 232–233 | 257–258 | Note: **closed-world assumption** — Spring AOT 엔진이 build 시점에 구조를 고정한다. `@Profile`·`@ConditionalOnProperty`가 **시작이 아니라 build 때** 평가된다. runtime property 변경으로 context가 재구성되지 않고, 컴파일 후 새 bean 설정을 넣을 수 없다. 특정 profile용 실행 파일이 필요하면 **build 때 그 profile을 켜야 한다** | [[02-adapting-an-application-for-native-image]] | 반영 |
| 233 | 258 | Initializr 좌표 8개와 의존성 6개(Spring Web·Mustache·H2·Spring Data JPA·Spring Security·**GraalVM Native Support**) | [[02-adapting-an-application-for-native-image]] | 반영 |
| 233–234 | 258–259 | 생성된 starter 6개 목록 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 234 | 259 | Spring Data JPA를 쓰면 Hibernate가 기본 provider. 네이티브에서는 **runtime bytecode 조작과 proxy 기반 동작이 더 제약**된다. Boot 4 AOT가 대부분을 자동 처리하지만, lazy attribute loading·dirty tracking·association management 같은 **bytecode 강화 기능**을 쓰면 build 시점에 적용해야 한다 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 234 | 259 | `hibernate-maven-plugin`의 `enhance` 실행 설정 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 235 | 260 | Boot parent POM이 제공하는 **`native` Maven profile** — Spring AOT 처리를 돌리고 GraalVM Native Build Tools 플러그인의 기본값을 잡아 준다 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 235 | 260 | `./mvnw clean package`가 uber JAR을 만드는 통상 흐름(Ch7). 네이티브는 흐름은 비슷하지만 **추가 도구**가 필요하다 | [[03-building-and-running-a-native-application]] | 반영 |
| 235 | 260 | Boot 4는 빌드·실행에 Java 17+이면 되지만, native image 생성은 **GraalVM의 `native-image` 도구**로 ahead-of-time 컴파일하므로 표준 JDK를 넘어선다 | [[03-building-and-running-a-native-application]] | 반영 |
| 235 | 260 | `native-maven-plugin`이 `native` profile로 활성화되어 GraalVM 툴체인을 빌드에 통합한다. JDK 전환에는 **SDKMAN**이 유용하다 | [[03-building-and-running-a-native-application]] | 반영 |
| 235–236 | 260–261 | Note: Linux가 가장 수월하고 macOS도 지원이 좋다. **Windows**는 GraalVM JDK 25 다운로드 → ZIP 해제 → `JAVA_HOME` 설정 → `bin`을 `PATH`에 추가, 추가로 **Microsoft C++ 컴파일러와 Windows SDK**가 필요하다 | [[03-building-and-running-a-native-application]] | 반영 |
| 236 | 261 | `sdk install java 25.0.2-graal` · `sdk use java 25.0.2-graal` · `java -version` 출력 | [[03-building-and-running-a-native-application]] | 반영 |
| 236 | 261 | 최신 GraalVM은 현재 Java 버전과 정렬되어 Graal 컴파일러와 `native-image` 툴링이 **JDK 배포판에 통합**돼 있다 | [[03-building-and-running-a-native-application]] | 반영 |
| 236 | 261 | `./mvnw -Pnative clean native:compile`. 표준 빌드보다 오래 걸린다 | [[03-building-and-running-a-native-application]] | 반영 |
| 237 | 262 | 전체 코드 스캔과 **AOT 컴파일** — bytecode로 두었다가 JVM 시작 때 기계어로 바꾸는 대신 미리 바꾼다. proxy·reflection 사용을 줄여야 하고, 쓰더라도 실행 파일이 커지고 이점이 줄며 **추가 metadata 등록**이 필요하다 | [[03-building-and-running-a-native-application]] | 반영 |
| 237 | 262 | Figure 8.1 — `mvnw -Pnative clean native:compile` 출력 | [[03-building-and-running-a-native-application]] | 반영 (**이미지 추출**) |
| 238 | 263 | 산출물은 uber JAR도 executable JAR도 아닌 **빌드한 플랫폼용 실행 파일**이다 | [[03-building-and-running-a-native-application]] | 반영 |
| 238 | 263 | Note: write once/run anywhere를 잃는다. `file target/ch8` → `Mach-O 64-bit executable arm64` | [[03-building-and-running-a-native-application]] | 반영 |
| 238 | 263 | `target/ch8` 실행 — 배너와 로그, **0.528초 시작** | [[03-building-and-running-a-native-application]] | 반영 |
| 239 | 264 | Figure 8.2 — 네트워크 연결 허용을 묻는 macOS 팝업. 정상 동작이며 문제가 아니다 | [[03-building-and-running-a-native-application]] | 반영 (Figure 미추출, 본문 서술) |
| 239–240 | 264–265 | **비용 논증** — 20초 시작 × 1,000 인스턴스 = 20,000초 = 5.6시간의 과금 시간. 패치마다 배포하면 청구서가 감당 안 된다. 0.1초면 1,000 인스턴스가 17분 미만 | [[03a-why-native-images-pay-off]] | 반영 |
| 240 | 265 | 메모리 구성도 더 효율적이다. CD 시스템이 **타깃과 같은 OS에서 빌드**하면 write-once/run-anywhere 상실은 문제가 아니다 | [[03a-why-native-images-pay-off]] | 반영 |
| 240 | 265 | 남은 문제 — 로컬 빌드 머신에 타깃 환경이 없다면? Windows·Mac에서 일하는데 클라우드가 Linux 컨테이너라면? | [[03a-why-native-images-pay-off]] · [[04-building-native-container-images]] | 반영 |
| 240 | 265 | Ch7의 `./mvnw spring-boot:build-image` + Paketo Buildpack에 `native` profile을 결합한 `./mvnw -Pnative spring-boot:build-image`. 로컬 빌드보다 더 오래 걸리지만 **네이티브 앱이 든 Docker 컨테이너**가 나온다 | [[04-building-native-container-images]] | 반영 |
| 240–241 | 265–266 | Spring Native는 **Boot 2.x 시대의 실험적 다리**였고, 지금 네이티브 지원은 Spring 주류다. AOT 처리·reachability metadata·빌드 통합이 현 포트폴리오에 들어와 Boot 4/Framework 7에서 계속 개선된다. **별도로 껴안을 "Spring Native" 프로젝트는 없다** | [[04a-from-spring-native-to-mainstream]] | 반영 |
| 241 | 266 | start.spring.io의 GraalVM Native Support를 고르는 것은 외부 프레임워크 추가가 아니라 **빌드 툴링 통합**이다. JPA/Hibernate는 build 시점 bytecode 강화를 켜야 할 수 있다 | [[04a-from-spring-native-to-mainstream]] | 반영 |
| 241 | 266 | 네이티브 지원은 Boot 4·Framework 7의 **first-class** 기능이다. Web·Data·Security·Actuator가 내장 AOT 처리와 네이티브 지원을 갖는다 | [[04b-graalvm-and-third-party-libraries]] | 반영 |
| 241 | 266 | **closed-world 분석 시스템**이므로 reflection·dynamic proxy·직렬화·resource 로딩이 build 시점에 알려져야 한다. 주류 라이브러리는 대체로 지원하거나 reachability metadata를 싣지만 **서드파티가 항상 준비된 것은 아니다** | [[04b-graalvm-and-third-party-libraries]] | 반영 |
| 241 | 266 | 과도하게 reflective하거나 동적인 라이브러리는 추가 설정이나 hint가 필요하다. spring.io/blog가 모범 사례를 낸다 | [[04b-graalvm-and-third-party-libraries]] | 반영 |
| 241 | 266 | 라이브러리 선택만의 문제가 아니다 — AOT 분석이 필요한 것을 다 추론할 수 없으면 **명시적으로 알려 줘야 한다** | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 242 | 267 | `@RegisterReflectionForBinding(VideoEntity.class)`를 붙인 `NativeConfig` — data binding에 reflective 접근이 필요한 타입 | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 242 | 267 | `@ImportRuntimeHints(VideoRuntimeHints.class)`를 붙인 `NativeAdvancedConfig` | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 242 | 267 | `VideoRuntimeHints implements RuntimeHintsRegistrar`의 `registerHints(RuntimeHints, ClassLoader)`와 `hints.reflection().registerType(...)` | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 243 | 268 | `INVOKE_DECLARED_CONSTRUCTORS`(객체 생성 허용)와 `INVOKE_PUBLIC_METHODS`(getter/setter 포함 public 메서드 reflective 호출 허용). closed-world 모델에서 hint는 **실용적인 escape hatch**다 | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 243 | 268 | 네이티브 컴파일만이 빠른 startup의 길은 아니다 — buildpack + Java AOT Cache로 **JVM에 남은 채** 개선할 수 있다 | [[06-using-buildpacks-with-java-aot-cache]] | 반영 |
| 243 | 268 | Buildpack은 GraalVM 전용이 아니다. 이 방식에서 앱은 **여전히 JVM에서 돌고**, 이미지 빌드가 **training run**을 수행해 캐시를 만들고 시작 때 재사용한다 | [[06-using-buildpacks-with-java-aot-cache]] | 반영 |
| 243 | 268 | Java AOT Cache 정의 — training run에서 생성된 선별 컴파일·프로파일링 산출물을 저장해 이후 실행에서 재사용한다. startup·warmup을 줄이면서 **JIT 능력을 온전히 유지**한다 | [[06-using-buildpacks-with-java-aot-cache]] · [[07-using-java-25-aot-cache]] | 반영 |
| 243 | 268 | `BP_JVM_AOT_ENABLED=true ./mvnw spring-boot:build-image` · `docker run -p 8080:8080 your-image-name` | [[06-using-buildpacks-with-java-aot-cache]] | 반영 |
| 244 | 269 | 네이티브 이미지는 startup이 인상적이고 메모리가 적지만 **빌드 복잡도와 reflection·proxy·runtime 동작의 제약**을 들여온다. JVM에 남으면서 빠른 startup은 없나? | [[07-using-java-25-aot-cache]] | 반영 |
| 244 | 269 | Java 25는 Java 24가 도입한 AOT Cache를 이어받아 **단일 training-run 명령**으로 캐시 생성을 단순화했다. **Project Leyden**, **JEP 483**(Ahead-of-Time Class Loading and Linking), **JEP 515**(Ahead-of-Time Method Profiling) | [[07-using-java-25-aot-cache]] | 반영 |
| 244 | 269 | 통상 JVM 실행 흐름 — class 로드 → tiered compilation → 프로파일링으로 hot path 식별 → JIT가 점진적으로 최적화 → warmup 후 steady-state 처리량 | [[07-using-java-25-aot-cache]] | 반영 |
| 244 | 269 | 장기 서비스에는 warmup 비용이 수용 가능하지만, **잦은 재시작·동적 스케일·cold-start 지연이 중요한 곳·serverless와 버스트 워크로드**에서는 운영상 문제가 된다 | [[07-using-java-25-aot-cache]] | 반영 |
| 244–245 | 269–270 | 네이티브와 다른 trade-off — 네이티브 바이너리를 만들지 않고 **JVM에 남고 JIT가 살아 있어 peak throughput이 보존**된다. 표준 JVM과 완전 네이티브 사이의 **아키텍처적 중간 지대** | [[07-using-java-25-aot-cache]] | 반영 |
| 245 | 270 | **Java AOT Cache와 Spring AOT 처리를 구분**해야 한다. Spring AOT는 build 시점에 애플리케이션 **구조**를 준비하고, Java AOT Cache는 JVM 수준에서 **런타임 성능**을 겨냥한다 | [[07-using-java-25-aot-cache]] | 반영 |
| 245 | 270 | AOT cache는 Spring 기능이 아니라 **JVM 기능**이다. 가장 단순한 형태는 Spring 설정 없이 JVM 옵션만으로 쓴다 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 245 | 270 | Java 25+는 record와 create 두 단계 대신 **training run 한 번**으로 캐시를 만든다. `java -XX:AOTCacheOutput=app.aot -Dspring.context.exit=onRefresh -jar target/ch8-0.0.1-SNAPSHOT.jar` | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 245 | 270 | `java -XX:AOTCache=app.aot -jar ...`로 시작. cold 상태 대신 캐시의 사전 컴파일 산출물을 로드하고, **JIT는 여전히 살아 있어** training에 없던 경로도 런타임에 최적화된다 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 245 | 270 | training run에서 **현실적이고 대표적인 동작**을 시켜야 한다 — 로그인, API 호출, DB 질의, 자주 쓰는 endpoint. 개선 폭은 앱 크기·로드 class 수·프레임워크 복잡도·하드웨어에 달렸다 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 246 | 271 | `app.aot`은 **정확히 같은 빌드와 JVM 버전**에 맞아야 한다. 재빌드·의존성 변경·JDK 변경 시 캐시를 다시 만들어야 한다 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 246 | 271 | 네 번째 선택지 **CRaC**(Coordinated Restore at Checkpoint). 네이티브 대신 CRaC를 고르는 이유는 **일반 JVM 런타임과 그 동적 기능을 유지**하면서 startup을 줄이려는 것 | [[07b-comparing-four-execution-strategies]] | 반영 |
| 246 | 271 | Table 8.1 — 네 접근의 Startup Time·Runtime Model·Memory Footprint·Build Complexity 비교 | [[07b-comparing-four-execution-strategies]] | 반영 (표로 재현) |
| 246–247 | 271–272 | 네 모델의 서술 비교 — Standard JVM은 JIT 전적 의존·warmup 필요·빌드 단순, AOT Cache는 JVM 유지 + 산출물 재사용, Native Image는 AOT 컴파일된 독립 실행 파일·JIT 없음·메모리 적음·제약 많음, CRaC는 초기화된 앱을 checkpoint 후 restore하며 **CRIU 기반이고 현재 Linux 지향** | [[07b-comparing-four-execution-strategies]] | 반영 |
| 247 | 272 | 개념 요약 — 네이티브는 전부 미리 컴파일, AOT cache는 HotSpot에 남아 캐시 재사용, CRaC는 초기화된 프로세스 상태 복원. 실제 수치는 앱·워크플로·컨테이너·하드웨어에 크게 좌우된다 | [[07b-comparing-four-execution-strategies]] | 반영 |
| 247–248 | 272–273 | Summary — 네이티브 컴파일, Paketo Buildpack 컨테이너화, closed-world assumption과 profile·조건부 bean·reflection·runtime hint에 대한 영향, Java 25 AOT Cache, CRaC. **네 가지 실행 전략**을 갖게 됐다. 다음 장은 리액티브 | [[_map]] | 반영 |
| 274 | 274 | 책 PDF 다운로드 QR 안내 · Part 4 도입 | — | 학습 무관, 제외 |

## 2. 코드·설정·명령 예제 → 노트 매핑

| # | 예제 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | Initializr 좌표 8개 + 의존성 6개 | 233 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 2 | 생성된 starter 6개 목록 | 233–234 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 3 | `hibernate-maven-plugin` `enhance` 설정 | 234 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 4 | `./mvnw clean package` (대조용 언급) | 235 | [[03-building-and-running-a-native-application]] | 반영 |
| 5 | `sdk install java 25.0.2-graal` | 236 | [[03-building-and-running-a-native-application]] | 반영 |
| 6 | `sdk use java 25.0.2-graal` | 236 | [[03-building-and-running-a-native-application]] | 반영 |
| 7 | `java -version` 출력 | 236 | [[03-building-and-running-a-native-application]] | 반영 |
| 8 | `./mvnw -Pnative clean native:compile` | 236 | [[03-building-and-running-a-native-application]] | 반영 |
| 9 | `file target/ch8` → `Mach-O 64-bit executable arm64` | 238 | [[03-building-and-running-a-native-application]] | 반영 |
| 10 | `target/ch8` 실행 로그 (0.528초) | 238 | [[03-building-and-running-a-native-application]] | 반영 |
| 11 | `./mvnw -Pnative spring-boot:build-image` | 240 | [[04-building-native-container-images]] | 반영 |
| 12 | `@RegisterReflectionForBinding(VideoEntity.class)` `NativeConfig` | 242 | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 13 | `@ImportRuntimeHints(VideoRuntimeHints.class)` `NativeAdvancedConfig` | 242 | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 14 | `VideoRuntimeHints implements RuntimeHintsRegistrar` | 242 | [[05-configuring-reflection-and-runtime-hints]] | 반영 |
| 15 | `BP_JVM_AOT_ENABLED=true ./mvnw spring-boot:build-image` | 243 | [[06-using-buildpacks-with-java-aot-cache]] | 반영 |
| 16 | `docker run -p 8080:8080 your-image-name` | 243 | [[06-using-buildpacks-with-java-aot-cache]] | 반영 |
| 17 | `java -XX:AOTCacheOutput=app.aot -Dspring.context.exit=onRefresh -jar ...` | 245 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 18 | `java -XX:AOTCache=app.aot -jar ...` | 245 | [[07a-enabling-aot-cache-for-spring-boot]] | 반영 |
| 19 | Table 8.1 네 전략 비교표 | 246 | [[07b-comparing-four-execution-strategies]] | 반영 |

## 3. Tip / Note 블록 → 노트 매핑

| # | Note 내용 | 책 쪽 | 노트 | 상태 |
|---:|---|---:|---|---|
| 1 | 소스는 저장소 `ch8` 폴더 | 229 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 2 | bytecode·JVM·write once run anywhere·JIT의 역사 | 231 | [[01-why-graalvm-native-image]] | 반영 |
| 3 | "reflection·proxy 미지원"은 거짓 — 제약이지 부재가 아니다 | 232 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 4 | closed-world assumption과 `@Profile`·`@ConditionalOnProperty`의 build-time 평가 | 232–233 | [[02-adapting-an-application-for-native-image]] | 반영 |
| 5 | Windows에서 네이티브 빌드 — GraalVM JDK 25·`JAVA_HOME`·`PATH`·MSVC·Windows SDK | 235–236 | [[03-building-and-running-a-native-application]] | 반영 |
| 6 | write once/run anywhere 상실과 `file target/ch8` | 238 | [[03-building-and-running-a-native-application]] | 반영 |

## 4. Figure 처리 판단

`pdfimages -f 254 -l 272 -list`로 raster **2개**(PDF pp. 262·264)를 확인하고 둘 다 PNG로 추출해 **육안 확인**한 뒤, **1개만 `_assets/`에 넣었다.**

| Figure | 책 쪽 | 내용 (육안 확인) | 판단 |
|---|---:|---|---|
| 8.1 | 237 | `native:compile` 출력 후반부 — 8단계 중 4~8단계 타이밍(methods 컴파일 **161.0s**), 이미지 크기 분해(code area 94.15MB / image heap 63.70MB / **총 159.62MB**), code area 기여 top 10(**hibernate-core 21.60MB**, java.base 16.18MB, svm.jar 9.74MB…), image heap object type top 10(code metadata용 byte[] 27.36MB, **reflection metadata용 byte[] 1.65MB**), Security report(Java 역직렬화 포함, CycloneDX SBOM 77개 컴포넌트), Recommendations(PGO·`--march=native` 등), **Peak RSS 5.03GB** | **추출** → `_assets/lsb4-p237-fig8-1-native-image-build-output.png`. 수치 자체가 학습 대상이다 — 왜 네이티브 빌드가 오래 걸리고 메모리를 먹는지, 이미지에서 무엇이 자리를 차지하는지를 본문 서술이 아니라 이 숫자가 말한다 |
| 8.2 | 239 | macOS 방화벽 대화상자 — "Do you want the application ch8 to accept incoming network connections?" / Deny · Allow 버튼 | **미추출**. OS 표준 대화상자이고 책 자신이 "정상 동작이며 문제가 아니다"라고만 말한다. 학습 대상은 팝업의 생김새가 아니라 "네이티브 실행 파일이 서명되지 않은 새 바이너리라 방화벽이 묻는다"는 사실이며, 그것은 [[03-building-and-running-a-native-application]]의 본문 한 문단으로 충분하다 |

## 5. 원문의 오류·공백 (노트에 명시)

| # | 원문 | 실제 | 노트 반영 |
|---:|---|---|---|
| 1 | p.245 training run을 **uber JAR에 직접** 실행한다 — `java -XX:AOTCacheOutput=app.aot ... -jar target/ch8-0.0.1-SNAPSHOT.jar` | Boot 4.1 공식 문서는 먼저 `java -Djarmode=tools -jar my-app.jar extract --destination application`으로 **풀어낸 뒤** 그 디렉터리에서 training run을 하라고 한다. 공식 Dockerfile 예제도 같다. 이유를 문서가 밝힌다 — 풀어낸 JAR은 애플리케이션 코드와 추출된 JAR 참조만 담아 "시작이 효율적이고 **AOT cache에 친화적인** 배치"이기 때문이다. uber JAR의 중첩 JAR 로딩 구조는 그 조건이 아니다 | [[07a-enabling-aot-cache-for-spring-boot]] §5 |
| 2 | p.244가 AOT Cache 근거로 **JEP 483·515만** 든다 | Java 25에서 "단일 training-run 명령"을 실제로 가능하게 한 것은 **JEP 514 Ahead-of-Time Command-Line Ergonomics**다(OpenJDK 자료로 확인). 책이 쓰는 **`-XX:AOTCacheOutput`이 바로 그 JEP가 도입한 옵션**이며, JVM이 `AOTMode=create` 하위 호출을 대신 오케스트레이션한다. 그 부수 효과로 **힙이 두 배 필요**한데 책은 둘 다 언급하지 않는다 | [[07-using-java-25-aot-cache]] §5 |
| 3 | p.234 Hibernate 강화 옵션 `enableLazyInitialization`·`enableDirtyTracking`·`enableAssociationManagement` | Hibernate 공식 문서 기준 이 세 옵션은 모두 **deprecated for removal**이고, lazy loading은 제거 후 기본 활성이 된다. 책은 현재 권장 설정처럼 제시한다 | [[02-adapting-an-application-for-native-image]] §5 |
| 4 | p.246 CRaC를 "Spring Boot가 문서화한 또 하나의 방법"이라고만 소개하고 **Spring 쪽 사용법을 보이지 않는다** | Spring Framework에는 AOT/CDS의 `spring.context.exit`와 **짝을 이루는 `spring.context.checkpoint=onRefresh`**가 있고(둘 다 `DefaultLifecycleProcessor`, 6.1부터), Boot는 CRaC MXBean이 classpath에 있으면 배너를 `Started` 대신 **`Restored`**로 바꾼다. 네 전략 비교에서 CRaC만 명령이 없는 공백 | [[07b-comparing-four-execution-strategies]] §5 |
| 5 | p.243이 Java AOT Cache를 "startup과 warmup을 줄인다"고만 말한다 | 같은 자리에서 Boot가 지원하는 **CDS**(`-XX:ArchiveClassesAtExit=application.jsa` → `-XX:SharedArchiveFile=...`)는 언급되지 않는다. Java 24 이전 JDK를 쓰는 팀에게는 이쪽이 유일한 선택지다 | [[06-using-buildpacks-with-java-aot-cache]] §5 |
| 6 | p.239–240 "0.1초에 뜬다"는 계산 | 바로 앞 p.238의 실제 로그는 **0.528초**다. 0.1초는 어디서도 측정되지 않은 숫자이며, 5.6시간 ↔ 17분 대비도 이 가정 위에 서 있다 | [[03a-why-native-images-pay-off]] §5 |
| 7 | p.230 "GraalVM by Oracle is essentially a new virtual machine" | 이 장이 실제로 쓰는 것은 VM으로서의 GraalVM이 아니라 **`native-image` AOT 컴파일러**다. 최종 산출물에는 JVM이 없다 — 같은 이름이 두 가지를 가리킨다 | [[01-why-graalvm-native-image]] §5 |

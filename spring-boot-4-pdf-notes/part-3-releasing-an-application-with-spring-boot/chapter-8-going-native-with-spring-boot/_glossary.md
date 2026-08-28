# Chapter 8 용어집

> *Learning Spring Boot 4*, Ch. 8 *Going Native with Spring Boot* (책 pp. 229–248 / PDF pp. 254–273)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## GraalVM (GraalVM)

Oracle이 만든 고성능 런타임이자 툴체인. Java·JavaScript·Python·Ruby·R·C·C++를 겨냥하며, 이 장이 실제로 쓰는 것은 그중 **`native-image` AOT 컴파일러**다.

## 네이티브-이미지 (native image)

애플리케이션과 필요한 런타임 조각을 미리 기계어로 컴파일해 만든 **플랫폼 전용 독립 실행 파일**. JVM 위에서 돌지 않으므로 JAR도 아니고 다른 OS·아키텍처로 옮겨 갈 수도 없다.

## AOT-컴파일 (ahead-of-time compilation)

실행 전에 미리 기계어로 번역해 두는 방식. 시작할 때 번역할 것이 없어 startup이 빠른 대신, 런타임 정보를 활용한 최적화 기회를 잃는다.

## JIT (just-in-time compilation)

실행 중 프로파일링으로 자주 도는 코드를 찾아내 그때그때 기계어로 컴파일하는 방식. 워밍업이 필요한 대신 **실제 실행 패턴에 맞춘 최적화**가 가능하다.

## 바이트코드 (bytecode)

Java 컴파일러가 만드는 플랫폼 중립 중간 표현. 명세를 따르는 어떤 JVM에서도 실행돼 "한 번 작성해 어디서나 실행"을 가능하게 했다.

## JVM (Java Virtual Machine)

바이트코드를 해석·컴파일해 실행하는 가상 머신. class 로딩, JIT, GC, 리플렉션 같은 동적 기능이 여기 산다.

## write-once-run-anywhere (write once, run anywhere)

같은 바이트코드를 기계마다 다시 컴파일하지 않고 어디서나 돌린다는 Java의 오랜 약속. 네이티브 이미지는 이것을 **의도적으로 포기**한다.

## 도달성-분석 (reachability analysis)

`main` 메서드·리플렉션 힌트·resource 설정·프레임워크 metadata 같은 **알려진 진입점에서 호출 그래프를 정적으로 추적**하는 분석. 여기서 닿지 않는 코드는 최종 이미지에서 잘려 나간다.

## 닫힌-세계-가정 (closed-world assumption)

"프로그램이 무엇을 쓸지는 build 시점에 전부 알 수 있다"는 전제. 이 전제 위에서만 도달하지 않는 코드를 잘라낼 수 있고, 그 대가로 **런타임에 구조를 바꾸는 일이 금지**된다.

## 리플렉션 (reflection)

클래스·메서드·필드를 이름으로 찾아 런타임에 접근하는 기능. 호출 대상이 코드에 문자열로만 나타나므로 도달성 분석이 볼 수 없다.

## 동적-프록시 (dynamic proxy)

인터페이스 구현체를 런타임에 바이트코드로 생성하는 기법. 네이티브 이미지는 런타임 바이트코드 생성을 못 하므로 **모든 프록시가 build 시점에 만들어져야** 한다.

## Spring-AOT-엔진 (Spring AOT engine)

build 시점에 애플리케이션을 분석해 bean 정의를 코드로 펼치고 GraalVM이 필요로 하는 metadata를 생성하는 Spring의 처리 단계. **애플리케이션 구조**를 다루며, JVM 수준의 Java AOT Cache와는 다른 층이다.

## 런타임-힌트 (runtime hints)

AOT 분석이 스스로 알아낼 수 없는 리플렉션·직렬화·resource 접근을 **명시적으로 등록**하는 정보. 닫힌 세계 가정의 escape hatch다.

## RuntimeHintsRegistrar (RuntimeHintsRegistrar)

`registerHints(RuntimeHints, ClassLoader)` 하나를 갖는 인터페이스. 힌트를 애노테이션이 아니라 **코드로** 조립할 때 구현한다.

## @ImportRuntimeHints (@ImportRuntimeHints)

`RuntimeHintsRegistrar` 구현을 configuration class에 붙여 Spring AOT 엔진에 등록하는 애노테이션.

## @RegisterReflectionForBinding (@RegisterReflectionForBinding)

데이터 바인딩 대상 타입에 리플렉션 접근이 필요함을 선언하는 애노테이션. `org.springframework.aot.hint.annotation` 패키지에 있다.

## MemberCategory (MemberCategory)

리플렉션 힌트에서 **어디까지 허용할지**를 고르는 열거형. `INVOKE_DECLARED_CONSTRUCTORS`는 객체 생성을, `INVOKE_PUBLIC_METHODS`는 public 메서드 호출을 연다.

## reachability-metadata (reachability metadata)

라이브러리가 "내 안에서는 여기에 리플렉션이 쓰인다"고 미리 실어 보내는 설정. 이것이 있으면 사용하는 쪽이 힌트를 직접 쓰지 않아도 된다.

## native-maven-plugin (native-maven-plugin)

`org.graalvm.buildtools` 그룹의 Maven 플러그인. `native:compile` 골이 GraalVM 툴체인을 불러 실행 파일을 만든다.

## native-프로파일 (native Maven profile)

`spring-boot-starter-parent`가 선언해 두는 Maven profile. `-Pnative`로 켜면 Spring AOT 처리를 돌리고 Native Build Tools의 기본값을 잡아 준다.

## SDKMAN (SDKMAN)

여러 Java 배포판을 설치하고 전환하는 macOS·Linux용 도구. 표준 JDK와 GraalVM을 오갈 때 쓴다.

## Spring-Native (Spring Native)

2019년 시작된 실험 프로젝트로, Boot 2.x 시대에 GraalVM 네이티브 이미지를 검증하던 **다리**였다. 지금은 그 기능이 본류로 흡수돼 **따로 추가할 프로젝트가 아니다**.

## 바이트코드-강화 (bytecode enhancement)

Hibernate가 엔티티 클래스의 바이트코드를 고쳐 lazy attribute loading·dirty tracking·association management를 넣는 것. 네이티브에서는 런타임에 못 하므로 **build 시점**으로 옮긴다.

## Paketo-Buildpack (Paketo Buildpack)

Dockerfile 없이 소스에서 컨테이너 이미지를 조립하는 buildpack 구현. Spring Boot의 `spring-boot:build-image`가 기본으로 쓴다.

## Java-AOT-Cache (Java AOT Cache)

training run에서 만든 선별 컴파일·프로파일링 산출물을 파일로 저장했다가 다음 실행에서 재사용하는 **JVM 수준** 최적화. JIT를 끄지 않는다.

## training-run (training run)

캐시를 만들기 위해 애플리케이션을 한 번 대표적으로 실행해 보는 단계. 여기서 밟지 않은 경로는 캐시에 담기지 않는다.

## Project-Leyden (Project Leyden)

Java의 시작·워밍업 시간을 줄이는 것을 목표로 하는 OpenJDK 프로젝트. AOT Cache가 그 산물이다.

## JEP (JDK Enhancement Proposal)

OpenJDK에 들어갈 변경을 기술한 제안 문서. AOT Cache는 JEP 483·514·515에 걸쳐 있다.

## warmup (warmup)

JVM이 프로파일을 모아 JIT 최적화를 적용해 가는 초기 구간. 이 구간 동안 성능이 정상보다 낮다.

## steady-state-처리량 (steady-state throughput)

워밍업이 끝나 최적화가 안정된 뒤의 처리 성능. JIT를 유지하는 방식이 지키려는 것이 이 값이다.

## tiered-compilation (tiered compilation)

인터프리터와 여러 단계의 JIT 컴파일러를 조합해, 처음엔 빨리 실행하고 자주 도는 코드만 점점 깊이 최적화하는 HotSpot의 실행 모델.

## CRaC (Coordinated Restore at Checkpoint)

완전히 초기화된 JVM 프로세스 상태를 파일로 떠 두었다가 나중에 복원하는 방식. 복원 후 startup이 극단적으로 빠를 수 있다.

## CRIU (Checkpoint/Restore In Userspace)

리눅스에서 실행 중인 프로세스를 파일로 덤프하고 되살리는 기반 기술. CRaC가 이것 위에 서 있어 현재 Linux 지향이다.

## 체크포인트 (checkpoint)

프로세스의 메모리와 상태를 특정 시점에 통째로 저장한 스냅숏.

## spring.context.exit (spring.context.exit)

값 `onRefresh`를 주면 `ApplicationContext` refresh가 끝나는 순간 JVM을 종료시키는 Spring Framework 속성. training run을 "떠 보고 바로 끄기"로 만든다.

## spring.context.checkpoint (spring.context.checkpoint)

같은 자리의 CRaC용 짝. `onRefresh`를 주면 refresh 시점에 체크포인트를 찍는다.

## CDS (Class Data Sharing)

로드된 class의 메타데이터를 아카이브로 저장해 다음 실행에서 재사용하는, AOT Cache 이전 세대의 JVM 기능.

## BP_JVM_AOT_ENABLED (BP_JVM_AOT_ENABLED)

buildpack에 "이미지 빌드 중 training run을 돌려 AOT 캐시를 구워 넣어라"라고 지시하는 환경 변수.

## cold-start (cold start)

인스턴스가 새로 뜨는 순간부터 첫 요청을 처리할 수 있을 때까지의 지연. serverless와 급격한 스케일아웃에서 비용이자 지연으로 직접 드러난다.

## 서버리스 (serverless)

요청이 올 때 인스턴스를 띄우고 끝나면 내리는 실행 모델. 인스턴스 수명이 짧아 startup 비용이 전체 비용에서 큰 비중을 차지한다.

## 지속-배포 (continuous delivery)

작은 변경을 자주 자동으로 배포하는 방식. 배포 횟수가 늘수록 인스턴스 시작 비용이 누적된다.

## uber-JAR (uber JAR)

애플리케이션과 모든 의존성을 한 파일에 담은 실행 가능 JAR. 안에 중첩 JAR을 품는 구조라 class 로딩 경로가 일반 classpath와 다르다.

## jarmode-tools (jarmode tools)

`java -Djarmode=tools -jar app.jar extract`로 uber JAR을 애플리케이션 코드와 의존 JAR로 **풀어내는** Spring Boot 기능.

## 이미지-힙 (image heap)

네이티브 이미지 안에 미리 만들어 넣는 객체 그래프 영역. build 시점에 초기화된 객체가 여기 저장돼 시작 시 그대로 쓰인다.

## 코드-영역 (code area)

네이티브 이미지에서 컴파일된 기계어가 차지하는 영역. 어떤 라이브러리가 이미지를 키우는지 여기 기여도로 드러난다.

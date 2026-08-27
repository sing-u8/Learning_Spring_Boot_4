# Going Native with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## graalvm
오라클에서 개발한 고성능 런타임이자, 자바 애플리케이션을 AOT 컴파일을 통해 플랫폼 네이티브 실행 파일로 변환해주는 도구
- 처음 나온 곳: [[01-what-is-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## ahead-of-time-compilation
런타임에 바이트코드를 번역하는 JIT와 달리, 빌드 시점에 기계어로 모두 번역해버리는 컴파일 방식
- 처음 나온 곳: [[01-what-is-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## cold-start
애플리케이션이 처음 메모리에 로드되고 예열(Warm-up)되기 전까지 초기 응답이 매우 느린 현상
- 처음 나온 곳: [[01-what-is-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## closed-world-assumption
애플리케이션 실행 시점에 로드될 모든 클래스와 메서드를 빌드 타임에 완전히 알 수 있다는 가정 (새로운 클래스의 런타임 로드를 허용하지 않음)
- 처음 나온 곳: [[02-retrofitting-for-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## reachability
정적 코드 분석을 통해 시작점부터 호출 트리를 따라가며 특정 코드가 실제로 쓰이는지(도달 가능한지) 판별하는 과정
- 처음 나온 곳: [[02-retrofitting-for-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## sdkman
자바 계열의 여러 JDK 및 빌드 도구(Maven, Gradle)의 버전을 쉽게 다운로드하고 교체(switch)하게 해주는 쉘 도구
- 처음 나온 곳: [[03-running-native-spring-boot]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## native-image
GraalVM 툴체인에 포함된 AOT 컴파일러 툴의 이름이자, 그 결과물로 나오는 실행 파일 포맷
- 처음 나온 곳: [[03-running-native-spring-boot]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## cross-compile
특정 OS나 아키텍처(예: Mac) 위에서 동작하는 툴체인을 가지고, 다른 아키텍처(예: Linux)용 바이너리를 생성해내는 컴파일 방식
- 처음 나온 곳: [[04-baking-a-docker-container-with-graalvm]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## runtime-hints
GraalVM 네이티브 빌드 시 컴파일러가 자동 분석하지 못하는 동적 코드(리플렉션, 프록시, 리소스 읽기 등)의 구조를 명시적으로 알려주는 메타데이터 API
- 처음 나온 곳: [[05-configuring-reflection-and-runtime-hints]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## java-aot-cache
JVM 레벨의 최적화 기술로, 훈련 주행(Training Run)을 통해 얻은 프로파일링과 컴파일 아티팩트를 디스크에 캐시해두고 다음 구동 시 재사용하는 방식
- 처음 나온 곳: [[06-using-buildpacks-with-java-aot-cache]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## training-run
애플리케이션을 시범적으로 구동하여 주로 사용되는 경로(Hot paths)나 클래스 정보를 JIT 컴파일러가 수집할 수 있게 하는 과정
- 처음 나온 곳: [[06-using-buildpacks-with-java-aot-cache]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## project-leyden
자바 생태계에서 JVM 애플리케이션의 시작(Startup) 시간과 메모리 발자국을 줄이기 위해 시작된 OpenJDK의 장기 최적화 프로젝트
- 처음 나온 곳: [[07-java-25-aot-cache]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## crac
Coordinated Restore at Checkpoint의 약자로 런타임 상태를 체크포인트로 저장하고 이후 빠르게 복원하는 JVM 기술
- 처음 나온 곳: [[07-java-25-aot-cache]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

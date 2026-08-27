# Chapter 8 용어집

- **GraalVM Native Image**: closed-world AOT로 만든 platform-specific executable. → [[01-why-graalvm-native-image]]
- **reachability analysis**: entry point에서 도달 가능한 code·resource를 찾는 분석. → [[02-adapting-an-application-for-native-image]]
- **closed-world assumption**: build 때 알려진 요소가 실행 세계의 전부라는 전제. → [[02-adapting-an-application-for-native-image]]
- **runtime hint**: 동적 접근 대상을 native image에 보존하는 metadata. → [[05-configuring-reflection-and-runtime-hints]]
- **Java AOT Cache**: JVM loading/linking/profiling artifact를 다음 실행에 재사용하는 cache. → [[06-using-buildpacks-with-java-aot-cache]]
- **JIT**: runtime profile을 이용해 hot code를 machine code로 compile하는 기능. → [[07-java-25-aot-cache-and-crac-comparison]]
- **CRaC**: 초기화된 JVM을 checkpoint/restore하는 startup 최적화. → [[07-java-25-aot-cache-and-crac-comparison]]


# 모범답안 — 06 buildpack과 Java AOT 캐시

> **먼저 답하고 나서 열 것.** [[06-using-buildpacks-with-java-aot-cache]]의 `## 8. 스스로 확인` 네 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **4문항 모두 답이 충분**했다.

---

## Q1. 네이티브와 AOT Cache가 startup을 줄이는 방식의 차이

**네이티브는 JIT를 없애서 startup을 얻고, AOT Cache는 JIT를 유지한 채 워밍업만 앞당긴다.**

| | **네이티브 이미지** | **Java AOT Cache** |
|---|---|---|
| JVM | **없앤다** | **남는다** |
| JIT | **없앤다** | **온전히 유지** |
| 얻는 것 | startup + 런타임 메모리 | **startup + 워밍업 단축** |
| 잃는 것 | **런타임 동적 기능, peak 처리량** | — |
| 제약 | 리플렉션·프록시·`@Profile` | **없음** |

> **애플리케이션은 여전히 JVM에서 돌고, 이미지 빌드가 캐시를 만들고, 그 캐시를 시작할 때 재사용한다.**

**AOT Cache가 하는 일**: **training run에서 생성된 선별 컴파일·프로파일링 산출물을 저장했다가 이후 실행에서 재사용한다.**

**그래서 "production 친화적인 대안"이다** — **JVM 기반 이미지이면서 startup이 개선되고, 네이티브 컴파일의 제약이 없다.**

**이 절이 방향을 트는 이유**: 지금까지 네이티브를 위해 지불한 것이 **빌드 161초·5.03GB, `@Profile` 고정, 리플렉션 힌트, 서드파티 협조**였는데, **우리가 원했던 것은 startup 하나**였다. **저 목록 전체를 감수해야만 얻을 수 있는 것이 아니다.**

---

## Q2. training run을 이미지 빌드 시점에 하는 이유

**운영 배포 시점에 하면 첫 인스턴스가 느려지므로 의미가 없기 때문이다.**

```
배포 시점에 training run  →  첫 인스턴스가 그 비용을 지불 → startup 개선이 상쇄된다
빌드 시점에 training run  →  CI 가 한 번 지불
                              → 배포되는 모든 인스턴스가 그 결과를 나눠 쓴다
```

> **[[03a-why-native-images-pay-off]]의 곱셈이 여기서도 작동한다 — 다만 이번엔 이득 쪽에서.**

**한 번의 비용 × 1 vs 절감 × 인스턴스 수** — **인스턴스가 많을수록 이득이 커진다.** 네이티브의 논증과 같은 구조다.

**대가**: **이미지 빌드 시간이 늘어난다.** training run만큼 CI 시간이 추가된다. 다만 **네이티브의 161초보다는 훨씬 싸다.**

**주의할 한계**(§6): **training run이 대표성 없으면 이득이 작다.** **빌드 중 실행이라 DB 같은 외부 의존성에 붙지 못할 수 있고, 그러면 밟는 경로가 얕아진다.**

**비유의 깨짐이 이것이다** — **리허설에서 연주하지 않은 곡은 조율이 안 돼 있다.** **training run에서 밟지 않은 코드 경로는 캐시에 없다.** **리허설을 대충 하면 이득이 작다.**

---

## Q3. `BP_`로 시작하는 환경 변수가 Maven 옵션이 아닌 이유

**buildpack에 주는 지시이기 때문이다.**

```bash
% BP_JVM_AOT_ENABLED=true ./mvnw spring-boot:build-image
  └────────┬────────┘
   buildpack 설정 (Maven 이 읽지 않는다)
```

> **`BP_`로 시작하는 이름은 buildpack 설정의 관례다.**

**층이 다르다**:
```
Maven      →  spring-boot:build-image 골을 실행
   ↓
Docker     →  Paketo 빌더 컨테이너를 띄운다
   ↓
buildpack  →  BP_* 환경 변수를 읽어 무엇을 할지 정한다   ← 여기
```

**Maven이 buildpack의 동작을 다 알 수 없으므로**, buildpack이 **자기 규약(환경 변수)**으로 설정을 받는다. [[04-building-native-container-images]]에서 본 것처럼 **buildpack은 Spring 것이 아니라 독립 프로젝트**다.

**`BP_JVM_AOT_ENABLED=true`가 켜지면**: **이미지 빌드 중에 training run이 수행되고, 생성된 AOT 캐시가 컨테이너에 박혀서 나온다.**

**그다음은 평범하다** — `docker run -p 8080:8080 your-image-name`. **시작할 때 JVM이 캐시된 컴파일 산출물을 재사용해 워밍업 시간이 줄고, JIT 능력은 그대로 남는다.**

**`-Pnative`와는 배타적이다** — **앞의 것은 JVM을 없애고 뒤의 것은 JVM을 전제한다. 같이 켤 이유가 없다.**

---

## Q4. Java 23 기반 이미지에서 startup을 줄이려면

**CDS를 쓴다.**

> **AOT Cache는 Java 24에서 도입돼 Java 25에서 단순화됐다. 그 이전 JDK 기반 이미지에서는 이 환경 변수가 의미가 없다.**

**CDS**: **class 메타데이터를 아카이브로 저장해 재사용**하는 기능.

**공식 문서의 절차**:
```bash
# 아카이브 생성
java -XX:ArchiveClassesAtExit=application.jsa \
     -Dspring.context.exit=onRefresh -jar app.jar
# 사용
java -XX:SharedArchiveFile=application.jsa -jar app.jar
```

`-Dspring.context.exit=onRefresh`가 요령이다 — **컨텍스트가 다 뜬 직후 종료**시켜, **실제 요청을 처리하지 않고도 로딩된 클래스를 아카이브**한다.

> **책이 빠뜨린 선택지다** — 이 절은 AOT Cache만 다루지만 **Spring Boot는 같은 자리에서 CDS도 지원한다.** **Java 24 이전 JDK를 쓰는 팀에게는 이쪽이 유일한 선택지**인데 **책에는 언급이 없다.**

**AOT Cache와의 차이**:
| | **CDS** | **AOT Cache** |
|---|---|---|
| 저장하는 것 | **class 메타데이터** | **컴파일·프로파일링 산출물** |
| 앞당기는 단계 | **로딩·링크** | **로딩·링크 + 프로파일·컴파일** |
| JDK 요구 | 오래전부터 | **24 이상** |

**AOT Cache가 더 많이 앞당긴다** — [[07-using-java-25-aot-cache]]의 JEP 483(class 로딩·링크)과 **JEP 515(메서드 프로파일링)** 둘을 합친 것이기 때문이다. **CDS는 앞의 절반**에 해당한다.

---

## 재출제 문항

1. 네이티브를 포기하고 AOT Cache로 가면 무엇을 되찾는가?
2. training run을 배포 스크립트에 넣었다. 무엇이 상쇄되는가?
3. `BP_JVM_AOT_ENABLED`를 `pom.xml`의 `<properties>`에 넣으면 동작하는가?
4. `-Pnative`와 `BP_JVM_AOT_ENABLED`를 같이 켰다. 왜 무의미한가?
5. Java 21 프로젝트다. 이 절의 방법을 쓸 수 있는가? 대안은?
6. CDS와 AOT Cache가 각각 앞당기는 단계를 구분하라.

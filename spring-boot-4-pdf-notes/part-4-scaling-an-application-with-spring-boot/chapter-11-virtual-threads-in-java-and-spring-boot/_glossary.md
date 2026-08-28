# Chapter 11 용어집

> *Learning Spring Boot 4*, Ch. 11 *Virtual Threads in Java and Spring Boot* (책 pp. 295–314 / PDF pp. 320–339)에서 쓰는 전문 용어의 정의는 이 파일이 유일한 원본이다. 각 concept note 본문의 첫 등장 자리에는 `**[[용어]]**(= 한 줄 풀이)` 형태로 링크만 걸고, 정의는 여기에서만 관리한다.

## 동시성 (concurrency)

여러 작업이나 요청을 **동시에 다루는** 능력. 전부가 같은 순간에 실행되고 있지 않더라도, 진행 중인 작업이 여럿이면 동시성이다.

## 플랫폼-스레드 (platform thread)

운영체제 스레드에 1:1로 대응하는 전통적인 자바 스레드. 강력하지만 메모리와 스케줄링 비용이 커서 한 프로세스가 효율적으로 쓸 수 있는 개수가 제한된다.

## 가상-스레드 (virtual thread)

**JVM이 관리하는** 경량 스레드. 운영체제가 아니라 JVM이 스케줄링하므로 수백만 개를 최소 오버헤드로 만들 수 있다.

## Project-Loom (Project Loom)

자바에 경량 동시성을 도입하기 위한 OpenJDK 프로젝트. 그 산물인 가상 스레드가 Java 19·20 preview를 거쳐 **Java 21에서 final**이 됐다.

## JEP (JDK Enhancement Proposal)

OpenJDK에 들어갈 변경을 기술한 제안 문서. 가상 스레드는 JEP 444, 구조적 동시성은 JEP 505다.

## 캐리어-스레드 (carrier thread)

가상 스레드를 **실제로 실행해 주는 플랫폼 스레드**. 가상 스레드 자체가 아니라, 그 순간 그것을 얹고 도는 밑바닥 스레드다.

## 마운트 (mount / unmount)

가상 스레드가 캐리어 스레드 위에 얹히는 것(mount)과 내려오는 것(unmount). 블로킹 연산을 만나면 unmount되어 캐리어가 다른 일을 할 수 있게 된다.

## ForkJoinPool (ForkJoinPool)

작업 훔치기(work-stealing) 방식의 자바 스레드 풀. JDK의 가상 스레드 스케줄러가 캐리어 스레드 풀로 쓰며, `CompletableFuture`의 기본 실행자(`commonPool`)이기도 하다.

## 스레드-풀 (thread pool)

비싼 스레드를 미리 만들어 두고 돌려 쓰는 방식. 플랫폼 스레드의 생성 비용을 감추기 위해 쓰였고, 가상 스레드에서는 풀이 필요 없어진다.

## 명령형-블로킹-스타일 (imperative blocking style)

위에서 아래로 순서대로 읽히고, 필요한 곳에서 결과를 기다리는(블로킹) 평범한 코드 형태. 디버거·스택 트레이스·try-catch가 그대로 통한다.

## 리액티브-모델 (reactive model)

논블로킹 연산과 데이터 흐름 조합으로 동시성을 다루는 모델. 확장성은 뛰어나지만 코드를 쓰고 조합하고 이해하는 방식에 복잡도를 더한다.

## 배압 (backpressure)

소비자가 감당할 수 있는 속도만큼만 생산자가 보내도록 조절하는 장치. 리액티브 스트림의 핵심 기능이며 가상 스레드가 대체하지 못하는 영역이다.

## I/O-바운드 (I/O-bound)

CPU 계산이 아니라 **기다림**이 시간을 차지하는 작업. 데이터베이스 응답, 네트워크 호출, 파일 읽기가 여기 속하며 가상 스레드가 가장 크게 이기는 영역이다.

## 블로킹-호출 (blocking call)

결과가 올 때까지 호출한 쪽이 멈춰 서는 호출. 플랫폼 스레드에서는 그 스레드를 통째로 묶어 두지만, 가상 스레드에서는 캐리어가 풀려난다.

## spring.threads.virtual.enabled (spring.threads.virtual.enabled)

Spring Boot가 **자기가 자동 설정하는 인프라**에 가상 스레드를 쓰게 하는 프로퍼티. 지원되는 내장 웹 서버의 요청 처리와 Spring이 관리하는 작업 실행에 적용된다.

## 서블릿-필터 (Filter)

요청이 컨트롤러에 닿기 전에 가로채는 서블릿 표준 훅. 이 장에서는 실행 중인 스레드가 가상인지 확인하는 데 쓴다.

## isVirtual (Thread.isVirtual())

현재 스레드가 가상 스레드인지 알려 주는 Java 21의 메서드. 로그로 확인할 수 있는 가장 직접적인 증거다.

## TaskExecutor (TaskExecutor)

작업을 별도 스레드에서 실행해 주는 Spring의 추상. `execute(Runnable)` 하나로 호출자를 막지 않고 일을 넘긴다.

## AsyncTaskExecutor (AsyncTaskExecutor)

`TaskExecutor`를 확장해 `Future`나 `CompletableFuture`로 **결과를 돌려받을 수 있게** 한 인터페이스. 완료 추적·결과 회수·명시적 예외 처리가 필요할 때 쓴다.

## Async (@Async)

메서드 호출을 별도 스레드로 넘기는 Spring 애노테이션. Spring Boot의 기본 실행자에 의존하면 가상 스레드 설정의 영향을 받는다.

## Scheduled (@Scheduled)

정해진 주기나 시각에 메서드를 실행시키는 Spring 애노테이션. 기본 스케줄러를 쓰면 역시 가상 스레드 설정을 따른다.

## fire-and-forget (fire-and-forget)

작업을 던져 놓고 결과를 확인하지 않는 방식. 감사 로그나 알림처럼 실패해도 주 흐름을 막지 않아야 하는 일에 쓴다.

## CompletableFuture (CompletableFuture)

비동기 연산의 결과를 나타내면서 연결·결합·예외 처리를 메서드 체인으로 표현할 수 있는 자바 타입.

## runAsync (CompletableFuture.runAsync)

값을 돌려주지 않는 작업을 비동기로 실행하는 정적 메서드. **실행자를 주지 않으면 JVM의 공용 풀**(`ForkJoinPool.commonPool()`)에서 돈다.

## exceptionally (exceptionally)

`CompletableFuture`의 체인에서 예외가 났을 때 실행될 대체 처리를 붙이는 메서드. 이것이 없으면 예외가 조용히 묻힌다.

## 예외-전파 (exception propagation)

던져진 예외가 호출 스택을 거슬러 올라가 처리자를 찾는 과정. **스레드 경계를 넘지 못한다**는 것이 이 장의 핵심 사실이다.

## 조용한-실패 (silent failure)

오류가 났는데 아무 데도 드러나지 않는 상태. 배경 작업의 예외를 잡지 않으면 이 상태가 된다.

## RestClient (RestClient)

Spring Framework 6.1이 들여온 **동기** HTTP 클라이언트. 블로킹 모델이라 가상 스레드와 자연스럽게 맞물린다.

## WebClient (WebClient)

논블로킹 리액티브 HTTP 클라이언트. `.block()`으로 가상 스레드와 함께 쓸 수는 있지만 그 순간 리액티브 스타일의 이점이 사라진다.

## HTTP-인터페이스-프록시 (HTTP interface proxy)

원격 서비스를 자바 인터페이스로 선언하면 Spring이 런타임 구현체를 만들어 주는 기능. 요청 조립과 응답 변환이 감춰진다.

## PostExchange (@PostExchange)

인터페이스 메서드를 원격 HTTP POST 호출로 바꿔 주는 애노테이션. 요청을 받는 쪽의 `@PostMapping`과 짝을 이루는 보내는 쪽 표기다.

## HttpServiceProxyFactory (HttpServiceProxyFactory)

`@PostExchange` 같은 표기가 붙은 인터페이스로부터 실제 구현체를 만들어 내는 팩토리.

## RestClientAdapter (RestClientAdapter)

`HttpServiceProxyFactory`가 `RestClient`를 백엔드로 쓸 수 있게 이어 주는 어댑터.

## 구조적-동시성 (structured concurrency)

관련된 동시 작업들을 **하나의 스코프로 묶어** 다루는 모델. 스코프를 벗어나기 전에 모든 작업이 끝나고, 실패가 일관되게 전파되며, 관련 작업을 함께 취소할 수 있다. 집필 시점에 preview다.

## JPA-엔티티 (JPA entity)

영속성 컨텍스트가 생명주기를 관리하는 **가변** 객체. 상태 변화를 추적해야 하므로 불변 타입으로는 표현하기 어렵다.

## 영속성-컨텍스트 (persistence context)

JPA가 엔티티의 신원과 변경 사항을 추적하는 작업 단위. 엔티티가 가변이어야 하는 이유가 여기 있다.

## record (record)

필드·생성자·접근자를 자동 생성하는 자바의 **불변** 데이터 타입. DTO에는 잘 맞지만 JPA 엔티티에는 맞지 않는다.

## CommandLineRunner (CommandLineRunner)

애플리케이션이 뜬 뒤 한 번 실행되는 Spring Boot의 함수형 인터페이스. 초기 데이터 적재에 흔히 쓴다.

## Thymeleaf (Thymeleaf)

서버 사이드 HTML을 렌더링하는 템플릿 엔진. 이 장의 employee 애플리케이션이 화면을 그리는 데 쓴다.

## 집중형-스타터 (focused starter)

기능 하나에 필요한 것만 묶은 Spring Boot 4의 의존성 단위. `spring-boot-starter-restclient`처럼 이름이 곧 범위를 말한다.

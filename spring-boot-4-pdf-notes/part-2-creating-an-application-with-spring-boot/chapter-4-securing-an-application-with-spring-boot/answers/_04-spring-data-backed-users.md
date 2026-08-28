# 모범답안 — 04 사용자를 데이터베이스로 옮기기

> **먼저 답하고 나서 열 것.** [[04-spring-data-backed-users]]의 `## 8. 스스로 확인` 일곱 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **7문항 모두 답이 충분**했다. 이 노트는 이미 책의 오류 두 건(메서드 이름, `@ElementCollection` 타입)을 잡아 두었다.

---

## Q1. 사용자 관리와 인증을 분리하면 보안이 좋아지는 이유

**핵심은 "권한이 나뉜다"는 것이다.**

| 결합된 구조 | 분리된 구조 |
|---|---|
| 계정을 만들려면 **애플리케이션 소스를 고쳐야** 한다 | 보안 엔지니어링 팀이 **자기 도구로 DB를 관리**한다 |
| **계정 관리 권한 = 코드 배포 권한** | 두 권한이 **서로 다른 사람**에게 나뉜다 |
| 계정 변경 이력이 **git 커밋에만** 남는다 | 사용자 관리 도구의 **감사 로그**에 남는다 |
| 비밀번호 정책·만료를 앱이 구현 | 전용 도구가 담당 |

**두 번째 줄이 결정적이다.** 결합된 구조에서는 **"사용자를 추가할 수 있는 사람 = 코드를 배포할 수 있는 사람"**이다. 그 말은 계정 관리를 맡기려면 **코드 배포 권한까지 줘야** 한다는 뜻이다. 권한이 필요 이상으로 커진다.

**분리의 원리**: **"사용자를 만드는 쪽"과 "사용자로 로그인시키는 쪽"이 같은 코드일 필요가 없다.** 우리 앱은 인증만 하고, 계정 관리는 넘긴다.

**부수 효과**: 사용자 한 명 추가에 **배포 파이프라인 전체가 도는** 일도 사라진다. 이건 편의지만, 위의 권한 분리가 본질이다.

---

## Q2. 리포지토리를 두 개로 나눈 결정이 막는 사고

**인증 경로에서 사용자를 지우거나 만드는 사고다.**

| | `UserManagementRepository` | `UserRepository` |
|---|---|---|
| 부모 | `JpaRepository` | **`Repository` 마커** |
| 상속되는 메서드 | `save`, `delete`, `findAll`, `count` … **수십 개** | **없다** |
| 노출되는 것 | 전부 | **`findByUsername` 하나뿐** |
| 용도 | 사용자 생성·수정 | **인증 시 조회** |

**`UserRepository`가 `JpaRepository`를 상속했다면** 인증 코드가 실수로 `deleteAll()`을 부를 수 있는 상태가 된다. 로그인 처리 중에 전체 사용자가 지워지는 것이다.

> **부모를 바꾸는 것만으로 그 가능성이 타입 수준에서 사라진다.**

**컴파일러가 막아 준다는 점이 중요하다.** 코드 리뷰나 규율이 아니라 **언어가 강제한다.** [[../chapter-3-querying-for-data-with-spring-boot/03-creating-repositories-and-declarative-queries|Ch3에서 본 "`Repository`가 비어 있는 이유"]]가 여기서 실전으로 쓰인다 — 비어 있기 때문에 **필요한 것만 골라 담을 수 있다.**

**일반 원리**: **각 사용처가 필요한 최소 권한만 갖는 인터페이스를 준다.** 같은 테이블이라도 읽는 쪽과 쓰는 쪽의 계약을 분리할 수 있다.

---

## Q3. `UserDetailsService`가 SAM이라는 사실

**추상 메서드가 하나뿐이므로 람다 하나가 곧 구현체가 된다.**

```java
@Bean
UserDetailsService userService(UserRepository repo) {
    return username -> repo.findByUsername(username).asUser();
}
```

**세 줄에 개념이 셋 겹쳐 있다**:

1. **`UserDetailsService`도 SAM이다** → 람다 하나가 구현체가 된다. 클래스를 만들 필요가 없다.
2. **그 유일한 메서드는 `loadUserByUsername(String)`**이다. 람다의 `username ->`이 **그 입력**이고, **로그인 폼에 사용자가 입력한 값**이 여기로 들어온다.
3. **반환하는 것은 `UserDetailsService`이지 `UserDetails`가 아니다.** 이 빈은 "사용자 정보"가 아니라 **"사용자 정보를 가져오는 서비스"**다.

**3번이 가장 헷갈린다.** 메서드 이름이 `userService`이고 반환 타입이 `UserDetailsService`인데, 몸통은 사용자 하나를 찾는 코드처럼 보인다. **람다 전체가 서비스이고, 람다의 본문이 그 서비스가 호출될 때 실행되는 것**이다.

> ⚠ **책의 오류**: 책은 이 메서드를 **`loadUserByName`**이라 쓰고, 두 문단 뒤에는 **`UserDetailsService.loadUserName()`**이라고 또 다르게 쓴다. **실제 이름은 `loadUserByUsername(String)` 하나다.**

---

## Q4. `asUser()`가 없으면 깨지는 것

**타입이 맞지 않는다.**

```
리포지토리가 돌려주는 것:  UserAccount   (우리 JPA 엔티티)
Spring Security가 원하는 것: UserDetails  (표준 모양)
```

`UserAccount`는 `UserDetails`를 구현하지 않으므로 **그대로 반환하면 컴파일 오류다.**

**`asUser()`가 하는 일**: 엔티티의 값을 Spring Security의 빌더에 옮겨 담는다.

```java
public UserDetails asUser() {
    return User.withDefaultPasswordEncoder()
        .username(getUsername())
        .password(getPassword())
        .authorities(getAuthorities())
        .build();
}
```

**이 메서드 하나가 두 세계의 경계선이다.** 왼쪽은 우리 도메인(JPA 엔티티), 오른쪽은 Spring Security의 어휘(`UserDetails`, `authority`).

**경계선을 명시적으로 두는 이득**: **도메인 모델에 필드를 더해도 Spring Security 쪽에 영향이 없다.** [[06a-updating-our-model]]에서 실제로 그런 변경이 일어난다.

**대안이 없는 것은 아니다** — `UserAccount`가 `UserDetails`를 직접 구현하게 할 수도 있다. 그러면 변환은 사라지지만 **엔티티가 Spring Security 타입에 묶인다.** [[../chapter-3-querying-for-data-with-spring-boot/02-dtos-entities-and-pojos|Ch3의 DTO/엔티티 분리]]와 같은 트레이드오프다.

---

## Q5. `@ElementCollection`에 `FetchType.EAGER`를 준 이유

**인증 직후 권한 목록을 반드시 읽어야 하는데, 지연 로딩이면 영속성 컨텍스트가 이미 닫힌 뒤에 접근하게 되어 실패하기 때문이다.**

흐름을 보면 명확하다.

```
1. loadUserByUsername 호출 → 리포지토리 조회 → 트랜잭션/영속성 컨텍스트 종료
2. asUser()가 getAuthorities() 호출
3. 인증 필터가 권한을 확인
```

**2번 시점에 컨텍스트가 이미 닫혀 있으면** 지연 로딩된 컬렉션에 접근할 수 없다.

**`@ElementCollection` 자체가 필요한 이유도 함께**: 사용자 한 명이 권한을 **여러 개** 가질 수 있으므로 컬럼 하나에 담을 수 없다. 그렇다고 **권한이 독립된 엔티티인 것도 아니다** — 사용자가 지워지면 그 권한도 의미가 없다. 이 **"종속된 값들의 모음"**이 정확히 `@ElementCollection`이 표현하는 관계다.

> ⚠ **책 코드의 문제**: `List<GrantedAuthority>`는 그대로는 부팅되지 않는다. **`GrantedAuthority`는 인터페이스**이고, `@ElementCollection`의 대상은 기본 타입이거나 `@Embeddable`이어야 한다. 실제로는 `List<String>`으로 두고 읽을 때 `SimpleGrantedAuthority`로 감싸거나 `@Embeddable` 래퍼를 만들어야 한다.

---

## Q6. 없는 아이디로 로그인하면

**이 코드는 `NullPointerException`이 난다.**

```java
return username -> repo.findByUsername(username).asUser();
                                                  ↑ findByUsername이 null을 돌려주면 여기서 NPE
```

`findByUsername`은 파생 질의이고 **못 찾으면 `null`을 돌려준다.** 그 `null`에 `.asUser()`를 부른다.

**규격대로라면 `UsernameNotFoundException`을 던져야 한다.** `loadUserByUsername`의 시그니처에 그 예외가 선언돼 있다.

**차이가 중요한 이유**:

| | `UsernameNotFoundException` | `NullPointerException` |
|---|---|---|
| Spring Security가 | **인증 실패로 처리** → 로그인 화면으로 | **예상 못 한 오류** → 500 |
| 사용자가 보는 것 | "아이디 또는 비밀번호가 틀립니다" | **오류 페이지** |
| 로그 | 정상적인 인증 실패 기록 | **스택 트레이스** |

**보안 관점의 부가 문제**: 500과 로그인 실패가 다르게 보이면 **아이디의 존재 여부가 새어 나간다.** 공격자가 "이 아이디는 존재한다"를 알아낼 수 있다.

**올바른 형태**: `Optional`로 받아 `orElseThrow(() -> new UsernameNotFoundException(username))`.

---

## Q7. 출입 관리/인사 시스템 비유가 깨지는 지점

**인사 시스템은 사람의 상태 변화를 출입 시스템에 즉시 통보한다. 여기서는 그렇지 않다.**

비유는 여기까지 맞는다 — **인사 시스템**(계정 관리 도구)이 직원을 등록하고, **출입 관리 시스템**(우리 앱)은 그 명부를 조회해 문을 열어 준다. 두 시스템의 **운영 주체가 다르다**는 것이 Q1의 요지다.

**깨지는 지점 둘**:

1. **즉시 반영되지 않는다.** 인사 시스템에서 퇴사 처리를 하면 실제 출입 시스템은 곧바로 막지만, `UserDetailsService`는 **로그인 시점에만 불린다.** DB에서 권한을 박탈해도 **이미 로그인한 세션에는 반영되지 않는다.**
2. **비밀번호 검증을 우리가 안 한다.** 출입 시스템은 카드를 읽고 판정까지 하지만, `UserDetailsService`는 **사용자를 찾아 주기만** 하고 비밀번호 비교는 **Spring Security가 따로** 한다 — [[03-creating-users-with-userdetailsservice]] Q7과 같은 지점.

**1번이 실무에서 자주 문제가 된다.** 즉시 차단이 필요하면 세션 무효화를 별도로 해야 한다.

---

## 재출제 문항

1. 인증 코드에서 `userRepository.deleteAll()`을 부를 수 있는가? 그 답이 설계에 대해 말해 주는 것은?
2. 없는 아이디로 로그인했더니 500이 났다. 무엇이 잘못됐고 왜 보안 문제이기도 한가?
3. `FetchType.LAZY`로 바꾸면 언제 어떻게 실패하는가?
4. `UserAccount`가 `UserDetails`를 직접 구현하게 하면 무엇을 얻고 무엇을 잃는가?
5. 관리자가 DB에서 사용자 권한을 박탈했다. 그 사용자는 즉시 막히는가?
6. `.roles("USER")`와 DB에 직접 적는 `ROLE_USER`가 왜 다른가?

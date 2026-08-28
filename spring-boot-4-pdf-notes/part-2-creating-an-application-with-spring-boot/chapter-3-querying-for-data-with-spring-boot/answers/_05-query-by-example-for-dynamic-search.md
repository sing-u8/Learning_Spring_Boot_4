# 모범답안 — 05 Query By Example로 동적 검색하기

> **먼저 답하고 나서 열 것.** [[05-query-by-example-for-dynamic-search]]의 `## 8. 스스로 확인` 여덟 문항 답안이다.

- 챕터 지도: [[_map]] · 용어: [[_glossary]] · 작성: 2026-08-28
- 본문 점검: **8문항 모두 답이 충분**했다. 보강하지 않았다.

---

## Q1. 검색 필드 하나 추가 — finder 방식 vs QBE

| | **finder 방식** | **QBE 방식** |
|---:|---|---|
| 필드 2개 | finder 3개 + `if` 3개 | 코드 그대로 |
| 필드 3개 | **finder 7개 + `if` 7개** | **코드 그대로** |
| 필드 4개 | **finder 15개** | **코드 그대로** |
| 이름 길이 | `findByNameContainsOrDescriptionContainsOrTagsContainsAllIgnoreCase(...)` | 변화 없음 |
| 리포지토리 수정 | 필요 | **불필요** |

**QBE는 프로브에 `setTags(...)` 한 줄만 늘어난다.** 리포지토리에는 아무것도 새로 선언하지 않는다 — `findAll(Example<S>)`는 이미 `JpaRepository`에 있다.

**비용 곡선이 다르다**: finder는 **2ⁿ − 1**로 늘고, QBE는 **n에 선형**(프로브 채우는 줄 수만큼)이다.

---

## Q2. "조건의 개수 자체가 런타임에 정해진다"

**메서드 이름은 컴파일 시점에 확정되는 문자열이기 때문이다.**

```
사용자가 name만 입력    → name 조건 하나
description만 입력      → description 조건 하나
셋 다 입력              → 세 조건
```

**어떤 조건이 몇 개 필요한지가 요청이 도착해야 정해진다.**

그런데 [[04b-limiting-query-results]]에서 본 대로 finder에서 **조건으로 쓸 컬럼과 결합 방식(`And`/`Or`)은 메서드 이름에 박혀 있다.** 이름은 소스 코드에 쓰는 순간 고정된다.

**정적인 것으로 동적인 것을 표현하려면 가능한 모든 경우를 미리 나열하는 수밖에 없다.** 그것이 조합 폭발이다.

**QBE의 전환**: **조건을 "이름"이 아니라 "값이 있는 객체"로 표현한다.** 이름은 컴파일 시점에 고정되지만 **객체는 런타임에 만들어진다.**

---

## Q3. 수배 전단 비유가 깨지는 지점

**수배 전단의 빈칸은 사람이 보고 알아서 "이건 조건이 아니구나"라고 해석한다.**

**그런데 관계형 데이터베이스에서 `null`은 "아무거나"가 아니라 "모른다"이고, `where name = null`은 아무것도 찾지 못한다.**

```sql
where name = 'SPRING'  → TRUE 또는 FALSE
where name = null      → 항상 UNKNOWN     ← FALSE 가 아니다
```

`WHERE` 절은 **TRUE인 행만** 남긴다. UNKNOWN은 통과하지 못한다 → **결과 0건.**

**즉 "무시하고 싶은 필드에 `null`을 넣는다"는 발상은 SQL에서 자연스럽게 동작하지 않는다.** 오히려 정반대로 작동한다.

**QBE가 `null` 필드를 조건에서 빼 버리는 것은 프레임워크가 대신 해 주는 일이지 SQL의 자연스러운 동작이 아니다.** → Q7

---

## Q4. `new VideoEntity()`가 `VideoService`에서 가능한 이유

**[[02a-entities-in-jpa]]의 인자 없는 생성자가 `protected`이고, `VideoService`가 같은 패키지에 있기 때문이다.**

```java
protected VideoEntity() {          // 같은 패키지의 코드만 부를 수 있다
      this(null, null);
}
```

**흥미로운 점**: 이 생성자는 원래 **JPA가 조회 결과를 만들기 위해** 요구한 것이었다. 그런데 여기서는 **프로브를 만드는 통로**로 재사용된다.

**같은 요구가 두 목적에 쓰인다** — 프레임워크가 빈 객체를 만들어 값을 채우는 것과, 우리가 빈 객체를 만들어 조건을 채우는 것은 **구조가 같다.**

**`protected`의 절충이 여기서도 값을 한다**: `private`였다면 프로브도 못 만들었고, `public`이었다면 어느 패키지에서든 빈 엔티티를 만들 수 있어 위험했을 것이다.

**주의**: 책 예제의 `probe.setTags(...)`는 **이 장의 `VideoEntity`에 없는 필드다.** 이 장의 엔티티는 `id`·`name`·`description` 셋뿐이다. **필드가 더 많은 엔티티를 가정한 설명용 예시**로 읽어야 한다.

---

## Q5. 통합 검색에서 `matchingAll()`을 쓰면

**AND로 묶여서 결과가 거의 항상 0건이 된다.**

통합 검색은 입력 **하나**를 받아 **여러 필드 중 어디에든** 걸리면 보여 주는 것이다.

```
사용자 입력: "spring"
프로브: name="spring", description="spring", tags="spring"   ← 같은 값을 전부에 넣는다

matchingAll()  → where name like '%spring%'
                   AND description like '%spring%'
                   AND tags like '%spring%'      ← 세 필드에 전부 들어 있어야 한다

matchingAny()  → where name like '%spring%'
                   OR  description like '%spring%'
                   OR  tags like '%spring%'      ← 어디든 걸리면 된다
```

**`matchingAll()`은 기본값이므로 그냥 두면 이 실수가 난다.** 그리고 **오류가 아니라 "결과가 없음"으로 나타나므로** 검색이 안 되는 것처럼 보인다.

| | `matchingAll()` (기본) | `matchingAny()` |
|---|---|---|
| 결합 | **AND** | **OR** |
| 쓰는 곳 | 조건을 **좁혀 갈 때** (필터 여러 개) | **통합 검색** (어디든 걸리면) |

---

## Q6. `withIgnoreCase()`가 인덱스에 미치는 영향

**컬럼에 `lower()`를 씌우므로 그 컬럼의 일반 인덱스를 쓸 수 없다.**

```sql
where name like ?             → name 인덱스 사용 가능
where lower(name) like ?      → name 인덱스 무용지물
```

인덱스는 **컬럼의 원래 값**으로 정렬돼 있다. `lower(name)`은 **다른 값**이므로 그 인덱스로 찾을 수 없다. 데이터베이스는 **전체 스캔**으로 내려간다.

**책이 괄호로 덧붙인 경고가 이것이다** — *"(그러니 인덱스를 적절히 조정하라!)"*

**대응**: **함수 기반 인덱스**를 별도로 만든다(`create index on video(lower(name))`). 그러면 `lower(name)`에 대한 인덱스가 생겨 다시 쓸 수 있다.

**주의할 점**: 이 비용은 **데이터가 적을 때 안 보인다.** 개발 환경에서는 대소문자 무시가 공짜처럼 느껴진다. [[04b-limiting-query-results]]의 "예측 불가능성"과 같은 형태의 함정이다.

**그리고 `withStringMatcher(CONTAINING)`도 같은 문제를 만든다** — `like '%값%'`은 앞에 와일드카드가 있어 인덱스를 쓸 수 없다. **두 설정이 겹치면 인덱스는 확실히 못 쓴다.**

---

## Q7. `where name = null`이 0건인 이유 — 삼치 논리

**SQL은 삼치 논리(three-valued logic)를 쓴다.**

```text
  SQL에서 비교의 결과는 세 가지다:  TRUE  /  FALSE  /  UNKNOWN

    where name = 'SPRING'   →  TRUE 또는 FALSE
    where name = null       →  항상 UNKNOWN     ← FALSE 가 아니다
    where null = null       →  UNKNOWN          ← "모르는 값끼리 같은가?"는 모른다

  그리고 WHERE 절은 TRUE 인 행만 남긴다.
  UNKNOWN 은 통과하지 못한다 → 결과 0건
```

**핵심은 `null`이 "값이 없음"이 아니라 "모르는 값"이라는 것이다.** 모르는 값과 무언가를 비교하면 결과도 **모른다**. 그래서 `null = null`조차 TRUE가 아니다.

**그래서 `IS NULL`이라는 별도 문법이 존재한다** — `= null`로는 표현할 수 없기 때문이다.

**QBE는 이 문제를 어떻게 우회하나**: **`null` 필드를 조건 목록에서 아예 제외한다.** `where` 절에 그 컬럼이 등장하지 않으므로 삼치 논리에 걸릴 일이 없다.

> **프레임워크가 대신 해 주는 이 한 가지가 QBE의 실질적 내용이다.**

---

## Q8. QBE가 표현할 수 없는 조건

**두 가지를 들면**:

1. **범위 비교** — `views < 1000`, `createdAt between A and B`. 프로브는 **값 하나를 담을 뿐** "이 값보다 작다"를 담을 방법이 없다.
2. **조인 조건** — 다른 표의 컬럼을 조건으로 쓰는 것. 프로브는 **한 엔티티의 인스턴스**이므로 관계 건너편을 표현할 수 없다.

**그 밖에도**:
- **`OR`와 `AND`를 섞는 것** — `matchingAll()`이나 `matchingAny()` 중 하나만 고를 수 있다. `(A or B) and C`는 불가능하다.
- **부정** — "이름에 X가 **없는**"
- **집계·서브쿼리**

**근본 원인**: 프로브는 **"필드 = 값"의 나열**이다. 그 형태로 표현되지 않는 조건은 담을 수 없다.

**그래서 사다리의 다음 칸이 필요하다** — [[06-writing-custom-jpa-queries]]가 정확히 범위 비교(`LessThan`)와 4-JOIN 예제로 시작한다.

**[[01a-using-spring-data-to-easily-manage-data]]의 사다리에서 QBE의 자리**: *"조건을 런타임에 조립"을 얻고 **"동등·문자열 비교 위주로 제한"**을 잃는다. 이 문항이 그 "잃는 것"의 구체적 내용이다.

---

## 재출제 문항

1. 통합 검색이 항상 0건을 돌려준다. 프로브는 제대로 채워져 있다. 무엇을 의심하는가?
2. 대소문자 무시 검색이 개발에서는 빠른데 운영에서 느리다. 무엇이 원인이고 어떻게 고치는가?
3. "조회수가 1000 미만인 비디오"를 QBE로 찾을 수 있는가? 왜인가?
4. `where name = null`과 `where name is null`의 차이를 설명하라.
5. 프로브를 만들 때 `new VideoEntity()`가 다른 패키지에서는 안 된다. 왜이고, 어떻게 하겠는가?
6. finder 15개를 QBE 하나로 바꿨다. 무엇을 잃었는가?

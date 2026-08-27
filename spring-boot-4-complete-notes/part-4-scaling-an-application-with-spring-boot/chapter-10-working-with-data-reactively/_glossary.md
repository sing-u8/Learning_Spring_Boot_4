# Working with Data Reactively 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## jdbc
Java Database Connectivity의 약자로, 자바 애플리케이션이 관계형 데이터베이스와 통신할 때 사용하는 표준 명세이나 태생적으로 동기/블로킹 방식이다
- 처음 나온 곳: [[01-fetching-data-reactively]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## r2dbc
Reactive Relational Database Connectivity의 약자로, 관계형 데이터베이스에 접근하기 위한 비동기/논블로킹 기반의 새로운 표준 스펙
- 처음 나온 곳: [[02-picking-a-reactive-data-store]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## reactive-crud-repository
스프링 데이터 공통 모듈에서 제공하는 인터페이스로, 모든 CRUD 데이터 작업의 반환형을 블로킹 객체 대신 Mono나 Flux로 제공한다
- 처음 나온 곳: [[03-creating-a-reactive-repository]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## r2dbc-entity-template
원시 SQL 실행, 객체 매핑 삽입/수정 등 데이터베이스 작업을 수월하게 처리하도록 도와주는 리액티브 전용 템플릿 헬퍼 클래스
- 처음 나온 곳: [[04-working-with-r2dbc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## database-client
Spring Framework R2DBC 모듈이 제공하는 코어 기능으로, 드라이버 레벨과 소통하여 네이티브 SQL 구문을 비동기적으로 실행하는 논블로킹 클라이언트
- 처음 나온 곳: [[04-working-with-r2dbc]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## flatmap
리액티브 스트림 내부 콜백 연산의 결과가 또 다른 리액티브 타입(Mono, Flux)일 때, 두꺼워진 껍질을 한 꺼풀 벗겨내어 단일 스트림으로 평탄화(Flattening)해주는 필수 연산자
- 처음 나온 곳: [[05-returning-data-reactively]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

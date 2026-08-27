# Chapter 10 용어집

- **reactive driver**: database I/O를 non-blocking signal로 제공하는 driver. → [[01-what-reactive-data-access-requires]]
- **JDBC**: 본질적으로 blocking인 Java relational database API. → [[01-what-reactive-data-access-requires]]
- **R2DBC**: Reactive Relational Database Connectivity specification. → [[02-choosing-r2dbc-and-a-reactive-data-store]]
- **ReactiveCrudRepository**: Mono/Flux CRUD contract. → [[03-creating-reactive-repositories-and-r2dbc-access]]
- **R2dbcEntityTemplate**: mapped entity 중심 reactive data operation. → [[03-creating-reactive-repositories-and-r2dbc-access]]
- **flatMap**: nested Publisher를 이어 한 sequence로 평탄화하는 operator. → [[04-connecting-reactive-data-to-api-and-templates]]
- **collectList**: Flux를 `Mono<List>`로 materialize하는 operator. → [[04-connecting-reactive-data-to-api-and-templates]]


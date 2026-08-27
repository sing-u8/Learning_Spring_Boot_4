# Releasing An Application with Spring Boot 용어집

> 정의의 유일한 원본. 각 노트의 첫 등장 인라인 풀이와 연결된다.

## uber-jar
실행에 필요한 모든 의존성(톰캣 등)을 포함하여 단독 실행 가능한 거대한 JAR 파일 (Fat JAR라고도 함)
- 처음 나온 곳: [[01-creating-an-uber-jar]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## shaded-jar
기존 서드파티 JAR들의 압축을 풀어 하나로 합치는 방식의 패키징 방법
- 처음 나온 곳: [[01-creating-an-uber-jar]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## paketo-buildpacks
개발자가 Dockerfile을 작성하지 않아도 소스 코드를 분석하여 최적화된 컨테이너 이미지를 생성해주는 오픈소스 프로젝트
- 처음 나온 곳: [[02-baking-a-docker-container]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## docker-tag
로컬 이미지를 특정 레지스트리 저장소 주소와 버전에 맞게 복제하여 이름을 짓는 과정
- 처음 나온 곳: [[03-releasing-application-to-docker-hub]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## docker-compose
여러 개의 Docker 컨테이너로 이루어진 복합 애플리케이션의 설정과 실행 순서를 하나의 YAML 파일로 정의하여 구동하게 해주는 도구
- 처음 나온 곳: [[04-tweaking-application-in-production]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

## orchestration
복수의 컨테이너 자동 배치, 스케일링, 로드 밸런싱, 네트워킹 등을 중앙에서 통합 관리하는 프로세스나 도구
- 처음 나온 곳: [[04-tweaking-application-in-production]]
- 섞이는 말: 해당 노트의 `5. 자주 헷갈리는 것` 참조

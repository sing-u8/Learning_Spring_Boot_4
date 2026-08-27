# Learning Spring Boot 4 학습 노트 저장소 (Deep-Tutor Vault)

> **교재**: *Learning Spring Boot 4: Simplify the development of production-grade applications using Java and Spring (4th Edition)*  
> **저자**: Wanderson Xesquevixos, Ranga Rao Karanam, Magnus Larsson, Greg L. Turnquist  
> **기술 스택**: Spring Boot 4.1.x, Java 25, Spring AI 1.x, Testcontainers 2.x, JUnit 6, OpenTelemetry, OCI Buildpacks  

이 저장소는 교재 원문 분석부터 핵심 개념 구조화까지 학습 과정 전반을 담고 있는 Obsidian 기반의 Deep-Tutor Vault입니다. 
저장소는 목적에 따라 크게 두 개의 메인 디렉토리로 나뉘어 구성되어 있습니다.

---

## 📂 저장소 구조 안내

### 1. [spring-boot-4-pdf-notes](spring-boot-4-pdf-notes/README.md) (PDF 기반 1차 요약 노트)
교재 원본 PDF(총 538쪽)를 읽으며, Part 1~7 및 Chapter 1~15의 목차 흐름을 그대로 따라가며 정리한 1차 학습 노트입니다. 

- **특징**: 기존 정리본을 재사용하지 않고 책의 텍스트와 예제를 바탕으로 내용을 충실히 재구성했습니다.
- **다이어그램**: 학습에 필수적인 표와 아키텍처 흐름도는 주로 Mermaid를 사용해 그렸으며, 복잡한 UI 화면 등 픽셀 정보가 필수적인 경우에만 PDF 이미지를 추출하여 배치했습니다.
- **목적**: 개념을 스스로 인출하기 전, 책의 전체 내용을 빠짐없이 파악하고 뼈대를 세우는 '원론적'인 역할을 합니다.

### 2. [spring-boot-4-complete-notes](spring-boot-4-complete-notes/README.md) (완전 학습 & Deep-Tutor 노트)
1차 노트와 원문을 바탕으로 개념을 촘촘하게 재구성하고 구조화한 개인 완전 학습용(Deep-Tutor) 노트입니다. 

- **규모**: 주제 단위로 세분화된 총 89개의 개념 노트, 15개의 Chapter별 개념 지도(`_map.md`), Chapter별 용어집(`_glossary.md`)으로 구성됩니다.
- **특징**: 책의 단순 번역이나 복사-붙여넣기가 아니라 이해한 내용을 바탕으로 재구성한 설명들로 채워져 있습니다. 
- **활용(Deep-Tutor)**: 
  - 각 노트는 구분자 아래에 `내 설명 시도` 영역이 있어 스스로 설명(Feynman 기법)해보는 인출 연습이 가능하도록 설계되었습니다.
  - 설명이 막히거나 개념 간 연결이 끊긴 부분은 `_global/gaps.md`에 기록하여 추후 약점을 보완합니다.

---

## 🛠️ 학습 및 활용 가이드

본 저장소는 마크다운 기반의 노트 앱(예: Obsidian) 환경에 최적화되어 있습니다.

1. **내용 파악**: 처음 접하는 개념은 `spring-boot-4-pdf-notes` 폴더의 노트들을 순서대로 읽으며 책의 전반적인 의도와 흐름을 파악합니다.
2. **구조적 인출 및 설명**: 어느 정도 내용이 숙지되면 `spring-boot-4-complete-notes` 폴더로 넘어갑니다. 각 장의 `_map.md`를 통해 큰 그림을 파악하고, 각 주제 노트를 열어 '내 설명 시도' 부분에 스스로 자신의 언어로 학습한 내용을 설명해 봅니다.
3. **약점 추적 및 보완**: 설명이 막히는 부분은 즉각적으로 `gaps.md`에 메모해 두고, 집중 반복 학습을 진행합니다.


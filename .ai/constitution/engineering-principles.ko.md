> 이 문서는 [`engineering-principles.md`](engineering-principles.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Engineering Principles

이 문서는 기술 선택이나 개별 기능보다 오래 지속되어야 할 engineering 원칙을 정의합니다.

## 변경 전 증거 확인 (Evidence before change)

먼저 기존 문서와 구현을 조사하세요. 가정보다 repository 증거를 우선하고, 검증되지 않은 구조를 전제로 변경을 제안하지 마세요.

## 최소한의 일관된 변경 (Minimal, coherent change)

요구사항을 충족하는 가장 작고 일관된 변경을 선호하세요. 추측성 abstraction, 기능, 자동화를 추가하지 마세요.

## 명시적 아키텍처 (Explicit architecture)

아키텍처 경계나 convention을 조용히 바꾸지 마세요. 장기적 영향이 있거나 되돌리기 어려운 결정을 드러내고, 구현 전이나 구현과 함께 ADR에 기록하세요.

## 검증 가능한 결과 (Verifiable outcomes)

검증 가능한 결과를 만드세요. 자동화된 검사가 있으면 실행하고, 없다면 검증 방법과 그 한계를 명시하세요. 판단이 필요한 guidance와 코드/테스트/linter/CI로 강제되어야 할 규칙을 구분하세요.

green한 자동화된 검사는 코드에 대한 증거일 뿐, 실행 중인 시스템에 대한 증거가 아닙니다. 변경이 실제 인프라(데이터베이스, 메시지 브로커, 배포된 환경, 다른 서비스)에서 동작해야 한다면, 그 자리에서 직접 확인하세요 — 실제 요청, 실제 로그 라인, 실제로 변경되는 것이 관찰된 값. 테스트 통과와 성공적인 배포 단계는 필요조건이지 충분조건이 아닙니다: adopting project들에서 발생한 여러 실제 결함(배포된 환경에서만 잘못됐던 환경변수, 어떤 테스트도 호출하지 않은 endpoint에서만 도달 가능했던 lazy-loading 버그, 내부적으로는 일관됐지만 실제와 맞지 않는 값을 만든 broadcast 로직)은 오직 이런 직접 검증 방식으로만 발견됐고, 자동화된 방법으로는 발견되지 않았습니다.

## Agent-agnostic core

Product 의도, 아키텍처, 결정, engineering 원칙을 특정 agent 전용 instruction 파일에 묶지 마세요. agent adapter는 자신의 agent를 공유 소스로 라우팅하는 데 필요한 차이만 포함할 수 있습니다.

## 분리된 경계 (Separated boundaries)

향후 구현은 domain 관심사를 외부 시스템 및 tool integration과 분리해야 합니다. 각 adopting project는 자신의 구체적인 기술 경계를 architecture 문서와 ADR에 정의해야 합니다.

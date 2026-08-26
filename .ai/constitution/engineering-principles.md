# Engineering Principles

이 문서는 기술 스택과 개별 기능보다 오래 유지되는 engineering 원칙을 정의한다.

## Evidence before change

기존 문서와 구현을 먼저 확인한다. 추측보다 repository evidence를 우선하며, 확인하지 않은 구조를 전제로 변경하지 않는다.

## Minimal, coherent change

요구사항을 충족하는 가장 작은 일관된 변경을 우선한다. 요청되지 않은 추상화, 기능, 자동화를 미리 추가하지 않는다.

## Explicit architecture

아키텍처 경계와 관례를 조용히 바꾸지 않는다. 오래 영향을 주거나 되돌리기 어려운 결정은 구현 전에 드러내고 ADR로 기록한다.

## Verifiable outcomes

검증 가능한 결과를 만든다. 자동 검증이 존재하면 실행하고, 아직 없다면 검증 방법과 한계를 명시한다. 사람이나 agent에게 지시할 규칙과 코드·테스트·lint·CI로 강제할 규칙을 구분한다.

## Agent-agnostic core

제품 의도, 아키텍처, 결정, 개발 원칙은 특정 agent의 지침 파일에 종속시키지 않는다. Agent adapter는 공통 원본을 연결하는 데 필요한 차이만 가진다.

## Separated boundaries

향후 구현에서는 domain concern과 외부 시스템·도구 통합을 분리한다. 구체적인 기술 경계는 해당 프로젝트의 architecture 문서와 ADR에서 결정한다.

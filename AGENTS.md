# Codex Project Adapter

이 파일은 Codex 계열 agent의 저장소 진입점이다. 프로젝트 정책이나 설계를 이 파일에 복제하지 않는다. 공통 source of truth는 아래 문서다.

## Context bootstrap

작업을 시작하기 전에 다음 순서로 읽는다.

1. `PROJECT.yaml`
2. `.ai/constitution/`의 모든 문서
3. `docs/product/`의 모든 문서
4. `docs/architecture/`의 모든 문서
5. 현재 작업과 관련된 `docs/decisions/`의 ADR
6. `docs/status/current-state.md`
7. 현재 요청과 관련된 저장소 파일

문서 간 충돌이 있으면 구체적인 accepted ADR을 우선하고, 해결되지 않으면 임의로 구현하지 말고 충돌을 보고한다.

## Working contract

- 저장소 근거를 확인한 뒤 계획하고 변경한다.
- 요청 범위를 만족하는 최소 변경을 우선한다.
- 아키텍처 변경을 암묵적으로 수행하지 않는다. 중요한 결정은 ADR로 남긴다.
- 완료를 주장하기 전에 가능한 검증을 수행하고 결과와 미검증 항목을 구분한다.
- 지속되어야 할 결정과 상태 변화는 같은 변경에서 해당 source of truth에 반영한다.
- 대화 기록과 이 파일을 장기 설계 원본으로 사용하지 않는다.

현재 phase와 다음 작업은 항상 `docs/status/current-state.md`에서 확인한다.

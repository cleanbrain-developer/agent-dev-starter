# Agent Context Model

## Context classes

### Permanent context

프로젝트 목적, 범위, architecture, engineering 원칙, accepted decisions처럼 세션을 넘어 유지되는 정보다. `PROJECT.yaml`, `.ai/constitution/`, product·architecture 문서와 ADR에 저장한다.

### Working context

현재 phase, 최근 완료 사항, 다음 작업, 열린 결정처럼 진행에 따라 바뀌는 정보다. `docs/status/current-state.md`에 저장한다.

### Task context

현재 사용자 요청, 관련 코드, 임시 조사 결과다. 필요할 때만 로드하며, 장기 가치가 생기면 적절한 permanent 또는 working source에 반영한다.

## Bootstrap order

1. Agent adapter에서 시작한다.
2. `PROJECT.yaml`로 identity와 phase를 확인한다.
3. constitution을 읽어 행동 경계를 확인한다.
4. product 문서로 목적과 범위를 확인한다.
5. architecture 문서로 구조와 책임을 확인한다.
6. 현재 작업과 관련된 accepted ADR을 확인한다.
7. `current-state.md`로 현재 위치와 다음 작업을 복원한다.
8. 요청과 관련된 repository evidence를 탐색한다.
9. 계획, 변경, 검증, 검토를 수행한다.
10. 지속해야 할 결정이나 상태 변화를 repository에 반영한다.

## Conflict handling

- 사용자 요청은 작업 목표를 정하지만 accepted architecture를 모르게 폐기하지 않는다.
- 구체적인 accepted ADR은 일반 architecture 설명보다 우선한다.
- 현재 상태는 원칙이나 설계를 재정의하지 않는다.
- Adapter 간 표현 차이는 공통 source of truth를 변경하지 않는다.
- 해결되지 않는 충돌은 추측으로 숨기지 않고 보고한다.

## Bootstrap acceptance test

깨끗한 새 세션에서 외부 링크 없이 entry adapter만 제공한다. Agent가 product, principles, architecture, phase, next work를 repository 경로와 함께 설명하면 context recovery가 성공한 것이다.

> 이 문서는 [`agent-context-model.md`](agent-context-model.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Agent Context Model

## Context 분류

### Permanent context

세션을 넘어 지속되는 정보로, project 목적, scope, architecture, engineering 원칙, accepted decision을 포함합니다. `PROJECT.yaml`, `.ai/constitution/`, product/architecture 문서, ADR에 저장하세요.

### Working context

진행상황에 따라 바뀌는 정보로, 현재 phase, 최근 완료된 작업, 다음 작업, open decision을 포함합니다. `docs/status/current-state.md`에 저장하세요.

프로젝트가 per-feature design 문서(예: `specs/<feature>/` convention)도 유지한다면, 그 각각의 status marker도 working context입니다 — 일회성 산출물이 아닙니다: 그것이 설명하는 기능의 상태가 바뀔 때(구현됨, 배포됨, superseded됨) 그 즉시, `current-state.md`와 같은 규율로 갱신되어야 합니다. 기능이 배포된 후에도 여전히 "not yet implemented"라고 되어 있는 design 문서는 역사적 기록이 아니라 stale한 working-context 소스입니다 — 이런 걸 발견하면 stale한 `current-state.md`와 마찬가지로 고쳐야 할 결함으로 취급하세요.

여러 병렬 sibling entity에 대해 같은 반복 절차를 기록하는 상태 문서가 있을 때(예를 들어, 공유 문서 안에 서비스별 섹션이 각각 어떤 설정 단계가 완료됐는지 기록하는 경우), 한 sibling에 대해 그 단계를 침묵하는 건 중립적이지 않습니다: 읽는 사람은 완료로 기록된 sibling들과 동일하다고 추론하지, "아직 안 됐다"고 추론하지 않습니다. 실제 adoption에서 정확히 이런 일이 있었습니다 — 다섯 개 sibling entry 중 두 개에 필수 설정 단계에 대한 기록이 전혀 없었는데, 이게 "이미 기록된 세 개와 같다"고 읽혔고, 실제로 거기에 의존하려던 시도가 실패하고 나서야 실제 시스템을 직접 조사해서 그 단계가 둘 중 어느 쪽에서도 수행된 적이 없다는 게 드러났습니다. 반복되는 단계의 상태는 모든 sibling entry에 대해 명시적으로(완료, 미완료, 해당 없음) 기술하세요, 우연히 사실이었던 항목만이 아니라 — 기록이 없는 것은 유추로 완료했다고 볼 증거가 아니라 표시해야 할 gap입니다.

### Task context

현재 사용자 요청, 관련 코드, 임시 조사 결과. 필요할 때만 로드하세요. durable한 가치를 갖게 되면 적절한 permanent 또는 working 소스에 반영하세요.

## Bootstrap 순서

1. 관련 agent adapter에서 시작한다.
2. `PROJECT.yaml`을 읽어 project와 phase를 식별한다.
3. constitution을 읽어 행동 경계를 이해한다.
4. product 문서를 읽어 목적과 scope를 이해한다.
5. architecture 문서를 읽어 구조와 책임을 이해한다.
6. 현재 작업과 관련된 accepted ADR을 읽는다.
7. 반복 가능한 운영 절차를 위해 `docs/guides/` 아래 관련 문서를 읽는다.
8. `current-state.md`를 읽어 현재 위치와 다음 작업을 복원한다.
9. 요청과 관련된 repository 증거를 조사한다.
10. 계획하고, 변경하고, 검증하고, 리뷰한다.
11. durable한 결정과 working-state 변경을 repository에 반영한다.

## 충돌 처리(Conflict handling)

- 사용자 요청은 작업 목표를 정의하지만, accepted architecture를 조용히 폐기하지 않는다.
- 구체적인 accepted ADR이 일반적인 architecture 설명보다 우선한다.
- current state는 원칙이나 design을 재정의하지 않는다.
- adapter 간 차이가 공유 source of truth를 바꾸지 않는다.
- 해결되지 않은 충돌은 가정 뒤에 숨기지 말고 보고한다.

## Bootstrap acceptance test

clean session에서 entry adapter만 제공하고 외부 링크는 주지 마세요. agent가 repository 문서로 뒷받침되는 방식으로 `docs/product/goals.md`("Success criteria")의 다섯 가지 acceptance question에 답할 수 있으면 context recovery가 성공한 것입니다.

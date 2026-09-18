> 이 문서는 [`ADR-0008-adapter-compatibility-verification.md`](ADR-0008-adapter-compatibility-verification.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0008: 새 지원 agent에 대한 adapter 호환성 검증하기

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`docs/status/current-state.md`는 지원 agent가 Codex와 Claude Code를 넘어 확장될 때 adapter 호환성을 어떻게 검증할지에 대한 open decision을 가지고 있었습니다. 4번의 실제 adoption 어디에서도 세 번째 agent가 추가된 적이 없어서, 이건 한 번도 실제로 실행되지 않았지만, 답 없이 열려있는 상태로 남아있었습니다.

## Decision

`supported_agents.initial`에(ADS 자신이든 어떤 adopted project든) 새 agent를 추가하는 건, 그 새 agent 자신의 entry adapter에서 시작하는 bootstrap acceptance test(`agent-context-model.md`, "Bootstrap acceptance test")가 통과해야 완료된 것으로 간주됩니다 — Codex와 Claude Code에 대해 이미 `using-the-starter.md`의 "Run the bootstrap acceptance test"에서 요구되는 것과 같은 방식입니다. agent별 test variant는 필요 없습니다: test 자체(`docs/product/goals.md`의 "Success criteria"에 있는 다섯 가지 acceptance question에 repository 경로로 뒷받침해서 답하는 것)는 이미 design상 agent-agnostic합니다(`agent-agnostic-core` 원칙) — 새로 필요한 작업은 오직 그 agent의 얇은 entry adapter를 작성하고 기존 test를 그걸 통해 실행하는 것뿐입니다.

## Consequences

### Positive

- 새로운 검증 메커니즘을 설계하거나 유지보수할 필요가 없습니다; 두 agent와 4번의 실제 adoption에 걸쳐 이미 증명된 test를 재사용합니다.
- `agent-agnostic-core` 원칙을 구체적으로 유지합니다: 새 adapter로 같은 test가 통과하지 못한다면, 그 adapter가 충분히 얇지 않거나 routing step이 빠진 것이며, 이건 정확히 이 test가 이미 잡아내도록 설계된 것입니다.

### Costs and risks

- 만약 미래의 agent tooling이 구조적으로 다른 bootstrap 필요성을 가진다면(예를 들어 하나의 entry 파일을 먼저 읽는 것과 동등한 개념이 없다면), 이 답이 매끄럽게 옮겨지지 않을 수 있고 그때 새 ADR로 재검토가 필요할 것입니다.

## Alternatives considered

### agent별 별도의 호환성 checklist

기각되었습니다: bootstrap acceptance test가 이미 검증하는 걸 중복하게 되고, 시간이 지나면서 거기서 표류할 것입니다 — `ADR-0001`의 핵심 결정이 이미 반대하는 것과 같은 중복입니다.

> 이 문서는 [`ADR-0007-first-deterministic-check.md`](ADR-0007-first-deterministic-check.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0007: deterministic check로 승격된 첫 번째 문서화 규칙

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`architecture/overview.md`의 "Enforcement boundary"는 항상 절대 위반되면 안 되는 규칙은 언젠가 deterministic gate로 승격되어야 한다고 말했지만, 후보나 순서를 정하지 않았습니다. `docs/status/current-state.md`는 이걸 open decision으로 가지고 있었습니다. 대부분의 ADS 규칙은 판단이 필요합니다(변경이 "minimal하고 coherent"한지, 원칙을 "진심으로" 따르는지) 그리고 기계적으로 검사하기 어렵습니다. `ADR-0005`의 한국어 companion cascade 규칙은 예외입니다: "모든 `.md` 파일에 대해 `.ko.md`가 존재하는가"는 완전히 기계적이고, 판단이 전혀 필요 없으며, 이미 4번의 실제 adoption 분량의 파일로 검사해볼 수 있습니다.

## Decision

`ADR-0005`의 `.ko.md` companion 완전성 규칙이, 다른 어떤 후보보다 먼저 deterministic check로 승격되는 첫 번째 규칙입니다. `scripts/check-ko-companions.sh` 스크립트가 이 repository에 추가됩니다: 모든 `.md` 파일(`.ko.md` 파일 자신과 `PROJECT.yaml` 같은 비-Markdown 파일 제외)에 대해, `.ko.md` companion이 없는지 보고하고, 별도로 companion의 파일 수정 시각이 영어 원본보다 오래된 경우 *possibly* stale로 표시합니다(증명이 아니라 heuristic입니다 — 건드렸지만 의미는 안 바뀐 파일은 false positive가 되고, 이 스크립트는 companion이 실제로 어긋났는지 판단하려 하지 않습니다).

이 스크립트는 CI에 연결되어 있지 않고 `using-the-starter.md`의 필수 step도 아닙니다. ADS-adopted project 어디서든 maintainer(사람이든 agent든)가 손으로 실행할 수 있게 제공됩니다. 이걸 자동으로 실행하는 CI pipeline을 추가하는 건 여전히 out of scope입니다(`docs/product/scope.md`) — 실제 adoption이 수동 실행으로 충분하지 않다는 걸 보여주기 전까지는요. 이 결정은 "어떤 규칙이 먼저인가"에만 답하는 것이고, "지금 pipeline을 만들자"가 아닙니다.

## Consequences

### Positive

- "어떤 규칙이 먼저인가"라는 질문에, 이미 가장 쉽고 증거로 뒷받침된 후보로 답해서 무기한 열어두지 않습니다.
- CI infra에 대한 커밋 없이, 지금 당장 maintainer에게 실제로 쓸 수 있는 도구를 줍니다.

### Costs and risks

- mtime 비교라는 staleness heuristic은 약합니다: `git clone`(mtime을 리셋함)을 견디지 못하고, 서식만 바꾼 touch와 실제 의미 변경을 구분하지 못합니다. "possibly stale" 출력은 판정이 아니라 "봐야 한다"는 신호로 취급하세요.
- 이 스크립트 자체도 repository의 파일 구조가 바뀌면서 계속 올바르게 유지되어야 합니다 — 작지만 받아들인 유지보수 대상입니다.

## Alternatives considered

### 지금 CI workflow에 이 check를 연결하기

기각되었습니다: 어떤 adopted project도 아직 `.ko.md`가 자동화된 강제가 필요할 만큼 심하게 표류한 적이 없습니다. 이건 `ADR-0002`가 다른 문제에 대해 이미 기각한 것과 정확히 같은 종류의 추측성 자동화입니다.

### 판단이 필요한 규칙을 대신 승격하기(예: "single responsibility")

기각되었습니다: 의미에 대한 판단이 필요한 규칙은 deterministic enforcement의 좋은 첫 후보가 아닙니다 — 사람이나 agent의 이해가 필요하고, 지금 강제로 기계화하면 거짓 확신을 만들 뿐입니다.

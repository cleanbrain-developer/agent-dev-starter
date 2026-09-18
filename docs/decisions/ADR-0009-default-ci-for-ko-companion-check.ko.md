> 이 문서는 [`ADR-0009-default-ci-for-ko-companion-check.md`](ADR-0009-default-ci-for-ko-companion-check.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0009: `.ko.md` check를 adopting project 자신의 CI에 기본으로 연결하기

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`ADR-0007`은 `.ko.md` 완전성 check가 수동 스크립트로 남고, 실제 adoption이 수동 실행으로 충분하지 않다는 걸 보여줄 때까지 CI에 연결하지 않기로 결정했습니다. 그런 실패는 아직 일어나지 않았습니다. 대신 maintainer가 직접적인 선호를 표현했습니다: 이 Starter를 채택하고 이미 자기 CI pipeline을 돌리는 project는 순전히 opt-in으로 남기지 않고 이 check를 자동으로 가져가야 한다는 것입니다. 이건 실패가 아니라 선호에 의해 움직이는 결정입니다 — `ADR-0004`/`ADR-0005`에서 이미 쓴 것과 같은 근거입니다.

이미 CI pipeline을 가진 현재 채택된 세 프로젝트(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`) 전부가 매 push마다, build/deploy 전에 `test` job을 돌립니다. 이 중 어느 것도 스크립트의 mtime 기반 staleness heuristic이 의미 있어질 만한 스케줄로 fresh checkout을 하지 않습니다 — `git checkout`은 모든 파일에 거의 같은 mtime을 주기 때문에, CI에서 영어 vs `.ko.md`의 mtime을 비교하는 건 신호가 아니라 잡음입니다.

## Decision

이미 CI pipeline을 가진 모든 ADS-adopted project는 기존 `test` job 초반(checkout 직후, 언어별 step 전)에 `scripts/check-ko-companions.sh --missing-only`를 실행하는 step을 추가하고, exit code가 0이 아니면(companion 누락) 이걸 warning이 아니라 실제 CI 실패로 취급합니다. CI pipeline이 전혀 없는 project는 영향받지 않습니다 — 이게 없는 곳에 CI를 새로 추가하라는 요구는 아니며, ADS 자신에게도 적용되지 않습니다(ADS는 CI가 없음). CI에서 `--missing-only` flag가 필요한 이유는 정확히, staleness heuristic이 fresh checkout을 견디지 못하기 때문입니다 — 거기서는 missing-companion check만 신뢰할 수 있습니다.

이건 이미 pipeline을 가진 project에 대해 `ADR-0007`의 "CI에 연결하지 않는다"는 입장을 수정하는 것입니다; 이것만을 위해 처음부터 CI를 만들지 않는다는 `ADR-0007`의 논리는 그대로입니다.

## Consequences

### Positive

- 누락된 `.ko.md` companion이 매 push마다 자동으로 잡힙니다, maintainer나 agent가 `agent-behavior.md`의 "Before completion" 리뷰 중 알아차리는 것에 의존하지 않고.
- 이미 pipeline이 있는 project에는 새 CI infra가 필요 없습니다 — 기존 것을 재사용해서 step 하나만 추가합니다.

### Costs and risks

- `.ko.md` companion 없이 Markdown 문서를 추가하거나 이름을 바꾸는 모든 push는 이제 완전히 무관한 작업 중이라도 CI를 실패시킵니다 — 이건 "mandatory"의 의도된 효과이지 버그가 아닙니다.
- Project는 다른 채택된 foundation 파일과 함께 `scripts/check-ko-companions.sh`(또는 그에 준하는 것)도 복사해야 하는데, 이건 이전에 `using-the-starter.md`의 "Files to adopt"에 없던 것입니다.

## Alternatives considered

### `ADR-0007`이 원래 정한 대로 수동만 유지하기

기각되었습니다: 수동 실행이 실제로 실패했는지와 무관하게, maintainer가 기본 CI 채택을 명시적으로 선호한다고 밝혀서 이를 superseed합니다.

### CI에서 실패가 아니라 non-blocking warning으로 만들기

기각되었습니다: 아무도 조치할 필요 없는 warning은 무시되는 경향이 있고, 이건 "수동이라 잊기 쉬움"에서 "자동"으로 옮기려던 원래 목적을 무력화합니다.

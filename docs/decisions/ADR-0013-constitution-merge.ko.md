> 이 문서는 [`ADR-0013-constitution-merge.md`](ADR-0013-constitution-merge.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0013: `.ai/constitution/engineering-principles.md`와 `agent-behavior.md` 병합

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

ADS V2는 GitHub Spec Kit을 채택하며, Spec Kit은 정확히 `.ai/constitution/engineering-principles.md`가 이미 하던 역할(spec, plan, 구현이 평가되는 기준이 되는 durable한 원칙)을 위한 `.specify/memory/constitution.md`를 소유합니다. 별개로, `ADR-0011`은 `AGENTS.md`를 유일한 adapter로 만들고 행동 지침을 직접 흡수하게 하는데, 이건 `.ai/constitution/agent-behavior.md`가 담고 있던 것입니다. Spec Kit과 `AGENTS.md`-only 모델을 채택한 뒤에도 옛 파일들을 계속 유지하면, 같은 책임 두 개가 각각 두 곳에 존재하게 됩니다 — 이건 정확히 `documentation-policy.md`의 "Single responsibility" 규칙이 이미 금지하는 중복입니다.

## Decision

- `.ai/constitution/engineering-principles.md`의 content는 `.specify/memory/constitution.md`(GitHub Spec Kit 자신의 constitution 역할)로 병합되고 옛 파일은 제거됩니다. `ADR-0006` 시절 규칙에 따라 `PROJECT.yaml`의 `principles`에 섞여 있던 project별 원칙은 이제 `.specify/memory/constitution.md`에 prose 정의를 갖습니다.
- `.ai/constitution/agent-behavior.md`의 content는 `AGENTS.md`로 직접 병합되고 옛 파일은 제거됩니다.
- `.ai/constitution/documentation-policy.md`는 영향받지 않습니다 — 문서 소유권이나 `.ko.md` 언어 정책은 어떤 열린 표준도 소유하지 않으므로, 정확히 지금 있는 곳에 그대로 남습니다.

## Consequences

### Positive

- 각 책임(durable한 원칙, agent 행동 계약, 문서 정책)이 정확히 하나의 집을 가지고, 그중 두 곳은 ADS가 지어낸 경로가 아니라 오픈소스 tool이나 새 agent가 이미 찾아볼 줄 아는 표준 위치입니다.

### Costs and risks

- 이미 채택된 모든 project는 자신의 V2 migration 중에 이 병합을 수행해야 합니다 — 이건 의도적으로 V1 파일 구조와 하위호환되지 않습니다(`docs/status/current-state.md`의 V2 migration 기록 참고).

## Alternatives considered

### 옛 파일을 새 위치를 가리키는 얇은 pointer로 유지하기

기각되었습니다: 이득 없이 간접 layer를 추가합니다 — agent의 bootstrap 순서는 중간 hop 없이 `.specify/memory/constitution.md`와 `AGENTS.md`를 바로 가리킬 수 있습니다.

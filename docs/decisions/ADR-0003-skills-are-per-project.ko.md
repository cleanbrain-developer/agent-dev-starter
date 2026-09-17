> 이 문서는 [`ADR-0003-skills-are-per-project.md`](ADR-0003-skills-are-per-project.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0003: Skills Are Per-Project, Not a Shared ADS Concept

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

`.ai/skills/`와 "reusable workflow skill"은 `docs/product/goals.md`의 장기 로드맵에 있었고, `docs/status/current-state.md`는 공유 skill의 canonical 위치와 이를 Claude Code/Codex discovery 경로에 어떻게 배포할지에 대한 open decision을 가지고 있었습니다. 지금까지의 세 번의 실제 adoption — `cleanbrain-me-entrance`(랜딩 페이지), `cleanbrain-me-developer`(포트폴리오와 live monitoring 대시보드), `relayhub-java`(이벤트 통합 플랫폼) — 은 목적이 서로 완전히 달라서 공통된 재사용 가능한 workflow가 나타나지 않았습니다. 지금 공유 skill을 정의하면 너무 일반적이라 가치가 없거나, 하나의 project workflow에 맞춰져서 그것을 위해 design되지 않은 서비스에 강제로 적용되는 skill이 될 것입니다.

## Decision

Skill은 공유 ADS concept이 아닙니다. ADS는 adopting project 사이에서 skill 라이브러리를 정의하거나, 호스팅하거나, 동기화하지 않습니다. 각 adopting project는 필요할 때 자신만의 `.ai/skills/`(또는 그에 준하는 것)를 정의할 수 있으며, agent가 그 project의 maintainer에게 어떤 반복 workflow를 상세화해야 하는지 직접 물어서 채웁니다. Agent는 skill의 내용을 스스로 발명해서는 안 되고, maintainer의 명시적 지시 없이 한 adopted project의 skill을 다른 project로 복사해서도 안 됩니다 — 두 project에서 재사용 가능해 보이는 skill은 ADS의 공유 core로 조용히 일반화할 대상이 아니라, maintainer에게 알릴 근거입니다.

## Consequences

### Positive

- 실제 사용 증거가 없는 공유 abstraction을 피합니다 — `evidence-before-change`와 "minimal, coherent change" 원칙과 일치합니다.
- 각 project의 skill이 가상의 공통 사례에 맞춰지지 않고, 그 project의 maintainer가 실제로 일하는 방식에 정직하게 특화되어 있도록 유지합니다.

### Costs and risks

- 나중에 여러 adopted project에 걸쳐 진짜 공통된 workflow가 나타나면, 그것을 ADS의 공유 core로 승격하려면 그 시점에 자체 ADR이 필요합니다 — 이 결정이 그것을 막지는 않습니다.
- 모든 adopting project는 skill을 원한다면 처음부터 자신만의 skill을 정의하는 비용을 치러야 하며, 공유되는 출발점은 없습니다.

## Alternatives considered

### ADS에서 배포하는 공유 `.ai/skills/` 라이브러리

기각되었습니다: 지금까지 어떤 실제 adoption도 재사용 가능한 skill을 만들어내지 못했습니다. 지금 하나를 정의하는 것은 maintainer의 실제 workflow 없이 content를 발명하는 것이며, 이는 adoption guide가 product와 architecture content에 대해 이미 금지하고 있는 것입니다.

> 이 문서는 [`ADR-0002-reference-only-distribution.md`](ADR-0002-reference-only-distribution.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0002: Reference-Only Distribution (No Template Repository or CLI)

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

ADR-0001은 CLI-first 구현을 미뤘고, `docs/status/current-state.md`는 GitHub template repository가 주요 V2 배포 방식이 될지에 대한 open decision을 실제 adoption 증거가 나올 때까지 남겨두었습니다. 이후 Agent Development Starter는 `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java` 세 번 실제로 채택되었고, `docs/guides/using-the-starter.md`의 수동 agent-driven 절차를 사용했습니다. 매번 반복된 작업은 project별 content(`PROJECT.yaml`의 identity와 purpose, `docs/product/`, `docs/architecture/`, 그리고 각 project가 자신의 `.ai/constitution/engineering-principles.md`에 추가한 내용)를 작성하는 것이었지, 몇 분 만에 tooling 없이 끝난 foundation 파일 복사가 아니었습니다.

## Decision

Agent Development Starter는 영구적으로 수동으로 참조되는 스펙으로 남습니다 — V1 phase에 한정되지 않습니다. copy-and-adapt 방식의 template repository와 CLI/initializer는 미뤄진 게 아니라 폐기됩니다: 세 번의 실제 adoption에서 파일 복사는 병목이 아니었으므로, 이를 최적화하는 도구는 의미가 없습니다. Adoption은 `docs/guides/using-the-starter.md`를 통해 계속되며, 사람이 직접 수행하거나 agent가 maintainer의 자연어 project 설명으로부터 대화형으로 수행합니다.

## Consequences

### Positive

- 실제로 관찰된 마찰을 해결하지 못할 배포 tooling에 투자하지 않는다.
- 스펙 자체를 진화시키기 위해 generator를 동기화할 필요 없이, 수동으로 검토하고 project별로 분기하기 쉬운 상태를 유지한다.

### Costs and risks

- 매 adoption마다 여전히 고정된 파일 집합을 수동으로 복사해야 한다 — 이건 작고 받아들여진 비용으로 남는다.
- 만약 향후 adoption에서 복사(content adaptation이 아니라)가 실제 병목이 된다면, 이 ADR을 superseed하는 새 ADR로 재검토해야 한다.

## Alternatives considered

### GitHub template repository

파일 복사 단계를 클릭 몇 번으로 줄여줄 것입니다. 기각되었습니다: 세 번의 실제 adoption에서 복사는 관찰된 병목이 아니었고, 실제 비용은 product/architecture content 작성이었으며 template은 이를 줄이지 못합니다.

### CLI/initializer

복사와 일부 scaffolding을 자동화할 것입니다. 같은 이유로 기각되었고, 스펙의 실제 content(product, architecture, 원칙)는 본질적으로 project별이라 content를 발명하지 않고는 기계적으로 생성할 수 없습니다 — 이건 adoption guide가 이미 금지하는 것입니다.

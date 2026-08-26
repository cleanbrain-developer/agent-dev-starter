# ADR-0001: Repository-First Context

- Status: Accepted
- Date: 2026-08-26
- Deciders: Project maintainers

## Context

AI coding workflow가 긴 initialization prompt와 이전 대화에 의존하면 세션 또는 agent가 바뀔 때 프로젝트 의도, 설계 근거, 현재 진행 상태가 손실된다. Agent별 지침 파일에 모든 내용을 복제하면 문서가 쉽게 불일치하고 특정 도구에 core knowledge가 종속된다.

프로젝트는 자유로운 task prompt를 허용하면서도 결과가 공통 engineering 원칙과 architecture를 따르도록 해야 한다. 최초 bootstrap에 사용한 외부 대화는 영구적으로 접근 가능하다고 가정할 수 없다.

## Decision

Repository를 persistent project context의 authoritative source로 사용한다.

- 프로젝트 identity는 `PROJECT.yaml`에 정형화한다.
- 장기 원칙은 `.ai/constitution/`에 둔다.
- 제품과 architecture 설명은 `docs/`에 둔다.
- 중요한 결정과 근거는 ADR에 둔다.
- 진행 중인 상태는 `docs/status/current-state.md`에 둔다.
- `AGENTS.md`와 `CLAUDE.md`는 이 공통 core를 로드하는 얇은 agent-specific adapter로 유지한다.
- 외부 대화와 bootstrap prompt는 repository에 결정이 반영된 뒤 장기 의존성에서 제거한다.

## Consequences

### Positive

- 새 세션과 다른 agent가 이전 대화 없이 작업을 이어갈 수 있다.
- 공통 정책을 한 곳에서 유지하여 adapter drift를 줄인다.
- 결정, 현재 상태, task prompt의 수명과 책임이 분리된다.
- 향후 template, CLI, skill, quality gate가 안정된 specification을 기반으로 발전할 수 있다.

### Costs and risks

- 코드와 문서 상태를 함께 유지해야 한다.
- Bootstrap 순서를 따르지 않는 agent는 중요한 context를 놓칠 수 있다.
- Markdown 규칙만으로는 준수를 보장할 수 없으므로 향후 deterministic gate가 필요하다.
- `PROJECT.yaml` schema와 adapter 배포 방식은 추가 결정이 필요하다.

## Alternatives considered

### Large reusable initialization prompt

시작은 단순하지만 prompt가 비대해지고 대화와 도구에 의존하므로 채택하지 않았다.

### Agent-specific documents as independent sources

도구별 최적화는 쉽지만 정책 중복과 drift가 발생하므로 채택하지 않았다.

### CLI-first implementation

자동화할 specification이 아직 안정되지 않았으므로 V1에서는 보류했다.

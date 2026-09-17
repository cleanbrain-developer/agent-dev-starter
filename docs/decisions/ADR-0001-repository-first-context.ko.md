> 이 문서는 [`ADR-0001-repository-first-context.md`](ADR-0001-repository-first-context.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0001: Repository-First Context

- Status: Accepted
- Date: 2026-08-26
- Deciders: Project maintainer

## Context

AI 코딩 workflow가 큰 초기화 prompt와 이전 대화에 의존하면, session이나 agent가 바뀔 때 project 의도, design 근거, working state가 사라집니다. 모든 context를 agent별 instruction 파일에 중복하면 drift가 생기고 core 지식이 특정 tool에 묶입니다.

Project는 간결하고 유연한 task prompt를 허용하면서도, 결과가 공유된 engineering 원칙과 architecture를 따르도록 보장해야 합니다. 초기 bootstrap에 사용된 외부 대화가 계속 사용 가능하리라고 가정할 수 없습니다.

## Decision

Repository를 durable한 project context의 authoritative 소스로 사용합니다.

- Project identity는 `PROJECT.yaml`에 구조화한다.
- Durable한 원칙은 `.ai/constitution/`에 저장한다.
- Product와 architecture 설명은 `docs/` 아래 저장한다.
- 중요한 결정과 근거는 ADR에 저장한다.
- Working state는 `docs/status/current-state.md`에 저장한다.
- `AGENTS.md`와 `CLAUDE.md`는 공유 core를 로드하는 얇은 agent별 adapter로 유지한다.
- 외부 대화와 bootstrap prompt는 그 결정이 repository에 반영된 후에는 장기 의존 대상에서 제외한다.

## Consequences

### Positive

- 새 session과 다른 agent가 이전 대화 없이 작업을 이어갈 수 있다.
- 공유 정책이 하나의 소스만 가져서 adapter drift가 줄어든다.
- 결정, working state, task prompt가 각자 다른 lifetime과 책임을 가진다.
- 미래의 template, CLI, skill, quality gate가 안정된 스펙으로부터 발전할 수 있다.

### Costs and risks

- 코드와 문서를 함께 유지보수해야 한다.
- bootstrap 순서를 무시하는 agent는 중요한 context를 놓칠 수 있다.
- Markdown 규칙은 준수를 보장할 수 없으므로 나중에 deterministic gate가 필요할 것이다.
- `PROJECT.yaml` 스키마와 adapter 배포 방식은 추가 결정이 필요하다.

## Alternatives considered

### 큰 재사용 가능한 초기화 prompt

시작은 쉽지만 과도하게 큰 prompt와 대화/tool에 대한 의존을 만듭니다. 기각되었습니다.

### 독립적인 소스로서의 agent별 문서

tool별 최적화는 쉽지만 정책 중복과 drift를 만듭니다. 기각되었습니다.

### CLI-first 구현

스펙이 아직 자동화하기에 충분히 안정적이지 않아서, 이 대안은 V1 이후로 미뤄졌습니다.

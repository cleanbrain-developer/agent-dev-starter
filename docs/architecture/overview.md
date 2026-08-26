# Architecture Overview

## Architectural style

V1은 실행 시스템이 아니라 repository information architecture다. Persistent context를 책임별 계층으로 나누고 agent-specific entrypoint가 공통 core를 참조한다.

```text
Task prompt
    ↓
Agent adapter (AGENTS.md / CLAUDE.md)
    ↓
PROJECT.yaml + Constitution + Product + Architecture + ADR + Current State
    ↓
Relevant repository evidence
    ↓
Plan → Change → Verify → Review → Persist state
```

## Layers

### Identity

`PROJECT.yaml`은 이름, 유형, lifecycle, 지원 agent, principles, 현재 phase와 주요 context 경로를 기계가 읽을 수 있게 제공한다.

### Policy

`.ai/constitution/`은 프로젝트와 task보다 오래 유지되는 engineering 및 documentation 원칙을 제공한다.

### Knowledge

`docs/product/`, `docs/architecture/`, `docs/decisions/`가 무엇을 왜 만들고, 어떻게 구성하며, 왜 중요한 선택을 했는지 설명한다.

### Working state

`docs/status/current-state.md`는 현재 phase에서 완료된 것과 다음 작업을 제공한다. 영구 원칙이나 상세 history는 담지 않는다.

### Adapters

`AGENTS.md`와 `CLAUDE.md`는 각 도구가 공통 context를 발견하도록 돕는다. 도구별 문법과 로딩 차이만 허용한다.

## Enforcement boundary

Markdown은 판단과 절차를 안내하지만 강제 수단은 아니다. 향후 절대 위반하면 안 되는 규칙은 가능한 경우 test, linter, architecture check, CI 같은 deterministic quality gate로 승격한다. V1에는 아직 이 자동화를 구현하지 않는다.

> 이 문서는 [`overview.md`](overview.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Architecture Overview

## 아키텍처 스타일

V1은 실행 가능한 시스템이 아니라 repository information architecture입니다. durable context를 책임별로 분리하고, agent별 entry point를 공유 core로 라우팅합니다.

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

## Layer

### Identity

`PROJECT.yaml`은 이름, 타입, lifecycle, 지원 agent, 원칙, 현재 phase, canonical context 경로를 머신 판독 가능한 데이터로 노출합니다.

### Policy

`.ai/constitution/`은 개별 작업보다 오래, 보통 project phase보다도 오래 지속되는 engineering 및 documentation 원칙을 제공합니다.

### Knowledge

`docs/product/`, `docs/architecture/`, `docs/decisions/`는 무엇을 만들고 있는지, 왜 중요한지, 어떻게 구조화되어 있는지, 왜 중요한 선택을 했는지를 설명합니다.

### Guidance

`docs/guides/`는 이 Starter를 다른 repository에 적용하는 방법을 포함해 반복 가능한 운영 절차를 담습니다. Guide는 정책과 design 소스를 재정의하지 않고 참조합니다.

### Working state

`docs/status/current-state.md`는 현재 phase의 완료된 작업과 다음 작업을 설명합니다. 영구적인 원칙이나 상세한 이력을 담지 않습니다.

### Adapter

`AGENTS.md`와 `CLAUDE.md`는 각자의 tool이 공유 context를 찾도록 돕습니다. tool 고유의 문법과 로딩 방식의 차이만 이 파일들에 속합니다.

## Enforcement boundary

Markdown은 판단과 절차를 안내할 뿐 준수를 강제하지 않습니다. 절대 위반되어서는 안 되는 규칙은 언젠가 테스트, linter, architecture check, CI 같은 deterministic quality gate로 승격되어야 합니다. 단 하나의 예외는 한국어 companion 완전성 규칙(`ADR-0005`)입니다 — 오늘 당장 검사할 수 있을 만큼 기계적입니다. `scripts/check-ko-companions.sh`와 `ADR-0007`을 참고하세요. 나머지는 여전히 자동화가 아니라 판단에 의존합니다.

> 이 문서는 [`overview.md`](overview.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Architecture Overview

## 아키텍처 스타일

ADS는 열린 표준과 convention 위에 지어진 repository information architecture입니다(`docs/product/overview.md`의 "ADS V2" 참고), 새 framework도 아니고 그 자체로 실행 가능한 시스템도 아닙니다. durable context를 책임별로 분리하는데, 대부분은 이제 ADS가 지어낸 메커니즘이 아니라 표준(`AGENTS.md`, GitHub Spec Kit, Agent Skills)이 소유하고, 어떤 표준도 적용되지 않는 곳만 ADS 자신의 얇은 opinion layer입니다.

```text
Task prompt
    ↓
AGENTS.md (유일한 adapter, ADR-0011)
    ↓
PROJECT.yaml + .specify/memory/constitution.md + Product + Architecture + ADR + Current State
    ↓
Active feature (specs/<NNN-feature>/{spec,plan,tasks}.md, GitHub Spec Kit)
    ↓
Relevant repository evidence
    ↓
Plan → Change → Verify → Review → Persist state
```

## Layer

### Identity

`PROJECT.yaml`은 이름, 타입, lifecycle, 지원 agent, 원칙, 현재 phase, pinned standard 버전, canonical context 경로를 머신 판독 가능한 데이터로 노출합니다.

### Policy

`.specify/memory/constitution.md`(GitHub Spec Kit 자신의 constitution 역할)는 durable한 engineering 원칙을 담습니다. `.ai/constitution/documentation-policy.md`는 문서 소유권과 `.ko.md` 언어 정책을 담습니다 — 어떤 열린 표준도 소유하지 않는 유일한 정책 영역입니다.

### Knowledge

두 가지 scope로 나뉩니다, 하나가 아니라: `docs/product/`와 `docs/architecture/`는 프로젝트 전체를 설명하고 feature를 넘어 지속됩니다; `specs/<NNN-feature>/{spec,plan,tasks}.md`(Spec Kit)는 하나의 feature를 설명하고 그 lifecycle에 scope됩니다. `docs/decisions/`는 어느 scope에서든 왜 중요한 선택을 했는지 설명합니다.

### Guidance

`docs/guides/`는 이 Starter를 다른 repository에 적용하는 방법을 포함해 반복 가능한 운영 절차를 담습니다. Guide는 정책과 design 소스를 재정의하지 않고 참조합니다.

### Working state

`docs/status/current-state.md`는 Spec Kit이 의도적으로 제공하지 않는 project 전체 레벨에서(GitHub Spec Kit 자신의 문서 `docs/concepts/spec-persistence.md` 참고) 현재 phase의 완료된 작업과 다음 작업을 설명합니다. 영구적인 원칙이나 상세한 이력을 담지 않고, feature 자신의 `tasks.md`를 중복하지도 않습니다.

### Adapter

`AGENTS.md`는 모든 지원 agent를 위한 유일한 entry point입니다(`ADR-0011`). routing과 공유 행동 계약만 담고, product나 architecture content는 절대 담지 않습니다.

### Skill

`.claude/skills/`와 `.agents/skills/`는 agent 자신의 harness가 자동으로 discover하는 재사용 가능한 절차를 담습니다 — GitHub Spec Kit 자신의 `speckit-*` workflow skill, 그리고 maintainer가 실제로 요청한 project 고유 skill(`ADR-0003`, `ADR-0012`)입니다. 이 layer는 "반복 작업을 어떻게 하는가"이고, 위의 모든 layer("프로젝트가 무엇이고 왜인가")와는 뚜렷이 구분됩니다.

## Enforcement boundary

Markdown은 판단과 절차를 안내할 뿐 준수를 강제하지 않습니다. 절대 위반되어서는 안 되는 규칙은 언젠가 테스트, linter, architecture check, CI 같은 deterministic quality gate로 승격되어야 합니다. 단 하나의 예외는 한국어 companion 완전성 규칙(`ADR-0005`)입니다 — 오늘 당장 검사할 수 있을 만큼 기계적입니다. `scripts/check-ko-companions.sh`와 `ADR-0007`/`ADR-0009`를 참고하세요. 나머지는 여전히 자동화가 아니라 판단에 의존합니다.

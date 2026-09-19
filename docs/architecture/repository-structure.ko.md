> 이 문서는 [`repository-structure.md`](repository-structure.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Repository Structure

## 책임 맵(Responsibility map)

| 경로 | 소유 책임 | 되면 안 되는 것 |
|---|---|---|
| `README.md` | 사람 대상 소개와 navigation | 전체 design 명세 |
| `PROJECT.yaml` | 구조화된 project identity, phase, pinned standard 버전 | narrative한 architecture 문서 |
| `AGENTS.md` | 모든 지원 agent를 위한 유일한 bootstrap adapter이자 행동 계약(`ADR-0011`) | 공유 정책 소스, 또는 여러 중복 adapter 중 하나 |
| `.specify/memory/constitution.md` | durable한 engineering 원칙(GitHub Spec Kit 자신의 constitution 역할 — `ADR-0013`) | project 기능 요구사항 |
| `.specify/` (나머지) | GitHub Spec Kit 자신이 관리하는 파일 — template, script, `feature.json` | ADS가 fork하거나 재구현하는 것 |
| `specs/<NNN-feature>/` | Spec Kit feature artifact: `spec.md`, `plan.md`, `tasks.md`, checklist | `docs/product/`(project 레벨)나 `docs/architecture/`(영속적 구조)의 대체물 |
| `.claude/skills/`, `.agents/skills/` | 실제로 agent가 discover하는 Skill 디렉터리 — Spec Kit 자신의 `speckit-*` skill과 이 project 고유 skill(`ADR-0012`) | `.ai/skills/`나 어떤 agent도 실제로 안 읽는 다른 지어낸 경로 |
| `.ai/constitution/documentation-policy.md` | 문서 소유권과 `.ko.md` 언어 정책 — 어떤 열린 표준도 이걸 소유하지 않음 | project 기능 요구사항이나 engineering 원칙(그건 `.specify/memory/constitution.md`에 있음) |
| `docs/product/` | 문제, 사용자, 목표, scope — project 레벨, feature 레벨이 아님 | 구현 지시사항 |
| `docs/architecture/` | 구조, 경계, context model — 영속적, feature 레벨이 아님 | 결정 이력 |
| `docs/guides/` | 반복 가능한 운영 절차 | product 정책이나 architecture 근거 |
| `docs/decisions/` | 중요한 결정과 근거 | 가변적인 current-state 체크리스트 |
| `docs/status/current-state.md` | 현재 phase, 진행상황, 다음 작업 — Spec Kit이 의도적으로 제공하지 않는 project 전체 snapshot | 영구 정책이나 changelog |
| `scripts/` (optional) | 기계적 규칙(예: `.ko.md` 완전성 — `ADR-0007`)을 위한 수동, non-CI 검증 tooling | build/CI pipeline |

## 의존 방향(Dependency direction)

`AGENTS.md`, guide, summary는 authoritative 문서를 안쪽으로 가리킬 수 있습니다. authoritative 문서는 adapter의 문구나 외부 대화 이력에 의존하지 않습니다.

```text
README ──────────────────┐
AGENTS.md ────────────────┼──> PROJECT.yaml + .specify/memory/constitution.md + docs
current-state.md ─────────┘                 │
                                            └──> accepted ADRs
```

`PROJECT.yaml`은 discovery를 위한 canonical 위치를 나열할 뿐, 그 narrative한 내용을 중복하지 않습니다.

## Optional context extension

`PROJECT.yaml`의 `context` 블록은 실제 adoption이 필요로 할 때, 위 책임 맵의 core set을 넘어서는 canonical 경로를 선언할 수 있습니다. 실제로 관찰된 것은 두 가지입니다(세 번째였던 feature specification은 더 이상 ADS가 지어낸 확장이 아닙니다 — 이제 GitHub Spec Kit 자신의 `specs/` 디렉터리이고, `ADR-0010`에 따라 pinned CLI가 설치하므로 여기서 선언할 필요가 없습니다):

- 다른 repository가 소유한, 이 프로젝트가 스스로 해결할 수 없는 요구사항을 추적하는 상태 파일(예: `docs/status/external-dependencies.md`) — 예를 들면 Kubernetes manifest와 DNS를 소유한 별도의 infra repository가 있는 경우입니다. 이건 `docs/status/` 책임입니다, `docs/architecture/`가 아니라: `current-state.md`처럼 pending과 resolved 사이를 오가며 변하지만, 이 프로젝트 자신의 진행상황이 아니라 이 프로젝트가 바깥에서 필요로 하는 것에 한정됩니다.
- related-repositories 문서(예: `docs/architecture/related-repositories.md`를 가리키는 `related_repositories:`) — 이 프로젝트가 여기서 완전히 통제하지 못하는 다른 repository에 의존하거나, 그 repository로부터 의존받거나, infra를 공유하는 경우를 위한 것입니다. 다룰 내용: 어떤 repository들이 관련되어 있고 각각 이 프로젝트가 소유하지 않은 무엇을 소유하는지; 관계의 형태(애플리케이션 repo + sibling simulator/test-harness 서비스; 코드를 소유하지 않는 독립적인 sibling들이 호출하는 공유 satellite 서비스; 여러 컴포넌트가 공유하는 환경이나 리소스); 그리고 공유가 시작되면서 조용히 깨지는 naming이나 identity 가정(공유 리소스당 컴포넌트가 정확히 하나라고 가정하는 identity/naming scheme이 실제 사례입니다 — 두 번째 컴포넌트가 그 리소스를 공유하는 순간 조용히 깨지고, 이 문서 없이는 직접 조사해야만 발견할 수 있습니다).

`PROJECT.yaml`의 `context` 블록에 optional 필드를 선언하는 건, 그 아래 파일이 이런 실제적이고 뚜렷한 책임을 가질 때만 하세요 — 아래 "Directory policy"가 여전히 적용됩니다. 추측성으로 추가하지 말고, 책임이 사라지면 제거하세요.

## Directory policy

파일이 실제 책임을 가질 때만 디렉터리를 추가하세요. preset이나 source tree를 위한 빈 구조를 만들지 마세요. `.specify/`와 `specs/`는 pinned Spec Kit CLI가 설치합니다(`ADR-0010`), 손으로 만드는 게 아닙니다. `.claude/skills/`/`.agents/skills/`는 maintainer가 실제 반복 workflow를 설명한 뒤에만 project 고유 skill을 담을 수 있습니다(`ADR-0003`, `ADR-0012`, `docs/guides/using-the-starter.md` 참고) — 추측성 placeholder로는 절대 안 됩니다.

## Evolution rule

top-level 영역이나 책임 layer를 추가하기 전에, 기존 위치(열린 표준 자신의 디렉터리 포함)가 그것을 표현할 수 없는지 확인하세요. 장기적인 의존 방향이나 adapter/core 경계의 변경은 ADR이 필요합니다.

# Repository Structure

## Responsibility map

| Path | Owner responsibility | Must not become |
|---|---|---|
| `README.md` | Human introduction and navigation | Full design specification |
| `PROJECT.yaml` | Structured project identity and phase | Narrative architecture document |
| `AGENTS.md` | Codex bootstrap adapter | Common policy source |
| `CLAUDE.md` | Claude Code bootstrap adapter | Duplicate of `AGENTS.md` |
| `.ai/constitution/` | Durable engineering and agent principles | Project feature requirements |
| `docs/product/` | Problem, users, goals, scope | Implementation instructions |
| `docs/architecture/` | Structure, boundaries, context model | Decision history |
| `docs/decisions/` | Important decisions and rationale | Mutable current-state checklist |
| `docs/status/current-state.md` | Current phase, progress, next work | Permanent policy or changelog |

## Dependency direction

Adapters and summaries may point inward to authoritative documents. Authoritative documents do not depend on adapter wording or external conversation history.

```text
README ───────────────┐
AGENTS / CLAUDE ──────┼──> PROJECT + constitution + docs
current-state ────────┘                 │
                                       └──> accepted ADRs
```

`PROJECT.yaml` lists canonical locations for discovery but does not duplicate their narrative content.

## Directory policy

디렉터리는 실제 책임을 가진 파일이 생길 때 추가한다. V1에서는 아직 정의되지 않은 skills, templates, presets, scripts, source tree를 빈 구조로 만들지 않는다.

## Evolution rule

새 top-level 영역이나 책임 계층을 추가할 때는 기존 위치로 표현할 수 없는지 먼저 확인한다. 장기적인 dependency direction 또는 adapter/core 경계를 바꾸면 ADR이 필요하다.

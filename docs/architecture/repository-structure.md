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
| `docs/guides/` | Repeatable operational procedures | Product policy or architecture rationale |
| `docs/decisions/` | Important decisions and rationale | Mutable current-state checklist |
| `docs/status/current-state.md` | Current phase, progress, next work | Permanent policy or changelog |

## Dependency direction

Adapters, guides, and summaries may point inward to authoritative documents. Authoritative documents do not depend on adapter wording or external conversation history.

```text
README ───────────────┐
AGENTS / CLAUDE ──────┼──> PROJECT + constitution + docs
current-state ────────┘                 │
                                       └──> accepted ADRs
```

`PROJECT.yaml` lists canonical locations for discovery but does not duplicate their narrative content.

## Directory policy

Add a directory only when a file has a real responsibility within it. Do not create empty structures for undefined skills, templates, presets, scripts, or source trees in V1.

## Evolution rule

Before adding a top-level area or responsibility layer, confirm that an existing location cannot represent it. A change to the long-term dependency direction or adapter/core boundary requires an ADR.

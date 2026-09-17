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

## Optional context extensions

`PROJECT.yaml`'s `context` block may declare canonical paths beyond the core set in the responsibility map above, when a real adoption needs one. Two have been observed in practice:

- A dedicated feature-specification directory (for example `specs:` pointing at `specs/`), for a project whose feature specs are detailed enough that they do not belong in `docs/architecture/` or `docs/decisions/`.
- A status file tracking cross-repository dependencies — requirements this project cannot resolve itself because another repository owns that concern (for example, a separate infrastructure repository that owns Kubernetes manifests and DNS). This is a `docs/status/` responsibility, not `docs/architecture/`: it changes as items move between pending and resolved, the same way `current-state.md` does, but it is scoped to what this project needs from outside itself rather than this project's own progress.

Declare an optional field in `PROJECT.yaml`'s `context` block only when a file under it has this kind of real, distinct responsibility — the "Directory policy" below still applies. Do not add one speculatively, and remove it if the responsibility goes away.

## Directory policy

Add a directory only when a file has a real responsibility within it. Do not create empty structures for undefined skills, templates, presets, scripts, or source trees in V1.

## Evolution rule

Before adding a top-level area or responsibility layer, confirm that an existing location cannot represent it. A change to the long-term dependency direction or adapter/core boundary requires an ADR.

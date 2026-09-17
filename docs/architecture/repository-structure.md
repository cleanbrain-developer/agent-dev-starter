# Repository Structure

## Responsibility map

| Path | Owner responsibility | Must not become |
|---|---|---|
| `README.md` | Human introduction and navigation | Full design specification |
| `PROJECT.yaml` | Structured project identity and phase | Narrative architecture document |
| `AGENTS.md` | Codex bootstrap adapter | Common policy source |
| `CLAUDE.md` | Claude Code bootstrap adapter | Duplicate of `AGENTS.md` |
| `.ai/constitution/` | Durable engineering and agent principles | Project feature requirements |
| `.ai/skills/` (optional, per-project) | A repeatable workflow this specific project's maintainer described (see `ADR-0003`) | A shared library synced from ADS or copied from another adopted project |
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

`PROJECT.yaml`'s `context` block may declare canonical paths beyond the core set in the responsibility map above, when a real adoption needs one. Three have been observed in practice:

- A dedicated feature-specification directory (for example `specs:` pointing at `specs/`). Create a `specs/<feature>/spec.md` for a change when at least one is true: it will span more than one session before shipping, it introduces or changes an architectural boundary significant enough to need its own decision record, or its design needs to be checked again against what actually shipped. Otherwise `current-state.md` plus commit history is enough — do not create a spec document as a matter of routine for every change. Update the spec's own status marker in the same change that ships the feature it describes; a shipped feature whose spec still says "design only" is a defect, not a historical artifact (see `agent-context-model.md`, "Working context").
- A status file tracking cross-repository dependencies (for example `docs/status/external-dependencies.md`) — requirements this project cannot resolve itself because another repository owns that concern (for example, a separate infrastructure repository that owns Kubernetes manifests and DNS). This is a `docs/status/` responsibility, not `docs/architecture/`: it changes as items move between pending and resolved, the same way `current-state.md` does, but it is scoped to what this project needs from outside itself rather than this project's own progress.
- A related-repositories document (for example `related_repositories:` pointing at `docs/architecture/related-repositories.md`), for a project that depends on, is depended on by, or shares infrastructure with another repository not fully controlled from here. Cover: which repositories are related and what each one owns that this one does not; the shape of the relationship (an application repo plus a sibling simulator/test-harness service; a shared satellite service called by otherwise-independent siblings that own no code in it; an environment or resource shared by more than one component); and any naming or identity assumption that silently stops holding once sharing is involved (an identity or naming scheme that assumes exactly one component per shared resource is one real example — it breaks silently once a second component shares that resource, and is only discoverable by direct inspection without this document).

Declare an optional field in `PROJECT.yaml`'s `context` block only when a file under it has this kind of real, distinct responsibility — the "Directory policy" below still applies. Do not add one speculatively, and remove it if the responsibility goes away.

## Directory policy

Add a directory only when a file has a real responsibility within it. Do not create empty structures for templates, presets, scripts, or source trees in V1. `.ai/skills/` is the one directory an adopting project may create for itself, and only once its maintainer has described a real, repeatable workflow for it (see `ADR-0003` and `docs/guides/using-the-starter.md`, step 9) — never as a speculative placeholder.

## Evolution rule

Before adding a top-level area or responsibility layer, confirm that an existing location cannot represent it. A change to the long-term dependency direction or adapter/core boundary requires an ADR.

# Repository Structure

## Responsibility map

| Path | Owner responsibility | Must not become |
|---|---|---|
| `README.md` | Human introduction and navigation | Full design specification |
| `PROJECT.yaml` | Structured project identity, phase, and pinned standard versions | Narrative architecture document |
| `AGENTS.md` | The sole bootstrap adapter and behavioral contract for every supported agent (`ADR-0011`) | Common policy source, or one of several duplicate adapters |
| `.specify/memory/constitution.md` | Durable engineering principles (GitHub Spec Kit's own constitution role — `ADR-0013`) | Project feature requirements |
| `.specify/` (the rest) | GitHub Spec Kit's own managed files — templates, scripts, `feature.json` | Something ADS forks or reimplements |
| `specs/<NNN-feature>/` | Spec Kit feature artifacts: `spec.md`, `plan.md`, `tasks.md`, checklists | A replacement for `docs/product/` (project-level) or `docs/architecture/` (persistent structure) |
| `.claude/skills/`, `.agents/skills/` | Real, agent-discovered Skill directories — Spec Kit's own `speckit-*` skills plus this project's own (`ADR-0012`) | `.ai/skills/` or any other invented path no agent actually reads |
| `.ai/constitution/documentation-policy.md` | Document ownership and the `.ko.md` language policy — no open standard owns this | Project feature requirements or engineering principles (those live in `.specify/memory/constitution.md`) |
| `docs/product/` | Problem, users, goals, scope — project-level, not feature-level | Implementation instructions |
| `docs/architecture/` | Structure, boundaries, context model — persistent, not feature-level | Decision history |
| `docs/guides/` | Repeatable operational procedures | Product policy or architecture rationale |
| `docs/decisions/` | Important decisions and rationale | Mutable current-state checklist |
| `docs/status/current-state.md` | Current phase, progress, next work — project-wide snapshot Spec Kit intentionally does not provide | Permanent policy or changelog |
| `scripts/` (optional) | Manual, non-CI verification tooling for a mechanical rule (e.g. `.ko.md` completeness — `ADR-0007`) | A build/CI pipeline |

## Dependency direction

`AGENTS.md`, guides, and summaries may point inward to authoritative documents. Authoritative documents do not depend on adapter wording or external conversation history.

```text
README ──────────────────┐
AGENTS.md ────────────────┼──> PROJECT.yaml + .specify/memory/constitution.md + docs
current-state.md ─────────┘                 │
                                            └──> accepted ADRs
```

`PROJECT.yaml` lists canonical locations for discovery but does not duplicate their narrative content.

## Optional context extensions

`PROJECT.yaml`'s `context` block may declare canonical paths beyond the core set in the responsibility map above, when a real adoption needs one. Two have been observed in practice (a third, feature specifications, is no longer an ADS-invented extension — it is GitHub Spec Kit's own `specs/` directory, installed by the pinned CLI per `ADR-0010`, not something declared here):

- A status file tracking cross-repository dependencies (for example `docs/status/external-dependencies.md`) — requirements this project cannot resolve itself because another repository owns that concern (for example, a separate infrastructure repository that owns Kubernetes manifests and DNS). This is a `docs/status/` responsibility, not `docs/architecture/`: it changes as items move between pending and resolved, the same way `current-state.md` does, but it is scoped to what this project needs from outside itself rather than this project's own progress.
- A related-repositories document (for example `related_repositories:` pointing at `docs/architecture/related-repositories.md`), for a project that depends on, is depended on by, or shares infrastructure with another repository not fully controlled from here. Cover: which repositories are related and what each one owns that this one does not; the shape of the relationship (an application repo plus a sibling simulator/test-harness service; a shared satellite service called by otherwise-independent siblings that own no code in it; an environment or resource shared by more than one component); and any naming or identity assumption that silently stops holding once sharing is involved (an identity or naming scheme that assumes exactly one component per shared resource is one real example — it breaks silently once a second component shares that resource, and is only discoverable by direct inspection without this document).

Declare an optional field in `PROJECT.yaml`'s `context` block only when a file under it has this kind of real, distinct responsibility — the "Directory policy" below still applies. Do not add one speculatively, and remove it if the responsibility goes away.

## Directory policy

Add a directory only when a file has a real responsibility within it. Do not create empty structures for presets or source trees. `.specify/` and `specs/` are installed by the pinned Spec Kit CLI (`ADR-0010`), not created by hand. `.claude/skills/`/`.agents/skills/` may hold a project-specific skill only once its maintainer has described a real, repeatable workflow for it (see `ADR-0003`, `ADR-0012`, and `docs/guides/using-the-starter.md`) — never as a speculative placeholder.

## Evolution rule

Before adding a top-level area or responsibility layer, confirm that an existing location — including an open standard's own directory — cannot represent it. A change to the long-term dependency direction or adapter/core boundary requires an ADR.

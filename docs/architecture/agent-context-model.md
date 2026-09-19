# Agent Context Model

## Context classes

### Permanent context

Information that persists across sessions, including project purpose, scope, architecture, engineering principles, and accepted decisions. Store it in `PROJECT.yaml`, `.specify/memory/constitution.md`, `.ai/constitution/documentation-policy.md`, product and architecture documents, and ADRs.

### Working context

Information that changes with progress, including the current phase, recently completed work, next actions, and open decisions. Store the project-wide snapshot in `docs/status/current-state.md`. Store per-feature progress in that feature's own `specs/<NNN-feature>/{spec,plan,tasks}.md` (GitHub Spec Kit) — `current-state.md` references which feature is active rather than duplicating its task-level detail.

A feature's own status marker is working context too, not a one-time artifact: it must be updated the moment the feature it describes changes state (specified, planned, implemented, deployed, superseded), on the same discipline as `current-state.md`. A spec or task list that still says "not yet implemented" after the feature has shipped is a stale working-context source, not a historical record — treat finding one as a defect to fix, the same as a stale `current-state.md`.

When a status document records the same repeatable procedure for multiple parallel sibling entities (one per-service section in a shared document each recording whether some setup step is done, for example), silence about that step for one sibling is not neutral: a reader infers parity with the siblings where it was recorded done, not "not yet done." A real adoption found exactly this — two of five sibling entries had no record of a required setup step at all, which read as "the same as the already-recorded three" until a real attempt to rely on it failed and direct inspection of the actual system showed the step had never been performed for either. State a repeated step's status explicitly (done, not yet done, or not applicable) for every sibling entry, not only the ones where it happened to be true — an absent record is a gap to flag, not evidence of completion by analogy.

### Task context

The current user request, relevant code, and temporary research findings. Load it only when needed. If it gains durable value, persist it in the appropriate permanent or working source.

## Bootstrap order

Progressive disclosure: load only what the current request needs, not every historical feature, ADR, or architecture document that exists.

1. Start from `AGENTS.md` (the sole adapter — `ADR-0011`).
2. Read `PROJECT.yaml` to identify the project, phase, and pinned standard versions.
3. Read `.specify/memory/constitution.md` (and `.ai/constitution/documentation-policy.md` for anything document-related) to understand behavioral boundaries.
4. Read `docs/status/current-state.md` to recover the current position, next work, and which feature (if any) is active.
5. If a feature is active, read only that feature's `specs/<NNN-feature>/{spec,plan,tasks}.md` — not every feature directory in the repository.
6. Read only the `docs/architecture/` documents and accepted ADRs that `current-state.md` or the active spec actually references, not the full history.
7. Load a `.claude/skills/` or `.agents/skills/` `SKILL.md` only when the current task matches what it covers — this is normally the harness's own job, not something to pre-load.
8. Inspect repository evidence relevant to the request.
9. Plan, change, verify, and review.
10. Persist durable decisions and working-state changes in the repository, including the feature's own spec/plan/tasks state if one is active.

`.ko.md` companions are never part of this order — read one only when the maintainer asks for a Korean explanation or review.

## Conflict handling

- A user request defines the work objective but does not silently discard accepted architecture.
- A specific accepted ADR takes precedence over a general architecture description.
- `current-state.md` does not redefine principles or design.
- Report unresolved conflicts instead of hiding them behind assumptions.

## Bootstrap acceptance test

In a clean session, provide only `AGENTS.md` and no external link. Context recovery succeeds when the agent answers the five acceptance questions in `docs/product/goals.md` ("Success criteria"), with every answer traceable to repository documentation.

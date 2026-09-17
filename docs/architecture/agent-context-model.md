# Agent Context Model

## Context classes

### Permanent context

Information that persists across sessions, including project purpose, scope, architecture, engineering principles, and accepted decisions. Store it in `PROJECT.yaml`, `.ai/constitution/`, product and architecture documents, and ADRs.

### Working context

Information that changes with progress, including the current phase, recently completed work, next actions, and open decisions. Store it in `docs/status/current-state.md`.

If the project also keeps per-feature design documents (for example a `specs/<feature>/` convention), each one's own status marker is working context too, not a one-time artifact: it must be updated the moment the feature it describes changes state (implemented, deployed, superseded), on the same discipline as `current-state.md`. A design document that still says "not yet implemented" after the feature has shipped is a stale working-context source, not a historical record — treat finding one as a defect to fix, the same as a stale `current-state.md`.

When a status document records the same repeatable procedure for multiple parallel sibling entities (one per-service section in a shared document each recording whether some setup step is done, for example), silence about that step for one sibling is not neutral: a reader infers parity with the siblings where it was recorded done, not "not yet done." A real adoption found exactly this — two of five sibling entries had no record of a required setup step at all, which read as "the same as the already-recorded three" until a real attempt to rely on it failed and direct inspection of the actual system showed the step had never been performed for either. State a repeated step's status explicitly (done, not yet done, or not applicable) for every sibling entry, not only the ones where it happened to be true — an absent record is a gap to flag, not evidence of completion by analogy.

### Task context

The current user request, relevant code, and temporary research findings. Load it only when needed. If it gains durable value, persist it in the appropriate permanent or working source.

## Bootstrap order

1. Start from the relevant agent adapter.
2. Read `PROJECT.yaml` to identify the project and phase.
3. Read the constitution to understand behavioral boundaries.
4. Read product documents to understand purpose and scope.
5. Read architecture documents to understand structure and responsibilities.
6. Read accepted ADRs relevant to the current work.
7. Read relevant documents under `docs/guides/` for repeatable operational procedures.
8. Read `current-state.md` to recover the current position and next work.
9. Inspect repository evidence relevant to the request.
10. Plan, change, verify, and review.
11. Persist durable decisions and working-state changes in the repository.

## Conflict handling

- A user request defines the work objective but does not silently discard accepted architecture.
- A specific accepted ADR takes precedence over a general architecture description.
- Current state does not redefine principles or design.
- Differences between adapters do not change the shared source of truth.
- Report unresolved conflicts instead of hiding them behind assumptions.

## Bootstrap acceptance test

In a clean session, provide only the entry adapter and no external link. Context recovery succeeds when the agent answers the five acceptance questions in `docs/product/goals.md` ("Success criteria"), with every answer traceable to repository documentation.

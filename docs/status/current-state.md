# Current State

Last updated: 2026-09-17

## Current phase

V1 foundation validated — the specification, adoption procedure, and bootstrap contract have been proven across four independent real adoptions. Remaining work refines specifics surfaced by continued adoption; it does not add new foundational structure.

## Completed

- Established the V1 foundation: repository-first context and an agent-agnostic core (`ADR-0001`), the responsibility-separated directory structure, Codex and Claude Code as initial supported agents, and a manual adoption guide (`docs/guides/using-the-starter.md`).
- Ran the bootstrap acceptance test in fresh Codex-style and Claude Code-style sessions (2026-08-27) and validated it again through later fixes; deduplicated the bootstrap reading order and the five acceptance-test questions across `AGENTS.md`, `CLAUDE.md`, `agent-context-model.md`, `overview.md`, and `goals.md` (2026-09-09).
- Documented and validated agent-driven adoption (2026-09-09): an agent can drive the full procedure conversationally from the maintainer's natural-language description, asking only where the guide marks human input required; git repo/remote creation and the first push always need separate confirmation.
- Completed four real external adoptions — `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo` — each shipped to production or under active development. Each surfaced real gaps, now fixed in the guide and constitution: the pre/post-implementation `delivery`/`lifecycle` round-trip; what counts as a "clean" bootstrap-test session; tying adapter-file creation to `supported_agents.initial`; a restart/discard path for a botched adoption; treating a stale `current-state.md` or per-feature spec status as a defect, with the update trigger changed from "session boundary" to "a shipped, verified change"; distinguishing a green automated check from direct verification against the real running system (caught three real production defects in `relayhub-java`); silence about a repeated step across sibling repos reading as false completion-by-analogy; preserving pre-existing, unrelated adapter content instead of overwriting it; and backfilling ADRs for undocumented pre-existing decisions during "Existing project" adoption. Full narrative detail for each is in git history, not repeated here.
- Accepted `ADR-0002` (permanently discard a template repository and CLI/initializer — the four adoptions' real cost was content adaptation, not file copying) and `ADR-0003` (skills are per-project, not a shared ADS library) (2026-09-17); updated `docs/product/scope.md` and `docs/product/goals.md` to reflect both, and wired `ADR-0003` into the adoption procedure as an optional step 9 with a matching checklist item and an optional `.ai/skills/` row in `repository-structure.md`.
- Documented `PROJECT.yaml` field patterns observed in real use but previously unwritten (2026-09-17): `context` may declare project-specific optional paths (`specs:`, a cross-repository dependency status file, or `related_repositories:`), and `principles` may mix retained ADS core principles with project-specific ones as long as every project-specific principle has a real prose definition in that project's own `.ai/constitution/engineering-principles.md`.
- Resolved the multi-repository-relationship and per-feature-spec-document open decisions with concrete optional conventions, based on patterns repeated across all four adoptions (2026-09-17) — see `docs/architecture/repository-structure.md`, "Optional context extensions."

## In progress

- None currently. See Next.

## Next

1. Decide the required fields and validation level for a machine-checkable `PROJECT.yaml` schema — field-level meaning is documented in prose; mechanical validation is still undecided.
2. Decide which documentation rules should be promoted first to tests, linting, or CI.
3. Watch real adoptions for whether the newly-added `related_repositories` and spec-document conventions hold up, or need revision.

## Open decisions

- Whether `PROJECT.yaml` remains a simple manifest or receives a separate machine-validatable schema (field-level meaning is documented in prose; only mechanical validation remains undecided)
- Which documentation rules should be promoted first to tests, linting, or CI
- How adapter compatibility should be verified as supported agents expand

## Known constraints

- There is no application code, test suite, build system, CLI, or automation, and none is planned (`ADR-0002`).
- The initial design conversation was used only as bootstrap evidence and is not required context for future sessions.
- Adoption is manual, permanently — see `ADR-0002`.

## V1 exit criteria

- A new agent session accurately recovers the project purpose, principles, architecture, current state, and next work without an external link. Met.
- All durable evidence for that answer exists in the repository. Met.
- Shared design is not duplicated in agent adapters. Met.
- Another project can adopt the foundation by following the manual guide without relying on undocumented conversation context. Met four times over as of 2026-09-17: `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`.

All four criteria are met; V1 is validated. `PROJECT.yaml`'s `current_phase` reflects a maintenance posture, not active foundation-building — remaining work is the three `Next` items above, discovered through continued adoption rather than required to close V1.

# Current State

Last updated: 2026-09-18

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
- Added `.ko.md` Korean companions for every document in this repository, and accepted `ADR-0004` (2026-09-17): English stays canonical and agent bootstrap reads only the English file; `PROJECT.yaml` has no companion since it is structured data, not prose.
- Accepted `ADR-0005` (2026-09-17), strengthening `ADR-0004`: a `.ko.md` companion is now mandatory for every ADS-adopted project (not a per-project choice reviewed during constitution review), and must be updated in the same change whenever its English original's meaning changes — a stale companion is a defect, the same discipline as `documentation-policy.md`'s "Maintenance" rule. Wired into `agent-behavior.md`'s "Before completion" checklist, `documentation-policy.md`'s "Language" section, and `using-the-starter.md`'s "Files to adopt" and adoption checklist. Applies retroactively to all four adopted projects.
- Retrofitted `.ko.md` companions into all four already-adopted projects (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`; `kioti-crm-discount-enhance-demo` still pending — outside this session's reachable directories) (2026-09-17/18).
- Closed all three remaining open decisions with evidence-based ADRs (2026-09-18): `ADR-0006` keeps `PROJECT.yaml` prose-documented, no machine schema — no real adoption has ever produced a structural failure that a schema would have caught. `ADR-0007` promotes the `.ko.md` completeness rule (the one fully mechanical rule) to the first deterministic check, via `scripts/check-ko-companions.sh` — run by hand, not wired into CI, since no adoption has shown that manual running is insufficient. `ADR-0008` answers adapter-compatibility verification for a future new agent: pass the existing bootstrap acceptance test through that agent's own entry adapter, reusing the mechanism already proven for Codex and Claude Code rather than building a new one.

- Accepted `ADR-0009` (2026-09-18), amending `ADR-0007` on the maintainer's explicit preference: any ADS-adopted project that already has a CI pipeline should run `scripts/check-ko-companions.sh --missing-only` in its existing `test` job by default, failing the build on a missing companion. Added the `--missing-only` flag to the script itself, since a fresh CI checkout resets mtimes and makes the staleness heuristic meaningless there. Wired into `using-the-starter.md`'s "Files to adopt" and adoption checklist. Applying this to the three already-adopted projects with CI (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`) is in progress.

## In progress

- Retrofitting `ADR-0009`'s CI step into the three already-adopted projects that have a pipeline (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`).

## Next

1. Watch real adoptions for whether the newly-added `related_repositories` and spec-document conventions hold up, or need revision.
2. Retrofit `.ko.md` companions and the `ADR-0009` CI step into `kioti-crm-discount-enhance-demo` once it is reachable again.
3. Revisit `ADR-0006`/`ADR-0007` if a future adoption's experience contradicts their "no evidence yet" premise (a real `PROJECT.yaml` structural failure, or a `.ko.md` drifting badly enough that manual checking proves insufficient).

## Open decisions

None currently open. The three that stood since 2026-08-27/09-09 were closed on 2026-09-18 by `ADR-0006`, `ADR-0007`, and `ADR-0008`.

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

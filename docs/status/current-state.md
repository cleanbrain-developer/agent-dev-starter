# Current State

Last updated: 2026-09-20

## Current phase

**V2: migrated onto open standards.** ADS no longer reimplements spec/plan/tasks conventions or invents non-standard agent-adapter/skill paths — it is now an opinionated profile on top of `AGENTS.md`, GitHub Spec Kit, and Agent Skills (`ADR-0010` through `ADR-0013`). V1's foundation (repository-first context, `PROJECT.yaml`, ADR discipline, `current-state.md`, mandatory bilingual documentation) is preserved; the parts V1 had reinvented without checking for a standard first were replaced.

## Completed

**V1 (2026-08-26 – 2026-09-18), compacted — full narrative detail is in git history, not repeated here:**
- Established repository-first context (`ADR-0001`), the responsibility-separated structure, and an agent-driven adoption procedure.
- Validated the foundation across four real adoptions (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`), each feeding real gaps back into the guide and constitution.
- Permanently discarded a template repository, an ADS-specific CLI, and a shared skill library, all on adoption evidence (`ADR-0002`, `ADR-0003`).
- Made every document mandatorily bilingual (English canonical, `.ko.md` companion, cascading with every change, checked by default in CI) — `ADR-0004`, `ADR-0005`, `ADR-0009`.
- Closed every remaining open decision with evidence-based ADRs rather than leaving them open indefinitely (`ADR-0006`, `ADR-0007`, `ADR-0008`).

**V2 (2026-09-20) — the standards-alignment migration:**
- `ADR-0010`: pinned `specify-cli==1.0.8` (GitHub Spec Kit) as the required version for every adoption, rather than ADS hand-vendoring rendered skill files it could not verify in this session (no working Python/`uv` toolchain was available to actually run the CLI).
- `ADR-0011`: removed `CLAUDE.md`. `AGENTS.md` is now the sole adapter for every supported agent, since Claude Code began reading `AGENTS.md` natively (v2.1.277, 2026-09-18) and the last reason to keep two adapters in sync is gone.
- `ADR-0012`: corrected the invented `.ai/skills/` path from `ADR-0003` to the real, agent-discovered `.claude/skills/` and `.agents/skills/` — no agent tool ever actually read the old path.
- `ADR-0013`: merged `.ai/constitution/engineering-principles.md` into `.specify/memory/constitution.md` (GitHub Spec Kit's own constitution role) and `.ai/constitution/agent-behavior.md` directly into `AGENTS.md`. Only `.ai/constitution/documentation-policy.md` remains, since no open standard owns document ownership or the language policy.
- Rewrote `docs/guides/using-the-starter.md`, `docs/architecture/{overview,repository-structure,agent-context-model}.md`, `docs/product/{overview,goals,scope}.md`, `PROJECT.yaml`, and `README.md` to reflect the above — adoption now installs the pinned Spec Kit CLI and generates real skill files instead of ADS providing its own equivalents.
- Compacted this file's V1 history (documented above) per `documentation-policy.md`'s "Status hygiene" rule, since it had grown into exactly the changelog that rule forbids.
- Retrofitted the V2 migration into `cleanbrain-me-entrance`, `cleanbrain-me-developer`, and `relayhub-java`.

**Real Spec Kit installation (2026-09-20, later same day):**
- Installed a real Python 3.12 + `uv` toolchain (via `winget` and `pip`) and `specify-cli==1.0.8` — the exact version `ADR-0010` pinned. This closes the gap that ADR recorded: ADS can now actually run the CLI it requires adopting projects to use.
- Ran `specify init --here --integration claude` then `specify integration install codex --force` in this repository. It preserved the existing, hand-authored `.specify/memory/constitution.md` unmodified (verified: the CLI's manifest tracking recognizes an already-customized file and does not overwrite it) and generated the real `.specify/templates/`, `.specify/scripts/`, `.claude/skills/speckit-*/SKILL.md`, and `.agents/skills/speckit-*/SKILL.md` — resolving the "unvalidated guidance" gap `ADR-0010` and the old Next item 2 recorded. `using-the-starter.md`'s Spec Kit installation steps now match real, observed CLI behavior, not just Spec Kit's documentation.
- Accepted `ADR-0014`: excluded vendored Spec Kit assets (`.specify/templates|scripts|workflows|integrations`, any `.claude/skills/speckit-*`/`.agents/skills/speckit-*`) from the `.ko.md` mandate — translating upstream boilerplate that gets replaced wholesale on every version bump has no reader benefit, the same reasoning already accepted for `node_modules`. `.specify/memory/constitution.md` and any project-specific skill remain mandatory. Updated `scripts/check-ko-companions.sh` accordingly; verified 0 missing after the real install.
- Retrofitted the same real installation into `cleanbrain-me-entrance`, `cleanbrain-me-developer`, and `relayhub-java` (which also had a pre-existing, non-Spec-Kit `specs/001`–`006` tree — migrating that into Spec Kit's own `specs/<NNN-feature>/` structure is separate from installing the CLI itself; see Next).
- Retrofitted the full V2 migration and the real Spec Kit install into `kioti-crm-discount-enhance-demo` in two commits (structural migration, then the bilingual `.ko.md` rollout) — `docs/decisions/ADR-0001`–`ADR-0007` were left untouched as historical records per that project's own ADR-immutability norm, matching the pattern used for `cleanbrain-me-entrance`/`cleanbrain-me-developer`/`relayhub-java`. All four originally-adopted projects are now on V2 with a real, pinned Spec Kit CLI install.

## In progress

None currently.

## Next

1. Decide whether and how to migrate `relayhub-java`'s pre-existing `specs/001`–`006` tree into Spec Kit's own `specs/<NNN-feature>/` structure now that the real CLI is available, or leave it as a documented, intentional exception.
2. Watch real adoptions for whether the newly-added `related_repositories` and spec-document conventions (now Spec Kit's own `specs/`) hold up, or need revision.
3. Revisit `ADR-0006`/`ADR-0007` if a future adoption's experience contradicts their "no evidence yet" premise (a real `PROJECT.yaml` structural failure, or a `.ko.md` drifting badly enough that manual checking proves insufficient).

## Open decisions

None currently open.

## Known constraints

- There is no ADS-specific application code, test suite, build system, or CLI, and none is planned (`ADR-0002`). GitHub Spec Kit's own CLI is a required external dependency for adopting projects, pinned via `ADR-0010`, and is now actually installed and verified in this environment.
- The initial design conversation was used only as bootstrap evidence and is not required context for future sessions.
- Adoption is manual, permanently — see `ADR-0002`.

## Exit criteria

- A new agent session, starting only from `AGENTS.md`, accurately recovers the project purpose, principles, architecture, current state, and next work without an external link. Met.
- All durable evidence for that answer exists in the repository. Met.
- Shared design is not duplicated across agent adapters — there is exactly one. Met (`ADR-0011`).
- Another project can adopt the foundation by following the manual guide without relying on undocumented conversation context. Met four times over under V1; V2's guidance (including the real Spec Kit install) has now been run for real in this repository and all four adopted projects.
- No ADS mechanism exists where an open standard (`AGENTS.md`, GitHub Spec Kit, Agent Skills) already solves the same problem. Met as of this migration; recheck whenever a new mechanism is proposed.

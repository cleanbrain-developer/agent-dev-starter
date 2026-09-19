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

## In progress

- Retrofitting the V2 migration into the three already-adopted projects reachable in this session (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`): remove `CLAUDE.md`, merge the constitution files, install the pinned Spec Kit CLI, move any project-specific skill to the correct path, and remove now-superseded V1-era documents.

## Next

1. Retrofit the V2 migration into `kioti-crm-discount-enhance-demo` once it is reachable again (same as the other three).
2. Validate this guidance against a real `specify init` run — this session had no working Python/`uv` toolchain, so `using-the-starter.md`'s Spec Kit installation steps were written from Spec Kit's own documentation and raw template source, not from having run the CLI (`ADR-0010`). The first real adoption under V2 should confirm the guidance matches actual CLI output.
3. Watch real adoptions for whether the newly-added `related_repositories` and spec-document conventions (now Spec Kit's own `specs/`) hold up, or need revision.
4. Revisit `ADR-0006`/`ADR-0007` if a future adoption's experience contradicts their "no evidence yet" premise (a real `PROJECT.yaml` structural failure, or a `.ko.md` drifting badly enough that manual checking proves insufficient).

## Open decisions

None currently open.

## Known constraints

- There is no ADS-specific application code, test suite, build system, or CLI, and none is planned (`ADR-0002`). GitHub Spec Kit's own CLI is a required external dependency for adopting projects, pinned via `ADR-0010`.
- The initial design conversation was used only as bootstrap evidence and is not required context for future sessions.
- Adoption is manual, permanently — see `ADR-0002`.
- This session could not run the actual Spec Kit CLI to verify its rendered output (see `ADR-0010` and Next item 2) — a real gap, not a hypothetical one, until the first real V2 adoption confirms it.

## Exit criteria

- A new agent session, starting only from `AGENTS.md`, accurately recovers the project purpose, principles, architecture, current state, and next work without an external link. Met.
- All durable evidence for that answer exists in the repository. Met.
- Shared design is not duplicated across agent adapters — there is exactly one. Met (`ADR-0011`).
- Another project can adopt the foundation by following the manual guide without relying on undocumented conversation context. Met four times over under V1; V2's guidance is unvalidated by a real adoption yet (see Next item 2).
- No ADS mechanism exists where an open standard (`AGENTS.md`, GitHub Spec Kit, Agent Skills) already solves the same problem. Met as of this migration; recheck whenever a new mechanism is proposed.

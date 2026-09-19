# ADR-0014: Exclude Vendored Spec Kit Assets From the `.ko.md` Mandate

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

With a real Python/`uv` toolchain now available and `specify-cli==1.0.8` actually installed (resolving the gap `ADR-0010` recorded), running `specify init` populates `.specify/templates/`, `.specify/scripts/`, `.specify/workflows/`, `.specify/integrations/`, and `.claude/skills/speckit-*/SKILL.md` / `.agents/skills/speckit-*/SKILL.md` with real, CLI-rendered content pinned to the installed Spec Kit version. `ADR-0004`/`ADR-0005` mandate a `.ko.md` companion for every Markdown document with no directory exemption beyond `node_modules`/`.git`/`build`/`dist`/`out` — applied literally, this would require translating upstream Spec Kit's own template and skill prose, which:

- is vendored third-party content this project does not author and cannot meaningfully improve by translating,
- gets silently replaced on every `specify upgrade` to a newer pinned version, making any translation stale by construction, not by neglect, and
- is analogous to `node_modules` — already excluded from the mandate for the same reason (vendored, not authored here).

`.specify/memory/constitution.md` and any project-specific skill (a `.claude/skills/<name>/SKILL.md` or `.agents/skills/<name>/SKILL.md` not prefixed `speckit-`) are different: they are authored by this project's own maintainer, exactly like every other mandatory-bilingual document, and this ADR does not exempt them.

## Decision

`scripts/check-ko-companions.sh` excludes, in addition to `node_modules`/`.git`/`build`/`dist`/`out`:

- `.specify/templates/`, `.specify/scripts/`, `.specify/workflows/`, `.specify/integrations/`, and any other Spec Kit-managed path under `.specify/` except `.specify/memory/` (which stays mandatory)
- any `.claude/skills/speckit-*/` or `.agents/skills/speckit-*/` directory (Spec Kit's own vendored skills)

Every other document — including `.specify/memory/constitution.md`, `specs/<NNN-feature>/*.md`, and any project-specific (non-`speckit-`-prefixed) skill — remains mandatory under `ADR-0004`/`ADR-0005`, unchanged.

## Consequences

### Positive

- The `.ko.md` mandate stays meaningful: it applies to content this project actually authors and can keep accurate, not to upstream boilerplate that changes independently of anything this project does.
- Avoids a translation burden that would be re-invalidated by the next `specify upgrade`, for no reader benefit.

### Costs and risks

- The exclusion list in `scripts/check-ko-companions.sh` must be kept current if Spec Kit's own directory layout changes in a future pinned-version bump (`ADR-0010`).

## Alternatives considered

### Translate vendored Spec Kit templates and skills anyway

Rejected: the content is not this project's to translate meaningfully, and any translation would need re-doing on every version bump — the same objection already accepted for `node_modules`.

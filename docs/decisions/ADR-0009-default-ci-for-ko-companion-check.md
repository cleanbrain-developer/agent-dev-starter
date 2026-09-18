# ADR-0009: Adopting Projects Should Wire the `.ko.md` Check Into Their Own CI by Default

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`ADR-0007` decided the `.ko.md` completeness check would stay a manual script, not wired into CI, until a real adoption showed manual running was insufficient. No such failure has occurred. Instead, the maintainer has expressed a direct preference: projects that adopt this Starter and already run their own CI pipeline should pick up this check automatically, rather than leaving it purely opt-in. This is a preference-driven decision, not a failure-driven one — the same basis already used for `ADR-0004`/`ADR-0005`.

All three currently-adopted projects with an existing CI pipeline (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`) already run a `test` job on every push, before build/deploy. None of them run a fresh checkout on a schedule that would make the script's mtime-based staleness heuristic meaningful — a `git checkout` gives every file close to the same mtime, so comparing English-vs-`.ko.md` mtimes in CI is noise, not signal.

## Decision

Any ADS-adopted project that already has a CI pipeline adds a step running `scripts/check-ko-companions.sh --missing-only` early in its existing `test` job (right after checkout, before language-specific steps), and treats a nonzero exit (a missing companion) as a real CI failure, not a warning. Projects with no CI pipeline at all are unaffected — this does not require adding CI where none exists, and it does not apply to ADS itself (which has no CI). The `--missing-only` flag is required in CI specifically because the staleness heuristic does not survive a fresh checkout; only the missing-companion check is reliable there.

This amends `ADR-0007`'s "not wired into CI" stance for projects that already have a pipeline; `ADR-0007`'s reasoning about not building CI *from scratch* for this alone is unchanged.

## Consequences

### Positive

- A missing `.ko.md` companion is caught automatically on every push, instead of depending on a maintainer or an agent noticing during `agent-behavior.md`'s "Before completion" review.
- No new CI infrastructure for projects that already have a pipeline — one added step, reusing what exists.

### Costs and risks

- Every push that adds or renames a Markdown document without its `.ko.md` companion now fails CI outright, including in the middle of otherwise-unrelated work — this is the intended effect of "mandatory," not a bug.
- Projects must also copy `scripts/check-ko-companions.sh` (or maintain an equivalent) alongside their other adopted foundation files, which was not previously part of "Files to adopt" in `using-the-starter.md`.

## Alternatives considered

### Leave it manual-only, as `ADR-0007` originally decided

Rejected: superseded by the maintainer's explicit preference for default CI adoption, independent of whether manual running had actually failed.

### Make it a non-blocking warning in CI instead of a failing step

Rejected: a warning that nobody has to act on tends to be ignored, which defeats the point of moving from "manual, easy to forget" to "automatic" in the first place.

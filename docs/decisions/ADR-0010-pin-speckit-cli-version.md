# ADR-0010: Pin the Spec Kit CLI Version, Don't Hand-Vendor Its Rendered Output

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

ADS V2 adopts GitHub Spec Kit for the spec/plan/tasks/clarify/analyze/implement workflow instead of ADS's own ad hoc `specs/` convention (see `docs/product/overview.md`'s "ADS V2" section). The maintainer wants every ADS-adopted project to converge on the same Spec Kit CLI version, rather than each adoption installing whatever the latest upstream release happens to be at the time.

Spec Kit's CLI (`specify`) renders its command templates into agent-specific files at `specify init` time — for Claude Code, real `.claude/skills/speckit-*/SKILL.md` files; for Codex, `.agents/skills/speckit-*/SKILL.md`. This session has no working Python/`uv`/`pip` (only a non-functional Windows Store stub `python.exe`), so the CLI cannot actually be run here to generate and verify real output. Hand-writing `SKILL.md` files by reading Spec Kit's raw command-template source (`templates/commands/*.md` in `github/spec-kit`) and guessing at the per-agent rendering would risk shipping subtly broken skill files across every adopted project — exactly the kind of speculative reimplementation `docs/product/overview.md` section 1 says to avoid ("ADS가 독자적인 SDD Framework 자체를 구현하는 방향은 피한다").

## Decision

ADS pins a specific Spec Kit CLI release (recorded in `PROJECT.yaml` and this ADR, updated only via a new ADR when bumped) and documents the exact install command for it. Every adoption runs the real `specify` CLI, at that pinned version, to generate its own `.specify/`, `.claude/skills/`, and/or `.agents/skills/` — ADS does not hand-vendor a guessed copy of that output. This achieves the maintainer's actual goal (version convergence across projects) through the pin, not through ADS reimplementing what the CLI renders.

Pinned version: `specify-cli==1.0.8` (the latest tag as of 2026-09-20; `uv tool install specify-cli==1.0.8`, or `pipx install specify-cli==1.0.8` where `uv` is unavailable).

Bumping the pin is itself a decision: record it in a new ADR (context: what changed upstream; decision: the new pinned version; consequences: which already-adopted projects need to re-run `specify upgrade` and by when), not a silent edit to this one.

## Consequences

### Positive

- Version convergence across every ADS-adopted project, which was the actual goal, without ADS needing to run or fake the CLI.
- No risk of shipping hand-guessed, unverified `SKILL.md` content — every adopted project's Spec Kit files are genuinely CLI-rendered and therefore correct for that CLI version.

### Costs and risks

- ADS cannot verify Spec Kit's exact rendered output itself in a session without a working Python toolchain — adoption guidance here was written from Spec Kit's documented behavior and raw template source, not from having run `specify init` and inspected the result. The first real adoption under this ADR should confirm the guidance matches actual CLI output and report back any mismatch as a normal adoption-feedback gap.
- A pin that goes stale (a project stays on an old version while upstream moves on) needs an active bump decision; nothing forces one automatically.

## Alternatives considered

### Vendor a hand-adapted snapshot of the rendered skills in ADS itself

Rejected: cannot be verified against real CLI output in this environment; the risk of shipping broken skill files outweighs the convenience.

### Leave the version unpinned, let each adoption use whatever `specify` is current

Rejected: this is precisely the version-drift problem the maintainer raised.

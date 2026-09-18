# ADR-0007: First Documentation Rule Promoted to a Deterministic Check

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`architecture/overview.md`'s "Enforcement boundary" has always said rules that must never be violated should eventually be promoted to deterministic gates, but named no candidate or order. `docs/status/current-state.md` carried this as an open decision. Most ADS rules require judgment (is a change "minimal and coherent," does a principle "genuinely" get followed) and resist mechanical checking. `ADR-0005`'s Korean-companion cascade rule is the exception: "does a `.ko.md` file exist for every `.md` file" is completely mechanical, has no judgment call, and already has four real adoptions' worth of files to check it against.

## Decision

The `.ko.md` companion-completeness rule from `ADR-0005` is the first rule promoted to a deterministic check, ahead of any other candidate. A script, `scripts/check-ko-companions.sh`, is added to this repository: for every `.md` file (excluding `.ko.md` files themselves and non-Markdown files like `PROJECT.yaml`), it reports whether a `.ko.md` companion is missing, and separately flags a companion whose file modification time is older than its English original as *possibly* stale (a heuristic, not a proof — a touched-but-meaning-unchanged file will false-positive, and the script does not attempt to judge whether a companion is actually out of sync).

This script is not wired into CI and is not a required step in `using-the-starter.md`. It is available for a maintainer (human or agent) to run by hand in any ADS-adopted project. Adding a CI pipeline that runs it automatically remains out of scope (`docs/product/scope.md`) until a real adoption shows manual running is not enough — this decision only answers "which rule would go first," not "build the pipeline now."

## Consequences

### Positive

- Answers the "which rule first" question with the rule that was already the easiest, evidence-backed candidate, rather than leaving it open indefinitely.
- Gives the maintainer an actual tool today, without committing to CI infrastructure the project has no evidence it needs yet.

### Costs and risks

- The staleness heuristic (mtime comparison) is weak: it does not survive a `git clone` (which resets mtimes) or a reformatting-only touch. Treat its "possibly stale" output as a prompt to look, not a verdict.
- The script itself now needs to be kept correct as the repository's file layout evolves — a small, accepted maintenance surface.

## Alternatives considered

### Wire the check into a CI workflow now

Rejected: no adopted project has reported a `.ko.md` drifting out of sync badly enough to need automated enforcement yet; this would be exactly the kind of speculative automation `ADR-0002` already rejected once for a different problem.

### Promote a judgment-heavy rule instead (e.g. "single responsibility")

Rejected: rules requiring judgment about meaning are not good first candidates for deterministic enforcement — they need a human or an agent's understanding, not a mechanical check, and forcing one now would produce false confidence.

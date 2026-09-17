# ADR-0005: Korean Companions Are Mandatory and Cascade With Every Edit

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

`ADR-0004` introduced a `.ko.md` companion convention but left two things soft: (1) each adopting project independently chose, during "Review the constitution," whether to keep the convention at all; (2) updating a `.ko.md` companion when its English original changed was "expected but not required in the same change," an accepted lag rather than a defect.

The maintainer has since decided both are too soft: every ADS-adopted project should apply Korean companions to every document without exception, and the companion should move in lockstep with its English original rather than being allowed to drift.

## Decision

1. **Mandatory, not optional.** Every project that adopts Agent Development Starter creates a `.ko.md` companion for every Markdown document it adopts or authors, with no per-project opt-out. This is no longer a choice reviewed during "Review the constitution" (`using-the-starter.md`, step 4) — it is part of the adopted foundation itself, the same way the responsibility-separated directory structure is not optional.
2. **Cascade, not a lag.** Whenever an English document changes in a way that affects its meaning (not a pure formatting fix), its `.ko.md` companion is updated in the same change. Treat this exactly like `documentation-policy.md`'s existing "Maintenance" rule ("If a code or structure change makes documentation false, update the documentation in the same change") — a `.ko.md` that has drifted out of sync with its English original is now a defect to fix, not an accepted lag to tolerate.
3. **English remains canonical.** `ADR-0004`'s core decision is not reversed: agent bootstrap still reads only the English file, and English still governs if the two ever disagree. Cascade is a maintenance discipline on the maintainer-facing companion, not a change to which file has authority.
4. **Scope.** This applies retroactively to every already-adopted project (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`) and to every future adoption, and to Agent Development Starter itself.

## Consequences

### Positive

- The Korean companion can be trusted at any point in time to reflect the current English meaning, not a stale snapshot.
- Removes the ambiguity of "when should I get around to updating the translation" — the answer is always "in this change."

### Costs and risks

- Doubles the diff size of every future documentation-touching change, in every adopted project, permanently.
- Raises the chance a change is slowed down or left half-done because two files need editing where one used to be enough — this is an accepted cost, not an oversight.
- No deterministic check enforces this yet (see `architecture/overview.md`, "Enforcement boundary"); until one exists, it depends on `agent-behavior.md`'s "Before completion" discipline.

## Alternatives considered

### Keep `ADR-0004`'s "expected but not required" (status quo)

Rejected: the maintainer explicitly asked for a stronger guarantee than an accepted lag provides.

### Periodic or batched translation sync instead of per-change cascade

Rejected: reintroduces exactly the drift window the maintainer wants removed, just on a schedule instead of indefinitely.

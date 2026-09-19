# ADR-0013: Merge `.ai/constitution/engineering-principles.md` and `agent-behavior.md`

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

ADS V2 adopts GitHub Spec Kit, which owns `.specify/memory/constitution.md` for exactly the role `.ai/constitution/engineering-principles.md` was already playing: durable principles a project's work is evaluated against. Separately, `ADR-0011` makes `AGENTS.md` the sole adapter and has it absorb behavioral instructions directly, which is what `.ai/constitution/agent-behavior.md` held. Keeping both old files after adopting Spec Kit and the `AGENTS.md`-only model would mean the same two responsibilities exist in two places each — exactly the duplication `documentation-policy.md`'s "Single responsibility" rule already forbids.

## Decision

- `.ai/constitution/engineering-principles.md`'s content is merged into `.specify/memory/constitution.md` and the old file is removed. Project-specific principles that were mixed into `PROJECT.yaml`'s `principles` field per the rule from `ADR-0006`-era guidance now get their prose definitions in `.specify/memory/constitution.md` instead.
- `.ai/constitution/agent-behavior.md`'s content is merged directly into `AGENTS.md` and the old file is removed.
- `.ai/constitution/documentation-policy.md` is unaffected — no open standard owns document ownership or the `.ko.md` language policy, so it stays exactly where it is.

## Consequences

### Positive

- Each responsibility (durable principles, agent behavior contract, documentation policy) now has exactly one home, and two of those three homes are standard locations an open-source tool or a new agent already knows to look for, instead of an ADS-invented path.

### Costs and risks

- Every already-adopted project must perform this merge during its own V2 migration — this is not backward compatible with the V1 file layout, by design (see `docs/status/current-state.md`'s V2 migration record).

## Alternatives considered

### Keep the old files as thin pointers to the new locations

Rejected: adds indirection with no benefit — an agent's bootstrap order can point straight at `.specify/memory/constitution.md` and `AGENTS.md` without an intermediate hop.

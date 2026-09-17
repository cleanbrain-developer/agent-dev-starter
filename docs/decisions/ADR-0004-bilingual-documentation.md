# ADR-0004: Bilingual Documentation (English Canonical, Korean Companion)

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

On 2026-08-27, this repository standardized all persistent documentation in English (see `docs/status/current-state.md`'s history). The maintainer has since asked for a Korean version of every document, including agent-facing ones (`.ai/constitution/`, `docs/architecture/`, `docs/decisions/`), not only human-entry documents like `README.md`.

This creates a real tension with `documentation-policy.md`'s "Do not duplicate the same policy across files" and with `engineering-principles.md`'s "minimal, coherent change": a second language version of every document doubles the surface that must be kept in sync on every future edit, and doubles what an adopting project copies during adoption — the opposite direction from `ADR-0002`'s finding that content adaptation, not file count, is the real adoption cost.

## Decision

Add a Korean translation alongside every Markdown document, as a separate file using the `.ko.md` suffix (for example `README.md` + `README.ko.md`), for every document in the repository including agent-facing ones. `PROJECT.yaml` is excluded: it is machine-read structured data with minimal prose, not a document meant to be read for its language, and a second YAML file would risk the two drifting into actually different data rather than just different wording — a worse failure mode than a stale translation.

English remains canonical for every pair:

- The bootstrap order in `agent-context-model.md` and both agent adapters reads the English file only. Agent bootstrap never reads a `.ko.md` file — this keeps agent context recovery at its current cost instead of doubling it, and avoids requiring a translation to be updated before an agent can act correctly.
- Every `.ko.md` file opens with a one-line note pointing back at its English original and stating that English governs on any conflict.
- When an English document changes, updating its `.ko.md` companion is expected but not required in the same change; a stale translation is a known, accepted lag, not a broken bootstrap the way a stale `current-state.md` is (see `agent-context-model.md`, "Working context") — because agents never depend on it.

Adopting projects decide independently, during their own adoption (`docs/guides/using-the-starter.md`, step 4, "Review the constitution"), whether to keep this convention; it is not made mandatory for them.

## Consequences

### Positive

- The maintainer can read every document in Korean without waiting on or blocking agent work, which continues to run on the English canonical version.
- The convention is explicit about which file wins, avoiding the ambiguity of "which language is authoritative" that an undocumented bilingual setup would create.

### Costs and risks

- Every document now has two files to maintain; keeping `.ko.md` companions from drifting far out of date is an ongoing, unenforced cost (no deterministic check exists yet — see `architecture/overview.md`, "Enforcement boundary").
- `PROJECT.yaml`'s asymmetry (no Korean companion) must stay understood as deliberate scope, not an oversight, so it does not get "fixed" into a bilingual pair later without revisiting this ADR.

## Alternatives considered

### A single bilingual file per document (English and Korean sections in one file)

Rejected: doubles what an agent reads on every bootstrap step even when it only reads the English section, since a language-scoped section cannot be selectively loaded from a single file. This costs the same for agents as a fully bilingual bootstrap, without the benefit of a translation being clearly separable or optional.

### Korean only, no English canonical

Rejected: would abandon the 2026-08-27 decision to standardize on one language, and would work against `supported_agents.policy: agent-agnostic-core` if a future supported agent's tooling or ecosystem defaults to English.

### Machine translation on demand, no stored `.ko.md` files

Rejected for now: produces no durable, reviewable Korean text in the repository itself, and reintroduces a dependency on an external process at read time rather than the repository being self-describing on its own. Revisit if maintaining stored translations proves too costly in practice.

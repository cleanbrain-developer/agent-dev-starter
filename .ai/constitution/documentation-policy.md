# Documentation Policy

## Authority

> Conversation is temporary. The repository is authoritative.

Conversations and external links may be discovery or bootstrap inputs, but they are not long-term dependencies. A durable agreement is not complete until it has been persisted in the repository.

## Single responsibility

- Project identity, structured phase, and pinned standard versions: `PROJECT.yaml`
- The sole agent entry point and behavioral contract: `AGENTS.md` (`ADR-0011`)
- Durable engineering principles: `.specify/memory/constitution.md` (`ADR-0013`)
- Document ownership and language policy: `.ai/constitution/documentation-policy.md` — the one policy area no open standard owns
- Project-level product purpose, goals, and scope: `docs/product/`
- Persistent structure and context model: `docs/architecture/`
- Feature-level requirements, technical approach, and execution plan: `specs/<NNN-feature>/{spec,plan,tasks}.md` (GitHub Spec Kit)
- Reusable agent procedures: `.claude/skills/`, `.agents/skills/` (`ADR-0012`)
- Operational adoption procedures: `docs/guides/`
- Significant decisions and rationale: `docs/decisions/`
- Current project-wide progress, next work, and open decisions: `docs/status/current-state.md`

Do not duplicate the same policy across files. When a summary is useful, link to the authoritative path.

## Decision records

Record choices with long-term impact, such as architecture, compatibility, and distribution strategy, in an ADR. An ADR must include context, decision, consequences, and status. An accepted ADR remains effective until another ADR supersedes it.

## Status hygiene

`current-state.md` is not a meeting log or a complete changelog. Keep only the completed work, work in progress, next actions, and open decisions required to reconstruct the current phase.

## Maintenance

If a code or structure change makes documentation false, update the documentation in the same change. Remove stale guidance; use ADRs or version control when history must be preserved.

## Language

Every Markdown document has a Korean companion using the `.ko.md` suffix — mandatory, not optional, for every ADS-adopted project (see `ADR-0004`, `ADR-0005`). English is canonical: agent bootstrap reads only the English file, and English governs if the two ever disagree. `PROJECT.yaml` has no Korean companion — it is structured data, not prose. When an English document's meaning changes, update its `.ko.md` companion in the same change — this is the same discipline as "Maintenance" above, not a separate, lower-priority task.

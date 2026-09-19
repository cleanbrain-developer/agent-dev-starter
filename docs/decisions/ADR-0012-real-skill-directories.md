# ADR-0012: Skills Live at the Directories Agents Actually Discover

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

`ADR-0003` correctly decided skills are a per-project extension point, not a shared ADS library, populated by asking the maintainer rather than invented. It named the directory `.ai/skills/` for this. No agent tool actually discovers that path automatically: Claude Code discovers `.claude/skills/`, and Codex (and several other Spec Kit integrations) discover `.agents/skills/`. `.ai/skills/` was invented by analogy to `.ai/constitution/` without checking what agents actually read, so a skill placed there would sit unused by any agent's automatic discovery.

This surfaced while integrating GitHub Spec Kit, whose own workflow commands are themselves delivered as skills at these same real paths (`.claude/skills/speckit-*/SKILL.md`, `.agents/skills/speckit-*/SKILL.md`) — see `docs/product/overview.md`'s "ADS V2" section and `ADR-0010`.

## Decision

Per-project skills live at `.claude/skills/<name>/SKILL.md` for Claude Code and `.agents/skills/<name>/SKILL.md` for Codex — whichever directory(ies) match that project's `supported_agents.initial` — never at `.ai/skills/`. When a project supports both agents and a skill applies to both, keep one skill's content in one place and have the other agent's directory reference or mirror it rather than maintaining two independently-drifting copies; if the two agents' skill formats genuinely diverge, that divergence itself is worth a short note in the skill file, not silent duplication.

`ADR-0003`'s actual decision — skills are per-project, elicited from the maintainer, never invented or copied wholesale between projects — is unchanged. Only the directory was wrong.

## Consequences

### Positive

- A skill placed following this ADR is one an agent's own harness will actually find and load, instead of inert content nobody's tooling reads.
- Aligns ADS with the same paths Spec Kit's own integration already uses, so a project's own custom skills sit naturally alongside `speckit-*` skills in the same directory.

### Costs and risks

- Any project that already created a `.ai/skills/` directory following the original `ADR-0003` wording needs to move its content to the correct path(s) as part of adopting this ADR.

## Alternatives considered

### Keep `.ai/skills/` as a project-level index that points into the real per-agent directories

Rejected: adds an indirection layer for no real benefit — a skill's actual home is wherever the agent looks, and pointing at it from a third location is one more place to keep in sync for nothing gained.

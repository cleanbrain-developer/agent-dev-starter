# Scope

## V1 in scope

- `PROJECT.yaml` for project identity and the current phase
- Thin entry adapters for Codex and Claude Code
- Shared engineering, agent behavior, and documentation principles
- Separate product, architecture, guide, decision, and status responsibilities
- An initial ADR that preserves the repository-first decision
- A status document that restores current working context
- Manual context bootstrap acceptance criteria
- A manual procedure for adopting the Starter in another repository

## V1 out of scope

- An executable CLI or initializer
- Automated project file generation
- GitHub template distribution configuration
- `.ai/skills/` and agent-specific skill synchronization
- Technology or framework presets
- Application source code
- Build, test, lint, or CI pipelines
- A plugin ecosystem and distribution strategy
- A complete validation schema for `PROJECT.yaml`

## Permanently discarded, not deferred

`ADR-0002` and `ADR-0003` promote four of the items above from "deferred for V1" to permanently out of scope, based on evidence from three real adoptions (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`): an executable CLI or initializer, automated project file generation, GitHub template distribution configuration, and a shared `.ai/skills/` library distributed from this repository. The manual, agent-driven procedure in `docs/guides/using-the-starter.md` remains the only supported adoption path. Skills remain a per-project extension point — an adopting project may define its own `.ai/skills/`, populated by asking its own maintainer — but ADS itself will not define, host, or synchronize one.

## Scope rule

Consider out-of-scope items only enough to avoid blocking future extension. Do not add placeholder directories, speculative abstractions, or unused scripts in V1.

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

## Scope rule

Consider out-of-scope items only enough to avoid blocking future extension. Do not add placeholder directories, speculative abstractions, or unused scripts in V1.

# ADR-0001: Repository-First Context

- Status: Accepted
- Date: 2026-08-26
- Deciders: Project maintainers

## Context

When an AI coding workflow depends on a large initialization prompt and previous conversations, project intent, design rationale, and working state are lost when the session or agent changes. Duplicating all context in agent-specific instruction files causes drift and binds core knowledge to particular tools.

The project must allow concise, flexible task prompts while ensuring that outcomes follow shared engineering principles and architecture. An external conversation used during initial bootstrap cannot be assumed to remain available.

## Decision

Use the repository as the authoritative source of persistent project context.

- Structure project identity in `PROJECT.yaml`.
- Store durable principles in `.ai/constitution/`.
- Store product and architecture explanations under `docs/`.
- Store significant decisions and rationale in ADRs.
- Store working state in `docs/status/current-state.md`.
- Keep `AGENTS.md` and `CLAUDE.md` as thin agent-specific adapters that load the shared core.
- Remove external conversations and bootstrap prompts from long-term dependencies after their decisions have been persisted in the repository.

## Consequences

### Positive

- New sessions and different agents can continue work without previous conversations.
- Shared policy has one source, reducing adapter drift.
- Decisions, working state, and task prompts have separate lifetimes and responsibilities.
- Future templates, CLIs, skills, and quality gates can evolve from a stable specification.

### Costs and risks

- Code and documentation must be maintained together.
- An agent that ignores the bootstrap order may miss important context.
- Markdown rules cannot guarantee compliance, so deterministic gates will be needed later.
- The `PROJECT.yaml` schema and adapter distribution method require further decisions.

## Alternatives considered

### Large reusable initialization prompt

This is easy to start but creates oversized prompts and dependencies on conversations and tools. It was rejected.

### Agent-specific documents as independent sources

This makes tool-specific optimization easy but creates policy duplication and drift. It was rejected.

### CLI-first implementation

The specification is not yet stable enough to automate, so this alternative was deferred beyond V1.

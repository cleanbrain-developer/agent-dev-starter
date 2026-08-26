# Claude Code Project Adapter

This file is the repository entry adapter for Claude Code. It is not the source of truth for shared policy or project design; it routes Claude Code to the repository context below.

## Required context

Before starting work, read the following in order:

1. `PROJECT.yaml`
2. `.ai/constitution/engineering-principles.md`
3. `.ai/constitution/agent-behavior.md`
4. `.ai/constitution/documentation-policy.md`
5. Relevant documents under `docs/product/`
6. Relevant documents under `docs/architecture/`
7. Relevant ADRs under `docs/decisions/`
8. `docs/status/current-state.md`
9. Repository files relevant to the current request

## Working contract

- Inspect existing evidence and prepare a change plan.
- Implement the smallest coherent change, verify it, and review the final diff.
- Do not leave architectural decisions or durable state only in conversation history.
- Add shared rules to the appropriate constitution or documentation source, not to this adapter.
- Make unresolved conflicts and open decisions explicit instead of silently fixing them through assumptions.

Use `docs/status/current-state.md` as the source of truth for the current phase and next work.

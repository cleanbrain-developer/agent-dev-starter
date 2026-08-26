# Codex Project Adapter

This file is the repository entry point for Codex-compatible agents. Do not duplicate project policy or design here. The shared sources of truth are listed below.

## Context bootstrap

Before starting work, read the following in order:

1. `PROJECT.yaml`
2. Every document under `.ai/constitution/`
3. Every document under `docs/product/`
4. Every document under `docs/architecture/`
5. ADRs under `docs/decisions/` that are relevant to the current work
6. `docs/status/current-state.md`
7. Repository files relevant to the current request

If documents conflict, prefer the more specific accepted ADR. If the conflict remains unresolved, report it instead of implementing an arbitrary interpretation.

## Working contract

- Inspect repository evidence before planning or changing anything.
- Prefer the smallest coherent change that satisfies the request.
- Never change architecture silently. Record significant decisions in an ADR.
- Perform available verification before claiming completion, and distinguish verified results from unverified items.
- Persist durable decisions and working-state changes in the correct source of truth within the same change.
- Do not treat conversation history or this adapter as a long-term design source.

Always use `docs/status/current-state.md` as the source of truth for the current phase and next work.

# ADR-0008: Verifying Adapter Compatibility for a New Supported Agent

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

`docs/status/current-state.md` carried an open decision on how adapter compatibility should be verified as supported agents expand beyond Codex and Claude Code. No third agent has been added yet in any of the four real adoptions, so this has never been exercised, but the question was left open rather than answered.

## Decision

Adding a new agent to `supported_agents.initial` (in `PROJECT.yaml`, for ADS itself or any adopted project) is not considered complete until the bootstrap acceptance test (`agent-context-model.md`, "Bootstrap acceptance test") passes starting from that new agent's own entry adapter, the same way it is already required for Codex and Claude Code in `using-the-starter.md`, "Run the bootstrap acceptance test." No agent-specific test variant is needed: the test itself (answer the five acceptance questions in `docs/product/goals.md`, "Success criteria," grounded in repository paths) is already agent-agnostic by design (`agent-agnostic-core` principle) — the only new work is writing that agent's thin entry adapter and running the existing test through it.

## Consequences

### Positive

- No new verification mechanism to design or maintain; reuses a test already proven across two agents and four real adoptions.
- Keeps the `agent-agnostic-core` principle concrete: if the same test cannot pass through a new adapter, the adapter is not thin enough or is missing a routing step, which is exactly what the test is already designed to catch.

### Costs and risks

- If a future agent's tooling has structurally different bootstrap needs (for example, no equivalent of reading a single entry file first), this answer may not transfer cleanly and would need revisiting with a new ADR at that time.

## Alternatives considered

### A separate compatibility checklist per agent

Rejected: would duplicate what the bootstrap acceptance test already verifies, and drift from it over time — the same duplication `ADR-0001`'s core decision already argues against.

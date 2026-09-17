# ADR-0003: Skills Are Per-Project, Not a Shared ADS Concept

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

`.ai/skills/` and "reusable workflow skills" appeared on the long-term roadmap in `docs/product/goals.md`, and `docs/status/current-state.md` carried an open decision on the canonical location of shared skills and how they would be distributed to Claude Code and Codex discovery paths. Across the three real adoptions to date — `cleanbrain-me-entrance` (a landing page), `cleanbrain-me-developer` (a portfolio and live monitoring dashboard), and `relayhub-java` (an event-integration platform) — the adopted services are different enough in purpose that no common, reusable workflow has emerged. A shared skill defined now would either be so generic it adds no value, or be shaped by one project's workflow and forced onto services it was not designed for.

## Decision

Skills are not a shared ADS concept. ADS does not define, host, or synchronize a skill library across adopting projects. Each adopting project may define its own `.ai/skills/` (or equivalent) if and when it needs one, populated by the agent asking that project's maintainer directly what repeatable workflow needs detailing. An agent must not invent a skill's content on its own, and must not copy a skill from one adopted project into another without the maintainer's explicit direction — a skill that looks reusable across two projects is evidence worth raising to the maintainer, not something to silently generalize into ADS's shared core.

## Consequences

### Positive

- Avoids a shared abstraction with no real usage evidence behind it, consistent with the `evidence-before-change` and `minimal, coherent change` principles.
- Keeps each project's skills honestly specific to how that project's maintainer actually works, rather than shaped to fit a hypothetical common case.

### Costs and risks

- If a genuinely common workflow does emerge across multiple adopted projects later, promoting it into ADS's shared core will need its own ADR at that time; this decision does not preclude that.
- Every adopting project pays the cost of defining its own skills from scratch if it wants them, with no shared starting point.

## Alternatives considered

### A shared `.ai/skills/` library distributed from ADS

Rejected: no real adoption to date has produced a reusable skill; defining one now would mean inventing content without a maintainer's real workflow behind it, which the adoption guide already forbids for product and architecture content.

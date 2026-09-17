# ADR-0002: Reference-Only Distribution (No Template Repository or CLI)

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

ADR-0001 deferred a CLI-first implementation, and `docs/status/current-state.md` carried an open decision on whether a GitHub template repository should become the primary V2 distribution method, pending real adoption evidence. Agent Development Starter has since been adopted three times — `cleanbrain-me-entrance`, `cleanbrain-me-developer`, and `relayhub-java` — using the manual, agent-driven procedure in `docs/guides/using-the-starter.md`. In every case, the repeated effort was writing project-specific content (`PROJECT.yaml` identity and purpose, `docs/product/`, `docs/architecture/`, and each project's own additions to `.ai/constitution/engineering-principles.md`), not copying the foundation files, which took minutes and needed no tooling.

## Decision

Agent Development Starter remains a manually-referenced specification, permanently, not only for the V1 phase. A copy-and-adapt template repository and a CLI/initializer are discarded from the roadmap, not merely deferred: they would optimize the file-copy step, which the three real adoptions show is not the bottleneck. Adoption continues via `docs/guides/using-the-starter.md`, performed by a human directly or driven conversationally by an AI agent from the maintainer's natural-language project description.

## Consequences

### Positive

- No investment in distribution tooling that would not address the actual observed friction.
- The specification stays simple to inspect, fork by hand, and diverge from per project, without a generator to keep in sync as the specification itself evolves.

### Costs and risks

- Each adoption still requires manually copying a fixed set of files; this remains a small, accepted cost.
- If a future adoption reveals that copying — not content adaptation — has become the actual bottleneck, this decision should be revisited with an ADR that supersedes this one.

## Alternatives considered

### GitHub template repository

Would reduce the file-copy step to a few clicks. Rejected: copying was never the observed bottleneck across three real adoptions; the real cost is writing product and architecture content, which a template does not reduce.

### CLI/initializer

Would automate copying and possibly some scaffolding. Rejected for the same reason, and because the specification's actual content (product, architecture, principles) is inherently project-specific and cannot be mechanically generated without inventing content, which the adoption guide already forbids.

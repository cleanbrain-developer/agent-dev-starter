# Goals

## Goals

1. Make the repository a self-describing project memory.
2. Prefer an open standard over an ADS-invented mechanism whenever one already solves the problem (`AGENTS.md`, GitHub Spec Kit, Agent Skills) — build only the opinion layer a standard doesn't cover.
3. Give every supported agent a consistent order for reading the same shared sources, from a single entry adapter.
4. Allow a new session to recover the project and its next work within five minutes, without an external conversation.
5. Dogfood the model in the Starter repository itself.
6. Provide a manual, testable adoption procedure. Automation was evaluated against real adoption evidence and permanently discarded, not merely deferred — see `ADR-0002`.

## Success criteria

Bootstrap succeeds when a new agent session starts from `AGENTS.md`, without a shared conversation link, and accurately answers:

- What is this project?
- Why does it exist?
- What are its core principles and architecture?
- What has been completed?
- What is the active feature, if any, and what should happen next?
- Where is the Korean companion for each major canonical document?

Every answer must be traceable to repository documentation and must not depend on design duplicated in an agent adapter.

## Long-term direction

Real adoption across four cleanbrain.me services (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`) validated the original repository specification and settled several roadmap questions:

- This repository stays a manually-referenced specification, permanently. A copy-and-adapt template repository and an ADS-specific CLI/initializer are discarded, not deferred — see `ADR-0002`. The friction observed in practice is per-project content adaptation (product, architecture, and principles specific to each service), which a copy mechanism does not reduce.
- Reusable workflow skills are not a shared ADS concept — see `ADR-0003`. Each adopting project may define its own skill, populated by the agent asking that project's maintainer directly what repeatable workflow needs detailing, never invented or copied from another project — now placed at the directory the relevant agent actually discovers (`ADR-0012`), not an ADS-invented path.
- ADS itself moved from reimplementing spec/plan/tasks conventions to adopting GitHub Spec Kit, and from two parallel agent adapters to one (`AGENTS.md`), once Claude Code's own native `AGENTS.md` support removed the last reason to keep `CLAUDE.md` (`ADR-0011`). The recurring lesson across `ADR-0002`, `ADR-0006`, and this migration is the same: check whether an open standard already solves it before building an ADS-specific mechanism.

Technology presets and a plugin ecosystem remain unconsidered; no adoption evidence to date supports or rules them out, and neither is scheduled.

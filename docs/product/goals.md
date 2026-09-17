# Goals

## V1 goals

1. Make the repository a self-describing project memory.
2. Separate the responsibilities of human guidance, structured data, agent adapters, shared policy, design, decisions, and working state.
3. Give Codex and Claude Code a consistent order for reading the same shared sources.
4. Allow a new session to recover the project and its next work within five minutes, without an external conversation.
5. Dogfood the model in the Starter repository itself.
6. Provide a manual, testable adoption procedure. Automation was evaluated against real adoption evidence and permanently discarded, not merely deferred — see `ADR-0002`.

## Success criteria

The V1 bootstrap succeeds when a new agent session starts from `AGENTS.md` or `CLAUDE.md`, without a shared conversation link, and accurately answers:

- What is this project?
- Why does it exist?
- What are its core principles and architecture?
- What has been completed?
- What should happen next?

Every answer must be traceable to repository documentation and must not depend on design duplicated in an agent adapter.

## Long-term direction

Real adoption across four cleanbrain.me services (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`) validated the repository specification itself and settled two roadmap questions that were previously open:

- This repository stays a manually-referenced specification, permanently. A copy-and-adapt template repository and a CLI/initializer are discarded, not deferred — see `ADR-0002`. The friction observed in practice is per-project content adaptation (product, architecture, and principles specific to each service), which a copy mechanism does not reduce.
- Reusable workflow skills are not a shared ADS concept — see `ADR-0003`. Each adopting project may define its own `.ai/skills/`, populated by the agent asking that project's maintainer directly what repeatable workflow needs detailing, never invented or copied from another project.

Technology presets and a plugin ecosystem remain unconsidered; no adoption evidence to date supports or rules them out, and neither is scheduled.

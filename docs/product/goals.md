# Goals

## V1 goals

1. Make the repository a self-describing project memory.
2. Separate the responsibilities of human guidance, structured data, agent adapters, shared policy, design, decisions, and working state.
3. Give Codex and Claude Code a consistent order for reading the same shared sources.
4. Allow a new session to recover the project and its next work within five minutes, without an external conversation.
5. Dogfood the model in the Starter repository itself.
6. Provide a manual, testable adoption procedure before automating project generation.

## Success criteria

The V1 bootstrap succeeds when a new agent session starts from `AGENTS.md` or `CLAUDE.md`, without a shared conversation link, and accurately answers:

- What is this project?
- Why does it exist?
- What are its core principles and architecture?
- What has been completed?
- What should happen next?

Every answer must be traceable to repository documentation and must not depend on design duplicated in an agent adapter.

## Long-term direction

The project may evolve from the validated specification in this order:

1. Repository specification
2. Template repository
3. Reusable workflow skills
4. Interactive initializer or CLI
5. Technology presets and plugin ecosystem

This sequence is a direction, not a V1 implementation commitment.

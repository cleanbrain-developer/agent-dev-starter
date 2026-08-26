# Current State

Last updated: 2026-08-27

## Current phase

V1 Foundation — establish and validate the minimum specification that allows the repository to explain its purpose, principles, structure, and state without external conversation history.

## Completed

- Finalized the repository name `agent-dev-starter` and product name Agent Development Starter.
- Adopted repository-first context and an agent-agnostic core.
- Selected Codex and Claude Code as the initial supported agents.
- Separated the responsibilities of the human entry point, structured manifest, agent adapters, constitution, product, architecture, guides, ADRs, and working state.
- Created the V1 directory structure and core documents.
- Persisted the repository-first context decision in ADR-0001.
- Excluded the CLI, skills, templates, presets, and CI from the V1 foundation.
- Initialized the Git repository and connected it to GitHub.
- Standardized all persistent repository documentation in English.
- Added a manual adoption guide for using the Starter in another project.

## In progress

- Run context bootstrap acceptance tests in fresh Codex and Claude Code sessions.
- Review the English documentation for duplication, omissions, and contradictions.

## Next

1. Validate the `AGENTS.md` and `CLAUDE.md` bootstraps independently in fresh sessions without a shared conversation.
2. Use the results to adjust document discovery order and minimum required context.
3. Validate the manual adoption guide against the first derived project.
4. Decide the required fields and validation level for the V1 `PROJECT.yaml` schema.
5. Define the minimum plan, verify, and review skill specifications only after repeated workflows have been observed.

## Open decisions

- Whether `PROJECT.yaml` remains a simple manifest or receives a separate machine-validatable schema
- The canonical location of shared skills and how they are distributed to Claude Code and Codex discovery paths
- Whether a GitHub template repository becomes the primary V2 distribution method
- The criteria for introducing a CLI, its implementation language, and command name
- Which documentation rules should be promoted first to tests, linting, or CI
- How adapter compatibility should be verified as supported agents expand

## Known constraints

- There is no application code, test suite, build system, CLI, or automation yet.
- The initial design conversation was used only as bootstrap evidence and is not required context for future sessions.
- Adoption is manual until a later distribution mechanism is accepted and implemented.

## V1 exit criteria

- A new agent session accurately recovers the project purpose, principles, architecture, current state, and next work without an external link.
- All durable evidence for that answer exists in the repository.
- Shared design is not duplicated in agent adapters.
- Another project can adopt the foundation by following the manual guide without relying on undocumented conversation context.

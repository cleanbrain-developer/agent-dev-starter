# Current State

Last updated: 2026-09-12

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
- Ran the context bootstrap acceptance test in independent, fresh Codex-style and Claude Code-style sessions (2026-08-27). Both correctly answered all five acceptance questions with citations to repository paths and no fabricated content. The test surfaced one real routing gap: `docs/guides/` was never included in `AGENTS.md`, `CLAUDE.md`, or `docs/architecture/agent-context-model.md`'s bootstrap order, so a fresh session could not discover the adoption guide. Fixed by adding a `docs/guides/` step to all three.
- Resolved the duplication the 2026-08-27 acceptance test flagged (2026-09-09): `AGENTS.md` and `CLAUDE.md` no longer restate the bootstrap order — both now point to `docs/architecture/agent-context-model.md`, the single source of truth for the reading sequence and conflict-handling rules. `docs/product/goals.md` ("Success criteria") is now the single canonical wording of the five acceptance-test questions; `docs/product/overview.md` and `agent-context-model.md` reference it instead of restating their own phrasing.
- Documented agent-driven adoption in `docs/guides/using-the-starter.md` (2026-09-09): added a "Who performs the adoption" section and marked each step in "Adapt the repository in this order" as agent-fillable from the maintainer's natural-language service description versus requiring the maintainer's own judgment, so an agent can drive the full procedure conversationally and stop only where human input is actually required. Added an explicit rule that Git repository/remote creation and the first push need the maintainer's separate confirmation, and a matching checklist item. This came from a pre-adoption design discussion, not from a completed adoption, so it was unvalidated against a real run until the next item.
- Ran the first real external adoption of the agent-driven procedure against `cleanbrain-me-entrance` (2026-09-09), including a mid-adoption restart (renamed from an earlier attempt, with the prior local directory and GitHub repo discarded). The agent-fillable/(human input required) split and the bootstrap acceptance test both worked as intended. The run surfaced four real gaps, now fixed in `using-the-starter.md`: (1) "New project" mode did not warn that `PROJECT.yaml`'s `delivery`/`lifecycle` fields get set pre-implementation and must be revisited right after the first implementation lands — added that expectation plus a rule to record it as a `Next` item during adoption itself; (2) the bootstrap acceptance test did not say whether a clean session could be a subagent the adopting agent spawns itself, as opposed to a human-opened session — clarified that isolation from the setup conversation is what matters, not who opens the session; (3) whether to create `AGENTS.md` and/or `CLAUDE.md` was still implicit in "Files to adopt," forcing an extra clarifying question each time — tied adapter-file creation directly to `supported_agents.initial`; (4) discarding and restarting an adoption attempt (renaming, or recovering from an incorrect first attempt) had no guidance and no confirmation rule of its own — added a "Restarting or discarding an adoption attempt" section that routes it back through New/Existing project mode and requires the same explicit confirmation as repo/remote creation before deleting a local directory or remote repo.
- Fed back real friction from `relayhub-java`'s adoption after several weeks of sustained, iterative maintainer-driven development on top of it, not just an initial bootstrap (2026-09-12). Its own `docs/status/current-state.md` had gone stale by one full day and 23 commits' worth of shipped, verified, production-deployed work (a full new feature — a field-mapping registry with its own REST API and frontend CRUD — plus several smaller ones) with no session boundary ever prompting an update, because the maintainer kept issuing small follow-up requests within one continuous session rather than starting new ones. One of its own per-feature `specs/<feature>/spec.md` documents was found still marked "Design only" after that same feature had shipped to production. Three concrete fixes: (1) `agent-context-model.md`'s "Working context" now explicitly covers per-feature design documents' own status markers, not only `current-state.md`, and names a stale one a defect rather than a historical artifact; (2) `using-the-starter.md`'s "Begin project work" step 5 now says the update trigger is "a shipped, verified change," not "a session boundary" — a long session that never pauses is exactly the case that was previously unhandled; (3) `.ai/constitution/engineering-principles.md`'s "Verifiable outcomes" now distinguishes a green automated check (evidence about the code) from direct verification against the real running system (evidence about reality) — `relayhub-java` had caught several real defects only the second way (a broadcast that was internally consistent but produced a value that didn't match the database, a config value only wrong in the deployed environment, a code path no test happened to call).

## In progress

- None currently. See Next.

## Next

1. Continue the `cleanbrain-me-entrance` adoption to completion (it is the first derived project, not yet finished) and watch for further gaps beyond the four already fixed.
2. Decide the required fields and validation level for the V1 `PROJECT.yaml` schema.
3. Define the minimum plan, verify, and review skill specifications only after repeated workflows have been observed.

## Open decisions

- Whether `PROJECT.yaml` remains a simple manifest or receives a separate machine-validatable schema
- The canonical location of shared skills and how they are distributed to Claude Code and Codex discovery paths
- Whether a GitHub template repository becomes the primary V2 distribution method
- The criteria for introducing a CLI, its implementation language, and command name
- Which documentation rules should be promoted first to tests, linting, or CI
- How adapter compatibility should be verified as supported agents expand
- How a project made of multiple related repositories (an application repo plus a sibling simulator/test-harness service plus a shared infra repo, `relayhub-java`'s actual shape as of 2026-09-12) should describe that relationship in repository-first context. V1 only specifies how one repository describes itself; nothing currently tells a fresh session opening one repo that sibling repos exist, what each owns, or where to find them, short of ad hoc prose in `current-state.md`. Worth deciding once more than one adopting project needs it, not before — but flagged now since the maintainer has said more services are coming on the same pattern.
- Whether V1 should say anything about when a change needs a per-feature design document (a `specs/<feature>/` entry) versus only a `current-state.md` update and commit history. Not part of the V1 foundation itself, but every real adoption so far has grown some version of this convention without guidance on where the line is.

## Known constraints

- There is no application code, test suite, build system, CLI, or automation yet.
- The initial design conversation was used only as bootstrap evidence and is not required context for future sessions.
- Adoption is manual until a later distribution mechanism is accepted and implemented.

## V1 exit criteria

- A new agent session accurately recovers the project purpose, principles, architecture, current state, and next work without an external link.
- All durable evidence for that answer exists in the repository.
- Shared design is not duplicated in agent adapters.
- Another project can adopt the foundation by following the manual guide without relying on undocumented conversation context.

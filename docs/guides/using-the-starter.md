# Using the Starter

This guide defines the V1 procedure for adopting Agent Development Starter in another project. The process is intentionally manual: the repository specification must be validated through real use before a template or CLI automates it.

## Expected result

After adoption, the target repository should be self-describing. A fresh Codex or Claude Code session should be able to recover the project's purpose, principles, architecture, current state, and next work without access to the conversations that created it.

## Choose an adoption mode

### New project

Start with an empty Git repository, copy the Starter foundation files into it, and make the repository project-specific before implementing application code. `PROJECT.yaml`'s `delivery` flags and `project.lifecycle`/`current_phase` will necessarily be set to a pre-implementation state (for example `implementation_present: false`, lifecycle `design`) during this pass, because the code does not exist yet. Record revisiting these fields once the first implementation lands as a `Next` item in `docs/status/current-state.md` during this same pass — do not treat the round trip as a later surprise.

### Existing project

Add the foundation to the existing repository without replacing application code or established documentation. Map existing authoritative documents to the ADS responsibilities first. Prefer linking or moving one source of truth over creating a duplicate.

A project adopted well after its initial build-out typically has significant architectural decisions that were made and implemented across earlier sessions but never recorded anywhere durable — only in conversation history and, at best, code comments. Treat identifying these as part of step 5 ("Record accepted decisions"), not an optional extra: read the implementation and its comments, and its commit/session history if available, for decisions that meet the ADR bar (see `docs/decisions/ADR-0001-repository-first-context.md`'s own context for what that bar looks like) and were never written down, and write them as ADRs during the same adoption pass, dated at adoption time with a note that they document a pre-existing decision rather than a new one. Do not treat "the adoption is retroactive" as a reason to skip this — a repository whose `docs/decisions/` only starts from the adoption date, with no record of why its most consequential existing behavior works the way it does, has not actually closed the gap ADR-0001 exists to close.

### Restarting or discarding an adoption attempt

An adoption attempt may need to be discarded and restarted — for example, the project is renamed, or an earlier attempt adopted the foundation incorrectly. Treat this as a fresh adoption in "New project" or "Existing project" mode, not as a separate procedure: discard the prior `PROJECT.yaml`, `.ai/constitution/`, `docs/product/`, `docs/architecture/`, and `docs/status/current-state.md` content and start the relevant steps below over, rather than patching the discarded attempt. Deleting a local project directory or an already-created remote repository are each irreversible, out-of-band actions — get the maintainer's explicit confirmation before either, the same way repository/remote creation requires it (see "Who performs the adoption").

### Who performs the adoption

Either mode above can be carried out by a human working through the steps below directly, or by an AI coding agent driving the same steps conversationally. In agent-driven adoption, the maintainer describes the target project in natural language (what it is, what it does, what it needs), and the agent performs the mechanical work — copying files, drafting `PROJECT.yaml` and the product/architecture documents, resetting `current-state.md`, removing stale Starter terms, running the acceptance test — while stopping to ask the maintainer only for the items marked **(human input required)** in "Adapt the repository in this order" below. An agent performing adoption must not invent product, scope, or architecture content to fill a document when the maintainer has not supplied it; ask instead. Creating a new Git repository or remote, and the first push, are out-of-band actions with external footprint — an agent must get explicit confirmation before either, separately from being asked to perform the adoption itself.

## Acquire the foundation

Until a template distribution method is implemented, download the source archive from the [ADS GitHub repository](https://github.com/cleanbrain-developer/agent-dev-starter) or clone it into a temporary directory. Copy only the foundation paths listed below into the target repository. Never copy the Starter's `.git/` directory.

There is intentionally no canonical copy command in V1. The first adoption should expose which files and transformations are stable enough to automate later.

## Files to adopt

Copy these paths as the V1 foundation:

```text
PROJECT.yaml
AGENTS.md
CLAUDE.md
.ai/constitution/
docs/product/
docs/architecture/
docs/decisions/
docs/status/current-state.md
```

Copy an agent adapter (`AGENTS.md` or `CLAUDE.md`) only for an agent that will actually appear in the target project's `supported_agents.initial` list — this is the same decision as "Keep only agents that the target project supports" in step 1, applied to which adapter files exist at all, not only to their content. Do not create an adapter file as an empty placeholder for an agent the project does not support, and do not ask the maintainer to choose between adapters as a separate step; derive the set directly from `supported_agents.initial` once it is set.

A target repository's `AGENTS.md` or `CLAUDE.md` may already exist for a reason unrelated to ADS — for example, `create-next-app` and other scaffolding tools write an `AGENTS.md` with tool-specific notices (framework breaking changes, version-specific docs pointers) that has nothing to do with repository-first context, and a Claude Code project may already use `CLAUDE.md`'s `@path` import syntax to pull that content in. Do not overwrite this kind of pre-existing, load-bearing adapter content to make room for the ADS routing section. Instead, keep the existing content reachable (e.g. preserve the `@AGENTS.md` import line at the top of `CLAUDE.md`) and add the ADS routing section below it in the same file. Treat this the same as "Existing project" mode's general rule below: map what already exists first, prefer keeping one working source over replacing it.

Create or keep the target project's own `README.md`, Git history, remote, source tree, build configuration, and quality tooling. Do not copy `docs/guides/using-the-starter.md` unless the target repository will itself distribute the Starter. Add target-specific guides only when they have a real responsibility, and remove `context.guides` from `PROJECT.yaml` when the target has no guides directory.

## Adapt the repository in this order

Each step below notes whether it can be drafted from the maintainer's natural-language description of the target project, or whether it needs the maintainer's own judgment. "Agent-fillable" means a first draft can be produced from what the maintainer has already said; it still must reflect only what was actually said, never invented detail. "(human input required)" means the agent must stop and ask rather than guess.

### 1. Define project identity — agent-fillable from the service description; confirm delivery/lifecycle state with the maintainer (human input required)

Edit `PROJECT.yaml` first.

- Replace the project name, repository name, type, lifecycle, purpose, and current phase.
- Keep only agents that the target project supports.
- Review every listed principle; do not retain one that the project will not follow. (human input required — the maintainer decides which principles the team will actually follow)
- Keep canonical context paths accurate if the target repository uses different locations.
- Set delivery flags to the target project's actual state. (human input required — the agent cannot know what is actually implemented without being told or inspecting the repository)

Do not use `PROJECT.yaml` as a narrative design document. Detailed explanations belong under `docs/`.

### 2. Define the product — agent-fillable from the service description, with open items flagged rather than invented

Replace the Starter-specific content under `docs/product/`.

- `overview.md`: problem, users, and product thesis
- `goals.md`: measurable goals and success criteria
- `scope.md`: current in-scope and out-of-scope boundaries

Write known facts and explicitly mark open decisions. Do not invent requirements simply to make the documents look complete. When the maintainer's description leaves a goal, user, or scope boundary unstated, ask (human input required) rather than filling it with a plausible-sounding guess.

### 3. Define the architecture — agent-fillable from the service description and repository inspection, with real open decisions flagged

Replace or extend the content under `docs/architecture/` so it describes the target system rather than ADS.

At minimum, document:

- System boundaries and major components
- Dependency direction and ownership boundaries
- External integrations
- Data and control flow where they affect implementation
- Constraints that agents must preserve

Keep `agent-context-model.md` and the repository documentation model when they remain applicable. Adapt them if the project has a justified, documented difference.

### 4. Review the constitution (human input required)

Review every file under `.ai/constitution/` with the project maintainers.

- Keep durable engineering principles that the team genuinely intends to follow.
- Add project-independent principles only when they will remain stable.
- Put product requirements and architecture-specific rules in their dedicated documents, not in the constitution.
- Plan deterministic enforcement for rules that must never be violated.

An agent performing adoption may propose which principles look reusable, but the decision to keep, drop, or add one belongs to the maintainer.

### 5. Record accepted decisions — agent-fillable mechanically; confirm the decision itself with the maintainer (human input required)

Keep ADR-0001 if the target project adopts repository-first context. Update its date and deciders if necessary, but preserve the decision and consequences.

Create additional ADRs only for decisions that are accepted and significant. Do not turn every preference or task note into an ADR.

### 6. Reset working state — agent-fillable from the service description and repository state

Rewrite `docs/status/current-state.md` for the target project.

Include only:

- Current phase
- Completed foundation work
- Work in progress
- Ordered next actions
- Open decisions
- Known constraints
- Exit criteria for the current phase

Remove all ADS-specific progress and open decisions that do not apply to the target project.

### 7. Update the human entry point

Write the target project's `README.md` for its human users. It should introduce the project, explain how to run or contribute to it when applicable, and link to the canonical project documents. Do not copy the ADS product description into a derived project.

### 8. Keep agent adapters thin

Review `AGENTS.md` and `CLAUDE.md`, but change them only for real tool-specific needs or changed canonical paths.

Do not copy product requirements, architecture rules, or status into the adapters. Both adapters must lead to the same shared sources of truth.

## Remove stale Starter context

Before the first implementation task, search the target repository for Starter-specific terms such as:

```text
Agent Development Starter
agent-dev-starter
ADS
V1 Foundation
```

Every remaining occurrence must be intentionally relevant. Also check dates, repository URLs, lifecycle values, delivery flags, and open decisions.

## Run the bootstrap acceptance test

Open clean sessions that do not have access to the setup conversation. "Clean" means isolated from the conversation that performed the adoption, not necessarily a session the maintainer opens by hand: an agent performing the adoption may satisfy this by delegating the test to a subagent (or equivalent isolated session) that shares no conversation history or memory with the adoption session and receives nothing beyond the entry adapter. What disqualifies a session is access to the setup conversation or its context, not who starts it.

For Codex, use:

```text
Read AGENTS.md and explain:
1. what this project is,
2. why it exists,
3. its core principles and architecture,
4. its current status,
5. what should be done next.
Include the repository path supporting each answer.
```

For Claude Code, run the equivalent test starting from `CLAUDE.md`.

The adoption passes only when both agents provide consistent answers grounded in repository files. Fix the sources of truth or adapter routing when an answer is missing, inconsistent, or based on an assumption.

## Begin project work

After the bootstrap test passes:

1. Commit the adopted foundation as a reviewable baseline. If an agent performed the adoption, creating the Git repository or remote and the first push each need the maintainer's explicit confirmation beforehand — adoption itself does not imply consent to those actions.
2. Start the first task with a concise task prompt.
3. Let the agent recover durable context from the repository.
4. Persist new accepted decisions in ADRs.
5. Update current state whenever the next session needs a different picture of progress. This trigger does not wait for a natural session boundary: a single long session that ships several small, maintainer-directed changes back to back (common once a project is past its initial build-out and into iterative feature requests) can go many verified, deployed changes without ever pausing to update `current-state.md`, because no individual change feels like "the end of a phase." Treat each shipped and verified change as a candidate update, not only a session's last one — a `current-state.md` that is one day and twenty-plus commits behind the repository's actual history is a bootstrap-test failure waiting to happen, not a harmless lag. The same applies to any per-feature design document's own status marker (see `docs/architecture/agent-context-model.md`, "Working context").
6. Add deterministic tests and quality gates as implementation begins.

## Adoption checklist

- [ ] `PROJECT.yaml` describes the target project.
- [ ] Product documents contain no stale Starter facts.
- [ ] Architecture documents describe the target system and its boundaries.
- [ ] Maintainers reviewed the constitution.
- [ ] Relevant repository-first decisions are recorded as ADRs.
- [ ] `current-state.md` identifies concrete next work.
- [ ] The target `README.md` serves its human users.
- [ ] Agent adapters remain thin and point to valid paths.
- [ ] Starter-specific placeholders and metadata have been removed.
- [ ] Fresh Codex and Claude Code sessions pass the bootstrap acceptance test.
- [ ] The foundation has been committed before feature implementation begins.
- [ ] If an agent performed the adoption, repository/remote creation and the first push were each explicitly confirmed by the maintainer, and no product, scope, or architecture content was invented without the maintainer's input.

## What V1 does not provide

V1 does not generate files, validate `PROJECT.yaml`, synchronize skills, choose a technology stack, or configure build and CI systems. Do those tasks explicitly in the target repository and document significant choices. Automation should be introduced only after this manual procedure has been validated across real projects.

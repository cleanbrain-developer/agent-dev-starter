# Using the Starter

This guide defines the V1 procedure for adopting Agent Development Starter in another project. The process is intentionally manual: the repository specification must be validated through real use before a template or CLI automates it.

## Expected result

After adoption, the target repository should be self-describing. A fresh Codex or Claude Code session should be able to recover the project's purpose, principles, architecture, current state, and next work without access to the conversations that created it.

## Choose an adoption mode

### New project

Start with an empty Git repository, copy the Starter foundation files into it, and make the repository project-specific before implementing application code.

### Existing project

Add the foundation to the existing repository without replacing application code or established documentation. Map existing authoritative documents to the ADS responsibilities first. Prefer linking or moving one source of truth over creating a duplicate.

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

Create or keep the target project's own `README.md`, Git history, remote, source tree, build configuration, and quality tooling. Do not copy `docs/guides/using-the-starter.md` unless the target repository will itself distribute the Starter. Add target-specific guides only when they have a real responsibility, and remove `context.guides` from `PROJECT.yaml` when the target has no guides directory.

## Adapt the repository in this order

### 1. Define project identity

Edit `PROJECT.yaml` first.

- Replace the project name, repository name, type, lifecycle, purpose, and current phase.
- Keep only agents that the target project supports.
- Review every listed principle; do not retain one that the project will not follow.
- Keep canonical context paths accurate if the target repository uses different locations.
- Set delivery flags to the target project's actual state.

Do not use `PROJECT.yaml` as a narrative design document. Detailed explanations belong under `docs/`.

### 2. Define the product

Replace the Starter-specific content under `docs/product/`.

- `overview.md`: problem, users, and product thesis
- `goals.md`: measurable goals and success criteria
- `scope.md`: current in-scope and out-of-scope boundaries

Write known facts and explicitly mark open decisions. Do not invent requirements simply to make the documents look complete.

### 3. Define the architecture

Replace or extend the content under `docs/architecture/` so it describes the target system rather than ADS.

At minimum, document:

- System boundaries and major components
- Dependency direction and ownership boundaries
- External integrations
- Data and control flow where they affect implementation
- Constraints that agents must preserve

Keep `agent-context-model.md` and the repository documentation model when they remain applicable. Adapt them if the project has a justified, documented difference.

### 4. Review the constitution

Review every file under `.ai/constitution/` with the project maintainers.

- Keep durable engineering principles that the team genuinely intends to follow.
- Add project-independent principles only when they will remain stable.
- Put product requirements and architecture-specific rules in their dedicated documents, not in the constitution.
- Plan deterministic enforcement for rules that must never be violated.

### 5. Record accepted decisions

Keep ADR-0001 if the target project adopts repository-first context. Update its date and deciders if necessary, but preserve the decision and consequences.

Create additional ADRs only for decisions that are accepted and significant. Do not turn every preference or task note into an ADR.

### 6. Reset working state

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

Open clean sessions that do not have access to the setup conversation.

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

1. Commit the adopted foundation as a reviewable baseline.
2. Start the first task with a concise task prompt.
3. Let the agent recover durable context from the repository.
4. Persist new accepted decisions in ADRs.
5. Update current state whenever the next session needs a different picture of progress.
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

## What V1 does not provide

V1 does not generate files, validate `PROJECT.yaml`, synchronize skills, choose a technology stack, or configure build and CI systems. Do those tasks explicitly in the target repository and document significant choices. Automation should be introduced only after this manual procedure has been validated across real projects.

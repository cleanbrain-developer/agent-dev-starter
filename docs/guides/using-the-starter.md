# Using the Starter

This guide defines the procedure for adopting Agent Development Starter in another project. The process is manual by design, permanently, not a stopgap awaiting a future template or CLI — see `ADR-0002`. ADS itself builds no CLI; where a real CLI is needed (GitHub Spec Kit), adoption installs the actual pinned tool instead of ADS reimplementing it (`ADR-0010`).

## Expected result

After adoption, the target repository should be self-describing. A fresh agent session, starting only from `AGENTS.md`, should be able to recover the project's purpose, principles, architecture, current state, active feature, and next work without access to the conversations that created it.

## Choose an adoption mode

### New project

Start with an empty Git repository, copy the Starter foundation files into it, and make the repository project-specific before implementing application code. `PROJECT.yaml`'s `delivery` flags and `project.lifecycle`/`current_phase` will necessarily be set to a pre-implementation state (for example `implementation_present: false`, lifecycle `design`) during this pass, because the code does not exist yet. Record revisiting these fields once the first implementation lands as a `Next` item in `docs/status/current-state.md` during this same pass — do not treat the round trip as a later surprise.

### Existing project

Add the foundation to the existing repository without replacing application code or established documentation. Map existing authoritative documents to the ADS responsibilities first. Prefer linking or moving one source of truth over creating a duplicate.

A project adopted well after its initial build-out typically has significant architectural decisions that were made and implemented across earlier sessions but never recorded anywhere durable — only in conversation history and, at best, code comments. Treat identifying these as part of step 4 ("Record accepted decisions"), not an optional extra: read the implementation and its comments, and its commit/session history if available, for decisions that meet the ADR bar (see `docs/decisions/ADR-0001-repository-first-context.md`'s own context for what that bar looks like) and were never written down, and write them as ADRs during the same adoption pass, dated at adoption time with a note that they document a pre-existing decision rather than a new one. Do not treat "the adoption is retroactive" as a reason to skip this — a repository whose `docs/decisions/` only starts from the adoption date, with no record of why its most consequential existing behavior works the way it does, has not actually closed the gap ADR-0001 exists to close.

An existing project may already have its own `specs/`, `plan`, or `tasks` convention it grew independently, without Spec Kit (this happened in practice — see `docs/status/current-state.md`'s migration record). Migrate that content into Spec Kit's own `specs/<NNN-feature>/` structure once Spec Kit is installed (below), rather than running both conventions side by side.

### Restarting or discarding an adoption attempt

An adoption attempt may need to be discarded and restarted — for example, the project is renamed, or an earlier attempt adopted the foundation incorrectly. Treat this as a fresh adoption in "New project" or "Existing project" mode, not as a separate procedure: discard the prior `PROJECT.yaml`, constitution, `docs/product/`, `docs/architecture/`, and `docs/status/current-state.md` content and start the relevant steps below over, rather than patching the discarded attempt. Deleting a local project directory or an already-created remote repository are each irreversible, out-of-band actions — get the maintainer's explicit confirmation before either, the same way repository/remote creation requires it (see "Who performs the adoption").

### Who performs the adoption

Either mode above can be carried out by a human working through the steps below directly, or by an AI coding agent driving the same steps conversationally. In agent-driven adoption, the maintainer describes the target project in natural language (what it is, what it does, what it needs), and the agent performs the mechanical work — copying files, installing Spec Kit, drafting `PROJECT.yaml` and the product/architecture documents, resetting `current-state.md`, removing stale Starter terms, running the acceptance test — while stopping to ask the maintainer only for the items marked **(human input required)** in "Adapt the repository in this order" below. An agent performing adoption must not invent product, scope, or architecture content to fill a document when the maintainer has not supplied it; ask instead. Creating a new Git repository or remote, and the first push, are out-of-band actions with external footprint — an agent must get explicit confirmation before either, separately from being asked to perform the adoption itself.

## Acquire the foundation

Download the source archive from the [ADS GitHub repository](https://github.com/cleanbrain-developer/agent-dev-starter) or clone it into a temporary directory — there is no other distribution mechanism, and none is planned (`ADR-0002`). Copy only the foundation paths listed below into the target repository. Never copy the Starter's `.git/` directory.

There is intentionally no canonical copy command for ADS's own files. Copying by hand, or having an agent do it conversationally (see "Who performs the adoption"), is the permanent adoption path, not a placeholder for later automation.

## Install GitHub Spec Kit (the pinned version)

Install the exact CLI version pinned in `PROJECT.yaml`'s `standards.spec_kit.pinned_version` (`ADR-0010`) — not whatever the latest release happens to be:

```bash
uv tool install specify-cli==<pinned-version>
# or, where uv is unavailable:
pipx install specify-cli==<pinned-version>
```

Then, from the target project's root:

```bash
specify init --here --integration <agent-key> [--integration <agent-key> ...]
```

Pass one `--integration` per agent in the target project's `supported_agents.initial` (e.g. `--integration claude --integration codex`). This installs `.specify/` (templates, scripts, `.specify/memory/`) and the real `.claude/skills/speckit-*/SKILL.md` / `.agents/skills/speckit-*/SKILL.md` files for each selected agent — do not hand-write these; let the pinned CLI render them (`ADR-0010`).

If the target project's version of the `specify` CLI ever needs to move, that is a decision for that project's own ADR, not a silent `specify upgrade` — record why, and whether the change should also be proposed as a bump to ADS's own pinned version.

## Files to adopt

Copy these ADS-owned paths as the foundation:

```text
PROJECT.yaml
AGENTS.md
.ai/constitution/documentation-policy.md
docs/product/
docs/architecture/
docs/decisions/
docs/status/current-state.md
```

`AGENTS.md` is the only agent adapter — copy it regardless of which agents are supported; do not create a `CLAUDE.md` (`ADR-0011`). Keep a `CLAUDE.md` only as an explicit, documented exception (pinning behavior for a pre-2.1.277 Claude Code, or Claude-specific instructions deliberately excluded from `AGENTS.md`) — this is not the default.

`.specify/memory/constitution.md` and `.claude/skills/`/`.agents/skills/` come from running the pinned Spec Kit CLI above, not from copying ADS's own files — ADS's own `.specify/memory/constitution.md` is a starting draft to adapt into the target's `constitution.md` after Spec Kit generates it, not something to copy over it.

A target repository's `AGENTS.md` may already exist for a reason unrelated to ADS — for example, `create-next-app` and other scaffolding tools write an `AGENTS.md` with tool-specific notices (framework breaking changes, version-specific docs pointers) that has nothing to do with repository-first context. Do not overwrite this kind of pre-existing, load-bearing content to make room for the ADS routing section. Instead, keep the existing content reachable and add the ADS routing section below it in the same file. Treat this the same as "Existing project" mode's general rule: map what already exists first, prefer keeping one working source over replacing it.

Create or keep the target project's own `README.md`, Git history, remote, source tree, build configuration, and quality tooling. Do not copy `docs/guides/using-the-starter.md` unless the target repository will itself distribute the Starter. Add target-specific guides only when they have a real responsibility, and remove `context.guides` from `PROJECT.yaml` when the target has no guides directory.

Create a `.ko.md` Korean companion for every Markdown document this project adopts or authors, including agent-facing ones — this is mandatory, not a per-project choice (see `ADR-0004`, `ADR-0005`). English stays canonical and agent bootstrap reads only the English file. Once a document's `.ko.md` companion exists, update it in the same change whenever the English original's meaning changes — a stale companion is a defect, not an accepted lag. This applies to Spec Kit's own generated `specs/<NNN-feature>/{spec,plan,tasks}.md` too, once a feature exists — not only to ADS's own foundation files.

If this project already has a CI pipeline, also copy `scripts/check-ko-companions.sh` and add a step running it with `--missing-only` early in the existing `test` job, failing the build on a missing companion (see `ADR-0009`). If this project has no CI pipeline, skip this — it is not a reason to add one.

## Adapt the repository in this order

Each step below notes whether it can be drafted from the maintainer's natural-language description of the target project, or whether it needs the maintainer's own judgment. "Agent-fillable" means a first draft can be produced from what the maintainer has already said; it still must reflect only what was actually said, never invented detail. "(human input required)" means the agent must stop and ask rather than guess.

### 1. Define project identity — agent-fillable from the service description; confirm delivery/lifecycle state with the maintainer (human input required)

Edit `PROJECT.yaml` first.

- Replace the project name, repository name, type, lifecycle, purpose, and current phase.
- Keep only agents that the target project supports, and set `standards.spec_kit.pinned_version` to the same version installed above.
- Review every listed principle; do not retain one that the project will not follow. (human input required — the maintainer decides which principles the team will actually follow)
- `principles` may list both retained ADS core principles and principles specific to this project, as long as every project-specific principle has a real prose definition in this project's own `.specify/memory/constitution.md` — never a bare name in `PROJECT.yaml` with no definition anywhere.
- `context` may add canonical paths beyond the core set (`human_entrypoint`, `agent_entrypoint`, `specify_constitution`, `documentation_policy`, `product`, `architecture`, `decisions`, `current_state`) when a path has a real, distinct responsibility this project needs — for example a status file tracking cross-repository dependencies (see `docs/architecture/repository-structure.md`, "Optional context extensions"). Drop `guides` and any other optional field the target project does not use; do not keep it as a stale placeholder.
- Keep canonical context paths accurate if the target repository uses different locations.
- Set delivery flags to the target project's actual state. (human input required — the agent cannot know what is actually implemented without being told or inspecting the repository) Revisit `delivery` and `lifecycle`/`current_phase` again once the first implementation actually lands, per the note in "New project" above — do not leave them at their pre-implementation values.

Do not use `PROJECT.yaml` as a narrative design document. Detailed explanations belong under `docs/`.

### 2. Define the product — agent-fillable from the service description, with open items flagged rather than invented

Replace the Starter-specific content under `docs/product/`.

- `overview.md`: problem, users, and product thesis
- `goals.md`: measurable goals and success criteria
- `scope.md`: current in-scope and out-of-scope boundaries

Write known facts and explicitly mark open decisions. Do not invent requirements simply to make the documents look complete. When the maintainer's description leaves a goal, user, or scope boundary unstated, ask (human input required) rather than filling it with a plausible-sounding guess. This is project-level product context, distinct from a feature's own `spec.md` — do not duplicate one into the other.

### 3. Define the architecture — agent-fillable from the service description and repository inspection, with real open decisions flagged

Replace or extend the content under `docs/architecture/` so it describes the target system rather than ADS.

At minimum, document:

- System boundaries and major components
- Dependency direction and ownership boundaries
- External integrations
- Data and control flow where they affect implementation
- Constraints that agents must preserve

Keep `agent-context-model.md` and the repository documentation model when they remain applicable. Adapt them if the project has a justified, documented difference.

If this project depends on, is depended on by, or shares infrastructure (a namespace, a deployment host) with another repository not fully controlled from here, add a related-repositories document and declare it in `PROJECT.yaml`'s `context` block — see `docs/architecture/repository-structure.md`, "Optional context extensions."

### 4. Adapt the constitution (human input required)

Review `.specify/memory/constitution.md` (generated by the Spec Kit install above, or drafted from ADS's own version if Spec Kit has not been run yet) with the project maintainers.

- Keep durable engineering principles that the team genuinely intends to follow.
- Add project-independent principles only when they will remain stable.
- Put product requirements and architecture-specific rules in their dedicated documents, not in the constitution.
- Plan deterministic enforcement for rules that must never be violated.

An agent performing adoption may propose which principles look reusable, but the decision to keep, drop, or add one belongs to the maintainer. `.ai/constitution/documentation-policy.md` needs no equivalent review — adapt its language-policy content only if the project's Korean-companion needs genuinely differ from ADS's own.

### 5. Record accepted decisions — agent-fillable mechanically; confirm the decision itself with the maintainer (human input required)

Keep ADR-0001 if the target project adopts repository-first context. Update its date and deciders if necessary, but preserve the decision and consequences.

Create additional ADRs only for decisions that are accepted and significant. Do not turn every preference or task note into an ADR.

### 6. Reset working state — agent-fillable from the service description and repository state

Rewrite `docs/status/current-state.md` for the target project.

Include only:

- Current phase
- Completed foundation work
- Work in progress
- Active feature, if any (a pointer to its `specs/<NNN-feature>/`, not a copy of its `tasks.md`)
- Ordered next actions
- Open decisions
- Known constraints
- Exit criteria for the current phase

Remove all ADS-specific progress and open decisions that do not apply to the target project.

### 7. Update the human entry point

Write the target project's `README.md` for its human users. It should introduce the project, explain how to run or contribute to it when applicable, and link to the canonical project documents. Do not copy the ADS product description into a derived project.

### 8. Keep `AGENTS.md` thin

Review `AGENTS.md`, but change it only for real project-specific needs or changed canonical paths.

Do not copy product requirements, architecture rules, or status into it. It routes to the shared sources of truth; it does not become one.

### 9. Define project skills — optional (human input required)

Ask the maintainer whether this project has a repeatable workflow specific to it that is worth capturing as a Skill (see `ADR-0003`). Do not infer one from the product or architecture documents. Place it at `.claude/skills/<name>/SKILL.md` and/or `.agents/skills/<name>/SKILL.md` — whichever the project's supported agents actually discover (`ADR-0012`) — never at an invented path, and never as an empty placeholder. Only create it once the maintainer has described at least one real, repeatable workflow; if the maintainer has none, skip this step entirely and revisit it later rather than forcing it now. Skills defined this way belong to this project alone — do not copy a skill from one adopted project into another without the maintainer's explicit direction, and do not confuse a project-specific skill with Spec Kit's own `speckit-*` skills, which the CLI installs and manages itself.

## Remove stale Starter context

Before the first implementation task, search the target repository for Starter-specific terms such as:

```text
Agent Development Starter
agent-dev-starter
ADS
```

Every remaining occurrence must be intentionally relevant. Also check dates, repository URLs, lifecycle values, delivery flags, and open decisions.

## Run the bootstrap acceptance test

Open clean sessions that do not have access to the setup conversation. "Clean" means isolated from the conversation that performed the adoption, not necessarily a session the maintainer opens by hand: an agent performing the adoption may satisfy this by delegating the test to a subagent (or equivalent isolated session) that shares no conversation history or memory with the adoption session and receives nothing beyond `AGENTS.md`. What disqualifies a session is access to the setup conversation or its context, not who starts it.

```text
Read AGENTS.md and explain:
1. what this project is,
2. why it exists,
3. its core principles and architecture,
4. its current status and active feature (if any),
5. what should be done next,
6. where the Korean companion for each major document is.
Include the repository path supporting each answer.
```

Run this once per supported agent (each starting from the same `AGENTS.md`). The adoption passes only when every agent provides consistent answers grounded in repository files. Fix the sources of truth or `AGENTS.md` routing when an answer is missing, inconsistent, or based on an assumption.

## Begin project work

After the bootstrap test passes:

1. Commit the adopted foundation as a reviewable baseline. If an agent performed the adoption, creating the Git repository or remote and the first push each need the maintainer's explicit confirmation beforehand — adoption itself does not imply consent to those actions.
2. Start the first task with a concise natural-language requirement. Let the agent determine whether it is a new feature (drive it through Spec Kit: `specify` → `clarify` if ambiguous → `plan` → `checklist` if warranted → `tasks` → `analyze` → `implement` → `converge`), a change to the active feature, or a pure architecture/documentation change with no feature at all.
3. Let the agent recover durable context from the repository, per `docs/architecture/agent-context-model.md`'s bootstrap order.
4. Persist new accepted decisions in ADRs.
5. Update `docs/status/current-state.md` whenever the next session needs a different picture of progress. This trigger does not wait for a natural session boundary: a single long session that ships several small, maintainer-directed changes back to back (common once a project is past its initial build-out and into iterative feature requests) can go many verified, deployed changes without ever pausing to update `current-state.md`, because no individual change feels like "the end of a phase." Treat each shipped and verified change as a candidate update, not only a session's last one — a `current-state.md` that is one day and twenty-plus commits behind the repository's actual history is a bootstrap-test failure waiting to happen, not a harmless lag. The same applies to any active feature's own `spec.md`/`plan.md`/`tasks.md` status (see `docs/architecture/agent-context-model.md`, "Working context").
6. Add deterministic tests and quality gates as implementation begins.

## Adoption checklist

- [ ] `PROJECT.yaml` describes the target project and pins the same Spec Kit CLI version actually installed.
- [ ] `AGENTS.md` is the only agent adapter, unless a documented exception keeps a thin `CLAUDE.md`.
- [ ] `.specify/` and any `.claude/skills/speckit-*`/`.agents/skills/speckit-*` were installed by the pinned CLI, not hand-written.
- [ ] Product documents contain no stale Starter facts.
- [ ] Architecture documents describe the target system and its boundaries.
- [ ] Maintainers reviewed `.specify/memory/constitution.md`.
- [ ] Relevant repository-first decisions are recorded as ADRs.
- [ ] `current-state.md` identifies concrete next work and, if a feature is active, points at its `specs/<NNN-feature>/` rather than duplicating it.
- [ ] The target `README.md` serves its human users.
- [ ] `AGENTS.md` remains thin and points at valid paths.
- [ ] Starter-specific placeholders and metadata have been removed.
- [ ] A fresh session for every supported agent passes the bootstrap acceptance test.
- [ ] The foundation has been committed before feature implementation begins.
- [ ] If an agent performed the adoption, repository/remote creation and the first push were each explicitly confirmed by the maintainer, and no product, scope, or architecture content was invented without the maintainer's input.
- [ ] The maintainer was asked about project-specific skills; a project-specific `SKILL.md` exists only at a real agent-discovered path, and only if the maintainer described a real workflow for it.
- [ ] Every adopted or authored Markdown document — including any `specs/<NNN-feature>/*.md` — has a `.ko.md` companion, and no companion is out of sync with a recent change to its English original.
- [ ] If this project has a CI pipeline, it runs `scripts/check-ko-companions.sh --missing-only` and fails on a missing companion (`ADR-0009`).

## What ADS does not provide

ADS does not generate files, validate `PROJECT.yaml` mechanically, synchronize skills across projects, choose a technology stack, or configure build and CI systems beyond the one Korean-companion check. Do those tasks explicitly in the target repository and document significant choices. This is permanent, not conditional on further validation — real adoptions have already validated the manual procedure, and `ADR-0002`/`ADR-0003`/`ADR-0010` decided against automating it, centralizing skills, or hand-rendering standard tooling regardless.

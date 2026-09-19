# Scope

## In scope

- `PROJECT.yaml` for project identity, current phase, and pinned standard versions (`ADR-0010`)
- `AGENTS.md` as the sole entry adapter for every supported agent (`ADR-0011`)
- GitHub Spec Kit for the spec/plan/tasks/clarify/analyze/implement/converge workflow, at the pinned CLI version
- Agent Skills at the paths agents actually discover (`.claude/skills/`, `.agents/skills/` — `ADR-0012`), for GitHub Spec Kit's own `speckit-*` skills and any project-specific skill a maintainer has asked for
- Durable engineering principles in `.specify/memory/constitution.md`; document ownership and language policy in `.ai/constitution/documentation-policy.md` (`ADR-0013`)
- Separate product, architecture, guide, decision, and status responsibilities
- An initial ADR that preserves the repository-first decision
- A status document that restores current project-wide working context (a scope Spec Kit deliberately leaves to teams)
- Mandatory, cascading `.ko.md` Korean companions for every document, English canonical (`ADR-0004`/`ADR-0005`), with a default CI check for projects that already have a pipeline (`ADR-0009`)
- Manual context bootstrap acceptance criteria
- An agent-driven adoption procedure for using the Starter in another repository

## Permanently out of scope

- An ADS-specific CLI, initializer, or file generator (`ADR-0002`) — GitHub Spec Kit's own CLI fills this role instead
- GitHub template distribution configuration (`ADR-0002`)
- A shared skill library defined, hosted, or synchronized by ADS itself (`ADR-0003`) — skills stay per-project
- A machine-validatable `PROJECT.yaml` schema (`ADR-0006`)
- Application source code
- CI pipelines built by ADS itself for adopting projects, beyond the one check described above (`ADR-0007`/`ADR-0009`)
- A plugin ecosystem and distribution strategy
- ADS reimplementing anything an open standard already solves (`ADR-0002`, `ADR-0006`, `ADR-0010`, `ADR-0011`, `ADR-0012`) — the recurring test for any proposed new ADS mechanism is whether AGENTS.md, GitHub Spec Kit, or Agent Skills already covers it

These are permanent decisions, not items deferred for a future version — each is backed by an ADR reached from real adoption evidence or, for the standards-alignment items, from checking what the open standards already provide before building an equivalent.

## Scope rule

Consider out-of-scope items only enough to avoid blocking future extension. Do not add placeholder directories, speculative abstractions, or unused scripts.

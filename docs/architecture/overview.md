# Architecture Overview

## Architectural style

ADS is a repository information architecture built on top of open standards and conventions, not a new framework and not an executable system in itself (see `docs/product/overview.md`, "ADS V2"). It separates persistent context by responsibility, most of it now owned by a standard (`AGENTS.md`, GitHub Spec Kit, Agent Skills) rather than an ADS-invented mechanism, plus a thin layer of ADS's own opinion where no standard applies.

```text
Task prompt
    ↓
AGENTS.md (sole adapter, ADR-0011)
    ↓
PROJECT.yaml + .specify/memory/constitution.md + Product + Architecture + ADR + Current State
    ↓
Active feature (specs/<NNN-feature>/{spec,plan,tasks}.md, GitHub Spec Kit)
    ↓
Relevant repository evidence
    ↓
Plan → Change → Verify → Review → Persist state
```

## Layers

### Identity

`PROJECT.yaml` exposes the name, type, lifecycle, supported agents, principles, current phase, pinned standard versions, and canonical context paths as machine-readable data.

### Policy

`.specify/memory/constitution.md` (GitHub Spec Kit's own constitution role) holds durable engineering principles. `.ai/constitution/documentation-policy.md` holds document ownership and the `.ko.md` language policy — the one policy area no open standard owns.

### Knowledge

Two scopes, not one: `docs/product/` and `docs/architecture/` describe the whole project and persist across features; `specs/<NNN-feature>/{spec,plan,tasks}.md` (Spec Kit) describes one feature and is scoped to its lifecycle. `docs/decisions/` explains why significant choices were made, at either scope.

### Guidance

`docs/guides/` contains repeatable operational procedures, including how to adopt this Starter in another repository. Guides reference policy and design sources rather than redefining them.

### Working state

`docs/status/current-state.md` describes completed work and next actions for the current phase, at the project-wide level Spec Kit intentionally does not provide (see `docs/concepts/spec-persistence.md` in GitHub Spec Kit's own documentation). It does not contain permanent principles or a detailed history, and it does not duplicate a feature's own `tasks.md`.

### Adapter

`AGENTS.md` is the sole entry point for every supported agent (`ADR-0011`). It contains only routing and the shared behavioral contract — never product or architecture content.

### Skills

`.claude/skills/` and `.agents/skills/` hold reusable procedures an agent's own harness discovers automatically — GitHub Spec Kit's own `speckit-*` workflow skills, plus any project-specific skill a maintainer has actually asked for (`ADR-0003`, `ADR-0012`). This layer is "how to do a repeatable task," distinct from every layer above it, which is "what the project is and why."

## Enforcement boundary

Markdown guides judgment and procedure but does not enforce compliance. Rules that must never be violated should eventually be promoted to deterministic quality gates such as tests, linters, architecture checks, and CI. The one exception is the Korean-companion completeness rule (`ADR-0005`), which is mechanical enough to check today — see `scripts/check-ko-companions.sh` and `ADR-0007`/`ADR-0009`. Everything else still relies on judgment, not automation.

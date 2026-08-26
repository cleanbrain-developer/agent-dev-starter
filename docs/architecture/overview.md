# Architecture Overview

## Architectural style

V1 is a repository information architecture, not an executable system. It separates persistent context by responsibility and routes agent-specific entry points to a shared core.

```text
Task prompt
    ↓
Agent adapter (AGENTS.md / CLAUDE.md)
    ↓
PROJECT.yaml + Constitution + Product + Architecture + ADR + Current State
    ↓
Relevant repository evidence
    ↓
Plan → Change → Verify → Review → Persist state
```

## Layers

### Identity

`PROJECT.yaml` exposes the name, type, lifecycle, supported agents, principles, current phase, and canonical context paths as machine-readable data.

### Policy

`.ai/constitution/` provides engineering and documentation principles that outlive an individual task and usually outlive a project phase.

### Knowledge

`docs/product/`, `docs/architecture/`, and `docs/decisions/` explain what is being built, why it matters, how it is structured, and why significant choices were made.

### Guidance

`docs/guides/` contains repeatable operational procedures, including how to adopt this Starter in another repository. Guides reference policy and design sources rather than redefining them.

### Working state

`docs/status/current-state.md` describes completed work and next actions for the current phase. It does not contain permanent principles or a detailed history.

### Adapters

`AGENTS.md` and `CLAUDE.md` help their respective tools discover shared context. Only tool-specific syntax and loading differences belong in these files.

## Enforcement boundary

Markdown guides judgment and procedure but does not enforce compliance. Rules that must never be violated should eventually be promoted to deterministic quality gates such as tests, linters, architecture checks, and CI. V1 does not implement that automation.

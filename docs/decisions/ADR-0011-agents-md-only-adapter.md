# ADR-0011: `AGENTS.md` Is the Sole Adapter; `CLAUDE.md` Is Removed

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

`ADR-0001` established `AGENTS.md` and `CLAUDE.md` as parallel thin adapters, one per supported agent, because Claude Code only read `CLAUDE.md`. That changed two days before this decision: Claude Code (from v2.1.277, 2026-09-18) now falls back to reading `AGENTS.md` natively when no `CLAUDE.md` exists in a directory. Codex has always read `AGENTS.md` directly — it is the open, agent-agnostic standard this convention already pointed at. With this fallback in place, maintaining a separate `CLAUDE.md` duplicates `AGENTS.md` for zero remaining benefit in the common case.

## Decision

`AGENTS.md` becomes the sole, universal agent entry point. `CLAUDE.md` is removed from ADS's own foundation and from `docs/guides/using-the-starter.md`'s adopted files. `AGENTS.md` also absorbs `.ai/constitution/agent-behavior.md`'s content (see `ADR-0013`) rather than pointing to a separate file, since the open `AGENTS.md` convention already expects behavioral instructions to live directly in it.

A project may still keep a `CLAUDE.md` as an explicit, documented exception, only when it needs to pin behavior for a Claude Code version older than 2.1.277, or needs Claude-specific instructions it deliberately does not want every other agent to read. This is not the default, and choosing it should be recorded as a one-line note in that project's own `current-state.md`, not silently reintroduced.

## Consequences

### Positive

- One file to keep thin and correct instead of two kept in sync.
- Directly follows the open standard's own intent (a single, tool-agnostic entry file) now that the last practical blocker (Claude Code not reading it) is gone.

### Costs and risks

- Any project that genuinely needs Claude-specific routing not appropriate for `AGENTS.md` must consciously reintroduce a thin `CLAUDE.md`, rather than getting one by default.
- If Claude Code's `AGENTS.md` fallback is ever disabled by a user's own `/config` setting, that project would need `CLAUDE.md` back — this is a per-user Claude Code setting, not something ADS controls, and adopting maintainers should be aware of it.

## Alternatives considered

### Keep both, unconditionally

Rejected: no remaining reason once Claude Code reads `AGENTS.md` natively; would keep paying the duplication cost `ADR-0001` already flagged as a risk, for a problem that no longer exists.

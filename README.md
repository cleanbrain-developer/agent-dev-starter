# Agent Development Starter

Agent Development Starter (ADS) is an opinionated profile built on top of open standards for AI-assisted software projects — **AGENTS.md**, **GitHub Spec Kit**, and **Agent Skills** — not a new framework (see `docs/product/overview.md`). It enables a coding agent to understand a project and continue work from repository evidence instead of depending on a previous conversation or a large initialization prompt.

This repository is the foundation and the first project to apply its own conventions. Codex and Claude Code are the initial supported agents, both reading the same `AGENTS.md`.

## Why it exists

Project intent, architecture, and working state are easy to lose when they exist only in chat history. ADS assigns each kind of durable context to a clear repository location — a standard's own location where one exists, ADS's own opinion only where none does — so task prompts can focus on what needs to be done.

> A new agent session must be able to understand the project and identify the next work item from the repository alone.

## Use this starter

There is no ADS-specific CLI or generator, permanently (`docs/decisions/ADR-0002-reference-only-distribution.md`). Where a real CLI is needed — GitHub Spec Kit — adoption installs the pinned upstream tool instead of ADS reimplementing it (`ADR-0010`). Adopting the starter is a deliberate, manual process:

1. Copy the foundation files into a new or existing repository.
2. Install GitHub Spec Kit at the pinned version for the target project's agents.
3. Replace starter-specific identity, product, architecture, and status content.
4. Adapt the constitution instead of copying it blindly.
5. Keep `AGENTS.md` — the sole adapter — thin.
6. Run the context bootstrap acceptance test in fresh agent sessions.

Follow the complete procedure in [`docs/guides/using-the-starter.md`](docs/guides/using-the-starter.md).

## Entry points

- Human entry point: `README.md`
- Every supported agent: `AGENTS.md` (Codex natively, Claude Code natively since v2.1.277)
- Structured project identity and pinned standard versions: `PROJECT.yaml`
- Durable engineering principles: `.specify/memory/constitution.md` (GitHub Spec Kit)
- Document ownership and language policy: `.ai/constitution/documentation-policy.md`
- Product and architecture sources: `docs/product/` and `docs/architecture/`
- Feature-level work: `specs/<NNN-feature>/` (GitHub Spec Kit)
- Reusable procedures: `.claude/skills/`, `.agents/skills/` (Agent Skills)
- Current working state: `docs/status/current-state.md`

## Structure

```text
.
├── README.md                         # Human entry point
├── PROJECT.yaml                      # Machine-readable identity + pinned standard versions
├── AGENTS.md                         # The sole agent adapter (ADR-0011)
├── .specify/                         # GitHub Spec Kit's own managed files
│   └── memory/constitution.md        # Durable engineering principles (ADR-0013)
├── .claude/skills/                   # Claude Code's real skill-discovery path
├── .agents/skills/                   # Codex's real skill-discovery path
├── .ai/
│   └── constitution/
│       └── documentation-policy.md   # Document ownership + language policy (no standard owns this)
├── specs/                            # GitHub Spec Kit feature artifacts (none yet — ADS itself has no features)
└── docs/
    ├── product/                      # Project-level: what is being built and why
    ├── architecture/                 # Persistent structure and context model
    ├── guides/                       # Operational usage procedures
    ├── decisions/                    # Decisions and rationale
    └── status/                       # Current project-wide working context
```

Every Markdown document above has a `.ko.md` Korean companion (English canonical — `ADR-0004`/`ADR-0005`); `PROJECT.yaml` does not, since it is structured data, not prose.

## Documentation boundaries

- `README.md` introduces and routes; it does not duplicate the full design.
- `AGENTS.md` is the sole thin adapter to shared sources of truth.
- `PROJECT.yaml` provides structured identity, phase data, and pinned standard versions.
- `.specify/memory/constitution.md` defines engineering principles that change infrequently; `.ai/constitution/documentation-policy.md` defines document ownership and language policy.
- `docs/product/` and `docs/architecture/` own project-level product and design knowledge; `specs/<NNN-feature>/` owns feature-level requirements, plan, and tasks.
- `docs/guides/` owns repeatable human-facing procedures.
- ADRs preserve important decisions and their consequences.
- `current-state.md` restores project-wide progress, next work, and open decisions.

See `docs/architecture/repository-structure.md` for the complete responsibility and dependency model.

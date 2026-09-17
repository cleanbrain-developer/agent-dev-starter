# Agent Development Starter

Agent Development Starter (ADS) is a repository-first specification for AI-assisted software projects. It enables a coding agent to understand a project and continue work from repository evidence instead of depending on a previous conversation or a large initialization prompt.

This repository is the V1 foundation and the first project to apply its own conventions. Codex and Claude Code are the initial supported agents, while the shared context remains agent-agnostic.

## Why it exists

Project intent, architecture, and working state are easy to lose when they exist only in chat history. ADS assigns each kind of durable context to a clear repository location so task prompts can focus on what needs to be done.

> A new agent session must be able to understand the project and identify the next work item from the repository alone.

## Use this starter

There is no CLI or generator, permanently (`docs/decisions/ADR-0002-reference-only-distribution.md`). Adopting the starter is a deliberate, manual process:

1. Copy the foundation files into a new or existing repository.
2. Replace starter-specific identity, product, architecture, and status content.
3. Review the constitution instead of copying it blindly.
4. Keep `AGENTS.md` and `CLAUDE.md` as thin adapters.
5. Run the context bootstrap acceptance test in fresh agent sessions.

Follow the complete procedure in [`docs/guides/using-the-starter.md`](docs/guides/using-the-starter.md).

## Entry points

- Human entry point: `README.md`
- Codex and `AGENTS.md`-compatible agents: `AGENTS.md`
- Claude Code: `CLAUDE.md`
- Structured project identity: `PROJECT.yaml`
- Durable engineering policy: `.ai/constitution/`
- Product and architecture sources: `docs/product/` and `docs/architecture/`
- Current working state: `docs/status/current-state.md`

## V1 structure

```text
.
├── README.md                         # Human entry point
├── PROJECT.yaml                      # Machine-readable project identity
├── AGENTS.md                         # Codex-compatible adapter
├── CLAUDE.md                         # Claude Code adapter
├── .ai/
│   └── constitution/                 # Durable engineering policy
│       ├── engineering-principles.md
│       ├── agent-behavior.md
│       └── documentation-policy.md
└── docs/
    ├── product/                      # What is being built and why
    ├── architecture/                 # Structure and context model
    ├── guides/                       # Operational usage procedures
    ├── decisions/                    # Decisions and rationale
    └── status/                       # Current working context
```

## Documentation boundaries

- `README.md` introduces and routes; it does not duplicate the full design.
- `AGENTS.md` and `CLAUDE.md` are thin adapters to shared sources of truth.
- `PROJECT.yaml` provides structured identity and phase data.
- `.ai/constitution/` defines principles that change infrequently.
- `docs/product/` and `docs/architecture/` own product and design knowledge.
- `docs/guides/` owns repeatable human-facing procedures.
- ADRs preserve important decisions and their consequences.
- `current-state.md` restores progress, next work, and open decisions.

See `docs/architecture/repository-structure.md` for the complete responsibility and dependency model.

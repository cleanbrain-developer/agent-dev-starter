# Product Overview

## Product

Agent Development Starter (ADS) is an opinionated profile built on top of open standards and established agent-development conventions — not a new AI development framework. Structurally: the **AGENTS.md** open standard, **GitHub Spec Kit**, and **Agent Skills** are the standards layer; `PROJECT.yaml`, `docs/status/current-state.md`, ADR discipline, architecture conventions, the context-loading model, and the bilingual documentation policy are ADS's own opinion on top of them (`ADR-0010` through `ADR-0013`). The value ADS provides is not a new standard — it is a consistent combination of existing ones, a bootstrap procedure, a context-recovery model, and a document lifecycle, so that repository-first context (`ADR-0001`) survives across sessions and agents.

## Problem

When every new project or agent session requires a large prompt that repeats purpose, architecture, and testing rules, development quality depends on prompt writing and conversation memory. Decision rationale and current working state are easily lost when a session ends or the agent changes.

## Product thesis

Standardize the repository instead of standardizing every prompt. A task prompt states what should be done; the repository explains what the project is and how work should be performed.

## Users

The initial user is a developer who uses Codex and Claude Code together or interchangeably in VS Code. Other coding agents should be able to reuse the shared core over time.

## Core experience

After being directed to `AGENTS.md`, a new agent session must be able to answer the five acceptance questions defined in `docs/product/goals.md` ("Success criteria") without previous conversation history, with every answer traceable to repository documentation, and continue implementation without the maintainer having to separately ask for a spec, a plan, tasks, an ADR, or a Korean translation — the agent's own workflow absorbs those steps (see `docs/guides/using-the-starter.md`'s artifact lifecycle).

Two questions gate every future addition to this project: does this capability already exist in an open standard (`AGENTS.md`, GitHub Spec Kit, Agent Skills) — if so, use that instead of building it; and can a fresh agent session, reading only the English canonical documents, recover this project's full state and next work within five minutes.

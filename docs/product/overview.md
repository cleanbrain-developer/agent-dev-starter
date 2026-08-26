# Product Overview

## Product

Agent Development Starter (ADS) is a starter specification for durable context, working conventions, and quality boundaries in repositories developed with AI coding agents.

## Problem

When every new project or agent session requires a large prompt that repeats purpose, architecture, and testing rules, development quality depends on prompt writing and conversation memory. Decision rationale and current working state are easily lost when a session ends or the agent changes.

## Product thesis

Standardize the repository instead of standardizing every prompt. A task prompt states what should be done; the repository explains what the project is and how work should be performed.

## Users

The initial user is a developer who uses Codex and Claude Code together or interchangeably in VS Code. Other coding agents should be able to reuse the shared core over time.

## V1 experience

After being directed to its entry adapter, a new agent session must be able to explain the following without previous conversation history:

- The project's purpose and problem
- Its core design principles and context hierarchy
- Its current phase and completed work
- Its next work and open decisions

Only after this foundation is validated should the project add a template repository, reusable skills, a CLI, technology presets, or deterministic quality gates.

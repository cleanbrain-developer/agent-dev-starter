# Constitution

This is the project's constitution in the sense GitHub Spec Kit uses the term: durable principles every spec, plan, and implementation is evaluated against. It replaces the old `.ai/constitution/engineering-principles.md` (`ADR-0013`) — this is now the one place these principles live.

## Evidence before change

Inspect existing documentation and implementation first. Prefer repository evidence over assumptions, and do not propose changes based on a structure that has not been verified.

## Minimal, coherent change

Prefer the smallest coherent change that satisfies the requirement. Do not add speculative abstractions, features, or automation.

## Explicit architecture

Do not change architectural boundaries or conventions silently. Surface decisions that have long-term impact or are difficult to reverse, and record them in an ADR before or with implementation.

## Verifiable outcomes

Produce outcomes that can be verified. Run automated checks when they exist; otherwise state the verification method and its limitations. Distinguish guidance that requires judgment from rules that should be enforced by code, tests, linters, or CI.

A green automated check is evidence about the code, not evidence about the running system. When a change is meant to run against real infrastructure (a database, a message broker, a deployed environment, another service), verify it there directly — a live request, a real log line, a value actually observed changing — before treating the change as done. Passing tests and a successful deploy step are necessary, not sufficient: several real defects in adopting projects (a misconfigured environment variable only wrong in the deployed environment, a lazy-loading bug only reachable through an endpoint no test called, broadcast logic that was internally consistent but produced a value that didn't match reality) were caught only by this kind of direct verification, not by anything automated.

## Agent-agnostic core

Do not bind product intent, architecture, decisions, or these principles to an agent-specific instruction file. `AGENTS.md` may contain only the routing and behavioral contract needed for any agent to find and follow these shared sources.

## Separated boundaries

Future implementations should separate domain concerns from external systems and tool integrations. Each adopting project must define its concrete technical boundaries in architecture documents and ADRs.

## Standards over reinvention

Prefer an established open standard or convention (AGENTS.md, GitHub Spec Kit, Agent Skills) over building an equivalent mechanism from scratch. Before adding a project-specific process, decision format, or file convention, check whether an open standard already solves it — see `ADR-0002`, `ADR-0006`, `ADR-0010`, `ADR-0011`, `ADR-0012` for concrete instances of this principle being applied.

## Project-specific principles

A project may add its own principles below this line, each with a real prose definition here — never a bare name only in `PROJECT.yaml`.

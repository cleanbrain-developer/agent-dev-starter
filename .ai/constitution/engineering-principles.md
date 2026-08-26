# Engineering Principles

This document defines engineering principles that should outlive a technology choice or an individual feature.

## Evidence before change

Inspect existing documentation and implementation first. Prefer repository evidence over assumptions, and do not propose changes based on a structure that has not been verified.

## Minimal, coherent change

Prefer the smallest coherent change that satisfies the requirement. Do not add speculative abstractions, features, or automation.

## Explicit architecture

Do not change architectural boundaries or conventions silently. Surface decisions that have long-term impact or are difficult to reverse, and record them in an ADR before or with implementation.

## Verifiable outcomes

Produce outcomes that can be verified. Run automated checks when they exist; otherwise state the verification method and its limitations. Distinguish guidance that requires judgment from rules that should be enforced by code, tests, linters, or CI.

## Agent-agnostic core

Do not bind product intent, architecture, decisions, or engineering principles to an agent-specific instruction file. An agent adapter may contain only the differences required to route its agent to shared sources.

## Separated boundaries

Future implementations should separate domain concerns from external systems and tool integrations. Each adopting project must define its concrete technical boundaries in architecture documents and ADRs.

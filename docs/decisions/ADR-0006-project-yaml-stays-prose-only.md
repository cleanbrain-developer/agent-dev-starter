# ADR-0006: `PROJECT.yaml` Stays Prose-Documented, No Machine Schema

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

Since 2026-08-27, `docs/status/current-state.md` carried an open decision on whether `PROJECT.yaml` should remain a simple manifest or receive a separate machine-validatable schema. Four real `PROJECT.yaml` files now exist (`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`). Every one of them used the same core fields correctly, and the two real optional-field extensions observed (`context.specs`, `context.related_repositories`) and the `principles` field mixing pattern are already documented in prose in `using-the-starter.md` (step 1) and `repository-structure.md` ("Optional context extensions"). No adoption has ever produced a malformed `PROJECT.yaml` that caused a real bootstrap-test failure or required a fix traceable to missing machine validation.

## Decision

`PROJECT.yaml` stays a prose-documented manifest. No JSON Schema, YAML schema, or validator is built. This mirrors the reasoning already accepted in `ADR-0002`: build no tooling for a problem no real adoption has actually produced.

## Consequences

### Positive

- No schema-maintenance burden that would need to track every optional field pattern as it is discovered.
- Consistent with the "evidence before change" principle — nothing here has failed in practice.

### Costs and risks

- A malformed `PROJECT.yaml` (a typo in a field name, wrong type) is caught only by the bootstrap acceptance test noticing missing or wrong context, not by an earlier, cheaper check.
- If a future adoption's `PROJECT.yaml` actually causes a real bootstrap failure traceable to a structural error, revisit this with a new ADR — this decision is not permanent the way `ADR-0002`'s is, because it answers a narrower, more mechanical question.

## Alternatives considered

### JSON Schema with a validator script

Rejected for now: no real adoption has needed it. Building it speculatively would repeat the mistake `ADR-0002` explicitly avoided for the CLI/template question.

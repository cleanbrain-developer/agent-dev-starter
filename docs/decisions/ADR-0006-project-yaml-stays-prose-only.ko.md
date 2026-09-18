> 이 문서는 [`ADR-0006-project-yaml-stays-prose-only.md`](ADR-0006-project-yaml-stays-prose-only.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0006: `PROJECT.yaml`은 prose 문서로만 남고, 기계 스키마는 없음

- Status: Accepted
- Date: 2026-09-18
- Deciders: Project maintainer

## Context

2026-08-27부터 `docs/status/current-state.md`는 `PROJECT.yaml`이 단순한 manifest로 남을지, 별도의 기계 검증 가능한 스키마를 받을지에 대한 open decision을 가지고 있었습니다. 이제 4개의 실제 `PROJECT.yaml` 파일이 존재합니다(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`). 그중 어느 것도 core 필드를 잘못 쓴 적이 없었고, 실제로 관찰된 두 가지 optional 필드 확장(`context.specs`, `context.related_repositories`)과 `principles` 필드 혼합 패턴은 이미 `using-the-starter.md`(step 1)와 `repository-structure.md`("Optional context extensions")에 prose로 문서화되어 있습니다. 지금까지 어떤 adoption도 실제 bootstrap-test 실패로 이어지거나, 기계 검증이 없어서 생긴 문제로 추적 가능한 잘못된 `PROJECT.yaml`을 만든 적이 없습니다.

## Decision

`PROJECT.yaml`은 prose로 문서화된 manifest로 남습니다. JSON Schema, YAML schema, validator는 만들지 않습니다. 이건 `ADR-0002`에서 이미 받아들여진 논리와 같습니다: 실제 adoption이 실제로 만들어내지 않은 문제를 위한 tooling은 만들지 않는다.

## Consequences

### Positive

- 발견되는 optional 필드 패턴마다 추적해야 하는 스키마 유지보수 부담이 없습니다.
- "변경 전 증거 확인" 원칙과 일치합니다 — 실제로 실패한 적이 없습니다.

### Costs and risks

- 잘못된 `PROJECT.yaml`(필드 이름 typo, 잘못된 타입)은 더 저렴하고 이른 검사가 아니라, bootstrap acceptance test가 context가 없거나 잘못됐다고 알아차릴 때만 잡힙니다.
- 만약 미래의 adoption에서 `PROJECT.yaml`이 구조적 오류로 실제 bootstrap 실패를 일으킨다면, 새 ADR로 재검토하세요 — 이 결정은 `ADR-0002`처럼 영구적이지 않습니다, 더 좁고 기계적인 질문에 답하는 것이기 때문입니다.

## Alternatives considered

### validator script가 있는 JSON Schema

지금은 기각되었습니다: 어떤 실제 adoption도 이걸 필요로 한 적이 없습니다. 추측성으로 만드는 건 `ADR-0002`가 CLI/template 질문에서 이미 피한 것과 같은 실수를 반복하는 것입니다.

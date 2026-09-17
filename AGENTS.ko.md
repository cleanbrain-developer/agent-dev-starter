> 이 문서는 [`AGENTS.md`](AGENTS.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Codex Project Adapter

이 파일은 Codex 호환 agent를 위한 repository entry point입니다. 여기에 project 정책이나 design을 중복 서술하지 마세요. 공유 source of truth는 아래와 같습니다.

## Context bootstrap

먼저 `PROJECT.yaml`을 읽고, `docs/architecture/agent-context-model.md`에 정의된 bootstrap 순서와 conflict-handling 규칙을 따르세요. 이 adapter는 그 순서를 다시 서술하지 않습니다 — 이 목록과 해당 문서가 서로 다르면 `agent-context-model.md`가 우선합니다.

## Working contract

- 계획하거나 변경하기 전에 repository 증거를 조사한다.
- 요청을 충족하는 가장 작은 일관된 변경을 선호한다.
- 아키텍처를 조용히 바꾸지 않는다. 중요한 결정은 ADR에 기록한다.
- 완료를 주장하기 전에 가능한 검증을 수행하고, 검증된 결과와 검증되지 않은 항목을 구분한다.
- durable한 결정과 working-state 변경은 같은 변경 안에서 올바른 source of truth에 반영한다.
- 대화 이력이나 이 adapter를 장기 design 소스로 취급하지 않는다.

현재 phase와 다음 작업의 source of truth는 항상 `docs/status/current-state.md`를 사용하세요.

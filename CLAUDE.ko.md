> 이 문서는 [`CLAUDE.md`](CLAUDE.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Claude Code Project Adapter

이 파일은 Claude Code를 위한 repository entry adapter입니다. 공유 정책이나 project design의 source of truth가 아니며, Claude Code를 아래 repository context로 안내하는 역할만 합니다.

## Required context

먼저 `PROJECT.yaml`을 읽고, `docs/architecture/agent-context-model.md`에 정의된 bootstrap 순서와 conflict-handling 규칙을 따르세요. 이 adapter는 그 순서를 다시 서술하지 않습니다 — 이 목록과 해당 문서가 서로 다르면 `agent-context-model.md`가 우선합니다.

## Working contract

- 기존 증거를 조사하고 변경 계획을 준비한다.
- 가장 작고 일관된 변경을 구현하고, 검증하고, 최종 diff를 리뷰한다.
- 아키텍처 결정이나 durable state를 대화 이력에만 남기지 않는다.
- 공유 규칙은 이 adapter가 아니라 적절한 constitution이나 documentation 소스에 추가한다.
- 해결되지 않은 충돌과 open decision은 가정으로 조용히 처리하지 말고 명시적으로 드러낸다.

현재 phase와 다음 작업의 source of truth는 `docs/status/current-state.md`를 사용하세요.

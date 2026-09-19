> 이 문서는 [`AGENTS.md`](AGENTS.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# AGENTS.md

이 파일은 이 repository에서 작업하는 모든 코딩 agent를 위한 단일한, agent에 종속되지 않는 entry point입니다 — Claude Code, Codex, 또는 `AGENTS.md`를 읽는 다른 어떤 tool이든요. 이건 product, architecture, 원칙의 source of truth가 아니라, 그것들로 라우팅하고 여기서 모든 agent가 따를 행동 계약을 명시합니다.

## Context bootstrap

먼저 `PROJECT.yaml`을 읽고, `docs/architecture/agent-context-model.md`에 정의된 bootstrap 순서와 conflict-handling 규칙을 따르세요. 이 섹션은 그 순서를 다시 서술하지 않습니다 — 이 섹션과 그 문서가 서로 다르면 `agent-context-model.md`가 우선합니다.

## Working contract

### 작업 전

- `agent-context-model.md`가 정의한 순서로 persistent context를 로드한다.
- 현재 요청, `docs/status/current-state.md`, 관련 파일을 조사한다.
- 변경을 제안하기 전에 기존 문서와 구현에서 증거를 찾는다.
- 변경 작업이라면, 구현 전에 비례적인 계획과 검증 전략을 준비한다.

### 작업 중

- 사용자 요청과 accepted decision 범위 안에서 작업하고, 기존 변경사항은 사용자 소유로 취급한다.
- 중요한 가정과 아키텍처 변경사항을 조용히 결정하지 않고 드러낸다.
- 새 규칙은 올바른 source of truth에 한 번만 기록한다 — 절대 이 파일에는 기록하지 않는다.

### 완료 전

- 관련 검증을 수행하거나 왜 수행할 수 없었는지 명시한다; green한 자동화 검사와 실제 실행 중인 시스템에 대한 직접 검증을 구분한다.
- 최종 변경사항을 요구사항, 아키텍처, 문서 책임과 대조하여 리뷰한다.
- 다음 세션이 상태 변화를 알아야 한다면 `docs/status/current-state.md`를 갱신한다.
- 이 변경이 `.ko.md` companion을 가진 문서를 수정했다면, 같은 변경 안에서 companion도 갱신한다(`ADR-0005`) — 오래된 번역은 나중에 할 일이 아니라 결함이다.

완료를 주장하는 것과 검증을 보여주는 것은 다릅니다. 검증 증거 없이 성공을 주장하지 마세요.

## Conflict handling

- 사용자 요청은 작업 목표를 정의하지만, accepted architecture를 조용히 폐기하지 않는다.
- 구체적인 accepted ADR이 일반적인 architecture 설명보다 우선한다.
- `current-state.md`는 원칙이나 design을 재정의하지 않는다.
- 해결되지 않은 충돌은 가정 뒤에 숨기지 말고 보고한다.

현재 phase와 다음 작업의 source of truth는 `docs/status/current-state.md`를 사용하세요.

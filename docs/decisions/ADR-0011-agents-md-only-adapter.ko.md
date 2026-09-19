> 이 문서는 [`ADR-0011-agents-md-only-adapter.md`](ADR-0011-agents-md-only-adapter.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0011: `AGENTS.md`가 유일한 adapter이고, `CLAUDE.md`는 제거됨

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

`ADR-0001`은 `AGENTS.md`와 `CLAUDE.md`를 병렬적인 얇은 adapter로 확립했습니다, Claude Code가 `CLAUDE.md`만 읽었기 때문입니다. 이 결정 이틀 전에 그게 바뀌었습니다: Claude Code(v2.1.277부터, 2026-09-18)는 디렉터리에 `CLAUDE.md`가 없으면 이제 `AGENTS.md`를 네이티브로 읽는 fallback을 갖습니다. Codex는 항상 `AGENTS.md`를 직접 읽었습니다 — 이 convention이 원래 가리키던 열린, agent-agnostic한 표준입니다. 이 fallback이 생기면서, 별도의 `CLAUDE.md`를 유지하는 건 일반적인 경우엔 남는 이익 없이 `AGENTS.md`를 중복하는 것입니다.

## Decision

`AGENTS.md`가 유일하고 보편적인 agent entry point가 됩니다. `CLAUDE.md`는 ADS 자신의 foundation과 `docs/guides/using-the-starter.md`의 adopted file 목록에서 제거됩니다. `AGENTS.md`는 `.ai/constitution/agent-behavior.md`의 content도 흡수합니다(`ADR-0013` 참고), 별도 파일을 가리키는 대신요 — 열린 `AGENTS.md` convention 자체가 행동 지침이 그 안에 직접 있길 이미 기대하기 때문입니다.

프로젝트는 여전히 명시적이고 문서화된 예외로서 `CLAUDE.md`를 유지할 수 있습니다, 오직 2.1.277보다 오래된 Claude Code 버전을 위해 행동을 pin해야 하거나, 다른 모든 agent가 읽지 않길 의도적으로 원하는 Claude 전용 지침이 필요할 때만요. 이게 기본값은 아니며, 이 선택은 조용히 재도입하지 말고 그 project 자신의 `current-state.md`에 한 줄 메모로 기록해야 합니다.

## Consequences

### Positive

- 동기화해야 할 두 파일 대신 얇고 정확하게 유지할 파일이 하나입니다.
- 마지막 실질적 장애물(Claude Code가 그걸 안 읽던 것)이 사라진 지금, 열린 표준 자신의 의도(단일하고 tool에 종속되지 않는 entry file)를 그대로 따릅니다.

### Costs and risks

- `AGENTS.md`에 적합하지 않은 Claude 전용 routing이 정말로 필요한 project는, 기본으로 얻는 대신 의식적으로 얇은 `CLAUDE.md`를 다시 도입해야 합니다.
- Claude Code의 `AGENTS.md` fallback이 사용자 자신의 `/config` 설정으로 비활성화되면, 그 project는 `CLAUDE.md`가 다시 필요할 것입니다 — 이건 ADS가 통제하지 않는, 사용자별 Claude Code 설정이며, adopting maintainer가 알아둬야 합니다.

## Alternatives considered

### 무조건 둘 다 유지하기

기각되었습니다: Claude Code가 이제 `AGENTS.md`를 네이티브로 읽는 지금은 남는 이유가 없습니다; 더 이상 존재하지 않는 문제를 위해 `ADR-0001`이 이미 리스크로 지목한 중복 비용을 계속 치르게 됩니다.

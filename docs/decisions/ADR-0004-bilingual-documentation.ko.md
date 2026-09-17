> 이 문서는 [`ADR-0004-bilingual-documentation.md`](ADR-0004-bilingual-documentation.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다.

# ADR-0004: 이중언어 문서 (영어 canonical + 한국어 companion)

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

2026-08-27, 이 repository는 모든 durable한 문서를 영어로 표준화했습니다(`docs/status/current-state.md`의 이력 참고). 이후 maintainer는 `.ai/constitution/`, `docs/architecture/`, `docs/decisions/`처럼 agent 대상 문서를 포함해 모든 문서의 한국어 버전을 요청했습니다.

이건 `documentation-policy.md`의 "같은 정책을 여러 파일에 중복 서술하지 말라"와 `engineering-principles.md`의 "minimal, coherent change"와 실제로 긴장 관계에 있습니다: 모든 문서의 두 번째 언어 버전은 앞으로 있을 모든 수정마다 동기화해야 할 대상을 두 배로 늘리고, adopting project가 adoption 시 복사하는 대상도 두 배로 늘립니다 — `ADR-0002`가 밝힌 "실제 adoption 비용은 파일 수가 아니라 content adaptation"이라는 방향과 반대입니다.

## Decision

모든 Markdown 문서 옆에, agent 대상 문서를 포함해 repository의 모든 문서에 대해 `.ko.md` suffix를 쓰는 별도 파일(예: `README.md` + `README.ko.md`)로 한국어 번역을 추가합니다. `PROJECT.yaml`은 제외됩니다: 이건 prose가 거의 없는 머신 판독용 구조화 데이터이지, 언어 때문에 읽는 문서가 아니며, 두 번째 YAML 파일은 단순히 문구가 다른 게 아니라 실제로 다른 데이터로 두 파일이 갈라질 위험이 있습니다 — 이는 오래된 번역보다 더 나쁜 실패 형태입니다.

모든 쌍에서 영어가 canonical로 남습니다:

- `agent-context-model.md`의 bootstrap 순서와 두 agent adapter는 영어 파일만 읽습니다. Agent bootstrap은 `.ko.md` 파일을 절대 읽지 않습니다 — 이는 agent의 context 복구 비용을 지금 수준으로 유지하고, agent가 올바르게 동작하기 전에 번역이 먼저 갱신되어야 하는 요구를 피합니다.
- 모든 `.ko.md` 파일은 자신의 영어 원본을 가리키고 충돌 시 영어가 우선한다는 한 줄 안내로 시작합니다.
- 영어 문서가 바뀌면 그 `.ko.md` companion을 갱신하는 것이 기대되지만 같은 변경 안에서 필수는 아닙니다. 오래된 번역은 알려져 있고 받아들여진 지연이지, `current-state.md`가 오래됐을 때처럼 bootstrap이 깨지는 것은 아닙니다(`agent-context-model.md`의 "Working context" 참고) — agent가 그것에 절대 의존하지 않기 때문입니다.

Adopting project는 자신의 adoption 중에(`docs/guides/using-the-starter.md` step 4, "Review the constitution") 이 convention을 유지할지 독립적으로 결정하며, 그들에게 강제되지 않습니다.

## Consequences

### Positive

- Maintainer는 agent 작업(계속 영어 canonical 버전으로 동작하는)을 막거나 기다리지 않고 모든 문서를 한국어로 읽을 수 있습니다.
- 어떤 파일이 우선하는지가 명시적이라, 문서화되지 않은 이중언어 설정이 만들 "어느 언어가 authoritative한가"라는 모호함을 피합니다.

### Costs and risks

- 이제 모든 문서가 유지보수해야 할 두 개의 파일을 가집니다. `.ko.md` companion이 크게 뒤쳐지지 않도록 유지하는 건 지속적이고 강제되지 않는 비용입니다(아직 deterministic check가 없음 — `architecture/overview.md`의 "Enforcement boundary" 참고).
- `PROJECT.yaml`의 비대칭(한국어 companion 없음)은 의도된 scope로 이해되어야 하며, 이 ADR을 다시 검토하지 않고 나중에 이중언어 쌍으로 "고쳐지면" 안 됩니다.

## Alternatives considered

### 문서당 하나의 이중언어 파일(한 파일 안에 영어/한국어 섹션)

기각되었습니다: 한 파일에서는 언어별 섹션을 선택적으로 로드할 수 없으므로, agent가 영어 섹션만 읽더라도 매 bootstrap 단계마다 두 배를 읽게 됩니다. 이는 번역을 명확히 분리하거나 선택적으로 만들 수 있는 이점 없이, agent 입장에서 완전한 이중언어 bootstrap과 같은 비용을 치릅니다.

### 한국어만, 영어 canonical 없음

기각되었습니다: 2026-08-27에 내린 "하나의 언어로 표준화한다"는 결정을 포기하는 것이고, 미래에 지원될 agent의 tooling이나 ecosystem이 영어를 기본값으로 삼는다면 `supported_agents.policy: agent-agnostic-core`와도 배치될 수 있습니다.

### 저장하지 않고 그때그때 기계 번역

지금은 기각되었습니다: repository 자체에 durable하고 검토 가능한 한국어 텍스트를 남기지 않고, repository가 스스로 self-describing하는 대신 읽는 시점에 외부 프로세스에 대한 의존을 다시 만듭니다. 저장된 번역을 유지하는 게 실제로 너무 비용이 크다고 드러나면 재검토하세요.

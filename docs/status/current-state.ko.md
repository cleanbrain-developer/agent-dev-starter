> 이 문서는 [`current-state.md`](current-state.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Current State

Last updated: 2026-09-17

## Current phase

V1 foundation 검증 완료 — 스펙, adoption 절차, bootstrap contract가 4번의 독립적인 실제 adoption을 통해 입증되었습니다. 남은 작업은 계속되는 adoption에서 드러난 세부사항을 다듬는 것이며, 새로운 foundation을 추가하는 게 아닙니다.

## Completed

- V1 foundation을 확립함: repository-first context와 agent-agnostic core(`ADR-0001`), 책임별로 분리된 디렉터리 구조, 초기 지원 agent로서 Codex와 Claude Code, 수동 adoption 가이드(`docs/guides/using-the-starter.md`).
- fresh한 Codex-style, Claude Code-style session에서 bootstrap acceptance test를 실행함(2026-08-27)하고 이후 fix를 통해 다시 검증함; `AGENTS.md`, `CLAUDE.md`, `agent-context-model.md`, `overview.md`, `goals.md`에 걸쳐 bootstrap 읽기 순서와 다섯 가지 acceptance-test question을 중복 제거함(2026-09-09).
- Agent-driven adoption을 문서화하고 검증함(2026-09-09): agent가 maintainer의 자연어 설명으로부터 전체 절차를 대화형으로 수행할 수 있고, 가이드가 human input required로 표시한 곳에서만 질문한다; git repo/remote 생성과 첫 push는 항상 별도 확인이 필요하다.
- 4번의 실제 외부 adoption을 완료함 — `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo` — 각각 production에 배포되었거나 활발히 개발 중임. 각각 실제 gap을 드러냈고, 이제 가이드와 constitution에 고쳐짐: 구현 전/후 `delivery`/`lifecycle` 왕복; "clean"한 bootstrap-test session의 기준; adapter 파일 생성을 `supported_agents.initial`에 연결; 잘못된 adoption의 재시작/폐기 경로; stale한 `current-state.md`나 per-feature spec 상태를 결함으로 취급하고, 갱신 트리거를 "session 경계"에서 "배포되고 검증된 변경"으로 변경; green한 자동화 검사와 실제 실행 중인 시스템에 대한 직접 검증을 구분(`relayhub-java`에서 실제 production 결함 3건을 잡음); sibling repo에 걸친 반복 단계에 대한 침묵이 유추에 의한 거짓 완료로 읽히는 문제; 기존의 무관한 adapter content를 덮어쓰지 않고 보존; "Existing project" adoption 중 문서화되지 않은 기존 결정을 ADR로 소급 기록. 각각의 전체 서사는 git history에 있으며 여기서 반복하지 않습니다.
- `ADR-0002`(template repository와 CLI/initializer를 영구 폐기 — 4번의 adoption에서 실제 비용은 파일 복사가 아니라 content adaptation이었음)와 `ADR-0003`(skill은 project별이며 공유 ADS 라이브러리가 아님)을 accept함(2026-09-17); `docs/product/scope.md`와 `docs/product/goals.md`를 이에 맞게 갱신하고, `ADR-0003`을 adoption 절차에 optional step 9와 대응하는 checklist 항목, `repository-structure.md`의 optional `.ai/skills/` 행으로 연결함.
- 실제 사용에서 관찰됐지만 이전엔 문서화되지 않았던 `PROJECT.yaml` 필드 패턴을 문서화함(2026-09-17): `context`는 project 고유의 optional 경로(`specs:`, cross-repository dependency status 파일, `related_repositories:`)를 선언할 수 있고, `principles`는 유지되는 ADS core 원칙과 project 고유 원칙을 섞을 수 있다 — 단 project 고유 원칙마다 그 project 자신의 `.ai/constitution/engineering-principles.md`에 실제 prose 정의가 있어야 한다.
- 4번의 adoption 전체에서 반복된 패턴에 근거하여 multi-repository-relationship과 per-feature-spec-document open decision을 구체적인 optional convention으로 해결함(2026-09-17) — `docs/architecture/repository-structure.md`의 "Optional context extensions" 참고.

## In progress

- 현재 없음. Next를 참고하세요.

## Next

1. 기계적으로 검증 가능한 `PROJECT.yaml` 스키마에 필요한 필드와 검증 수준을 결정하기 — 필드 수준 의미는 이제 prose로 문서화되어 있지만, 기계적 검증은 아직 결정되지 않음.
2. 어떤 문서화 규칙을 test, linting, CI로 먼저 승격할지 결정하기.
3. 새로 추가된 `related_repositories`와 spec-document convention이 실제 adoption에서 잘 작동하는지, 수정이 필요한지 지켜보기.

## Open decisions

- `PROJECT.yaml`이 단순한 manifest로 남을지, 별도의 기계 검증 가능한 스키마를 받을지 (필드 수준 의미는 prose로 문서화됨; 기계적 검증만 남아있음)
- 어떤 문서화 규칙을 test, linting, CI로 먼저 승격할지
- 지원 agent가 늘어날 때 adapter 호환성을 어떻게 검증할지

## Known constraints

- 애플리케이션 코드, test suite, build system, CLI, 자동화가 없으며, 계획도 없습니다(`ADR-0002`).
- 초기 design 대화는 bootstrap 증거로만 사용됐고 향후 session에 필요한 context가 아닙니다.
- Adoption은 영구적으로 수동입니다 — `ADR-0002` 참고.

## V1 exit criteria

- 새 agent session이 외부 링크 없이 project 목적, 원칙, architecture, 현재 상태, 다음 작업을 정확히 복원한다. 충족됨.
- 그 답에 대한 모든 durable한 증거가 repository에 존재한다. 충족됨.
- 공유 design이 agent adapter에 중복되지 않는다. 충족됨.
- 다른 project가 문서화되지 않은 대화 context에 의존하지 않고 수동 가이드를 따라 foundation을 채택할 수 있다. 2026-09-17 기준 4번 충족됨: `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`.

네 가지 기준이 모두 충족되었습니다; V1은 검증되었습니다. `PROJECT.yaml`의 `current_phase`는 활발한 foundation 구축이 아니라 유지보수 태세를 반영합니다 — 남은 작업은 위 세 가지 `Next` 항목이며, V1을 닫기 위해 필요한 게 아니라 계속되는 adoption을 통해 발견된 것입니다.

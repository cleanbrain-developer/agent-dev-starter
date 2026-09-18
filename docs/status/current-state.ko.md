> 이 문서는 [`current-state.md`](current-state.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Current State

Last updated: 2026-09-18

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
- 이 repository의 모든 문서에 `.ko.md` 한국어 companion을 추가하고 `ADR-0004`를 accept함(2026-09-17): 영어가 canonical로 남고 agent bootstrap은 영어 파일만 읽는다; `PROJECT.yaml`은 prose가 아니라 구조화된 데이터라 companion이 없다.
- `ADR-0004`를 강화하는 `ADR-0005`를 accept함(2026-09-17): 이제 `.ko.md` companion은 모든 ADS-adopted project에서 필수이며(constitution 리뷰 중 검토되는 project별 선택이 아님), 영어 원본의 의미가 바뀔 때마다 같은 변경 안에서 갱신되어야 한다 — 오래된 companion은 `documentation-policy.md`의 "Maintenance" 규칙과 같은 수준의 결함이다. `agent-behavior.md`의 "Before completion" 체크리스트, `documentation-policy.md`의 "Language" 섹션, `using-the-starter.md`의 "Files to adopt"와 adoption checklist에 반영됨. 이미 채택된 4개 project 전부에 소급 적용됨.
- `cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java` 세 곳에 `.ko.md` companion을 소급 적용함(`kioti-crm-discount-enhance-demo`는 이번 세션에서 접근 가능한 디렉터리 밖이라 아직 보류)(2026-09-17/18).
- 증거 기반 ADR로 남아있던 open decision 세 개를 모두 닫음(2026-09-18): `ADR-0006`은 `PROJECT.yaml`을 prose 문서로 유지하고 기계 스키마는 만들지 않기로 함 — 어떤 실제 adoption도 스키마가 잡아줄 만한 구조적 실패를 만든 적이 없음. `ADR-0007`은 (완전히 기계적인 유일한 규칙인) `.ko.md` 완전성 규칙을 `scripts/check-ko-companions.sh`를 통한 첫 deterministic check로 승격함 — 수동 실행이며 CI에 연결하지 않음, 수동 실행으로 충분하지 않다는 게 드러나지 않았기 때문. `ADR-0008`은 미래의 새 agent에 대한 adapter 호환성 검증에 답함: 새 메커니즘을 만들지 않고, Codex/Claude Code에서 이미 증명된 bootstrap acceptance test를 그 agent의 entry adapter로 실행하는 것으로 재사용함.

- `ADR-0007`을 수정하는 `ADR-0009`를 accept함(2026-09-18), maintainer의 명시적 선호에 따라: 이미 CI pipeline을 가진 모든 ADS-adopted project는 기본적으로 기존 `test` job에서 `scripts/check-ko-companions.sh --missing-only`를 실행하고, companion 누락 시 build를 실패시켜야 한다. fresh CI checkout이 mtime을 리셋해서 staleness heuristic이 거기서 무의미해지기 때문에, 스크립트 자체에 `--missing-only` flag를 추가함. `using-the-starter.md`의 "Files to adopt"와 adoption checklist에 반영됨. CI를 가진 이미 채택된 3개 project(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`)에 적용하는 작업이 진행 중.

## In progress

- CI를 가진 이미 채택된 3개 project에 `ADR-0009`의 CI step을 소급 적용하는 중(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`).

## Next

1. 새로 추가된 `related_repositories`와 spec-document convention이 실제 adoption에서 잘 작동하는지, 수정이 필요한지 지켜보기.
2. `kioti-crm-discount-enhance-demo`에 다시 접근 가능해지면 `.ko.md` companion과 `ADR-0009`의 CI step을 소급 적용하기.
3. `ADR-0006`/`ADR-0007`이 전제한 "아직 증거 없음"이 미래의 adoption 경험과 어긋나면 재검토하기(실제 `PROJECT.yaml` 구조적 실패, 또는 수동 검사로 충분하지 않을 만큼 심하게 표류한 `.ko.md`).

## Open decisions

현재 열려있는 open decision이 없습니다. 2026-08-27/09-09부터 열려있던 세 가지는 2026-09-18에 `ADR-0006`, `ADR-0007`, `ADR-0008`로 닫혔습니다.

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

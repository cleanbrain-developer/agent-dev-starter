> 이 문서는 [`current-state.md`](current-state.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`). Agent bootstrap은 이 번역본이 아니라 영어 원본을 읽습니다.

# Current State

Last updated: 2026-09-20

## Current phase

**V2: 열린 표준으로 migration 완료.** ADS는 더 이상 spec/plan/tasks convention을 재구현하거나 비표준 agent-adapter/skill 경로를 지어내지 않습니다 — 이제 `AGENTS.md`, GitHub Spec Kit, Agent Skills 위에 얹힌 opinionated profile입니다(`ADR-0010`부터 `ADR-0013`까지). V1의 foundation(repository-first context, `PROJECT.yaml`, ADR discipline, `current-state.md`, 필수 이중언어 문서화)은 보존되었습니다; V1이 표준을 먼저 확인하지 않고 재발명했던 부분들만 교체되었습니다.

## Completed

**V1(2026-08-26 – 2026-09-18), 압축됨 — 전체 서사는 git history에 있으며 여기서 반복하지 않습니다:**
- Repository-first context(`ADR-0001`), 책임별로 분리된 구조, agent-driven adoption 절차를 확립함.
- 4번의 실제 adoption(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`)에 걸쳐 foundation을 검증함, 각각 실제 gap을 가이드와 constitution에 피드백함.
- template repository, ADS 전용 CLI, 공유 skill 라이브러리를 adoption 증거에 근거해 영구 폐기함(`ADR-0002`, `ADR-0003`).
- 모든 문서를 필수적으로 이중언어화함(영어 canonical, `.ko.md` companion, 매 변경마다 cascade, CI에서 기본으로 검사) — `ADR-0004`, `ADR-0005`, `ADR-0009`.
- 무기한 열어두지 않고 증거 기반 ADR로 남아있던 모든 open decision을 닫음(`ADR-0006`, `ADR-0007`, `ADR-0008`).

**V2(2026-09-20) — standards-alignment migration:**
- `ADR-0010`: `specify-cli==1.0.8`(GitHub Spec Kit)을 모든 adoption에 필요한 버전으로 pin함, ADS가 이 세션에서 검증할 수 없는 렌더링된 skill 파일을 손으로 vendor하는 대신(이 세션에는 CLI를 실제로 실행할 동작하는 Python/`uv` toolchain이 없었음).
- `ADR-0011`: `CLAUDE.md`를 제거함. `AGENTS.md`가 이제 모든 지원 agent를 위한 유일한 adapter입니다, Claude Code가 `AGENTS.md`를 네이티브로 읽기 시작했기 때문에(v2.1.277, 2026-09-18) 두 adapter를 동기화할 마지막 이유가 사라졌습니다.
- `ADR-0012`: `ADR-0003`의 지어낸 `.ai/skills/` 경로를 실제 agent가 discover하는 `.claude/skills/`와 `.agents/skills/`로 정정함 — 어떤 agent tool도 실제로 옛 경로를 읽은 적이 없습니다.
- `ADR-0013`: `.ai/constitution/engineering-principles.md`를 `.specify/memory/constitution.md`(GitHub Spec Kit 자신의 constitution 역할)로, `.ai/constitution/agent-behavior.md`를 `AGENTS.md`로 직접 병합함. `.ai/constitution/documentation-policy.md`만 남습니다, 문서 소유권이나 언어 정책은 어떤 열린 표준도 소유하지 않기 때문입니다.
- `docs/guides/using-the-starter.md`, `docs/architecture/{overview,repository-structure,agent-context-model}.md`, `docs/product/{overview,goals,scope}.md`, `PROJECT.yaml`, `README.md`를 위 내용에 맞게 다시 작성함 — adoption이 이제 pinned Spec Kit CLI를 설치하고 실제 skill 파일을 생성합니다, ADS가 자기 버전을 제공하는 대신.
- `documentation-policy.md`의 "Status hygiene" 규칙에 따라 이 파일의 V1 이력을 압축함(위에 문서화됨), 그 규칙이 금지하는 정확히 그런 changelog가 되어버렸기 때문입니다.

## In progress

- 이번 세션에서 접근 가능한 이미 채택된 3개 project(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`)에 V2 migration을 소급 적용하는 중: `CLAUDE.md` 제거, constitution 파일 병합, pinned Spec Kit CLI 설치, project 고유 skill을 올바른 경로로 이동, 이제 대체된 V1 시절 문서 제거.

## Next

1. 다시 접근 가능해지면 `kioti-crm-discount-enhance-demo`에도 V2 migration을 소급 적용하기(다른 세 곳과 동일하게).
2. 실제 `specify init` 실행으로 이 guidance를 검증하기 — 이 세션에는 동작하는 Python/`uv` toolchain이 없어서, `using-the-starter.md`의 Spec Kit 설치 step은 실제로 CLI를 실행해본 게 아니라 Spec Kit 자신의 문서와 원본 template 소스로부터 작성됐습니다(`ADR-0010`). V2 아래의 첫 실제 adoption이 이 guidance가 실제 CLI 결과와 맞는지 확인해야 합니다.
3. 새로 추가된 `related_repositories`와 spec-document convention(이제 Spec Kit 자신의 `specs/`)이 실제 adoption에서 잘 작동하는지, 수정이 필요한지 지켜보기.
4. `ADR-0006`/`ADR-0007`이 전제한 "아직 증거 없음"이 미래의 adoption 경험과 어긋나면 재검토하기(실제 `PROJECT.yaml` 구조적 실패, 또는 수동 검사로 충분하지 않을 만큼 심하게 표류한 `.ko.md`).

## Open decisions

현재 열려있는 open decision이 없습니다.

## Known constraints

- ADS 전용 애플리케이션 코드, test suite, build system, CLI가 없으며, 계획도 없습니다(`ADR-0002`). GitHub Spec Kit 자신의 CLI는 adopting project에게 필요한 외부 의존성이며, `ADR-0010`으로 pin되어 있습니다.
- 초기 design 대화는 bootstrap 증거로만 사용됐고 향후 session에 필요한 context가 아닙니다.
- Adoption은 영구적으로 수동입니다 — `ADR-0002` 참고.
- 이 세션은 실제 Spec Kit CLI를 실행해서 그 렌더링 결과를 검증할 수 없었습니다(`ADR-0010`과 Next 항목 2 참고) — 이건 가상의 문제가 아니라 실제 gap입니다, 첫 실제 V2 adoption이 이를 확인하기 전까지는요.

## Exit criteria

- `AGENTS.md`만으로 시작하는 새 agent session이 외부 링크 없이 project 목적, 원칙, architecture, 현재 상태, 다음 작업을 정확히 복원한다. 충족됨.
- 그 답에 대한 모든 durable한 증거가 repository에 존재한다. 충족됨.
- 공유 design이 여러 agent adapter에 중복되지 않는다 — 정확히 하나만 있다. 충족됨(`ADR-0011`).
- 다른 project가 문서화되지 않은 대화 context에 의존하지 않고 수동 가이드를 따라 foundation을 채택할 수 있다. V1 기준으로 4번 충족됨; V2의 guidance는 아직 실제 adoption으로 검증되지 않았습니다(Next 항목 2 참고).
- 열린 표준(`AGENTS.md`, GitHub Spec Kit, Agent Skills)이 이미 같은 문제를 해결하는 ADS 메커니즘이 없다. 이번 migration 기준으로 충족됨; 새 메커니즘이 제안될 때마다 다시 확인하세요.

> 이 문서는 [`using-the-starter.md`](using-the-starter.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Using the Starter

이 가이드는 다른 project에서 Agent Development Starter를 채택하는 절차를 정의합니다. 이 과정은 design상 수동이며, 영구적으로 그렇습니다 — 미래의 template이나 CLI를 기다리는 임시방편이 아닙니다. `ADR-0002`를 참고하세요.

## 기대 결과

Adoption 이후, 대상 repository는 self-describing해야 합니다. fresh한 Codex나 Claude Code 세션은 그것을 만든 대화에 접근하지 않고도 project의 목적, 원칙, architecture, 현재 상태, 다음 작업을 복원할 수 있어야 합니다.

## Adoption mode 선택

### New project

빈 Git repository로 시작해서 Starter foundation 파일을 복사하고, 애플리케이션 코드를 구현하기 전에 repository를 project별로 만드세요. `PROJECT.yaml`의 `delivery` flag와 `project.lifecycle`/`current_phase`는 이 단계에서 필연적으로 구현 전 상태(예: `implementation_present: false`, lifecycle `design`)로 설정됩니다. 코드가 아직 없기 때문입니다. 첫 구현이 완료되면 이 필드들을 다시 확인해야 한다는 걸 같은 단계에서 `docs/status/current-state.md`의 `Next` 항목으로 기록하세요 — 이 왕복을 나중의 놀라움으로 남기지 마세요.

### Existing project

애플리케이션 코드나 이미 확립된 문서를 대체하지 않고 기존 repository에 foundation을 추가하세요. 먼저 기존 authoritative 문서를 ADS 책임에 매핑하세요. 중복을 만들기보다 하나의 source of truth를 링크하거나 옮기는 걸 우선하세요.

초기 build-out이 한참 지난 뒤 채택된 project는 대체로 이전 세션들에서 만들어지고 구현된 중요한 아키텍처 결정을 가지고 있지만, 어디에도 durable하게 기록되어 있지 않습니다 — 오직 대화 이력과, 잘해봐야 코드 주석에만 있습니다. 이를 찾아내는 걸 step 5("Record accepted decisions")의 일부로 취급하세요, 선택적인 추가 작업이 아니라: 구현과 그 주석, 가능하다면 commit/session 이력을 읽어서 ADR 기준(그 기준이 어떤 모습인지는 `docs/decisions/ADR-0001-repository-first-context.md` 자신의 context를 참고하세요)을 충족하지만 한 번도 기록된 적 없는 결정을 찾고, 같은 adoption pass 동안 ADR로 작성하세요 — adoption 시점으로 날짜를 매기고 새 결정이 아니라 기존 결정을 문서화한다는 메모를 남기세요. "이 adoption은 소급적이다"를 이걸 건너뛸 이유로 삼지 마세요 — `docs/decisions/`가 adoption 날짜부터만 시작하고, 가장 중요한 기존 동작이 왜 그렇게 동작하는지에 대한 기록이 없는 repository는, ADR-0001이 메우려는 gap을 실제로 메우지 못한 것입니다.

### Adoption 시도를 재시작하거나 폐기하기

Adoption 시도는 폐기하고 재시작해야 할 수도 있습니다 — 예를 들어 project 이름이 바뀌거나, 이전 시도가 foundation을 잘못 적용한 경우입니다. 이를 별도 절차가 아니라 "New project"나 "Existing project" 모드의 새로운 adoption으로 취급하세요: 폐기된 시도를 patch하는 대신, 기존 `PROJECT.yaml`, `.ai/constitution/`, `docs/product/`, `docs/architecture/`, `docs/status/current-state.md` content를 버리고 아래 관련 step부터 다시 시작하세요. 로컬 project 디렉터리나 이미 만들어진 remote repository를 삭제하는 건 각각 되돌릴 수 없는 out-of-band 작업입니다 — repository/remote 생성이 필요로 하는 것과 같은 방식으로, 둘 중 하나를 하기 전에 maintainer의 명시적 확인을 받으세요("Who performs the adoption" 참고).

### 누가 adoption을 수행하는가

위 두 모드 모두 사람이 아래 step을 직접 수행하거나, AI 코딩 agent가 같은 step을 대화형으로 수행할 수 있습니다. Agent-driven adoption에서는 maintainer가 대상 project를 자연어로 설명하고(무엇이고, 무엇을 하고, 무엇이 필요한지), agent가 기계적인 작업을 수행합니다 — 파일 복사, `PROJECT.yaml`과 product/architecture 문서 초안 작성, `current-state.md` 재설정, stale한 Starter 용어 제거, acceptance test 실행 — 아래 "Adapt the repository in this order"에서 **(human input required)**로 표시된 항목에 대해서만 멈춰서 maintainer에게 묻습니다. Adoption을 수행하는 agent는 maintainer가 제공하지 않은 product, scope, architecture content를 발명해서는 안 되며, 대신 물어봐야 합니다. 새 Git repository나 remote를 만드는 것, 그리고 첫 push는 외부에 흔적을 남기는 out-of-band 작업입니다 — agent는 adoption 수행 자체를 요청받은 것과 별개로, 둘 중 하나를 하기 전에 명시적 확인을 받아야 합니다.

## Foundation 확보하기

[ADS GitHub repository](https://github.com/cleanbrain-developer/agent-dev-starter)에서 source archive를 다운로드하거나 임시 디렉터리로 clone하세요 — 다른 배포 메커니즘은 없고, 계획도 없습니다(`ADR-0002`). 아래 나열된 foundation 경로만 대상 repository로 복사하세요. Starter의 `.git/` 디렉터리는 절대 복사하지 마세요.

의도적으로 canonical한 복사 명령어는 없습니다. 손으로 복사하거나 agent가 대화형으로 수행하는 것("Who performs the adoption" 참고)이 영구적인 adoption 경로이지, 나중에 자동화될 placeholder가 아닙니다.

## 채택할 파일

다음 경로를 V1 foundation으로 복사하세요:

```text
PROJECT.yaml
AGENTS.md
CLAUDE.md
.ai/constitution/
docs/product/
docs/architecture/
docs/decisions/
docs/status/current-state.md
```

대상 project의 `supported_agents.initial` 목록에 실제로 있는 agent에 대해서만 agent adapter(`AGENTS.md` 또는 `CLAUDE.md`)를 복사하세요 — 이건 step 1의 "Keep only agents that the target project supports"와 같은 결정이며, content뿐 아니라 어떤 adapter 파일이 존재하는지 자체에도 적용됩니다. project가 지원하지 않는 agent를 위한 빈 placeholder로 adapter 파일을 만들지 말고, adapter 중에 고르라고 별도 step으로 maintainer에게 묻지 마세요; `supported_agents.initial`이 정해지면 그 집합에서 바로 도출하세요.

대상 repository의 `AGENTS.md`나 `CLAUDE.md`는 ADS와 무관한 이유로 이미 존재할 수 있습니다 — 예를 들어 `create-next-app`이나 다른 scaffolding tool이 repository-first context와 아무 관련 없는 tool 고유의 notice(framework breaking change, 버전별 문서 링크)가 담긴 `AGENTS.md`를 이미 작성했을 수 있고, Claude Code project가 이미 `CLAUDE.md`의 `@path` import 문법으로 그 content를 끌어오고 있을 수 있습니다. ADS routing section을 위해 이런 기존의, load-bearing한 adapter content를 덮어쓰지 마세요. 대신 기존 content를 접근 가능하게 유지하고(예: `CLAUDE.md` 맨 위의 `@AGENTS.md` import 줄을 보존), 같은 파일 안에 ADS routing section을 그 아래에 추가하세요. 이걸 "Existing project" 모드의 일반 규칙과 동일하게 취급하세요: 먼저 이미 있는 것을 매핑하고, 대체하기보다 하나의 working 소스를 유지하는 걸 우선하세요.

대상 project 자신의 `README.md`, Git history, remote, source tree, build 설정, quality tooling은 만들거나 유지하세요. 대상 repository가 스스로 Starter를 배포할 게 아니라면 `docs/guides/using-the-starter.md`는 복사하지 마세요. project별 guide는 실제 책임이 있을 때만 추가하고, 대상에 guide 디렉터리가 없다면 `PROJECT.yaml`에서 `context.guides`를 제거하세요.

## 이 순서로 repository를 조정하기

아래 각 step은 maintainer의 자연어 project 설명으로부터 초안을 작성할 수 있는지, 아니면 maintainer 자신의 판단이 필요한지를 표시합니다. "Agent-fillable"은 maintainer가 이미 말한 것으로부터 첫 초안을 만들 수 있다는 뜻입니다 — 그래도 실제로 말한 것만 반영해야 하고, 절대 세부사항을 발명하지 않습니다. "(human input required)"는 agent가 추측하지 말고 멈춰서 물어봐야 한다는 뜻입니다.

### 1. Project identity 정의하기 — service 설명으로부터 agent-fillable; delivery/lifecycle 상태는 maintainer에게 확인 (human input required)

먼저 `PROJECT.yaml`을 수정하세요.

- Project 이름, repository 이름, type, lifecycle, purpose, current phase를 교체한다.
- 대상 project가 지원하는 agent만 남긴다.
- 나열된 모든 원칙을 검토한다; project가 따르지 않을 원칙은 유지하지 않는다. (human input required — team이 실제로 따를 원칙은 maintainer가 결정)
- `principles`는 유지되는 ADS core 원칙과 이 project 고유의 원칙을 함께 나열할 수 있다. 단, project 고유 원칙마다 이 project 자신의 `.ai/constitution/engineering-principles.md`에 실제 prose 정의가 있어야 한다 — `PROJECT.yaml`에 정의 없이 이름만 있는 건 절대 안 된다.
- `context`는 이 project가 필요로 하는 실제적이고 뚜렷한 책임을 가진 경로가 있을 때, core set(`human_entrypoint`, `agent_entrypoints`, `constitution`, `product`, `architecture`, `decisions`, `current_state`)을 넘어서는 canonical 경로를 추가할 수 있다 — 예를 들어 전용 feature-specification 디렉터리를 위한 `specs:`, 또는 cross-repository dependency를 추적하는 status 파일(`docs/architecture/repository-structure.md`의 "Optional context extensions" 참고). `guides`나 대상 project가 쓰지 않는 다른 optional 필드는 지운다; stale한 placeholder로 남기지 않는다.
- 대상 repository가 다른 위치를 쓴다면 canonical context 경로를 정확하게 유지한다.
- delivery flag를 대상 project의 실제 상태로 설정한다. (human input required — agent는 듣거나 repository를 조사하지 않고는 실제로 무엇이 구현됐는지 알 수 없다) 첫 구현이 실제로 완료되면 위 "New project"의 메모대로 `delivery`와 `lifecycle`/`current_phase`를 다시 확인한다 — 구현 전 값으로 남겨두지 않는다.

`PROJECT.yaml`을 narrative한 design 문서로 쓰지 마세요. 상세한 설명은 `docs/` 아래에 속합니다.

### 2. Product 정의하기 — service 설명으로부터 agent-fillable, 발명하지 않고 open item으로 표시

`docs/product/` 아래의 Starter 고유 content를 교체하세요.

- `overview.md`: 문제, 사용자, product thesis
- `goals.md`: 측정 가능한 목표와 success criteria
- `scope.md`: 현재 in-scope/out-of-scope 경계

알려진 사실을 쓰고 open decision을 명시적으로 표시하세요. 문서를 완성돼 보이게 하려고 요구사항을 발명하지 마세요. maintainer의 설명이 목표, 사용자, scope 경계를 정하지 않은 채로 남겨뒀다면, 그럴듯한 추측으로 채우지 말고 물어보세요(human input required).

### 3. Architecture 정의하기 — service 설명과 repository 조사로부터 agent-fillable, 실제 open decision은 표시

`docs/architecture/` 아래 content를 교체하거나 확장해서 ADS가 아니라 대상 시스템을 설명하게 하세요.

최소한 다음을 문서화하세요:

- 시스템 경계와 주요 컴포넌트
- 의존 방향과 소유권 경계
- 외부 integration
- 구현에 영향을 주는 데이터/제어 흐름
- agent가 보존해야 할 제약사항

`agent-context-model.md`와 repository documentation model이 여전히 적용 가능하면 유지하세요. project에 정당하고 문서화된 차이가 있으면 조정하세요.

이 project가 여기서 완전히 통제하지 못하는 다른 repository에 의존하거나, 그 repository로부터 의존받거나, infra(namespace, 배포 host)를 공유한다면, related-repositories 문서를 추가하고 `PROJECT.yaml`의 `context` 블록에 선언하세요 — `docs/architecture/repository-structure.md`의 "Optional context extensions" 참고.

### 4. Constitution 검토하기 (human input required)

`.ai/constitution/` 아래 모든 파일을 project maintainer와 함께 검토하세요.

- team이 진심으로 따를 durable한 engineering 원칙을 유지한다.
- 안정적으로 유지될 원칙만 project-independent하게 추가한다.
- product 요구사항과 architecture 고유 규칙은 constitution이 아니라 각자의 전용 문서에 둔다.
- 절대 위반되면 안 되는 규칙은 deterministic enforcement를 계획한다.

Adoption을 수행하는 agent는 재사용 가능해 보이는 원칙을 제안할 수 있지만, 유지/제거/추가 결정은 maintainer에게 속합니다.

### 5. Accepted decision 기록하기 — 기계적으로 agent-fillable; 결정 자체는 maintainer에게 확인 (human input required)

대상 project가 repository-first context를 채택한다면 ADR-0001을 유지하세요. 필요하면 날짜와 decider를 갱신하되, decision과 consequences는 보존하세요.

Accepted되고 significant한 결정에 대해서만 추가 ADR을 만드세요. 모든 취향이나 task 메모를 ADR로 만들지 마세요.

### 6. Working state 재설정하기 — service 설명과 repository 상태로부터 agent-fillable

대상 project를 위해 `docs/status/current-state.md`를 다시 작성하세요.

다음만 포함하세요:

- 현재 phase
- 완료된 foundation 작업
- 진행 중인 작업
- 순서가 있는 다음 작업
- Open decision
- 알려진 제약사항
- 현재 phase의 exit criteria

대상 project에 적용되지 않는 ADS 고유의 진행상황과 open decision은 전부 제거하세요.

### 7. 사람 대상 entry point 갱신하기

대상 project의 사람 사용자를 위해 `README.md`를 작성하세요. Project를 소개하고, 해당되면 실행/기여 방법을 설명하고, canonical project 문서로 링크해야 합니다. ADS의 product 설명을 derived project에 복사하지 마세요.

### 8. Agent adapter를 얇게 유지하기

`AGENTS.md`와 `CLAUDE.md`를 검토하되, 실제 tool 고유의 필요나 바뀐 canonical 경로에 대해서만 변경하세요.

Product 요구사항, architecture 규칙, status를 adapter에 복사하지 마세요. 두 adapter 모두 같은 공유 source of truth로 이어져야 합니다.

### 9. Project skill 정의하기 — optional (human input required)

이 project에 Skill로 담아둘 만한 project 고유의 반복 workflow가 있는지 maintainer에게 물어보세요(`ADR-0003` 참고). product나 architecture 문서로부터 유추하지 말고, `.ai/skills/`를 빈 placeholder로 만들지 마세요 — maintainer가 실제 반복 workflow를 하나라도 설명한 뒤에만 만드세요. maintainer에게 없다면 이 step은 완전히 건너뛰세요; 지금 억지로 만들지 말고 나중에 필요해지면 다시 다루세요. 이렇게 정의된 skill은 오직 이 project에만 속합니다 — maintainer의 명시적 지시 없이 한 adopted project의 skill을 다른 project로 복사하지 마세요.

## Stale한 Starter context 제거하기

첫 구현 작업 전에, 대상 repository에서 다음과 같은 Starter 고유 용어를 검색하세요:

```text
Agent Development Starter
agent-dev-starter
ADS
V1 Foundation
```

남아있는 모든 항목은 의도적으로 관련이 있어야 합니다. 날짜, repository URL, lifecycle 값, delivery flag, open decision도 확인하세요.

## Bootstrap acceptance test 실행하기

setup 대화에 접근할 수 없는 clean session을 여세요. "Clean"은 adoption을 수행한 대화로부터 격리되어 있다는 뜻이지, 반드시 maintainer가 손으로 연 session이어야 한다는 뜻은 아닙니다: adoption을 수행하는 agent는 adoption session과 대화 이력이나 memory를 전혀 공유하지 않고 entry adapter 외에는 아무것도 받지 않는 subagent(또는 그에 준하는 격리된 session)에 이 test를 위임해서 만족시킬 수 있습니다. session을 실격시키는 건 setup 대화나 그 context에 대한 접근이지, 누가 시작했는지가 아닙니다.

Codex의 경우 다음을 사용하세요:

```text
Read AGENTS.md and explain:
1. what this project is,
2. why it exists,
3. its core principles and architecture,
4. its current status,
5. what should be done next.
Include the repository path supporting each answer.
```

Claude Code의 경우 `CLAUDE.md`부터 시작하는 동등한 test를 실행하세요.

두 agent 모두 repository 파일에 근거한 일관된 답을 줄 때만 adoption이 통과합니다. 답이 없거나, 일관되지 않거나, 가정에 기반했다면 source of truth나 adapter routing을 고치세요.

## Project 작업 시작하기

Bootstrap test를 통과한 후:

1. 채택된 foundation을 리뷰 가능한 baseline으로 commit하세요. agent가 adoption을 수행했다면, Git repository나 remote를 만드는 것과 첫 push는 각각 사전에 maintainer의 명시적 확인이 필요합니다 — adoption 자체가 이런 행동에 대한 동의를 의미하지 않습니다.
2. 간결한 task prompt로 첫 작업을 시작하세요.
3. agent가 repository로부터 durable한 context를 복원하게 하세요.
4. 새로 accepted된 결정은 ADR에 반영하세요.
5. 다음 session이 다른 진행상황을 알아야 할 때마다 current state를 갱신하세요. 이 트리거는 자연스러운 session 경계를 기다리지 않습니다: 초기 build-out이 지나 반복적인 기능 요청 단계에 들어가면 흔히 있는 일인데, 작은 maintainer 지시 변경 여러 개를 연달아 배포하는 하나의 긴 session이, 어떤 개별 변경도 "phase의 끝"처럼 느껴지지 않아서 `current-state.md`를 한 번도 갱신하지 않고 지나갈 수 있습니다. session의 마지막뿐 아니라 배포되고 검증된 각 변경을 갱신 후보로 취급하세요 — repository의 실제 이력보다 하루와 20개 이상의 commit만큼 뒤쳐진 `current-state.md`는 무해한 지연이 아니라 곧 일어날 bootstrap-test 실패입니다. 이건 per-feature design 문서 자신의 status marker에도 똑같이 적용됩니다(`docs/architecture/agent-context-model.md`의 "Working context" 참고).
6. 구현이 시작되면 deterministic test와 quality gate를 추가하세요.

## Adoption checklist

- [ ] `PROJECT.yaml`이 대상 project를 설명한다.
- [ ] Product 문서에 stale한 Starter 사실이 없다.
- [ ] Architecture 문서가 대상 시스템과 그 경계를 설명한다.
- [ ] Maintainer가 constitution을 검토했다.
- [ ] 관련된 repository-first 결정이 ADR로 기록되어 있다.
- [ ] `current-state.md`가 구체적인 다음 작업을 식별한다.
- [ ] 대상 `README.md`가 사람 사용자에게 도움이 된다.
- [ ] Agent adapter가 얇게 유지되고 유효한 경로를 가리킨다.
- [ ] Starter 고유의 placeholder와 metadata가 제거됐다.
- [ ] fresh한 Codex와 Claude Code session이 bootstrap acceptance test를 통과한다.
- [ ] 기능 구현이 시작되기 전에 foundation이 commit되었다.
- [ ] agent가 adoption을 수행했다면, repository/remote 생성과 첫 push가 각각 maintainer에게 명시적으로 확인받았고, maintainer의 입력 없이 product/scope/architecture content가 발명되지 않았다.
- [ ] maintainer에게 project 고유 skill에 대해 물어봤고, maintainer가 실제 workflow를 설명한 경우에만 `.ai/skills/`가 존재한다.

## ADS가 제공하지 않는 것

ADS는 파일을 생성하거나, `PROJECT.yaml`을 기계적으로 검증하거나, project 간에 skill을 동기화하거나, 기술 스택을 선택하거나, build/CI 시스템을 설정하지 않습니다. 이런 작업은 대상 repository에서 명시적으로 수행하고 중요한 선택을 문서화하세요. 이건 영구적이며, 추가 검증에 달려있지 않습니다 — 이미 4번의 실제 adoption이 수동 절차를 검증했고, `ADR-0002`/`ADR-0003`은 그럼에도 이를 자동화하거나 skill을 중앙화하지 않기로 결정했습니다.

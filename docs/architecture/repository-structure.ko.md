> 이 문서는 [`repository-structure.md`](repository-structure.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Repository Structure

## 책임 맵(Responsibility map)

| 경로 | 소유 책임 | 되면 안 되는 것 |
|---|---|---|
| `README.md` | 사람 대상 소개와 navigation | 전체 design 명세 |
| `PROJECT.yaml` | 구조화된 project identity와 phase | narrative한 architecture 문서 |
| `AGENTS.md` | Codex bootstrap adapter | 공유 정책 소스 |
| `CLAUDE.md` | Claude Code bootstrap adapter | `AGENTS.md`의 중복 |
| `.ai/constitution/` | durable한 engineering/agent 원칙 | project 기능 요구사항 |
| `.ai/skills/` (optional, project별) | 이 특정 프로젝트의 maintainer가 설명한 반복 workflow (`ADR-0003` 참고) | ADS에서 동기화되거나 다른 adopted project에서 복사된 공유 라이브러리 |
| `docs/product/` | 문제, 사용자, 목표, scope | 구현 지시사항 |
| `docs/architecture/` | 구조, 경계, context model | 결정 이력 |
| `docs/guides/` | 반복 가능한 운영 절차 | product 정책이나 architecture 근거 |
| `docs/decisions/` | 중요한 결정과 근거 | 가변적인 current-state 체크리스트 |
| `docs/status/current-state.md` | 현재 phase, 진행상황, 다음 작업 | 영구 정책이나 changelog |

## 의존 방향(Dependency direction)

Adapter, guide, summary는 authoritative 문서를 안쪽으로 가리킬 수 있습니다. authoritative 문서는 adapter의 문구나 외부 대화 이력에 의존하지 않습니다.

```text
README ───────────────┐
AGENTS / CLAUDE ──────┼──> PROJECT + constitution + docs
current-state ────────┘                 │
                                       └──> accepted ADRs
```

`PROJECT.yaml`은 discovery를 위한 canonical 위치를 나열할 뿐, 그 narrative한 내용을 중복하지 않습니다.

## Optional context extension

`PROJECT.yaml`의 `context` 블록은 실제 adoption이 필요로 할 때, 위 책임 맵의 core set을 넘어서는 canonical 경로를 선언할 수 있습니다. 실제로 관찰된 것은 세 가지입니다:

- 전용 feature-specification 디렉터리(예: `specs/`를 가리키는 `specs:`). 다음 중 하나라도 해당하면 `specs/<feature>/spec.md`를 만드세요: 한 세션을 넘어 여러 세션에 걸쳐 진행될 변경, 자체 decision record가 필요할 만큼 중요한 아키텍처 경계를 도입하거나 바꾸는 변경, 또는 실제로 배포된 것과 design을 다시 대조해야 하는 변경. 그 외에는 `current-state.md`와 commit history로 충분합니다 — 모든 변경마다 습관적으로 spec 문서를 만들지 마세요. 그 spec이 설명하는 기능을 배포하는 같은 변경 안에서 spec 자체의 status marker도 갱신하세요. 이미 배포된 기능의 spec이 여전히 "design only"라고 되어 있다면 그것은 역사적 기록이 아니라 결함입니다(`agent-context-model.md`의 "Working context" 참고).
- 다른 repository가 소유한, 이 프로젝트가 스스로 해결할 수 없는 요구사항을 추적하는 상태 파일(예: `docs/status/external-dependencies.md`) — 예를 들면 Kubernetes manifest와 DNS를 소유한 별도의 infra repository가 있는 경우입니다. 이건 `docs/architecture/`가 아니라 `docs/status/`의 책임입니다: `current-state.md`처럼 pending과 resolved 사이를 오가며 변하지만, 이 프로젝트 자신의 진행상황이 아니라 이 프로젝트가 바깥에서 필요로 하는 것에 한정됩니다.
- related-repositories 문서(예: `docs/architecture/related-repositories.md`를 가리키는 `related_repositories:`) — 이 프로젝트가 여기서 완전히 통제하지 못하는 다른 repository에 의존하거나, 그 repository로부터 의존받거나, infra를 공유하는 경우를 위한 것입니다. 다룰 내용: 어떤 repository들이 관련되어 있고 각각 이 프로젝트가 소유하지 않은 무엇을 소유하는지; 관계의 형태(애플리케이션 repo + sibling simulator/test-harness 서비스; 코드를 소유하지 않는 독립적인 sibling들이 호출하는 공유 satellite 서비스; 여러 컴포넌트가 공유하는 환경이나 리소스); 그리고 공유가 시작되면서 조용히 깨지는 naming이나 identity 가정(공유 리소스당 컴포넌트가 정확히 하나라고 가정하는 identity/naming scheme이 실제 사례입니다 — 두 번째 컴포넌트가 그 리소스를 공유하는 순간 조용히 깨지고, 이 문서 없이는 직접 조사해야만 발견할 수 있습니다).

`PROJECT.yaml`의 `context` 블록에 optional 필드를 선언하는 건, 그 아래 파일이 이런 실제적이고 뚜렷한 책임을 가질 때만 하세요 — 아래 "Directory policy"가 여전히 적용됩니다. 추측성으로 추가하지 말고, 책임이 사라지면 제거하세요.

## Directory policy

파일이 실제 책임을 가질 때만 디렉터리를 추가하세요. V1에서 template, preset, script, source tree를 위한 빈 구조를 만들지 마세요. `.ai/skills/`는 adopting project가 스스로 만들 수 있는 유일한 디렉터리이며, 그것도 maintainer가 실제 반복 workflow를 설명한 뒤에만입니다(`ADR-0003`과 `docs/guides/using-the-starter.md` step 9 참고) — 추측성 placeholder로는 절대 안 됩니다.

## Evolution rule

top-level 영역이나 책임 layer를 추가하기 전에, 기존 위치가 그것을 표현할 수 없는지 확인하세요. 장기적인 의존 방향이나 adapter/core 경계의 변경은 ADR이 필요합니다.

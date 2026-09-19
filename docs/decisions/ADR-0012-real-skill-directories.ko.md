> 이 문서는 [`ADR-0012-real-skill-directories.md`](ADR-0012-real-skill-directories.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0012: Skill은 agent가 실제로 discover하는 경로에 있어야 함

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

`ADR-0003`은 skill이 공유 ADS 라이브러리가 아니라 project별 확장 지점이고, maintainer에게 물어서 채우지 발명하지 않는다고 정확히 결정했습니다. 이를 위한 디렉터리 이름을 `.ai/skills/`라고 지었습니다. 어떤 agent tool도 실제로 그 경로를 자동으로 discover하지 않습니다: Claude Code는 `.claude/skills/`를 discover하고, Codex(그리고 여러 다른 Spec Kit integration)는 `.agents/skills/`를 discover합니다. `.ai/skills/`는 agent가 실제로 무엇을 읽는지 확인하지 않고 `.ai/constitution/`과의 유사성으로 지어낸 것이라, 거기 놓인 skill은 어떤 agent의 자동 discovery에도 쓰이지 않고 방치됩니다.

이건 GitHub Spec Kit을 통합하면서 드러났습니다 — Spec Kit 자신의 워크플로 명령어들이 정확히 이 같은 실제 경로(`.claude/skills/speckit-*/SKILL.md`, `.agents/skills/speckit-*/SKILL.md`)에 skill로서 제공되기 때문입니다 — `docs/product/overview.md`의 "ADS V2" 섹션과 `ADR-0010`을 참고하세요.

## Decision

Project별 skill은 Claude Code라면 `.claude/skills/<name>/SKILL.md`, Codex라면 `.agents/skills/<name>/SKILL.md`에 있습니다 — 그 project의 `supported_agents.initial`에 맞는 쪽(들)에요 — 절대 `.ai/skills/`가 아닙니다. project가 두 agent를 모두 지원하고 skill이 둘 다에 적용된다면, 하나의 skill content를 한 곳에 유지하고 다른 agent의 디렉터리는 그걸 참조하거나 미러링하세요, 독립적으로 표류하는 두 복사본을 유지하는 대신요; 두 agent의 skill 형식이 정말로 다르다면, 그 차이 자체를 skill 파일에 짧게 적어두는 게 조용한 중복보다 낫습니다.

`ADR-0003`의 실제 결정 — skill은 project별이고, maintainer에게서 이끌어내며, 절대 발명되거나 다른 project에서 통째로 복사되지 않는다 — 은 바뀌지 않습니다. 경로만 잘못되었던 것입니다.

## Consequences

### Positive

- 이 ADR을 따라 놓인 skill은 agent 자신의 harness가 실제로 찾아서 로드하는 것이지, 어떤 tool도 안 읽는 비활성 content가 아닙니다.
- ADS를 Spec Kit 자신의 integration이 이미 쓰는 같은 경로에 맞춰서, project 고유 skill이 `speckit-*` skill과 같은 디렉터리에 자연스럽게 놓입니다.

### Costs and risks

- 원래의 `ADR-0003` 문구를 따라 이미 `.ai/skills/` 디렉터리를 만든 project는, 이 ADR을 적용하는 과정에서 그 content를 올바른 경로(들)로 옮겨야 합니다.

## Alternatives considered

### `.ai/skills/`를 실제 per-agent 디렉터리를 가리키는 project-level index로 유지하기

기각되었습니다: 아무 이득 없이 간접 layer를 추가합니다 — skill의 실제 집은 agent가 보는 곳이고, 세 번째 위치에서 그걸 가리키는 건 얻는 것 없이 동기화할 곳을 하나 더 만드는 것입니다.

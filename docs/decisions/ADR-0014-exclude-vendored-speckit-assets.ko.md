> 이 문서는 [`ADR-0014-exclude-vendored-speckit-assets.md`](ADR-0014-exclude-vendored-speckit-assets.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0014: vendor된 Spec Kit asset을 `.ko.md` 의무 대상에서 제외하기

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

실제 Python/`uv` toolchain이 이제 확보되어 `specify-cli==1.0.8`이 실제로 설치되면서(`ADR-0010`이 기록한 gap이 해결됨), `specify init`을 실행하면 `.specify/templates/`, `.specify/scripts/`, `.specify/workflows/`, `.specify/integrations/`, `.claude/skills/speckit-*/SKILL.md` / `.agents/skills/speckit-*/SKILL.md`에 설치된 Spec Kit 버전에 pin된, 실제 CLI가 렌더링한 content가 채워집니다. `ADR-0004`/`ADR-0005`는 `node_modules`/`.git`/`build`/`dist`/`out` 외에 별다른 디렉터리 예외 없이 모든 Markdown 문서에 `.ko.md` companion을 의무화합니다 — 이를 문자 그대로 적용하면 upstream Spec Kit 자신의 template과 skill prose까지 번역해야 하는데, 이건:

- 이 프로젝트가 작성하지 않고 번역한다고 의미 있게 개선할 수도 없는 vendor된 third-party content이고,
- `specify upgrade`로 새 pinned 버전으로 옮길 때마다 조용히 통째로 교체되어서, 어떤 번역이든 방치가 아니라 구조적으로 stale해지며,
- 이미 같은 이유(vendor된 것, 여기서 작성한 게 아님)로 제외된 `node_modules`와 같은 성격입니다.

`.specify/memory/constitution.md`와 project 고유 skill(`speckit-`로 시작하지 않는 `.claude/skills/<name>/SKILL.md`나 `.agents/skills/<name>/SKILL.md`)은 다릅니다: 이건 이 프로젝트 자신의 maintainer가 작성한 것이고, 다른 모든 필수-이중언어 문서와 정확히 같은 처지이며, 이 ADR은 그것들을 예외로 두지 않습니다.

## Decision

`scripts/check-ko-companions.sh`는 `node_modules`/`.git`/`build`/`dist`/`out`에 더해 다음을 제외합니다:

- `.specify/templates/`, `.specify/scripts/`, `.specify/workflows/`, `.specify/integrations/`, 그리고 `.specify/memory/`를 제외한 그 외 Spec Kit가 관리하는 `.specify/` 아래 경로(`.specify/memory/`는 여전히 필수)
- `.claude/skills/speckit-*/`나 `.agents/skills/speckit-*/` 디렉터리(Spec Kit 자신의 vendor된 skill)

`.specify/memory/constitution.md`, `specs/<NNN-feature>/*.md`, project 고유(`speckit-`로 시작하지 않는) skill을 포함한 다른 모든 문서는 `ADR-0004`/`ADR-0005`에 따라 여전히 필수입니다, 변경 없이.

## Consequences

### Positive

- `.ko.md` 의무가 의미를 유지합니다: 이 프로젝트가 실제로 작성하고 정확하게 유지할 수 있는 content에 적용되지, 이 프로젝트와 무관하게 바뀌는 upstream boilerplate에는 적용되지 않습니다.
- 다음 `specify upgrade`로 무효화될 번역 부담을, 독자에게 아무 이득도 없이 지지 않습니다.

### Costs and risks

- Spec Kit 자신의 디렉터리 구조가 미래의 pinned-version bump(`ADR-0010`)에서 바뀌면 `scripts/check-ko-companions.sh`의 제외 목록도 최신으로 유지되어야 합니다.

## Alternatives considered

### vendor된 Spec Kit template과 skill도 어쨌든 번역하기

기각되었습니다: 그 content는 이 프로젝트가 의미 있게 번역할 대상이 아니고, 버전이 bump될 때마다 다시 해야 합니다 — `node_modules`에 대해 이미 받아들여진 것과 같은 반론입니다.

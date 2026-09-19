> 이 문서는 [`ADR-0010-pin-speckit-cli-version.md`](ADR-0010-pin-speckit-cli-version.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0010: Spec Kit CLI 버전을 pin하고, 그것이 렌더링하는 결과물을 손으로 만들지 않기

- Status: Accepted
- Date: 2026-09-20
- Deciders: Project maintainer

## Context

ADS V2는 spec/plan/tasks/clarify/analyze/implement 워크플로에 ADS 자신의 즉흥적인 `specs/` convention 대신 GitHub Spec Kit을 채택합니다(`docs/product/overview.md`의 "ADS V2" 섹션 참고). maintainer는 모든 ADS-adopted project가 같은 Spec Kit CLI 버전으로 수렴하길 원합니다, 각 adoption이 그때그때 최신 upstream release를 설치하는 대신요.

Spec Kit의 CLI(`specify`)는 `specify init` 시점에 자신의 command template을 agent별 파일로 렌더링합니다 — Claude Code라면 실제 `.claude/skills/speckit-*/SKILL.md` 파일, Codex라면 `.agents/skills/speckit-*/SKILL.md`. 이 세션에는 동작하는 Python/`uv`/`pip`가 없어서(Windows Store의 동작 안 하는 stub `python.exe`뿐임) 여기서 CLI를 실제로 실행해서 결과를 만들고 검증할 수 없습니다. `github/spec-kit`의 원본 command-template 소스(`templates/commands/*.md`)를 읽고 agent별 렌더링을 추측해서 `SKILL.md`를 손으로 쓰는 건, 모든 adopted project에 미묘하게 망가진 skill 파일을 퍼뜨릴 위험이 있습니다 — 이건 정확히 `docs/product/overview.md` section 1이 피하라고 한 추측성 재구현입니다("ADS가 독자적인 SDD Framework 자체를 구현하는 방향은 피한다").

## Decision

ADS는 특정 Spec Kit CLI release를 pin하고(`PROJECT.yaml`과 이 ADR에 기록, bump할 때만 새 ADR로 갱신) 그 정확한 설치 명령을 문서화합니다. 모든 adoption은 그 pinned 버전으로 실제 `specify` CLI를 실행해서 자신의 `.specify/`, `.claude/skills/`, `.agents/skills/`를 생성합니다 — ADS는 그 결과물을 추측해서 손으로 vendor하지 않습니다. 이게 maintainer의 실제 목표(project 간 버전 수렴)를 CLI가 렌더링하는 걸 ADS가 재구현하는 대신 pin을 통해 달성합니다.

Pinned version: `specify-cli==1.0.8`(2026-09-20 기준 최신 tag; `uv tool install specify-cli==1.0.8`, 또는 `uv`가 없으면 `pipx install specify-cli==1.0.8`).

pin을 bump하는 것도 하나의 결정입니다: 새 ADR에 기록하세요(context: upstream에서 뭐가 바뀌었는지; decision: 새 pinned version; consequences: 이미 채택된 어떤 project가 언제까지 `specify upgrade`를 다시 실행해야 하는지) — 이 ADR을 조용히 수정하지 마세요.

## Consequences

### Positive

- ADS가 CLI를 실행하거나 흉내내지 않으면서도, 모든 ADS-adopted project에 걸쳐 버전이 수렴합니다 — 이게 실제 목표였습니다.
- 손으로 추측한, 검증 안 된 `SKILL.md` content를 퍼뜨릴 위험이 없습니다 — 각 adopted project의 Spec Kit 파일은 진짜로 CLI가 렌더링한 것이므로 그 CLI 버전에 대해 정확합니다.

### Costs and risks

- ADS는 동작하는 Python toolchain이 없는 세션에서는 Spec Kit의 정확한 렌더링 결과를 스스로 검증할 수 없습니다 — 여기 있는 adoption guidance는 실제로 `specify init`을 실행해서 결과를 확인한 게 아니라 Spec Kit의 문서화된 동작과 원본 template 소스로부터 작성됐습니다. 이 ADR 아래의 첫 실제 adoption은 이 guidance가 실제 CLI 결과와 맞는지 확인하고, 안 맞으면 평범한 adoption feedback gap으로 보고해야 합니다.
- pin이 stale해지면(한 project가 옛 버전에 머물고 upstream은 계속 나아가면) 능동적인 bump 결정이 필요합니다 — 아무것도 자동으로 그걸 강제하지 않습니다.

## Alternatives considered

### ADS 자신이 렌더링된 skill의 손으로 adapt한 snapshot을 vendor하기

기각되었습니다: 이 환경에서 실제 CLI 결과와 대조 검증할 수 없습니다; 망가진 skill 파일을 퍼뜨릴 위험이 편의성보다 큽니다.

### 버전을 pin하지 않고, 각 adoption이 그때그때 현재 `specify`를 쓰게 하기

기각되었습니다: 이게 정확히 maintainer가 제기한 버전 drift 문제입니다.

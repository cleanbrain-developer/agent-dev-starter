> 이 문서는 [`ADR-0005-mandatory-cascading-korean-companions.md`](ADR-0005-mandatory-cascading-korean-companions.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# ADR-0005: 한국어 companion을 필수화하고 원본과 cascade로 관리하기

- Status: Accepted
- Date: 2026-09-17
- Deciders: Project maintainer

## Context

`ADR-0004`는 `.ko.md` companion convention을 도입했지만 두 가지를 느슨하게 남겨뒀습니다: (1) 각 adopting project가 "Review the constitution" 중에 이 convention을 유지할지 독립적으로 선택했고, (2) 영어 원본이 바뀔 때 `.ko.md` companion을 갱신하는 건 "기대되지만 같은 변경 안에서 필수는 아닌" 것 — 결함이 아니라 받아들여진 지연이었습니다.

Maintainer는 이후 둘 다 너무 느슨하다고 판단했습니다: 모든 ADS-adopted project는 예외 없이 모든 문서에 한국어 companion을 적용해야 하고, companion은 표류하도록 두지 말고 영어 원본과 같은 보폭으로 움직여야 합니다.

## Decision

1. **선택이 아니라 필수.** Agent Development Starter를 채택하는 모든 project는 자신이 채택하거나 작성하는 모든 Markdown 문서에 `.ko.md` companion을 만듭니다, project별 opt-out 없이. 이건 더 이상 "Review the constitution"(`using-the-starter.md` step 4) 중에 검토되는 선택이 아니라, 책임별로 분리된 디렉터리 구조가 선택이 아닌 것처럼 채택된 foundation 자체의 일부입니다.
2. **지연이 아니라 cascade.** 영어 문서가 의미에 영향을 주는 방식으로 바뀔 때마다(단순 서식 수정이 아니라), 그 `.ko.md` companion을 같은 변경 안에서 갱신합니다. 이걸 `documentation-policy.md`의 기존 "Maintenance" 규칙("코드나 구조 변경으로 문서가 사실과 달라지면, 같은 변경 안에서 문서를 갱신하라")과 정확히 똑같이 취급하세요 — 영어 원본과 어긋나게 표류한 `.ko.md`는 이제 참아줄 지연이 아니라 고쳐야 할 결함입니다.
3. **영어는 여전히 canonical입니다.** `ADR-0004`의 핵심 결정은 뒤집히지 않습니다: agent bootstrap은 여전히 영어 파일만 읽고, 두 파일이 다르면 여전히 영어가 우선합니다. Cascade는 어느 파일이 권위를 갖는지를 바꾸는 게 아니라, maintainer 대상 companion에 대한 유지보수 규율입니다.
4. **범위.** 이건 이미 채택된 모든 project(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`)에 소급 적용되고, 앞으로의 모든 adoption과 Agent Development Starter 자신에게도 적용됩니다.

## Consequences

### Positive

- 한국어 companion을 언제든 현재 영어 의미를 반영한 것으로 신뢰할 수 있습니다, 오래된 snapshot이 아니라.
- "번역을 언제쯤 손봐야 하나"라는 모호함을 제거합니다 — 답은 항상 "지금 이 변경 안에서"입니다.

### Costs and risks

- 앞으로 문서를 건드리는 모든 변경의 diff 크기가, 모든 adopted project에서 영구적으로 두 배가 됩니다.
- 예전엔 파일 하나만 고치면 됐던 곳에서 이제 두 파일을 고쳐야 해서, 변경이 느려지거나 절반만 끝난 채 남을 가능성이 높아집니다 — 이건 실수가 아니라 받아들인 비용입니다.
- 아직 이를 강제하는 deterministic check가 없습니다(`architecture/overview.md`의 "Enforcement boundary" 참고); 그런 게 생기기 전까지는 `agent-behavior.md`의 "Before completion" 규율에 의존합니다.

## Alternatives considered

### `ADR-0004`의 "기대되지만 필수는 아님"을 유지 (현상 유지)

기각되었습니다: maintainer가 받아들여진 지연보다 더 강한 보장을 명시적으로 요청했습니다.

### 매 변경마다가 아니라 주기적/일괄 번역 동기화

기각되었습니다: maintainer가 없애고 싶어한 표류 구간을, 무기한이 아니라 일정 주기로 재도입하는 것일 뿐입니다.

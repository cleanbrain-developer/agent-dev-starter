# Claude Code Project Adapter

이 파일은 Claude Code의 저장소 진입 adapter다. 공통 정책과 프로젝트 설계의 원본이 아니며, 아래 repository context를 읽고 따르도록 연결한다.

## Required context

작업 전에 다음 순서로 읽는다.

1. `PROJECT.yaml`
2. `.ai/constitution/engineering-principles.md`
3. `.ai/constitution/agent-behavior.md`
4. `.ai/constitution/documentation-policy.md`
5. `docs/product/`의 관련 문서
6. `docs/architecture/`의 관련 문서
7. 관련 `docs/decisions/` ADR
8. `docs/status/current-state.md`
9. 현재 요청과 관련된 저장소 파일

## Working contract

- 기존 근거를 탐색하고 변경 계획을 세운다.
- 최소 범위로 구현하고 검증한 뒤 diff를 검토한다.
- 아키텍처 결정이나 장기 상태를 대화에만 남기지 않는다.
- 공통 규칙을 이 adapter에 추가하지 말고 적절한 constitution 또는 docs 원본을 갱신한다.
- 문서가 충돌하거나 중요한 결정이 열려 있으면 가정으로 고정하지 말고 명시한다.

현재 phase와 다음 작업의 원본은 `docs/status/current-state.md`다.

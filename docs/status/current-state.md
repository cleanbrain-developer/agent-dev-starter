# Current State

Last updated: 2026-08-27

## Current phase

V1 Foundation — repository가 외부 대화 없이 스스로 목적, 원칙, 구조, 상태를 설명할 수 있는 최소 specification을 구성하고 검증한다.

## Completed

- Repository 이름을 `agent-dev-starter`, 제품명을 Agent Development Starter로 확정했다.
- Repository-first context와 agent-agnostic core 방향을 채택했다.
- Codex와 Claude Code를 초기 지원 agent로 정했다.
- Human entrypoint, structured manifest, agent adapters, constitution, product, architecture, ADR, working state의 책임을 분리했다.
- V1 디렉터리 구조와 핵심 문서를 생성했다.
- ADR-0001로 repository-first context 결정을 영속화했다.
- CLI, skills, templates, presets, CI를 V1 foundation 범위에서 제외했다.
- 로컬 Git repository를 초기화하고 GitHub 원격 저장소를 연결했다.

## In progress

- 새 Codex 및 Claude Code 세션에서 context bootstrap acceptance test 수행
- 문서 간 중복, 누락, 모순에 대한 사람 검토

## Next

1. 공유 대화 없이 새 세션에서 `AGENTS.md`와 `CLAUDE.md` bootstrap을 각각 검증한다.
2. 검증 결과에 따라 문서 탐색 순서와 최소 필수 context를 조정한다.
3. `PROJECT.yaml` V1 schema의 필수 필드와 validation 수준을 결정한다.
4. 반복 workflow가 실제로 확인된 뒤 plan, verify, review skill의 최소 규격을 결정한다.

## Open decisions

- `PROJECT.yaml`을 단순 manifest로 유지할지 별도 machine-validatable schema를 제공할지
- 공통 skills의 canonical location과 Claude Code/Codex 검색 경로로의 배포 방식
- Template repository를 V2의 주 배포 방식으로 사용할지
- CLI가 필요해지는 기준, 구현 언어, 명령 이름
- 문서 규칙 중 어떤 항목을 test, lint, CI로 우선 승격할지
- 지원 agent가 늘어날 때 adapter compatibility를 어떻게 검증할지

## Known constraints

- Application code, tests, build system, CLI, automation은 아직 없다.
- 최초 설계 대화는 bootstrap 근거로만 사용했으며, 이후 세션의 필수 context가 아니다.

## V1 exit criteria

- 새 agent 세션이 외부 링크 없이 프로젝트 목적, 원칙, architecture, 현재 상태, 다음 작업을 정확히 복원한다.
- 그 답의 모든 지속 가능한 근거가 repository 안에 있다.
- Agent adapter에 공통 설계가 중복되어 있지 않다.

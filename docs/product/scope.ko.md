> 이 문서는 [`scope.md`](scope.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Scope

## In scope

- Project identity, 현재 phase, pinned standard 버전을 위한 `PROJECT.yaml`(`ADR-0010`)
- 모든 지원 agent를 위한 유일한 entry adapter로서의 `AGENTS.md`(`ADR-0011`)
- spec/plan/tasks/clarify/analyze/implement/converge 워크플로를 위한, pinned CLI 버전의 GitHub Spec Kit
- agent가 실제로 discover하는 경로(`.claude/skills/`, `.agents/skills/` — `ADR-0012`)의 Agent Skills, GitHub Spec Kit 자신의 `speckit-*` skill과 maintainer가 요청한 project 고유 skill을 위해
- `.specify/memory/constitution.md`의 durable한 engineering 원칙; `.ai/constitution/documentation-policy.md`의 문서 소유권과 언어 정책(`ADR-0013`)
- product, architecture, guide, decision, status 책임의 분리
- repository-first 결정을 보존하는 최초 ADR
- 현재 project 전체 working context를 복원하는 status 문서(Spec Kit이 의도적으로 team에게 남겨두는 scope)
- 모든 문서에 대한 필수적이고 cascade되는 `.ko.md` 한국어 companion, 영어 canonical(`ADR-0004`/`ADR-0005`), 이미 CI pipeline이 있는 project를 위한 기본 CI check(`ADR-0009`)
- 수동 context bootstrap acceptance 기준
- Starter를 다른 repository에 적용하는 agent-driven adoption 절차

## 영구 out of scope

- ADS 전용 CLI, initializer, 파일 생성기(`ADR-0002`) — GitHub Spec Kit 자신의 CLI가 이 역할을 대신함
- GitHub template 배포 설정(`ADR-0002`)
- ADS 자신이 정의, 호스팅, 동기화하는 공유 skill 라이브러리(`ADR-0003`) — skill은 project별로 남음
- 기계 검증 가능한 `PROJECT.yaml` 스키마(`ADR-0006`)
- 애플리케이션 소스 코드
- 위에서 설명한 하나의 check를 넘어서 ADS 자신이 adopting project를 위해 만드는 CI pipeline(`ADR-0007`/`ADR-0009`)
- Plugin ecosystem과 배포 전략
- 열린 표준이 이미 해결하는 것을 ADS가 재구현하는 것(`ADR-0002`, `ADR-0006`, `ADR-0010`, `ADR-0011`, `ADR-0012`) — 새로운 ADS 메커니즘을 제안할 때마다 반복되는 테스트는 AGENTS.md, GitHub Spec Kit, Agent Skills가 이미 그걸 다루는지 여부입니다

이건 미래 버전으로 미뤄진 항목이 아니라 영구적인 결정입니다 — 각각 실제 adoption 증거로부터 나온 ADR, 또는 standards-alignment 항목의 경우 동등한 걸 만들기 전에 열린 표준이 이미 제공하는지 확인한 것으로 뒷받침됩니다.

## Scope rule

Out-of-scope 항목은 향후 확장을 막지 않을 정도로만 고려하세요. placeholder 디렉터리, 추측성 abstraction, 사용되지 않는 script를 추가하지 마세요.

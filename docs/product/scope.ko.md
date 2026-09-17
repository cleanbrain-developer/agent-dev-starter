> 이 문서는 [`scope.md`](scope.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Scope

## V1 in scope

- Project identity와 현재 phase를 위한 `PROJECT.yaml`
- Codex와 Claude Code를 위한 얇은 entry adapter
- 공유되는 engineering, agent behavior, documentation 원칙
- product, architecture, guide, decision, status 책임의 분리
- repository-first 결정을 보존하는 최초 ADR
- 현재 working context를 복원하는 status 문서
- 수동 context bootstrap acceptance 기준
- Starter를 다른 repository에 적용하는 수동 절차

## V1 out of scope

- 실행 가능한 CLI나 initializer
- 자동화된 project 파일 생성
- GitHub template 배포 설정
- `.ai/skills/`와 agent별 skill 동기화
- 기술/framework preset
- 애플리케이션 소스 코드
- Build, test, lint, CI pipeline
- Plugin ecosystem과 배포 전략
- `PROJECT.yaml`을 위한 완전한 검증 스키마

## 영구 폐기, 유예가 아님

`ADR-0002`와 `ADR-0003`은 위 항목 중 네 가지를 "V1에서 유예됨"에서 "영구적으로 out of scope"로 승격시켰으며, 4개 실제 adoption(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`)의 증거에 근거합니다: 실행 가능한 CLI나 initializer, 자동화된 project 파일 생성, GitHub template 배포 설정, 그리고 이 repository에서 배포되는 공유 `.ai/skills/` 라이브러리. `docs/guides/using-the-starter.md`의 수동 agent-driven 절차가 유일하게 지원되는 adoption 경로로 남습니다. Skill은 여전히 project별 확장 지점입니다 — adopting project는 자신의 maintainer에게 물어서 채운 자신만의 `.ai/skills/`를 정의할 수 있지만, ADS 자신은 그것을 정의하거나 호스팅하거나 동기화하지 않습니다.

## Scope rule

Out-of-scope 항목은 향후 확장을 막지 않을 정도로만 고려하세요. V1에서 placeholder 디렉터리, 추측성 abstraction, 사용되지 않는 script를 추가하지 마세요.

# Scope

## V1 in scope

- 프로젝트 identity와 현재 phase를 표현하는 `PROJECT.yaml`
- Codex와 Claude Code용 얇은 entry adapter
- 공통 engineering, agent behavior, documentation 원칙
- product와 architecture 문서의 책임 분리
- repository-first 결정을 보존하는 최초 ADR
- 새 세션이 현재 위치를 복원하는 status 문서
- context bootstrap의 수동 검증 기준

## V1 out of scope

- 실행 가능한 CLI 또는 initializer
- 프로젝트 파일 생성 자동화
- GitHub template 배포 설정
- `.ai/skills/`와 agent별 skill 동기화
- technology/framework preset
- application source code
- build, test, lint, CI pipeline
- plugin ecosystem과 distribution 전략
- 완전한 `PROJECT.yaml` validation schema

## Scope rule

Out-of-scope 항목은 향후 확장 가능성을 막지 않는 수준에서만 고려한다. V1에 placeholder directory, 추측성 abstraction, 사용되지 않는 script를 추가하지 않는다.

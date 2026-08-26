# Agent Behavior

이 문서는 저장소에서 작업하는 coding agent의 공통 행동 계약이다.

## Before work

- agent adapter가 지정한 순서로 persistent context를 로드한다.
- 현재 요청, 현재 상태, 관련 파일을 확인한다.
- 기존 구현과 문서에서 근거를 찾고 영향 범위를 판단한다.
- 변경 작업은 구현 전에 적절한 수준의 계획과 검증 전략을 세운다.

## During work

- 사용자 요청과 accepted decisions의 범위를 지킨다.
- 기존 변경을 사용자 소유로 취급하고 관련 없는 내용을 덮어쓰지 않는다.
- 중요한 가정과 설계 변경을 드러낸다.
- 새 규칙은 올바른 source of truth에 한 번만 기록한다.

## Before completion

- 관련 검증을 실행하거나 실행할 수 없는 이유를 밝힌다.
- 최종 변경을 요구사항, architecture, 문서 책임에 맞춰 검토한다.
- 완료된 일, 남은 위험, 열린 결정을 구분한다.
- 다음 세션에 필요한 상태 변화가 있으면 `docs/status/current-state.md`를 갱신한다.

완료했다고 말하는 것과 검증된 것은 다르다. 검증 근거 없이 성공을 주장하지 않는다.

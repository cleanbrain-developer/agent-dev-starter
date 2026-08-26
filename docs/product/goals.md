# Goals

## V1 goals

1. 저장소를 self-describing project memory로 만든다.
2. 사람, 정형 데이터, agent adapter, 공통 정책, 설계, 결정, 현재 상태의 책임을 분리한다.
3. Codex와 Claude Code가 같은 공통 원본을 일관된 순서로 읽게 한다.
4. 새 세션이 외부 대화 없이 5분 안에 프로젝트와 다음 작업을 복원할 수 있게 한다.
5. Starter 자체가 이 모델을 사용해 dogfooding하도록 한다.

## Success criteria

V1 bootstrap은 새 agent 세션이 공유 대화 링크 없이 `AGENTS.md` 또는 `CLAUDE.md`에서 시작하여 다음 질문에 정확히 답할 때 성공이다.

- 이 프로젝트는 무엇인가?
- 왜 존재하는가?
- 핵심 원칙과 architecture는 무엇인가?
- 지금 어디까지 왔는가?
- 다음에 무엇을 해야 하는가?

답변은 repository 문서로 추적 가능해야 하며, agent adapter에 복제된 설계에 의존해서는 안 된다.

## Long-term direction

검증된 specification을 기반으로 다음 순서의 진화를 고려한다.

1. Repository specification
2. Template repository
3. Reusable workflow skills
4. Interactive initializer or CLI
5. Technology presets and plugin ecosystem

이 순서는 방향이지 V1 구현 약속이 아니다.

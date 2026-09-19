> 이 문서는 [`goals.md`](goals.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Goals

## Goals

1. repository를 self-describing한 project memory로 만든다.
2. 열린 표준이 이미 문제를 해결한다면 ADS가 지어낸 메커니즘보다 그 표준을 우선한다(`AGENTS.md`, GitHub Spec Kit, Agent Skills) — 표준이 다루지 않는 opinion layer만 만든다.
3. 모든 지원 agent에게 하나의 entry adapter로부터 같은 공유 소스를 읽는 일관된 순서를 제공한다.
4. 외부 대화 없이 5분 안에 새 세션이 project와 다음 작업을 복원할 수 있게 한다.
5. Starter repository 자신에게 이 모델을 dogfood한다.
6. 수동으로 검증 가능한 adoption 절차를 제공한다. 자동화는 실제 adoption 증거를 근거로 평가됐고 단순히 미뤄진 게 아니라 영구적으로 폐기됐습니다 — `ADR-0002` 참고.

## Success criteria

Bootstrap은 새 agent 세션이 공유된 대화 링크 없이 `AGENTS.md`에서 시작해서 다음을 정확히 답할 때 성공합니다:

- 이 project는 무엇인가?
- 왜 존재하는가?
- 핵심 원칙과 architecture는 무엇인가?
- 무엇이 완료되었는가?
- active한 feature가 있다면 무엇이고, 다음에 무엇을 해야 하는가?
- 각 주요 canonical 문서에 대응하는 한국어 companion은 어디에 있는가?

모든 답은 repository 문서로 추적 가능해야 하며, agent adapter에 중복된 design에 의존해서는 안 됩니다.

## 장기 방향(Long-term direction)

cleanbrain.me의 4개 서비스(`cleanbrain-me-entrance`, `cleanbrain-me-developer`, `relayhub-java`, `kioti-crm-discount-enhance-demo`)에 걸친 실제 adoption이 원래의 repository 스펙을 검증했고, 여러 로드맵 질문을 해결했습니다:

- 이 repository는 영구적으로 수동으로 참조되는 스펙으로 남습니다. copy-and-adapt 방식의 template repository와 ADS 전용 CLI/initializer는 미뤄진 게 아니라 폐기되었습니다 — `ADR-0002` 참고. 실제로 관찰된 마찰은 서비스마다 다른 content adaptation(product, architecture, 각 서비스에 특화된 원칙)이었고, 이건 복사 메커니즘으로 줄일 수 없습니다.
- Reusable workflow skill은 공유 ADS concept이 아닙니다 — `ADR-0003` 참고. 각 adopting project는 agent가 그 project의 maintainer에게 어떤 반복 workflow를 상세화해야 하는지 직접 물어서 채운 자신만의 skill을 정의할 수 있으며, 다른 project에서 발명되거나 복사되지 않습니다 — 이제 관련 agent가 실제로 discover하는 디렉터리에 놓입니다(`ADR-0012`), ADS가 지어낸 경로가 아니라.
- ADS 자신은 spec/plan/tasks convention을 재구현하던 것에서 GitHub Spec Kit을 채택하는 쪽으로, 그리고 병렬적인 두 agent adapter에서 하나(`AGENTS.md`)로 옮겨갔습니다, Claude Code 자신의 네이티브 `AGENTS.md` 지원이 `CLAUDE.md`를 유지할 마지막 이유를 없앤 뒤에요(`ADR-0011`). `ADR-0002`, `ADR-0006`, 그리고 이번 migration에서 반복되는 교훈은 같습니다: ADS 전용 메커니즘을 만들기 전에 열린 표준이 이미 그걸 해결하는지 확인하라는 것입니다.

Technology preset과 plugin ecosystem은 아직 고려되지 않았습니다. 지금까지의 adoption 증거는 이를 지지하지도 배제하지도 않았고, 둘 다 예정되어 있지 않습니다.

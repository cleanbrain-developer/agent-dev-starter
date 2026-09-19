> 이 문서는 [`overview.md`](overview.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Product Overview

## Product

Agent Development Starter(ADS)는 열린 표준과 이미 확립된 agent-development convention 위에 지어진 opinionated profile입니다 — 새로운 AI development framework가 아닙니다. 구조적으로: **AGENTS.md** 열린 표준, **GitHub Spec Kit**, **Agent Skills**가 표준 layer이고; `PROJECT.yaml`, `docs/status/current-state.md`, ADR discipline, architecture convention, context-loading model, 이중언어 문서 정책이 그 위에 얹힌 ADS 자신의 opinion입니다(`ADR-0010`부터 `ADR-0013`까지). ADS가 제공하는 가치는 새 표준이 아닙니다 — 기존 표준들의 일관된 조합, bootstrap 절차, context-recovery model, 문서 lifecycle이며, 이를 통해 repository-first context(`ADR-0001`)가 session과 agent를 넘어 유지됩니다.

## 문제

매번 새로운 project나 agent 세션이 목적, architecture, testing 규칙을 반복하는 큰 prompt를 필요로 하면, 개발 품질이 prompt 작성 능력과 대화 기억력에 좌우됩니다. 결정 근거와 현재 working state는 세션이 끝나거나 agent가 바뀌면 쉽게 사라집니다.

## Product thesis

모든 prompt를 표준화하는 대신 repository를 표준화하세요. task prompt는 무엇을 해야 하는지 말하고, repository는 이 project가 무엇이고 작업을 어떻게 수행해야 하는지 설명합니다.

## 사용자

초기 사용자는 VS Code에서 Codex와 Claude Code를 함께 또는 번갈아 쓰는 개발자입니다. 시간이 지나면 다른 코딩 agent도 공유 core를 재사용할 수 있어야 합니다.

## Core 경험

`AGENTS.md`로 안내된 후, 새 agent 세션은 이전 대화 이력 없이 `docs/product/goals.md`("Success criteria")에 정의된 다섯 가지 acceptance question에 답할 수 있어야 하며, 모든 답은 repository 문서로 추적 가능해야 하고, maintainer가 spec, plan, tasks, ADR, 한국어 번역을 따로따로 요청하지 않아도 구현을 이어갈 수 있어야 합니다 — agent 자신의 workflow가 그 단계들을 흡수합니다(`docs/guides/using-the-starter.md`의 artifact lifecycle 참고).

이 프로젝트에 앞으로 추가되는 모든 것은 두 가지 질문을 통과해야 합니다: 이 기능이 이미 열린 표준(`AGENTS.md`, GitHub Spec Kit, Agent Skills)에 존재하는가 — 그렇다면 새로 만들지 말고 그걸 쓴다; 그리고 새 agent 세션이 영어 canonical 문서만 읽고도 5분 안에 이 project의 전체 상태와 다음 작업을 복원할 수 있는가.

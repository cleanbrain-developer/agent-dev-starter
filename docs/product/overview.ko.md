> 이 문서는 [`overview.md`](overview.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Product Overview

## Product

Agent Development Starter(ADS)는 AI 코딩 agent로 개발되는 repository에서 durable context, working convention, quality boundary를 위한 starter 스펙입니다.

## 문제

매번 새로운 project나 agent 세션이 목적, architecture, testing 규칙을 반복하는 큰 prompt를 필요로 하면, 개발 품질이 prompt 작성 능력과 대화 기억력에 좌우됩니다. 결정 근거와 현재 working state는 세션이 끝나거나 agent가 바뀌면 쉽게 사라집니다.

## Product thesis

모든 prompt를 표준화하는 대신 repository를 표준화하세요. task prompt는 무엇을 해야 하는지 말하고, repository는 이 project가 무엇이고 작업을 어떻게 수행해야 하는지 설명합니다.

## 사용자

초기 사용자는 VS Code에서 Codex와 Claude Code를 함께 또는 번갈아 쓰는 개발자입니다. 시간이 지나면 다른 코딩 agent도 공유 core를 재사용할 수 있어야 합니다.

## V1 경험

entry adapter로 안내된 후, 새 agent 세션은 이전 대화 이력 없이 `docs/product/goals.md`("Success criteria")에 정의된 다섯 가지 acceptance question에 답할 수 있어야 하며, 모든 답은 repository 문서로 추적 가능해야 합니다.

이 foundation이 검증된 이후에만 project는 template repository, reusable skill, CLI, technology preset, deterministic quality gate를 추가해야 합니다.

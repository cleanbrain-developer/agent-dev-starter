# Product Overview

## Product

Agent Development Starter(ADS)는 AI coding agent와 함께 개발하는 저장소의 지속 가능한 context, 작업 규약, 품질 경계를 표준화하기 위한 starter specification이다.

## Problem

새 프로젝트와 새 agent 세션마다 목적, 설계, 테스트 규칙을 긴 프롬프트로 다시 설명하면 품질이 prompt 작성과 대화 기억에 의존한다. 세션이 종료되거나 agent가 바뀌면 결정 근거와 현재 작업 위치도 쉽게 사라진다.

## Product thesis

프롬프트 자체를 표준화하는 대신, 프롬프트가 자유로워도 결과가 일관되도록 repository를 표준화한다. Task prompt는 무엇을 할지 말하고, repository는 프로젝트가 무엇이며 어떻게 일해야 하는지를 제공한다.

## Users

초기 사용자는 VS Code에서 Codex와 Claude Code를 함께 또는 번갈아 사용하는 개발자다. 장기적으로는 다른 coding agent도 공통 core를 재사용할 수 있어야 한다.

## V1 experience

저장소를 연 새 agent 세션에 entry adapter를 읽으라고 지시하면, 이전 대화 없이 다음을 설명할 수 있어야 한다.

- 프로젝트의 목적과 문제
- 핵심 설계 원칙과 context hierarchy
- 현재 phase와 완료 상태
- 다음 작업과 열린 결정

이 foundation이 검증된 뒤에만 template repository, reusable skills, CLI, technology preset, deterministic quality gate를 점진적으로 추가한다.

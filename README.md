# Agent Development Starter

AI coding agent가 이전 대화나 긴 초기 프롬프트 없이도 저장소만 읽고 일관된 방식으로 개발을 이어가게 하는 repository-first starter specification이다.

현재 저장소는 Starter 자체가 제안하는 방식을 먼저 적용하는 V1 foundation이다. Codex와 Claude Code를 초기 대상 agent로 삼되, 공통 설계와 정책은 특정 agent에 종속시키지 않는다.

## 왜 만드는가

AI 보조 개발은 프로젝트의 목적, 설계 원칙, 현재 상태가 대화에만 남으면 세션이 바뀔 때 맥락을 잃는다. 이 프로젝트는 지속할 맥락을 저장소에 명시하고, task prompt는 현재 할 일에 집중하게 한다.

핵심 목표는 다음 한 문장으로 요약된다.

> 새로운 agent 세션이 이전 대화를 몰라도 저장소만 읽고 프로젝트를 이해하고 다음 작업을 시작할 수 있어야 한다.

## 시작하기

사람은 이 문서에서 시작한다. Agent는 자신에게 맞는 adapter에서 시작한다.

- Codex 및 `AGENTS.md`를 지원하는 agent: `AGENTS.md`
- Claude Code: `CLAUDE.md`
- 프로젝트 정형 정보: `PROJECT.yaml`
- 제품 및 아키텍처 원본: `docs/`
- 장기 개발 원칙: `.ai/constitution/`
- 현재 진행 상태: `docs/status/current-state.md`

현재는 실행 가능한 CLI나 생성기가 없다. V1은 정보 구조와 context bootstrap contract를 검증하는 단계다.

## V1 구조

```text
.
├── README.md                         # 사람을 위한 진입점
├── PROJECT.yaml                      # 기계가 읽을 수 있는 프로젝트 identity card
├── AGENTS.md                         # Codex 계열 진입 adapter
├── CLAUDE.md                         # Claude Code 진입 adapter
├── .ai/
│   └── constitution/                 # 프로젝트 전반에 적용할 장기 원칙
│       ├── engineering-principles.md
│       ├── agent-behavior.md
│       └── documentation-policy.md
└── docs/
    ├── product/                      # 무엇을 왜 만드는가
    │   ├── overview.md
    │   ├── goals.md
    │   └── scope.md
    ├── architecture/                 # 어떻게 구성하고 맥락을 로드하는가
    │   ├── overview.md
    │   ├── repository-structure.md
    │   └── agent-context-model.md
    ├── decisions/                    # 결정과 근거
    │   └── ADR-0001-repository-first-context.md
    └── status/                       # 현재 작업 맥락
        └── current-state.md
```

## 문서 책임 원칙

- `README.md`는 소개와 탐색만 담당하며 상세 설계를 복제하지 않는다.
- `AGENTS.md`와 `CLAUDE.md`는 공통 원본을 읽게 하는 얇은 adapter다.
- `PROJECT.yaml`은 프로젝트 identity와 phase를 정형 데이터로 제공한다.
- `.ai/constitution/`은 쉽게 바뀌지 않는 개발 원칙을 정의한다.
- `docs/product/`와 `docs/architecture/`는 제품·설계 설명의 source of truth다.
- ADR은 중요한 결정의 이유와 결과를 보존한다.
- `current-state.md`는 완료·다음 작업·열린 결정을 복원한다.

상세한 책임과 의존 방향은 `docs/architecture/repository-structure.md`를 따른다.

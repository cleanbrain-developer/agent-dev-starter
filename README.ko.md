> 이 문서는 [`README.md`](README.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Agent Development Starter

Agent Development Starter(ADS)는 AI 기반 소프트웨어 프로젝트를 위한 repository-first 스펙입니다. 코딩 agent가 이전 대화나 대규모 초기화 프롬프트에 의존하지 않고, repository의 증거만으로 프로젝트를 이해하고 작업을 이어갈 수 있게 합니다.

이 repository는 V1 foundation이며, 자기 자신의 convention을 최초로 적용한 프로젝트입니다. Codex와 Claude Code가 초기 지원 agent이고, 공유 context 자체는 agent-agnostic하게 유지됩니다.

## 왜 존재하는가

프로젝트 의도, 아키텍처, 작업 상태는 채팅 이력에만 존재할 경우 쉽게 사라집니다. ADS는 각 종류의 durable context를 명확한 repository 위치에 배정해서, task prompt가 "무엇을 해야 하는지"에만 집중할 수 있게 합니다.

> 새 agent 세션은 repository만으로 프로젝트를 이해하고 다음 작업 항목을 식별할 수 있어야 합니다.

## 이 starter 사용하기

CLI나 generator는 영구적으로 없습니다(`docs/decisions/ADR-0002-reference-only-distribution.md`). Starter 적용은 의도적인 수동 프로세스입니다:

1. Foundation 파일을 새 repository 또는 기존 repository에 복사한다.
2. Starter 고유의 identity, product, architecture, status 내용을 교체한다.
3. constitution을 그대로 복사하지 말고 검토한다.
4. `AGENTS.md`와 `CLAUDE.md`를 얇은 adapter로 유지한다.
5. fresh agent 세션에서 context bootstrap acceptance test를 실행한다.

전체 절차는 [`docs/guides/using-the-starter.md`](docs/guides/using-the-starter.md)를 따르세요.

## Entry point

- 사람 대상 entry point: `README.md`
- Codex 및 `AGENTS.md` 호환 agent: `AGENTS.md`
- Claude Code: `CLAUDE.md`
- 구조화된 project identity: `PROJECT.yaml`
- Durable engineering policy: `.ai/constitution/`
- Product/architecture 소스: `docs/product/`, `docs/architecture/`
- 현재 working state: `docs/status/current-state.md`

## V1 구조

```text
.
├── README.md                         # 사람 대상 entry point
├── PROJECT.yaml                      # 머신 판독 가능한 project identity
├── AGENTS.md                         # Codex 호환 adapter
├── CLAUDE.md                         # Claude Code adapter
├── .ai/
│   └── constitution/                 # Durable engineering policy
│       ├── engineering-principles.md
│       ├── agent-behavior.md
│       └── documentation-policy.md
└── docs/
    ├── product/                      # 무엇을 왜 만드는가
    ├── architecture/                 # 구조와 context model
    ├── guides/                       # 반복 가능한 운영 절차
    ├── decisions/                    # 결정과 근거
    └── status/                       # 현재 working context
```

## 문서 경계

- `README.md`는 소개하고 안내할 뿐, 전체 설계를 중복 서술하지 않는다.
- `AGENTS.md`와 `CLAUDE.md`는 공유 source of truth로 가는 얇은 adapter다.
- `PROJECT.yaml`은 구조화된 identity/phase 데이터를 제공한다.
- `.ai/constitution/`은 자주 바뀌지 않는 원칙을 정의한다.
- `docs/product/`와 `docs/architecture/`가 product/design 지식을 소유한다.
- `docs/guides/`는 반복 가능한 사람 대상 절차를 소유한다.
- ADR은 중요한 결정과 그 결과를 보존한다.
- `current-state.md`는 진행상황, 다음 작업, open decision을 복원한다.

전체 책임/의존성 모델은 `docs/architecture/repository-structure.md`를 참고하세요.

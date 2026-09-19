> 이 문서는 [`README.md`](README.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Agent Development Starter

Agent Development Starter(ADS)는 AI 기반 소프트웨어 프로젝트를 위해 열린 표준 — **AGENTS.md**, **GitHub Spec Kit**, **Agent Skills** — 위에 지어진 opinionated profile입니다(`docs/product/overview.md` 참고), 새 framework가 아닙니다. 코딩 agent가 이전 대화나 대규모 초기화 프롬프트에 의존하지 않고, repository의 증거만으로 프로젝트를 이해하고 작업을 이어갈 수 있게 합니다.

이 repository는 foundation이며, 자기 자신의 convention을 최초로 적용한 프로젝트입니다. Codex와 Claude Code가 초기 지원 agent이고, 둘 다 같은 `AGENTS.md`를 읽습니다.

## 왜 존재하는가

프로젝트 의도, 아키텍처, 작업 상태는 채팅 이력에만 존재할 경우 쉽게 사라집니다. ADS는 각 종류의 durable context를 명확한 repository 위치에 배정합니다 — 표준이 소유하는 위치가 있으면 그곳에, 어떤 표준도 없는 곳만 ADS 자신의 opinion으로.

> 새 agent 세션은 repository만으로 프로젝트를 이해하고 다음 작업 항목을 식별할 수 있어야 합니다.

## 이 starter 사용하기

ADS 전용 CLI나 generator는 영구적으로 없습니다(`docs/decisions/ADR-0002-reference-only-distribution.md`). 실제 CLI가 필요한 곳(GitHub Spec Kit)에서는 ADS가 재구현하는 대신 pinned된 upstream tool을 설치합니다(`ADR-0010`). Starter 적용은 의도적인 수동 프로세스입니다:

1. Foundation 파일을 새 repository 또는 기존 repository에 복사한다.
2. 대상 project의 agent를 위해 pinned 버전으로 GitHub Spec Kit을 설치한다.
3. Starter 고유의 identity, product, architecture, status 내용을 교체한다.
4. constitution을 그대로 복사하지 말고 적용한다.
5. `AGENTS.md` — 유일한 adapter — 를 얇게 유지한다.
6. fresh agent 세션에서 context bootstrap acceptance test를 실행한다.

전체 절차는 [`docs/guides/using-the-starter.md`](docs/guides/using-the-starter.md)를 따르세요.

## Entry point

- 사람 대상 entry point: `README.md`
- 모든 지원 agent: `AGENTS.md`(Codex는 원래부터, Claude Code는 v2.1.277부터 네이티브로)
- 구조화된 project identity와 pinned standard 버전: `PROJECT.yaml`
- Durable한 engineering 원칙: `.specify/memory/constitution.md`(GitHub Spec Kit)
- 문서 소유권과 언어 정책: `.ai/constitution/documentation-policy.md`
- Product/architecture 소스: `docs/product/`, `docs/architecture/`
- Feature 레벨 작업: `specs/<NNN-feature>/`(GitHub Spec Kit)
- 재사용 가능한 절차: `.claude/skills/`, `.agents/skills/`(Agent Skills)
- 현재 working state: `docs/status/current-state.md`

## 구조

```text
.
├── README.md                         # 사람 대상 entry point
├── PROJECT.yaml                      # 머신 판독 가능한 identity + pinned standard 버전
├── AGENTS.md                         # 유일한 agent adapter (ADR-0011)
├── .specify/                         # GitHub Spec Kit 자신이 관리하는 파일
│   └── memory/constitution.md        # Durable한 engineering 원칙 (ADR-0013)
├── .claude/skills/                   # Claude Code가 실제로 discover하는 경로
├── .agents/skills/                   # Codex가 실제로 discover하는 경로
├── .ai/
│   └── constitution/
│       └── documentation-policy.md   # 문서 소유권 + 언어 정책 (어떤 표준도 소유하지 않음)
├── specs/                            # GitHub Spec Kit feature artifact (아직 없음 — ADS 자신은 feature가 없음)
└── docs/
    ├── product/                      # project 레벨: 무엇을 왜 만드는가
    ├── architecture/                 # 영속적인 구조와 context model
    ├── guides/                       # 운영 사용 절차
    ├── decisions/                    # 결정과 근거
    └── status/                       # 현재 project 전체 working context
```

위의 모든 Markdown 문서는 `.ko.md` 한국어 companion을 가집니다(영어가 canonical — `ADR-0004`/`ADR-0005`); `PROJECT.yaml`은 prose가 아니라 구조화된 데이터라 companion이 없습니다.

## 문서 경계

- `README.md`는 소개하고 안내할 뿐, 전체 설계를 중복 서술하지 않는다.
- `AGENTS.md`는 공유 source of truth로 가는 유일한 얇은 adapter다.
- `PROJECT.yaml`은 구조화된 identity, phase 데이터, pinned standard 버전을 제공한다.
- `.specify/memory/constitution.md`는 자주 바뀌지 않는 engineering 원칙을 정의한다; `.ai/constitution/documentation-policy.md`는 문서 소유권과 언어 정책을 정의한다.
- `docs/product/`와 `docs/architecture/`가 project 레벨 product/design 지식을 소유한다; `specs/<NNN-feature>/`가 feature 레벨 요구사항, plan, tasks를 소유한다.
- `docs/guides/`는 반복 가능한 사람 대상 절차를 소유한다.
- ADR은 중요한 결정과 그 결과를 보존한다.
- `current-state.md`는 project 전체 진행상황, 다음 작업, open decision을 복원한다.

전체 책임/의존성 모델은 `docs/architecture/repository-structure.md`를 참고하세요.

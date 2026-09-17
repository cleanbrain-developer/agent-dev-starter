> 이 문서는 [`documentation-policy.md`](documentation-policy.md)의 한국어 번역본입니다. 영어 원본이 canonical이며, 충돌 시 영어 원본이 우선합니다 (`ADR-0004`).

# Documentation Policy

## 권위(Authority)

> 대화는 임시적이다. Repository가 authoritative하다.

대화와 외부 링크는 discovery나 bootstrap 입력이 될 수 있지만, 장기 의존 대상은 아닙니다. durable한 합의는 repository에 반영되기 전까지는 완료된 것이 아닙니다.

## 단일 책임(Single responsibility)

- Project identity와 구조화된 phase: `PROJECT.yaml`
- Product 목적, 목표, scope: `docs/product/`
- 구조와 context model: `docs/architecture/`
- 운영 adoption 절차: `docs/guides/`
- 중요한 결정과 근거: `docs/decisions/`
- 현재 진행상황, 다음 작업, open decision: `docs/status/current-state.md`
- Durable한 development 원칙: `.ai/constitution/`
- Tool별 bootstrap 차이: agent adapter

같은 정책을 여러 파일에 중복 서술하지 마세요. 요약이 유용하다면 authoritative 경로로 링크하세요.

## 결정 기록(Decision records)

아키텍처, 호환성, 배포 전략처럼 장기적 영향이 있는 선택은 ADR에 기록하세요. ADR은 context, decision, consequences, status를 포함해야 합니다. accepted ADR은 다른 ADR이 superseed할 때까지 유효합니다.

## Status hygiene

`current-state.md`는 meeting log나 complete changelog가 아닙니다. 현재 phase를 재구성하는 데 필요한 완료된 작업, 진행 중인 작업, 다음 작업, open decision만 남기세요.

## 유지보수(Maintenance)

코드나 구조 변경으로 문서가 사실과 달라지면, 같은 변경 안에서 문서를 갱신하세요. stale한 가이드는 제거하고, 이력을 보존해야 한다면 ADR이나 version control을 사용하세요.

## 언어(Language)

모든 Markdown 문서는 `.ko.md` suffix를 쓰는 한국어 companion을 가집니다 — 모든 ADS-adopted project에서 선택이 아니라 필수입니다(`ADR-0004`, `ADR-0005` 참고). 영어가 canonical입니다: agent bootstrap은 영어 파일만 읽고, 두 파일이 다를 경우 영어가 우선합니다. `PROJECT.yaml`은 한국어 companion이 없습니다 — 이건 prose가 아니라 구조화된 데이터이기 때문입니다. 영어 문서의 의미가 바뀌면 같은 변경 안에서 그 `.ko.md` companion을 갱신하세요 — 이건 위 "Maintenance"와 같은 규율이지, 별도의 우선순위 낮은 작업이 아닙니다.

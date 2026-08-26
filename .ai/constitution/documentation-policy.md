# Documentation Policy

## Authority

> Conversation is temporary. Repository is authoritative.

대화와 외부 링크는 탐색 및 bootstrap 입력일 수 있지만 장기 의존성이 아니다. 지속되어야 할 합의가 repository에 반영되지 않았다면 결정은 아직 완료되지 않은 것으로 본다.

## Single responsibility

- 프로젝트 identity와 정형 phase: `PROJECT.yaml`
- 제품 목적, 목표, 범위: `docs/product/`
- 구조와 context model: `docs/architecture/`
- 중요한 결정과 근거: `docs/decisions/`
- 현재 완료·다음 작업·열린 결정: `docs/status/current-state.md`
- 변하지 않는 개발 원칙: `.ai/constitution/`
- 도구별 bootstrap 차이: agent adapter

같은 정책을 여러 파일에 복제하지 않는다. 요약이 필요하면 원본 경로를 가리킨다.

## Decision records

아키텍처, 호환성, 배포 방식처럼 장기 영향이 있는 선택은 ADR로 남긴다. ADR은 context, decision, consequences, status를 포함하며 accepted ADR은 새 ADR로 대체하기 전까지 유효하다.

## Status hygiene

`current-state.md`는 회의록이나 전체 변경 이력이 아니다. 현재 phase를 재구성하는 데 필요한 완료 사항, 진행 사항, 다음 작업, 열린 결정만 유지한다.

## Maintenance

코드나 구조 변경으로 문서가 거짓이 되면 같은 변경에서 문서를 갱신한다. 더 이상 유효하지 않은 내용을 방치하지 말고 history가 필요하면 ADR 또는 version control에 맡긴다.

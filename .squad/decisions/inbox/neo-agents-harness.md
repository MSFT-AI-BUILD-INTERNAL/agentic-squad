# Decision: AGENTS.md Harness 도입

- **Date:** 2026-04-09
- **Author:** Neo (Developer)
- **Status:** Implemented
- **Requested by:** thomas.park

## 결정 사항

리포지토리 루트에 `AGENTS.md` 파일을 생성하여 **Agent Harness** (에이전트 가드레일) 체계를 도입했다.

## 핵심 규칙

- **Rule 1**: `git push` 및 모든 변형 명령어 절대 금지
- 대안: 로컬 커밋 → `gh pr create --draft` → 사용자 알림

## 팀 영향

- **모든 에이전트**: AGENTS.md의 Harness 규칙은 개별 Charter보다 우선한다
- **Oracle/Architect**: 새 패턴 설계 시 Harness 준수 여부를 검증해야 한다
- **향후**: 새로운 금지 규칙을 동일한 구조(금지 명령어, 이유, 대안, 집행)로 추가 가능

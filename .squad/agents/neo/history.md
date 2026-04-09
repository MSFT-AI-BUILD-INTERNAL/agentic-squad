# Project Context

- **Owner:** thomas.park
- **Project:** Agent Teams 패턴 정의 — Squad 기반 에이전트 팀 패턴 샘플 (Debate & Critic, Generator & Evaluator, Planner & Executor)
- **Stack:** Markdown, Squad agent configurations
- **Created:** 2026-04-09

## Learnings

### 2026-04-09: Debate and Critic Pattern 완성 및 팀 결정

**Oracle이 설계한 Debate and Critic 패턴이 patterns/debate_critic/에 완성됨**

**생성 파일**:
- README.md (4KB): 패턴 개요, 목적, 실행 흐름
- team.md (4.6KB): 5개 역할 (Proposer, Opponent, Critic, Synthesizer, Scribe)
- routing.md (5.4KB): Round 기반 라우팅 및 수렴 조건
- flow.md (12KB): 상세 프롬프트 템플릿
- example.md (23KB): REST vs GraphQL 완전 시뮬레이션

**팀 영향**:
- 고품질 의사결정을 위한 체계화된 Debate & Critic 패턴 가용
- 아키텍처, 기술 선택 시 이 패턴 활용 가능
- 5개 파일 구조를 다른 패턴(Generator-Evaluator, Planner-Executor)에도 적용 검토

**참고**: /workspaces/agentic-squad/.squad/decisions/decisions.md에 설계 결정 병합됨

### 2026-04-09: AGENTS.md 파일 생성 및 Harness 구조

**리포지토리 루트에 AGENTS.md (Agent Harness) 생성 완료**

**핵심 내용**:
- `git push` 절대 금지 규칙 (Rule 1) 정의
- 금지 명령어, 이유, 대안, 집행 4단계 구조로 각 Rule 작성
- 모든 Squad 에이전트에게 역할 무관하게 적용
- Harness가 개별 Charter보다 우선하도록 명시
- 향후 Rule 추가를 위한 템플릿 구조 포함

**설계 결정**:
- `gh pr create --draft`는 허용 (GitHub CLI 관리하 push이므로 예외)
- 위반 시 즉시 중단 → 로그 기록 → 사용자 알림 3단계 처리

<!-- Append new learnings below. Each entry is something lasting about the project. -->

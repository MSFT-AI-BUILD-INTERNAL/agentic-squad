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

<!-- Append new learnings below. Each entry is something lasting about the project. -->

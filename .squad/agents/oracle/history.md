# Project Context

- **Owner:** thomas.park
- **Project:** Agent Teams 패턴 정의 — Squad 기반 에이전트 팀 패턴 샘플 (Debate & Critic, Generator & Evaluator, Planner & Executor)
- **Stack:** Markdown, Squad agent configurations
- **Created:** 2026-04-09

## Learnings

<!-- Append new learnings below. Each entry is something lasting about the project. -->

### 2024-04-09: Debate and Critic Pattern 설계

**작업 완료**: patterns/debate_critic/ 디렉토리에 완전한 에이전트 팀 패턴 정의 생성

**생성 파일**:
- README.md (4KB): 패턴 개요, 목적, 실행 흐름, Mermaid 다이어그램, 장단점
- team.md (4.6KB): Reservoir Dogs 캐릭터 기반 5개 역할 정의 (Proposer, Opponent, Critic, Synthesizer, Scribe)
- routing.md (5.4KB): Round 기반 순차 라우팅, 수렴 조건, 에러 처리
- flow.md (12KB): 각 단계별 상세 프롬프트 템플릿 및 Expected Output
- example.md (23KB): REST API vs GraphQL 완전한 2-Round 시뮬레이션 + Decision Document

**패턴 특징**:
- **변증법적 사고**: Proposer vs Opponent 대립 논증으로 다각도 분석
- **Round 기반 반복**: Synthesizer의 수렴 판단(CONVERGED/CONTINUE)으로 제어
- **5개 역할 분리**: 책임 명확화 (주장/반박/평가/종합/기록)
- **Squad 즉시 실행 가능**: task tool 호출 예시 코드 포함

**핵심 학습**:
1. **문서 구조 재사용 패턴**: README(개요) + team(역할) + routing(흐름) + flow(상세) + example(실전)
2. **프롬프트 템플릿 형식**: Input/Task/Output/Expected Structure 일관된 형식
3. **실전 예시의 중요성**: 23KB 완전 시뮬레이션이 이해도를 크게 향상
4. **수렴 조건 설계**: CONVERGED(명확한 우위/합의)/CONTINUE(미해결)/FORCE_STOP(최대 Round)
5. **Mermaid 활용**: Sequence diagram, State diagram으로 복잡한 흐름 시각화

**재사용 가능 결정**:
- Reservoir Dogs 캐스팅 (대립적 성격이 패턴과 잘 맞음)
- 5개 파일 구조 (다른 패턴에도 적용 가능)
- 한국어 + 영어 기술 용어 병기 스타일
- Round 제한 (보통 3 rounds, 무한 반복 방지)

**주요 파일 경로**:
- /workspaces/agentic-squad/patterns/debate_critic/README.md
- /workspaces/agentic-squad/patterns/debate_critic/example.md (가장 상세)
- /workspaces/agentic-squad/.squad/decisions/decisions.md (설계 결정 문서, 병합됨)

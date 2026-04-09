# Team Decisions

## Decision: Git Push Prohibition Directive

**Date**: 2026-04-09  
**Author**: thomas.park (via Copilot)  
**Status**: Active  
**Type**: Agent Harness Rule

### Context

User directive received to enforce git push prohibition across all agents.

### Decision

Define git push prohibition harness rule in AGENTS.md for all team agents:
- **Directive**: git push 절대 금지 — git push 명령 실행 금지
- **Scope**: All agents in agentic-squad
- **Enforcement**: Harness rules in AGENTS.md

### Rationale

User explicitly requested that no agent should execute git push commands. This is captured as a team-wide harness rule to prevent accidental or unauthorized repository modifications.

### Status

Captured for team memory and AGENTS.md harness implementation.

---

## Decision: Debate and Critic Pattern 설계 방향

**Date**: 2024-04-09  
**Author**: Oracle  
**Status**: Implemented  
**Type**: Pattern Design

### Context

사용자가 patterns/debate_critic/ 디렉토리에 Squad로 실행 가능한 Debate and Critic 패턴 샘플을 요청했다. 이 패턴은 대립적 논증과 비평을 통해 고품질 의사결정을 도출하는 에이전트 협업 패턴이다.

### Decision

#### 1. 문서 구조
다음 5개 파일로 패턴을 완전히 정의:
- **README.md**: 패턴 개요, 목적, 장단점, Squad 실행 방법
- **team.md**: 팀 로스터 및 역할별 프롬프트 힌트
- **routing.md**: Round 기반 라우팅 규칙 및 수렴 조건
- **flow.md**: 각 단계별 상세 프롬프트 템플릿
- **example.md**: 실전 예시 (REST vs GraphQL 전체 시뮬레이션)

#### 2. 역할 정의
5개 핵심 역할:
1. **Proposer** (Mr. Orange): 특정 입장 주장 및 옹호
2. **Opponent** (Mr. White): 반대 입장 및 리스크 분석
3. **Critic** (Mr. Pink): 양측 논증 평가 (중립적)
4. **Synthesizer** (Nice Guy Eddie): 논의 종합 및 수렴 판단
5. **Scribe** (Mr. Blonde): 최종 문서화

→ **Reservoir Dogs 캐릭터 캐스팅**: 기억하기 쉽고 역할 구분이 명확

#### 3. 실행 흐름
- **Round 기반 반복**: Setup → Round 1-N → Finalization
- **각 Round**: Proposer → Opponent → Critic → Synthesizer
- **수렴 조건**: Synthesizer가 CONVERGED/CONTINUE 판단
- **최대 Round**: 보통 3 rounds (무한 반복 방지)

#### 4. 프롬프트 템플릿 형식
각 역할별로 다음 구조:
```
## 역할
[역할 설명]

## 주제
{topic}

## 지시사항
### 1. [섹션 1]
### 2. [섹션 2]
...

명확하고 구조화된 결과를 작성하세요.
```

→ **일관된 형식**으로 재사용성 향상

#### 5. 실전 예시 선택
**주제**: "REST API vs GraphQL for MarketFlow"
- 실무에서 자주 발생하는 의사결정
- 2 Rounds 전체 시뮬레이션 (Round 1: 원칙 논쟁, Round 2: 데이터 기반 재논의)
- 최종 Decision Document까지 포함 (23KB 분량)

→ **구체적이고 완전한 예시**로 사용자가 패턴을 즉시 이해하고 적용 가능

#### 6. 문서화 언어
- **한국어 주 언어** + 영어 기술 용어 병기
- Mermaid 다이어그램으로 시각화
- 표(Table) 활용으로 정보 밀도 향상

### Rationale

#### 왜 Reservoir Dogs 캐스팅?
- 사용자 요청에 명시되지 않았으나, team.md 예시로 구체적 캐릭터 필요
- Reservoir Dogs는 역할이 명확하고 대립적 성격(Mr. Orange vs Mr. White)이 패턴과 잘 맞음
- 코드 네임(Mr. Orange, Mr. Pink 등)이 역할 이름으로 기억하기 쉬움

#### 왜 5개 역할?
- Proposer/Opponent: 대립 논증의 핵심
- Critic: 중립적 평가 (양측이 자기 편향 방지)
- Synthesizer: 수렴 판단 및 방향 제시 (Critic과 분리하여 책임 명확화)
- Scribe: 최종 문서화 (결정 근거 추적 가능성)

#### 왜 example.md가 23KB?
- 실전 예시 없이는 패턴 적용이 어려움
- 2 Rounds 완전 시뮬레이션으로 수렴 과정까지 보여줌
- 각 역할의 실제 Output 예시 포함 (프롬프트만으로는 부족)

### Alternatives Considered

#### 대안 1: 더 단순한 구조 (3개 파일)
- README + team + example만 제공
- **기각 이유**: routing, flow 세부사항이 누락되면 실제 구현 시 어려움

#### 대안 2: 실전 예시 없이 추상적 설명만
- **기각 이유**: 사용자가 패턴을 이해하기 어렵고, 적용 시 시행착오 증가

#### 대안 3: Marvel/Star Trek 같은 다른 캐스팅
- **선택 이유**: Reservoir Dogs가 대립적 성격(긴장감)을 더 잘 표현
- (team.md에 다른 캐스팅 옵션도 제시함)

### Impact

#### 팀 전체
- Debate and Critic 패턴을 즉시 사용 가능
- 중요한 의사결정(아키텍처, 기술 선택 등)에서 체계적 분석 가능

#### 향후 패턴 설계
- 이 문서 구조(5개 파일)를 다른 패턴(Generator-Evaluator, Planner-Executor 등)에도 적용 가능
- 프롬프트 템플릿 형식 재사용

### Next Steps

- [ ] 다른 패턴(generator_evaluator, planner_executor)에도 동일 구조 적용 검토
- [ ] 실제 프로젝트에 Debate and Critic 적용 후 피드백 수집
- [ ] 패턴 변형(Fast Track, Multi-Perspective 등) 필요 시 추가

### References

- /workspaces/agentic-squad/patterns/debate_critic/README.md
- /workspaces/agentic-squad/patterns/debate_critic/example.md
- Squad task tool documentation

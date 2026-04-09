# 🤖 Agentic Squad

> Squad CLI를 활용한 **멀티 에이전트 협업 패턴** 레퍼런스 프로젝트

여러 AI 에이전트가 역할을 분담하여 협업하는 패턴들을 정의하고, [Squad CLI](https://github.com/bradygaster/squad)로 실행할 수 있는 샘플을 제공합니다.

## 프로젝트 구조

```
agentic-squad/
├── AGENTS.md                  # 모든 에이전트 공통 가드레일 (Harness)
├── init.sh                    # Codespace 환경 셋업 스크립트
├── .squad/                    # Squad 팀 설정 (team, routing, ceremonies 등)
│   ├── config.json
│   ├── team.md                # 팀 구성 — Morpheus, Oracle, Neo, Trinity, Scribe, Ralph
│   ├── routing.md             # 작업 라우팅 규칙
│   ├── ceremonies.md          # Design Review / Retrospective
│   └── agents/                # 에이전트별 Charter
└── patterns/                  # 멀티 에이전트 협업 패턴 예시
    ├── debate_critic/         # 변증법적 토론 패턴
    ├── generator_evaluator/   # 생성-평가 반복 패턴
    └── planner_executor/      # 계획-실행 분리 패턴
```

## 팀 구성

| 이름 | 역할 | 설명 |
|------|------|------|
| **Morpheus** | Lead | 작업 라우팅, 아키텍처 리뷰, 스코프 결정 |
| **Oracle** | Pattern Designer | 패턴 정의 문서, 에이전트 역할 설계 |
| **Neo** | Developer | 샘플 코드/설정 작성, 패턴 파일 구현 |
| **Trinity** | Reviewer | 패턴 유효성 검증, 리뷰, 엣지 케이스 확인 |
| **Scribe** | Session Logger | 논의 과정과 결론 자동 기록 |
| **Ralph** | Work Monitor | 지속적 작업 모니터링 |

## 시작하기

### 사전 요구 사항

- [GitHub Codespaces](https://github.com/features/codespaces) 또는 Node.js 18+ 환경
- [GitHub Copilot CLI](https://docs.github.com/copilot)

### 방법 1: Codespace (권장)

이 레포를 Codespace로 열면 `init.sh`가 자동 실행되어 모든 도구가 설치됩니다.

### 방법 2: 로컬 환경

```bash
# Squad CLI 설치
npm install -g @bradygaster/squad-cli

# 프로젝트 클론 후 Squad 초기화
git clone https://github.com/<owner>/agentic-squad.git
cd agentic-squad
squad init
```

## Squad 실행 방법

### Squad 대화형 쉘 시작

```bash
# Squad 인터랙티브 모드 실행
squad
```

인자 없이 `squad`를 실행하면 대화형 쉘이 시작됩니다. 이후 자연어로 팀에게 작업을 요청할 수 있습니다.

### 유용한 Squad 명령어

```bash
# 팀 상태 확인
squad status

# 팀 구성원 & 역할 보기
squad cast

# 사용 가능한 기본 역할 목록
squad roles

# Squad 설정 검증
squad doctor

# 토큰 사용량 확인
squad cost
```

---

## 패턴 예시 실행하기

### 1. 🗣️ Debate & Critic (변증법적 토론)

> 두 명의 Debater가 대립적으로 논증하고, Critic이 평가하며, Synthesizer가 최종 결론을 도출하는 패턴

**패턴 상세:** [`patterns/debate_critic/README.md`](patterns/debate_critic/README.md)

#### 실행 커맨드 & 프롬프트

```bash
# Squad 대화형 쉘 진입
squad
```

쉘 진입 후 아래 프롬프트를 입력합니다:

```
Squad, REST API vs GraphQL 중 우리 프로젝트에 어떤 걸 쓸지 debate 해줘
```

```
Squad, 모노레포 vs 멀티레포 장단점을 토론해줘
```

```
Squad, PostgreSQL vs MongoDB — 우리 서비스 데이터 특성에 맞는 DB를 골라줘
```

```
Team, Kubernetes vs Serverless — 우리 팀 규모와 서비스 특성에 맞는 인프라를 논의해줘
```

#### 진행 흐름

1. **Proposer** → 찬성 입장 제시
2. **Opponent** → 반대 논증 및 약점 지적
3. **Critic** → 양측 논증의 강점/약점 평가
4. **Synthesizer** → 종합 및 수렴 판단
5. 수렴하지 않으면 → 다음 Round 반복 (최대 3회)
6. 수렴 시 → **Scribe**가 최종 문서화

---

### 2. 🔄 Generator & Evaluator (생성-평가 반복)

> Generator가 콘텐츠·코드·솔루션을 생성하고, Evaluator가 기준에 따라 평가·채점하며, Refiner가 피드백을 반영해 개선하는 순환 패턴

**패턴 상세:** [`patterns/generator_evaluator/README.md`](patterns/generator_evaluator/README.md)

#### 에이전트 구성

| 역할 | 설명 |
|------|------|
| **Generator** | 요구사항을 분석하여 초안(코드·문서·설계)을 생성 |
| **Evaluator** | 기준표에 따라 산출물을 평가·채점하고 개선점 제시 |
| **Refiner** | Evaluator 피드백을 반영하여 산출물을 구체적으로 개선 |
| **Scribe** | 각 Cycle의 변경 이력과 최종 결과를 기록·요약 |

#### 실행 커맨드 & 프롬프트

```bash
squad
```

쉘 진입 후 아래 프롬프트를 입력합니다:

```
Team, 사용자 인증 API 코드를 생성하고 리뷰해줘
```

```
Team, 제품 소개 랜딩페이지 카피를 작성하고 평가해줘
```

```
Team, CI/CD 파이프라인 설정을 생성하고 검증해줘
```

#### 진행 흐름

1. **Generator** → 요구사항 분석 후 초안 생성
2. **Evaluator** → 기준표에 따라 평가·채점, Pass/Fail 판정
3. Fail → **Refiner**가 피드백을 반영하여 산출물 개선 → Evaluator 재평가 (최대 3 Cycles)
4. Pass → **Scribe**가 최종 산출물과 Cycle별 개선 이력을 문서화

---

### 3. 📋 Planner & Executor (계획-실행 분리)

> Planner가 요구사항을 분석하여 구조화된 실행 계획을 수립하고, Executor가 태스크별로 구현하며, Validator가 완료 기준 충족 여부를 검증하는 패턴

**패턴 상세:** [`patterns/planner_executor/README.md`](patterns/planner_executor/README.md)

#### 에이전트 구성

| 역할 | 설명 |
|------|------|
| **Planner** | 요구사항을 분석하고 태스크·의존성·순서를 포함한 실행 계획 수립 |
| **Executor** | 계획에 따라 태스크를 하나씩 구현·실행 |
| **Validator** | 각 태스크의 완료 기준(Acceptance Criteria) 충족 여부를 검증 |
| **Scribe** | 계획·실행·검증 과정 전체를 기록·요약 |

#### 실행 커맨드 & 프롬프트

```bash
squad
```

쉘 진입 후 아래 프롬프트를 입력합니다:

```
Team, 결제 시스템 통합을 계획하고 실행해줘
```

```
Team, 레거시 API를 v2로 마이그레이션 계획 세워줘
```

```
Team, 모노레포 전환 작업을 단계별로 계획하고 진행해줘
```

#### 진행 흐름

1. **Planner** → 요구사항 분석 후 태스크 목록·의존성·완료 기준을 포함한 실행 계획 수립
2. **Executor** → 계획의 첫 번째(또는 다음) 태스크를 구현
3. **Validator** → 구현 결과가 완료 기준을 충족하는지 검증, Pass/Revise 판정
4. Pass → 다음 태스크로 진행 (Step 2로)
5. Revise → **Planner**가 계획을 수정하고 해당 태스크부터 재실행
6. 모든 태스크 Pass → **Scribe**가 전체 과정을 문서화

---

## 커스텀 패턴 적용하기

기존 패턴을 프로젝트에 적용하려면:

```bash
# 1. 패턴의 team.md를 .squad/team.md로 복사
cp patterns/debate_critic/team.md .squad/team.md

# 2. Squad 재초기화 (기존 설정 유지)
squad init

# 3. Squad 시작
squad
```

## 가드레일 (AGENTS.md)

모든 에이전트는 [`AGENTS.md`](AGENTS.md)에 정의된 Harness Rules를 준수합니다:

- 🔴 **`git push` 절대 금지** — 모든 원격 반영은 `gh pr create --draft`를 통한 PR 기반 워크플로우로 진행
- 코드가 원격 저장소에 반영되기 전 반드시 사람의 검토를 거침

## 라이선스

이 프로젝트의 라이선스 정보는 레포지토리 설정을 확인하세요.

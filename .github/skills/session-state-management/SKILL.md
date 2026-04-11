---
name: session-state-management
description: "파일 기반 세션 상태 관리 라이프사이클. 패턴 에이전트(debate_critic, generator_evaluator, planner_executor, leadership)가 세션 상태를 영속화하고 중단된 세션을 복구할 때 사용한다."
---

# Session State Management

모든 패턴 에이전트가 공통으로 사용하는 파일 기반 세션 상태 관리 라이프사이클.
각 패턴 agent.md 에서 이 스킬을 참조하고, 패턴 고유 설정과 조합하여 사용한다.

## 디렉토리 구조

```
.squad/patterns/
├── state.json                          # 활성 세션 인덱스
└── history/                            # 완료된 세션 요약
    └── {date}-{pattern}-{slug}.md
```

### 세션 디렉토리 (실행 중 생성)

```
.squad/patterns/{session-id}/
├── meta.json                           # 세션 메타데이터
├── progress.json                       # 진행 상황 (패턴별 스키마)
├── agents/                             # 에이전트별 산출물
│   └── {agent-name}[-{context}].md
└── summary.md                          # 최종 요약 (완료 시)
```

## Session Init (세션 시작 시)

1. `.squad/patterns/state.json` 을 읽는다.
2. `active` 가 이 패턴의 세션 ID 를 가리키고 있으면:
   - 해당 세션의 `progress.json` 을 읽고 중단 지점을 파악한다.
   - 사용자에게 알린다: `"이전 세션이 {iteration} {N} 에서 중단되었습니다. 이어서 진행합니다."`
   - 이미 `agents/` 에 산출물이 있는 에이전트는 건너뛴다.
3. `active` 가 null 이면 새 세션을 생성한다:
   - 세션 ID: `{ISO-date}-{pattern_name}-{slug}` (slug 은 사용자 프롬프트에서 2~3 단어)
   - `.squad/patterns/{session-id}/` 디렉토리 생성
   - `meta.json` 작성:
     ```json
     {
       "id": "{session-id}",
       "pattern": "{pattern_name}",
       "prompt": "{사용자 프롬프트}",
       "createdAt": "{ISO}",
       "status": "in-progress",
       "user": "{git user.name}"
     }
     ```
   - `progress.json` 초기화 — **패턴별 스키마에 따라** (각 agent.md 에 정의됨)
   - `agents/` 디렉토리 생성
   - `.squad/patterns/state.json` 의 `active` 를 세션 ID 로 업데이트

## After Each Agent Step (에이전트 완료 시마다)

1. 에이전트 산출물을 `.squad/patterns/{session-id}/agents/` 에 기록한다 — **파일명은 패턴별 규칙에 따름**.
2. `progress.json` 에서 해당 에이전트/단계의 status 를 업데이트한다 — **업데이트 로직은 패턴별 규칙에 따름**.
3. `meta.json` 의 `updatedAt` 을 갱신한다.

## On Completion (완료 시)

1. `meta.json` 의 `status` 를 `"completed"` 로 변경한다.
2. 최종 산출물(Scribe/Chief of Staff)을 `.squad/patterns/{session-id}/summary.md` 로 복사한다.
3. `.squad/patterns/state.json` 의 `active` 를 `null` 로, `history` 에 완료 기록을 추가한다:
   ```json
   { "id": "{session-id}", "pattern": "{pattern_name}", "status": "completed", "summary": "{1줄 요약}" }
   ```
4. `.squad/patterns/history/{date}-{pattern_name}-{slug}.md` 에 최종 요약을 append 한다.
5. 의사결정이 있으면 `.squad/decisions/inbox/{pattern_name}-{slug}.md` 로 드롭한다.

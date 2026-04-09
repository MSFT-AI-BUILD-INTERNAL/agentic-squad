# Squad Decisions

## Active Decisions

### 2026-04-09T08:31:41Z: Pattern Simplification Directive

**By:** thomas.park (via Copilot)  
**Status:** IMPLEMENTED (Neo completed pattern simplification)

**Directive**: patterns 폴더는 각 Agent Teams 활용 Pattern에 맞는 예시만 있으면 된다. 기본적인 md 파일 셋업만 알려주고, 어떤식으로 실행하면 되는지를 README.md에 포함. 실제 논의는 사용자가 Squad를 통해 연습하는 구조.

**Decision**: Each pattern folder should contain concise setup + execution guide in README.md. Neo simplified debate_critic pattern: 2,636 lines → 158 lines, deleted 4 files, rewrote README with minimal team.md template.

**Impact**: All patterns follow concise structure; documentation reduced while clarity maintained.

---

### 2026-04-09: Agent Harness Framework — AGENTS.md

**Date:** 2026-04-09  
**Author:** Neo (Developer)  
**Status:** Implemented

**Decision**: Repository root AGENTS.md file establishes **Agent Harness** framework (agent guardrails).

**Core Rules**:
- **Rule 1**: `git push` and all variants absolutely prohibited
- **Alternative**: Local commit → `gh pr create --draft` → user notification

**Team Impact**:
- All agents: AGENTS.md Harness rules supersede individual Charters
- Oracle/Architect: Must validate Harness compliance in new pattern designs
- Future: New prohibitive rules follow same structure (forbidden command, reason, alternative, enforcement)

## Governance

- All meaningful changes require team consensus
- Document architectural decisions here
- Keep history focused on work, decisions focused on direction

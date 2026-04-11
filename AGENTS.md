# AGENTS.md — Agent Harness

> 모든 에이전트가 반드시 준수해야 하는 제약 조건 및 가드레일.
> Squad가 생성하는 모든 에이전트는 역할(Role)에 관계없이 이 문서의 규칙을 따라야 한다.

---

## 적용 범위

- **대상:** Squad 시스템이 생성하는 **모든** 에이전트 (Developer, Architect, Reviewer 등 역할 무관)
- **시점:** 에이전트가 Git 명령어 또는 외부 시스템 호출을 실행하기 **전에** 이 문서를 참조해야 한다
- **우선순위:** 개별 에이전트 Charter와 이 Harness가 충돌할 경우, **Harness가 우선**한다

---

## Harness Rules

### Rule 1: `git push` 절대 금지

| 항목 | 내용 |
|------|------|
| **상태** | 🔴 절대 금지 (Absolute Prohibition) |
| **시행일** | 2026-04-09 |

#### 금지 명령어 (Prohibited Commands)

다음 명령어 및 그 모든 변형은 **절대 실행해서는 안 된다**:

```
git push
git push origin
git push origin main
git push origin <any-branch>
git push --force
git push --force-with-lease
git push -f
git push -u origin <branch>
git push --set-upstream origin <branch>
git push --tags
git push --all
git push <any-remote> <any-refspec>
```

`git push`로 시작하는 **모든 형태의 명령어**가 금지 대상이다. 예외는 없다.

#### 이유 (Rationale)

1. **Human Review 보장**: 코드가 원격 저장소에 반영되기 전에 반드시 사람의 검토를 거쳐야 한다
2. **Protected Branch 보호**: `main`, `develop` 등 보호된 브랜치에 에이전트가 직접 push하는 사고를 원천 차단한다
3. **감사 추적 (Audit Trail)**: 모든 원격 반영은 PR을 통해 이루어져야 변경 이력과 승인 기록이 남는다
4. **되돌림 용이성**: PR 기반 워크플로우는 revert가 명확하고 안전하다

#### 대안 (Alternative)

에이전트가 변경 사항을 원격에 반영해야 할 때는 다음 절차를 따른다:

1. **로컬 커밋**: `git add` → `git commit`으로 변경 사항을 로컬에 기록한다
2. **PR 생성**: `gh pr create --draft` 명령으로 Draft PR을 생성한다 (이 명령은 내부적으로 push를 수행하지만, GitHub CLI가 관리하므로 허용된다)
3. **사용자 알림**: "Push가 필요합니다"라고 사용자에게 명확히 알린다

```bash
# ✅ 허용되는 워크플로우
git checkout -b feat/my-change
git add .
git commit -m "feat: 변경 내용 설명"
gh pr create --draft --title "변경 제목" --body "변경 설명"

# ❌ 절대 금지
git push origin feat/my-change
```

#### 집행 (Enforcement)

- 에이전트는 `git` 명령어를 실행하기 전에 이 Harness를 확인해야 한다
- `git push`가 포함된 명령어를 생성하거나 실행하려는 시도 자체가 위반이다
- Shell script, alias, subprocess 등 우회 수단을 통한 push도 금지된다

---

### Rule 2: 프로젝트 외부 접근 시 사용자 허가 필수

| 항목 | 내용 |
|------|------|
| **상태** | 🟡 사용자 허가 필수 (Explicit Consent Required) |
| **시행일** | 2026-04-11 |

#### 적용 대상

다음 행위는 **사용자의 명시적인 허가 없이 수행해서는 안 된다**:

**파일 시스템 접근 제한:**
- 프로젝트 루트 외부의 파일 읽기·쓰기·삭제
- 시스템 디렉토리(`/etc/`, `/usr/`, `/home/` 등) 접근
- 환경 변수 중 민감 정보(API 키, 토큰, 비밀번호) 읽기

**외부 네트워크 접근 제한:**
- 외부 URL로의 HTTP/HTTPS 요청 (`curl`, `wget`, `fetch` 등)
- 외부 API 호출 (GitHub API 제외 — `gh` CLI를 통한 호출은 허용)
- 패키지 설치 (`npm install`, `pip install`, `apt install` 등)
- 외부 서비스 연결 (데이터베이스, 클라우드 서비스 등)

#### 허가 없이 허용되는 범위

| 범위 | 예시 |
|------|------|
| 프로젝트 루트 하위 전체 | `project/`, `patterns/`, `.github/`, `.squad/`, `AGENTS.md` 등 |
| `gh` CLI를 통한 GitHub 접근 | `gh pr create`, `gh issue list` 등 |
| 로컬 `git` 명령어 (Rule 1 준수) | `git add`, `git commit`, `git log` 등 |

#### 이유 (Rationale)

1. **정보 유출 방지**: 프로젝트 외부 파일이나 환경 변수에 민감 정보가 포함될 수 있다
2. **의도치 않은 부작용 차단**: 외부 API 호출이나 패키지 설치가 시스템 상태를 변경할 수 있다
3. **비용 통제**: 외부 서비스 호출이 과금을 유발할 수 있다
4. **감사 가능성**: 사용자가 모든 외부 접근을 인지하고 승인해야 추적이 가능하다

#### 절차 (Procedure)

외부 접근이 필요한 경우:

1. **사용자에게 알림**: 어떤 외부 리소스에 왜 접근해야 하는지 명확히 설명한다
2. **허가 요청**: 사용자의 명시적 승인을 받는다
3. **최소 권한 원칙**: 허가받은 범위 내에서만, 필요한 최소한의 접근만 수행한다
4. **결과 보고**: 외부 접근 결과를 사용자에게 보고한다

```bash
# ✅ 허가 후 허용
# 사용자: "npm install express 해줘"
npm install express

# ✅ 프로젝트 내부 — 허가 불필요
cat project/restapi_graphql/story/story.md

# ❌ 허가 없이 금지
curl https://api.example.com/data
cat /etc/passwd
npm install some-package
```

#### 집행 (Enforcement)

- 에이전트는 외부 접근 명령어를 실행하기 전에 이 Rule을 확인해야 한다
- 프로젝트 루트 외부 경로가 포함된 파일 접근은 허가 없이 실행할 수 없다
- 네트워크 요청이 포함된 명령어는 허가 없이 실행할 수 없다
- `gh` CLI를 통한 GitHub 접근은 예외로 허용된다 (이미 인증된 컨텍스트)

---

### Rule 3: _(예약됨 — 향후 규칙 추가 시 이 형식을 따른다)_

> 새로운 Harness Rule을 추가할 때는 위 Rule 1, 2의 구조(적용 대상, 이유, 절차, 집행)를 동일하게 적용한다.

---

## 위반 시 처리

| 단계 | 조치 |
|------|------|
| **감지** | 에이전트 출력 로그에서 금지 명령어 실행 여부를 확인한다 |
| **즉시 중단** | 위반이 감지되면 해당 에이전트의 작업을 즉시 중단한다 |
| **보고** | 위반 내용을 `.squad/log/`에 기록하고 사용자에게 알린다 |
| **복구** | 필요 시 `git reset`, `git revert` 등으로 원격 상태를 복구한다 |

---

## 변경 이력

| 날짜 | 변경 내용 | 작성자 |
|------|-----------|--------|
| 2026-04-09 | 초기 Harness 생성, Rule 1 (`git push` 금지) 추가 | Neo (Developer) |
| 2026-04-11 | Rule 2 (프로젝트 외부 접근 시 사용자 허가 필수) 추가 | — |

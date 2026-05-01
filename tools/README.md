# tools/

Copilot CLI 에이전트가 활용할 수 있는 도구 모음.

## parse_ppt.py

PowerPoint (.pptx) 파일을 파싱하여 JSON 또는 Markdown 형식으로 출력하는 도구.

### 의존성

```bash
pip install python-pptx
```

### 사용법

```bash
# 기본 사용 (JSON 출력)
python tools/parse_ppt.py presentation.pptx

# 슬라이드 목록 조회
python tools/parse_ppt.py presentation.pptx --slides

# 특정 슬라이드를 Markdown으로 출력
python tools/parse_ppt.py presentation.pptx --slide 3 --format markdown

# 테이블만 추출
python tools/parse_ppt.py presentation.pptx --tables

# 이미지 메타데이터 포함
python tools/parse_ppt.py presentation.pptx --images

# 발표자 노트 포함
python tools/parse_ppt.py presentation.pptx --notes --format markdown

# 요약 통계 출력
python tools/parse_ppt.py presentation.pptx --summary

# 최대 슬라이드 수 제한
python tools/parse_ppt.py presentation.pptx --max-slides 10
```

### 출력 형식

| 형식 | 설명 |
|------|------|
| `json` | 구조화된 JSON (기본값) — 에이전트가 프로그래밍적으로 처리하기 좋음 |
| `markdown` | Markdown — 사람이 읽기 좋은 형식 |

### Copilot CLI 에이전트 활용 예시

에이전트가 PowerPoint 파일을 분석해야 할 때:

```bash
# 1. 먼저 슬라이드 구조 파악
python tools/parse_ppt.py input.pptx --slides

# 2. 요약으로 전체 구조 파악
python tools/parse_ppt.py input.pptx --summary

# 3. 특정 슬라이드를 상세 분석
python tools/parse_ppt.py input.pptx --slide 5 --notes --images --format markdown
```

---

## parse_excel.py

Excel (.xlsx) 파일을 파싱하여 JSON, Markdown, CSV 형식으로 출력하는 도구.

### 의존성

```bash
pip install openpyxl
```

### 사용법

```bash
# 기본 사용 (JSON 출력)
python tools/parse_excel.py data.xlsx

# 시트 목록 조회
python tools/parse_excel.py data.xlsx --sheets

# 특정 시트를 Markdown 테이블로 출력
python tools/parse_excel.py data.xlsx --sheet "Sheet2" --format markdown

# 특정 범위만 파싱
python tools/parse_excel.py data.xlsx --range A1:D10

# 요약 통계 출력
python tools/parse_excel.py data.xlsx --summary

# 최대 행 수 제한
python tools/parse_excel.py data.xlsx --max-rows 50 --format csv
```

### 출력 형식

| 형식 | 설명 |
|------|------|
| `json` | 구조화된 JSON (기본값) — 에이전트가 프로그래밍적으로 처리하기 좋음 |
| `markdown` | Markdown 테이블 — 사람이 읽기 좋은 형식 |
| `csv` | CSV — 다른 도구와 연동하기 좋은 형식 |

### Copilot CLI 에이전트 활용 예시

에이전트가 Excel 파일을 분석해야 할 때:

```bash
# 1. 먼저 시트 구조 파악
python tools/parse_excel.py input.xlsx --sheets

# 2. 요약 통계로 데이터 개요 파악
python tools/parse_excel.py input.xlsx --summary

# 3. 필요한 데이터를 JSON으로 추출
python tools/parse_excel.py input.xlsx --sheet "매출" --format json
```

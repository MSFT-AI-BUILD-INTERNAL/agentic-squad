---
name: "excel-parser"
description: "Parse and analyze Excel (.xlsx) files using the project's parse_excel.py tool"
domain: "data-processing"
confidence: "high"
source: "project tool — tools/parse_excel.py"
tools:
  - name: "bash"
    description: "Execute parse_excel.py to extract data from Excel files"
    when: "When a user provides an .xlsx file or asks to analyze/read Excel data"
---

## Context

The project includes a custom Excel parsing tool at `tools/parse_excel.py` that converts .xlsx files into structured formats (JSON, Markdown, CSV) suitable for agent consumption. Agents should use this tool whenever they need to read, analyze, or process Excel files rather than attempting to install ad-hoc packages or read binary data directly.

## When to Use

- User uploads or references an `.xlsx`, `.xlsm`, `.xltx`, or `.xltm` file
- Task requires reading spreadsheet data
- Task involves analyzing tabular data stored in Excel format
- Comparing or transforming data from Excel sources

## Patterns

### 1. Discovery — Understand the file structure first

Always start by listing sheets to understand what's available:

```bash
python tools/parse_excel.py <file.xlsx> --sheets
```

### 2. Overview — Get summary statistics before full extraction

For large files, get a summary to understand column types and data distribution:

```bash
python tools/parse_excel.py <file.xlsx> --summary
python tools/parse_excel.py <file.xlsx> --sheet "특정시트" --summary
```

### 3. Extraction — Pull data in the most useful format

Choose the format based on the task:

```bash
# JSON — best for programmatic processing by the agent
python tools/parse_excel.py <file.xlsx> --format json

# Markdown — best for presenting to users
python tools/parse_excel.py <file.xlsx> --format markdown

# CSV — best for piping to other tools or large datasets
python tools/parse_excel.py <file.xlsx> --format csv
```

### 4. Targeted extraction — Use range and row limits for large files

```bash
# Only first 20 rows
python tools/parse_excel.py <file.xlsx> --max-rows 20

# Specific cell range
python tools/parse_excel.py <file.xlsx> --range A1:E50

# Specific sheet with row limit
python tools/parse_excel.py <file.xlsx> --sheet "Data" --max-rows 100 --format json
```

### 5. No-header mode — When the file has no header row

```bash
python tools/parse_excel.py <file.xlsx> --header 0
```

## Recommended Workflow

1. `--sheets` → identify relevant sheets
2. `--summary` → understand data shape and types
3. `--format json --max-rows 20` → inspect sample data
4. Full extraction with appropriate format for the task

## Anti-Patterns

- Don't try to read .xlsx files with `cat`, `view`, or other text tools — they are binary
- Don't install additional Excel packages (pandas, xlrd) when parse_excel.py suffices
- Don't extract the entire file if only a specific range or sheet is needed
- Don't skip the `--sheets` step for unfamiliar files

## Dependencies

Requires `openpyxl`. Install if missing:

```bash
pip install openpyxl
```

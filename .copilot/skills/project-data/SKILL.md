---
name: "project-data"
description: "Reference project data files (Excel, CSV, JSON, etc.) in each project's data/ folder before starting work"
domain: "data-awareness"
confidence: "high"
source: "project convention — project/*/data/ folders contain reference data for each project"
tools:
  - name: "bash"
    description: "List and parse data files in project data/ directories"
    when: "When starting work on a project or when data context is needed"
  - name: "view"
    description: "Read text-based data files (CSV, JSON, TXT)"
    when: "When data files are text-readable formats"
---

## Context

Each project under `project/` may contain a `data/` subfolder with reference materials — spreadsheets, CSVs, JSON files, configuration data, sample inputs, or specification documents. Agents should check for and reference these files when working on the corresponding project, as they often contain business rules, data schemas, or requirements that inform implementation decisions.

## Directory Convention

```
project/
├── <project-name>/
│   ├── data/          ← Reference data lives here
│   │   ├── *.xlsx    (Excel files — use tools/parse_excel.py)
│   │   ├── *.csv     (CSV files — use view or cat)
│   │   ├── *.json    (JSON files — use view or jq)
│   │   └── *.txt     (Text files — use view)
│   ├── story/         ← Requirements/stories
│   └── ...
```

## Patterns

### 1. Discovery — Check what data is available at the start of any project task

```bash
find project/<project-name>/data/ -type f 2>/dev/null | sort
```

Or for all projects:

```bash
find project/*/data/ -type f 2>/dev/null | sort
```

### 2. Reading data by file type

**Excel files (.xlsx, .xlsm):**
```bash
python tools/parse_excel.py project/<project-name>/data/<file>.xlsx --sheets
python tools/parse_excel.py project/<project-name>/data/<file>.xlsx --summary
python tools/parse_excel.py project/<project-name>/data/<file>.xlsx --format json
```

**CSV files:**
```bash
head -20 project/<project-name>/data/<file>.csv
```

**JSON files:**
Use the `view` tool directly or:
```bash
cat project/<project-name>/data/<file>.json | python -m json.tool
```

**Text/Markdown files:**
Use the `view` tool directly.

### 3. Using data context in implementation

When implementing features for a project:
1. First check `project/<name>/data/` for any relevant reference files
2. Parse and understand the data structure before writing code
3. Use data column names, value ranges, and business rules from the data files
4. Validate implementation against the reference data

## When to Use

- Starting any task related to a specific project
- Implementing data models or database schemas
- Writing data transformation or processing logic
- Creating APIs that serve or accept data matching the project's domain
- Writing tests that need realistic sample data
- Answering questions about a project's data structure or business rules

## Anti-Patterns

- Don't ignore data/ files when they exist — they are placed there intentionally as reference
- Don't hardcode values that could be derived from the data files
- Don't assume data structure without checking the actual files first
- Don't read entire large Excel files at once — use `--summary` first, then targeted extraction

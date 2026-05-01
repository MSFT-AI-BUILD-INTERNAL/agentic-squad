---
name: "ppt-parser"
description: "Parse and analyze PowerPoint (.pptx) files using the project's parse_ppt.py tool"
domain: "data-processing"
confidence: "high"
source: "project tool — tools/parse_ppt.py"
tools:
  - name: "bash"
    description: "Execute parse_ppt.py to extract data from PowerPoint files"
    when: "When a user provides a .pptx file or asks to analyze/read PowerPoint data"
---

## Context

The project includes a custom PowerPoint parsing tool at `tools/parse_ppt.py` that converts .pptx files into structured formats (JSON, Markdown) suitable for agent consumption. Agents should use this tool whenever they need to read, analyze, or process PowerPoint files rather than attempting to install ad-hoc packages or read binary data directly.

## When to Use

- User uploads or references a `.pptx` or `.pptm` file
- Task requires reading presentation content (text, tables, notes)
- Task involves analyzing slide structure or extracting specific slides
- Comparing or summarizing presentation content

## Patterns

### 1. Discovery — Understand the presentation structure first

Always start by listing slides to understand what's available:

```bash
python tools/parse_ppt.py <file.pptx> --slides
```

### 2. Overview — Get summary statistics before full extraction

For large presentations, get a summary to understand slide count and content types:

```bash
python tools/parse_ppt.py <file.pptx> --summary
```

### 3. Extraction — Pull data in the most useful format

Choose the format based on the task:

```bash
# JSON — best for programmatic processing by the agent
python tools/parse_ppt.py <file.pptx> --format json

# Markdown — best for presenting to users
python tools/parse_ppt.py <file.pptx> --format markdown
```

### 4. Targeted extraction — Focus on specific content

```bash
# Specific slide only
python tools/parse_ppt.py <file.pptx> --slide 3

# Tables only (across all slides)
python tools/parse_ppt.py <file.pptx> --tables

# Include image metadata
python tools/parse_ppt.py <file.pptx> --images

# Include speaker notes
python tools/parse_ppt.py <file.pptx> --notes

# Limit number of slides
python tools/parse_ppt.py <file.pptx> --max-slides 10
```

### 5. Combined options — Full extraction with all metadata

```bash
python tools/parse_ppt.py <file.pptx> --notes --images --format markdown
```

## Recommended Workflow

1. `--slides` → identify slide titles and structure
2. `--summary` → understand content types (tables, images, charts)
3. `--slide N --format markdown` → inspect specific slides of interest
4. Full extraction with appropriate format and options for the task

## Anti-Patterns

- Don't try to read .pptx files with `cat`, `view`, or other text tools — they are binary (ZIP archives)
- Don't install additional PowerPoint packages when parse_ppt.py suffices
- Don't extract the entire presentation if only a specific slide is needed
- Don't skip the `--slides` step for unfamiliar files

## Dependencies

Requires `python-pptx`. Install if missing:

```bash
pip install python-pptx
```

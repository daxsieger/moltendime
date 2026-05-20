# AI Rule Archive

This directory stores a local catalog of AI-agent customization assets for archival and teaching purposes.

`ai-rule-learner` is the primary owner of this archive as part of the wider workspace knowledge index.

## Files

- `catalog.jsonl`: append-only archive records.
- `../knowledge-index/README.md`: ownership model and update procedure for the full knowledge index.
- `../knowledge-index/INDEX.md`: generated snapshot of structural personas, expert personas, bundles, skills, and agents.

## Record Fields

- `timestamp`
- `engine`
- `asset_type`
- `name`
- `path`
- `summary`
- `tags`
- `notes`

## Rule

- Archive assets by reading and summarizing them, not by executing them.
- Refresh the broader knowledge index with `./scripts/rebuild-knowledge-index.ps1` whenever system personas, expert personas, repo bundles, paper bundles, skills, or agents change.
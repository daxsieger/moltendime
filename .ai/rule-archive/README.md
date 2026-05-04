# AI Rule Archive

This directory stores a local catalog of AI-agent customization assets for archival and teaching purposes.

## Files

- `catalog.jsonl`: append-only archive records.
- `moltbook-programmers-index.json`: generated index of Moltbook programmer stories for archival lookup.

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
- Generated indexes should point to stable story files so archivist agents can consult summaries before reading full markdown histories.
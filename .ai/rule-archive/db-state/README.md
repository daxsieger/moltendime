# DB State Manifests

This directory stores derived knowledge-state manifests for branch-aware indexes.

- `total_knowledge_hash` changes when the full knowledge visible to the DB changes.
- Each branch also gets its own `knowledge_hash` so cross-branch readers can detect which branch changed.
- These manifests are derived from canonical textual snapshots in `.ai/persona-knowledge/` plus the DB-specific source globs in `.ai/db-definitions.json`.
# Knowledge Index Maintenance

- Treat `ai-rule-learner` as the primary steward of the workspace-wide knowledge index.
- Keep the system persona map in `.ai/personalities/README.md` explicit.
- Keep the readable knowledge index entrypoint in `.ai/knowledge-index/README.md`.
- Rebuild `.ai/knowledge-index/INDEX.md` with `./scripts/rebuild-knowledge-index.ps1` whenever structural personas, bundles, skills, or agents change.
- Catalog new index-facing assets with `./scripts/catalog-agent-asset.ps1`.
- Keep Copilot, Claude Code, and Cursor coverage aligned and record support in `SUPPORTED.md`.
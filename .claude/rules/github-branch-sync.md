# GitHub Branch Sync Rule

- Use `./scripts/sync-personality-branches.ps1` when `main` and `persona/*` branches must be pushed to or pulled from GitHub in one batch.
- Prefer `-DryRun` before modifying remote state.
- Use `-Mode push` to publish newly created local personality branches.
- Use `-Mode pull` to fetch and fast-forward local branches from GitHub.
- Pull is intentionally `ff-only`; if a branch diverges, stop and resolve the branch state explicitly instead of merging implicitly.
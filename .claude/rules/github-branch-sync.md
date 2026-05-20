# GitHub Branch Sync Rule

- Use `./scripts/sync-personality-branches.ps1` when `main` and `persona/*` branches must be pushed to or pulled from GitHub in one batch.
- Use `./scripts/push-all-personas.ps1` and `./scripts/pull-all-personas.ps1` when a shorter entrypoint is enough.
- Prefer `-DryRun` before modifying remote state.
- Use `-RequireConfirmation` when you want an explicit confirmation before push or pull starts.
- Use `-Mode push` to publish newly created local personality branches.
- Use `-Mode pull` to fetch and fast-forward local branches from GitHub.
- Pull is intentionally `ff-only`; if a branch diverges, stop and resolve the branch state explicitly instead of merging implicitly.
- Fail fast on unpublished `persona/*` branches with `./scripts/assert-personality-branch-published.ps1`.
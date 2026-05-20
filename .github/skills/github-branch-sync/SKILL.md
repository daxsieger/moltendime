---
name: github-branch-sync
description: 'Use for pushing or pulling main and persona branches to or from GitHub in one batch.'
argument-hint: 'Describe whether to push, pull, or both, and which remote to target.'
user-invocable: true
---

# GitHub Branch Sync

Use this skill when you need to synchronize `main` and the personality branches under `persona/*` with a GitHub remote.

## When to Use

- Push newly created personality branches to GitHub.
- Pull all existing personality branches from GitHub.
- Run one batch sync after branch bootstrap or branch hygiene work.
- Verify the branch sync plan before changing remote state.

## Script

- PowerShell entrypoint: `./scripts/sync-personality-branches.ps1`
- Wrapper push entrypoint: `./scripts/push-all-personas.ps1`
- Wrapper pull entrypoint: `./scripts/pull-all-personas.ps1`
- Branch publication guard: `./scripts/assert-personality-branch-published.ps1`

## Supported Modes

- `push`: push local `main` and `persona/*` branches to the remote
- `pull`: fetch remote refs and fast-forward local `main` and `persona/*` branches when possible
- `both`: run pull logic first, then push logic

## Safe Defaults

- Default remote: `origin`
- Default base branch: `main`
- Default personality pattern: `persona/*`
- Use `-DryRun` first when you want to inspect the plan without modifying refs or remotes
- Use `-RequireConfirmation` when you want one explicit confirmation before the sync starts

## Examples

Push everything to GitHub:

```powershell
./scripts/sync-personality-branches.ps1 -Mode push -Remote origin
```

Push everything with the short wrapper:

```powershell
./scripts/push-all-personas.ps1 -Remote origin
```

Pull everything from GitHub with prune:

```powershell
./scripts/sync-personality-branches.ps1 -Mode pull -Remote origin -Prune
```

Pull everything with the short wrapper:

```powershell
./scripts/pull-all-personas.ps1 -Remote origin -Prune
```

Inspect the full sync plan first:

```powershell
./scripts/sync-personality-branches.ps1 -Mode both -Remote origin -Prune -DryRun
```

Run with an explicit confirmation step:

```powershell
./scripts/sync-personality-branches.ps1 -Mode push -Remote origin -RequireConfirmation
```

## Operational Notes

- The script uses temporary worktrees so it can update local branches without switching your active branch.
- Pull uses `merge --ff-only`, so diverged branches are reported as failures instead of being merged implicitly.
- Remote branches that do not exist yet are reported as skipped during pull and can then be created with a push run.
- `-RequireConfirmation` prompts once per push or pull phase before any remote-changing action starts.
- `commit-prompt-state.ps1` now refuses to commit from a `persona/*` branch that has not yet been published on `origin`, unless explicitly overridden.

## Recommended Workflow

1. Create missing personality branches locally.
2. Run `-DryRun` to inspect the batch sync plan.
3. Run `./scripts/push-all-personas.ps1` or `-Mode push` to publish missing local branches.
4. Work on a personality branch only after it exists on `origin`.
5. Use `./scripts/pull-all-personas.ps1` or `-Mode pull` later to keep local and remote refs aligned.
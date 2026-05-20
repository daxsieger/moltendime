---
name: git-versioning
description: 'Use for git repository setup, prompt-based commits, commit policy enforcement, and versioning workflow automation in this workspace.'
argument-hint: 'Describe the git action to perform, such as initialize repo, commit current prompt changes, or inspect status.'
user-invocable: true
---

# Git Versioning

Use this skill to manage repository lifecycle and the prompt-based commit policy in this workspace.

## When to Use

- Initialize the repository.
- Check git status.
- Commit changes produced during the current prompt.
- Maintain prompt-based commit hooks and policy files.
- Create and manage one branch per agent personality.
- Preserve a shared learning history across personality branches.

## Rules

- Keep the workspace under git.
- Commit after every prompt that changes the workspace.
- Use `./scripts/commit-prompt-state.ps1` for consistent commit messages and local git identity bootstrap.
- Update `SUPPORTED.md` whenever adding a new AI customization.
- Assign each personality a dedicated branch named `persona/<slug>`.
- Keep shared cross-personality learnings in `.ai/SHARED_LEARNINGS.md`.
- Use `./scripts/create-personality-branch.ps1` to bootstrap personality branches.
- Use `./scripts/record-personality-learning.ps1` to append new learnings.
- Use `./scripts/sync-personality-branches.ps1` when `main` and `persona/*` branches need one batch push/pull against GitHub.

## Workflow

1. Ensure the workspace is a git repository.
2. Ensure the active personality has a dedicated `persona/<slug>` branch.
3. Keep `.ai/SHARED_LEARNINGS.md` updated with cross-personality knowledge.
4. Make the requested changes.
5. Run the shared commit script.
6. Confirm whether a commit was created or skipped because there were no changes.

## Personality Branching

- Branch convention: `persona/<slug>`
- Shared learning log: `.ai/SHARED_LEARNINGS.md`
- Personality notes directory: `.ai/personalities/`

### Bootstrap a personality branch

```powershell
./scripts/create-personality-branch.ps1 -PersonalityName planner
```

### Record a learning transfer

```powershell
./scripts/record-personality-learning.ps1 -PersonalityName planner -LearnedFrom reviewer -Summary "Adopt concise review findings before broad refactors."
```

### Sync shared learnings across personality branches

```powershell
./scripts/sync-shared-learnings.ps1 -SourceBranch main
```

### Push or pull all personality branches with GitHub

```powershell
./scripts/sync-personality-branches.ps1 -Mode both -Remote origin -Prune -DryRun
```
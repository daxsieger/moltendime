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

## Rules

- Keep the workspace under git.
- Commit after every prompt that changes the workspace.
- Use `./scripts/commit-prompt-state.ps1` for consistent commit messages and local git identity bootstrap.
- Update `SUPPORTED.md` whenever adding a new AI customization.

## Workflow

1. Ensure the workspace is a git repository.
2. Make the requested changes.
3. Run the shared commit script.
4. Confirm whether a commit was created or skipped because there were no changes.
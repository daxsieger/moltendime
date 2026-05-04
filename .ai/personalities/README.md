# Personality Branches

Each agent personality gets its own branch using the convention `persona/<slug>`.

## Expected Files

- `.ai/SHARED_LEARNINGS.md`: shared history of what personalities learned from each other.
- `.ai/personalities/<slug>.md`: local note for the personality branch.

## Workflow

1. Create the branch with `./scripts/create-personality-branch.ps1`.
2. Work on that personality's branch.
3. Append cross-personality learnings to `.ai/SHARED_LEARNINGS.md`.
4. Commit the prompt changes.
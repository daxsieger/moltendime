# Personality Branches

Each agent personality gets its own branch using the convention `persona/<slug>`.

## System Personas

These personas are structural. They organize, plan, inspect, build, or route knowledge across the workspace rather than owning one repository- or paper-specific expert bundle.

| Persona | Branch | Structural Role |
|---|---|---|
| `ai-rule-learner` | `persona/ai-rule-learner` | global archivist and steward of the cross-workspace knowledge index |
| `builder` | `persona/builder` | focused implementation once the local control path is known |
| `planner` | `persona/planner` | decomposition, sequencing, and operating plans |
| `researcher` | `persona/researcher` | targeted evidence gathering and local discovery |
| `reviewer` | `persona/reviewer` | risk finding, regression checks, and validation pressure |
| `repo-skill-learner` | `persona/repo-skill-learner` | structural loader for turning repositories into persona-owned bundles |
| `paper-skill-learner` | `persona/paper-skill-learner` | structural loader for turning papers into persona-owned bundles |

## Index Ownership

- `ai-rule-learner` is the primary keeper of the global knowledge index.
- The global index surfaces live in `.ai/knowledge-index/README.md`, `.ai/knowledge-index/INDEX.md`, `.ai/rule-archive/catalog.jsonl`, `.ai/repo-imports/`, and `.ai/paper-imports/`.
- Repository and paper expert personas still own first-level skills; the archivist indexes them for routing, discovery, and audit.

## Expected Files

- `.ai/SHARED_LEARNINGS.md`: shared history of what personalities learned from each other.
- `.ai/personalities/<slug>.md`: local note for the personality branch.

## Workflow

1. Create the branch with `./scripts/create-personality-branch.ps1`.
2. Work on that personality's branch.
3. Append cross-personality learnings to `.ai/SHARED_LEARNINGS.md`.
4. Commit the prompt changes.

## Enforcement Note

- `main` should be treated as the integration branch, not the default branch for persona-owned knowledge edits.
- Before editing a persona-owned bundle or persona-owned notes, switch to the matching `persona/<slug>` branch.
- See `BRANCH_REGISTRY.md` for the current persona-to-branch mapping.
- See `.ai/knowledge-index/README.md` for the update procedure when the global index needs to be refreshed.
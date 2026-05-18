---
name: repo-knowledge-loader
description: 'Use for learning skills, memories, and technical documents from a target GitHub repository, inferring missing knowledge when the source is incomplete, and producing a bridge skill for external projects.'
argument-hint: 'Provide the target GitHub repository URL plus the destination persona or knowledge bundle name.'
user-invocable: true
---

# Repo Knowledge Loader

Use this skill to ingest reusable AI knowledge from a target GitHub repository into the local `repo-skill-learner` persona.

## Inputs

- Target GitHub repository URL
- Optional branch or commit reference
- Optional destination bundle name

## What to Import First

- Existing skills, prompts, instructions, hooks, agents, and rules
- Existing memories, notes, ADRs, design docs, runbooks, and architecture docs
- Technical markdown that explains workflows, conventions, or domain knowledge

## Fallback When Assets Are Missing

If the target repository does not contain enough explicit AI assets:

1. Inspect the codebase structure and developer documentation.
2. Infer the minimum viable skill set from repeated workflows, scripts, and conventions.
3. Write concise memory files that capture stable repository facts.
4. Produce short technical documents that explain the inferred workflows and constraints.
5. Mark inferred material explicitly.

## Local Destination Layout

- Imported bundles: `.ai/repo-imports/<repo-slug>/`
- Persona metadata: `.ai/personalities/repo-skill-learner.md`
- External bridge template: `templates/external-bridge-skill.md`

## Expected Bundle Contents

- `skills.md`: imported or inferred reusable skills
- `memories.md`: stable repository facts and conventions
- `technical-docs.md`: concise technical explanation of key workflows
- `sources.md`: source paths, URLs, and inference notes

## External Project Bridge

After importing knowledge, create or refresh a bridge skill in the external repository using `templates/external-bridge-skill.md`.

That bridge skill should:

- point to this repository as the canonical knowledge host
- identify the target bundle under `.ai/repo-imports/<repo-slug>/`
- instruct the external project to delegate learning work to `Repo Skill Learner`

## Output Format

- target repository
- imported assets
- inferred assets
- local bundle path
- external bridge status

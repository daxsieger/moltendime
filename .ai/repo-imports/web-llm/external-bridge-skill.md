---
name: web-llm-knowledge-bridge
description: 'Use when an external repository needs to load and reuse the web-llm knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository and the target repository context.'
user-invocable: true
---

# web-llm Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: web-llm
- maintained_by_agent: Web LLM Runtime Architect
- thematic_family: browser-AI and WebGPU runtimes

## Load Sequence

1. Open https://github.com/daxsieger/moltendime.
2. Read `.ai/repo-imports/browser-ai-webgpu-family.md` to confirm the target repository belongs to the same browser-runtime family.
3. Read `.ai/repo-imports/web-llm/skills.md` and `.ai/repo-imports/web-llm/skills-index.md`.
4. Load `.ai/repo-imports/web-llm/01-browser-runtime-and-loading-skills.md` through `.ai/repo-imports/web-llm/04-engine-pipeline-and-runtime-control-skills.md` as the first-level transferable skill packs.
5. Read `.ai/repo-imports/web-llm/memories.md`, `.ai/repo-imports/web-llm/technical-docs.md`, and `.ai/repo-imports/web-llm/sources.md` before adapting the skills.
6. Reuse the imported bundle for browser-native inference, worker-hosted execution, OpenAI-compatible local APIs, and WebGPU-backed runtime integration.
7. Do not transfer the `web-llm-runtime-architect` persona ownership itself; only reuse the extracted techniques and then materialize repository-specific first-level skills in the destination repository persona.
8. Delegate refresh work to `web-llm-runtime-architect` when the upstream repository changes materially.

## Automatic Reuse Rule

- If an external repository implements browser-local model inference, worker-hosted LLM execution, OpenAI-compatible local APIs, or WebGPU-backed LLM runtime integration, load this bundle before synthesizing new guidance.
- If the destination repository is only adjacent rather than equivalent, import the relevant pack selectively and record the adaptation boundary in its local bundle.

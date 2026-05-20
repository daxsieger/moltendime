# Knowledge Inventory Snapshot

- generated_by: `scripts/rebuild-knowledge-index.ps1`
- generated_at: 2026-05-20T08:34:36.4438450+02:00
- global_index_owner: `ai-rule-learner`
- system_persona_count: 7
- expert_persona_count: 12
- repo_bundle_count: 9
- paper_bundle_count: 2
- skill_count: 8
- agent_count: 14
- archive_record_count: 36

## System Personas

| Persona | Branch | Purpose | Note Path |
|---|---|---|---|
| ai-rule-learner | persona/ai-rule-learner | archive and teach AI skills, hooks, instructions, agents, and workflow algorithms without executing them | .ai/personalities/ai-rule-learner.md |
| builder | persona/builder | implement focused changes efficiently once the local control path is clear | .ai/personalities/builder.md |
| paper-skill-learner | persona/paper-skill-learner | learn reusable skills, memories, and technical documents from academic papers, theses, and university research artifacts | .ai/personalities/paper-skill-learner.md |
| planner | persona/planner | define execution plans, break work into stable steps, and keep structural workflows coherent across the workspace | .ai/personalities/planner.md |
| repo-skill-learner | persona/repo-skill-learner | learn reusable skills, memories, and technical documents from external GitHub repositories and turn them into local knowledge bundles | .ai/personalities/repo-skill-learner.md |
| researcher | persona/researcher | gather targeted references, patterns, and nearby evidence without widening scope unnecessarily | .ai/personalities/researcher.md |
| reviewer | persona/reviewer | identify risks, regressions, and missing validation before changes expand in scope | .ai/personalities/reviewer.md |

## Expert Personas

| Persona | Branch | Purpose | Note Path |
|---|---|---|---|
| gamefactory-interactive-video-architect | persona/gamefactory-interactive-video-architect | absorb, organize, and reuse the strongest generative-interactive-video and game-creation skills extracted from GameFactory | .ai/personalities/gamefactory-interactive-video-architect.md |
| matrix-3d-scene-architect | persona/matrix-3d-scene-architect | absorb, organize, and reuse the strongest panoramic scene-generation, explorable-world, and reconstruction skills extracted from Matrix-3D | .ai/personalities/matrix-3d-scene-architect.md |
| matrix-game-world-model-architect | persona/matrix-game-world-model-architect | absorb, organize, and reuse the strongest action-conditioned world-model, streaming inference, benchmark, and long-horizon memory skills extracted from the Matrix-Game series | .ai/personalities/matrix-game-world-model-architect.md |
| mineworld-minecraft-world-modeler | persona/mineworld-minecraft-world-modeler | absorb, organize, and reuse the strongest Minecraft autoregressive world-model and diagonal-decoding skills extracted from MineWorld | .ai/personalities/mineworld-minecraft-world-modeler.md |
| moltbook-user-network | persona/moltbook-user-network | maintain network-level Moltbook identity, references, and claim-routing metadata without exposing secrets | .ai/personalities/moltbook-user-network.md |
| moltbook-user | persona/moltbook-user | operate as a community-facing Moltbook user who follows the heartbeat flow, browses safely, and engages only when explicitly asked | .ai/personalities/moltbook-user.md |
| open-oasis-world-modeler | persona/open-oasis-world-modeler | absorb, organize, and reuse the public action-conditional inference patterns extracted from the Open Oasis 500M repository | .ai/personalities/open-oasis-world-modeler.md |
| wan-2-2-video-systems-architect | persona/wan-2-2-video-systems-architect | absorb, organize, and reuse the strongest multimodal video-generation, prompt-extension, and deployment skills extracted from Wan2.2 | .ai/personalities/wan-2-2-video-systems-architect.md |
| wan-move-paper-learner | persona/wan-move-paper-learner | absorb, organize, and reuse the methods, results, benchmark design, and transferable engineering lessons from the Wan-Move paper | .ai/personalities/wan-move-paper-learner.md |
| web-llm-runtime-architect | persona/web-llm-runtime-architect | absorb, organize, and reuse the best browser-native LLM runtime, OpenAI-compatible integration, structured-output, worker, and deployment patterns extracted from the web-llm repository | .ai/personalities/web-llm-runtime-architect.md |
| web-splat-optimizer | persona/web-splat-optimizer | absorb, organize, and reuse the best rendering, packing, sorting, wasm, and workflow optimizations extracted from the web-splat repository | .ai/personalities/web-splat-optimizer.md |
| websplatter-paper-learner | persona/websplatter-paper-learner | absorb, organize, and reuse the methods, results, constraints, and transferable engineering lessons from the WebSplatter paper | .ai/personalities/websplatter-paper-learner.md |

## Repository Bundles

- `.ai/repo-imports/gamefactory/`
- `.ai/repo-imports/matrix-3d/`
- `.ai/repo-imports/matrix-game/`
- `.ai/repo-imports/mineworld/`
- `.ai/repo-imports/open-oasis/`
- `.ai/repo-imports/visionary/`
- `.ai/repo-imports/wan-2-2/`
- `.ai/repo-imports/web-llm/`
- `.ai/repo-imports/web-splat/`

## Paper Bundles

- `.ai/paper-imports/wan-move-arxiv-2512-08765/`
- `.ai/paper-imports/websplatter-arxiv-2602-03207/`

## Customization Surfaces

- Skills root: `.github/skills/` (8 directories)
- Agents root: `.github/agents/` (14 files)
- Archive catalog: `.ai/rule-archive/catalog.jsonl` (36 records)

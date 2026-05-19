# web-llm Skills 06-10

## Skill 06: Model Conversation Framing as Data
- evidence: `src/config.ts`
- pattern: Represent roles, separators, stop strings, templates, and token boundaries in a dedicated conversation-template structure.
- transfer: Externalize prompt framing rules so model families can be swapped without rewriting the request pipeline.

## Skill 07: Preserve Tokenizer Post-Processing as Typed Runtime State
- evidence: `src/config.ts`
- pattern: Store tokenizer-specific post-processing and spacing rules beside tokenizer metadata instead of burying them in ad hoc helpers.
- transfer: Make grammar, decoding, and schema-constrained generation reproducible across model reloads.

## Skill 08: Add Extensible Logit Processing Through a Registry
- evidence: `src/config.ts`
- pattern: Support a logit processor registry in engine config so stateful generation policies can be injected without forking the core runtime.
- transfer: Use explicit plugin points when token-level control needs to evolve faster than the engine core.

## Skill 09: Validate Generation Parameters After Initialization
- evidence: `src/config.ts`
- pattern: Run range and non-negativity checks on penalties and generation parameters immediately after config assembly.
- transfer: Fail fast on malformed request settings before they reach the hot inference path.

## Skill 10: Make Structured Output and Multimodal Extension First-Class
- evidence: `README.md`, `src/config.ts`, `examples/json-mode/README.md`, `examples/vision-model/README.md`
- pattern: Treat JSON-mode, response formats, and vision-model fields as built-in runtime capabilities rather than post-hoc wrappers.
- transfer: If structured or multimodal inference is strategic, represent it in the core config model from the beginning.
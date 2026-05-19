# web-llm Skills 01-05

## Skill 01: Treat Browser Inference as the Primary Runtime
- evidence: `README.md`
- pattern: Design the package around fully local browser execution with WebGPU acceleration and no required inference server.
- transfer: When building browser AI products, make local execution a first-class architecture choice instead of a fallback mode.

## Skill 02: Preserve OpenAI-Style App Integration Over Local Models
- evidence: `README.md`
- pattern: Expose local model inference through an OpenAI-compatible surface so existing application code can be reused with minimal adaptation.
- transfer: Keep the adoption cost low by matching the interface developers already use in remote-LLM applications.

## Skill 03: Ship Both Package-Manager and CDN Entry Paths
- evidence: `README.md`
- pattern: Support installation through npm-style package managers and direct CDN imports for low-friction prototyping.
- transfer: Offer one integration path for production apps and another for playgrounds, demos, and cloud notebooks.

## Skill 04: Keep App, Engine, and Generation Configs Separate
- evidence: `src/config.ts`
- pattern: Distinguish app-wide model inventory, engine initialization, and per-generation options instead of collapsing all runtime settings into one object.
- transfer: Separate slow-changing bootstrap config from request-level tuning to keep runtime APIs stable and composable.

## Skill 05: Anchor Runtime Loading on Explicit Chat Config Metadata
- evidence: `src/config.ts`
- pattern: Load tokenizer files, conversation templates, window sizes, penalties, and model metadata from an explicit `ChatConfig` structure.
- transfer: Make model reload and runtime behavior depend on typed config artifacts rather than scattered implicit defaults.
# web-llm Skills 16-25

## Skill 16: Make Model Loading a Separate Explicit Phase
- evidence: `src/engine.ts`
- pattern: Treat `CreateMLCEngine(modelId, ...)` as a convenience wrapper around `new MLCEngine().reload(modelId, ...)`, keeping model load and runtime creation explicit.
- transfer: Separate engine construction from model reload so applications can reason about lifecycle, retries, and warm starts clearly.

## Skill 17: Treat Device-Loss Recovery as a Public Runtime Contract
- evidence: `src/engine.ts`, `src/types.ts`
- pattern: Document device-loss and OOM recovery as a caller responsibility, including reloading or recreating the engine after failure.
- transfer: In browser GPU runtimes, surface device loss as an expected operational path rather than hiding it behind opaque retries.

## Skill 18: Split Generation Into Prefill and Decode Phases
- evidence: `src/engine.ts`, `src/llm_chat.ts`
- pattern: Implement request execution as one prefill step followed by repeated decode steps, and build metrics around that separation.
- transfer: Preserve the structural difference between prompt ingestion and token generation so latency, batching, and caching decisions stay observable.

## Skill 19: Export Runtime Telemetry in Tokens-Per-Second Terms
- evidence: `src/engine.ts`, `src/openai_api_protocols/chat_completion.ts`
- pattern: Report `prefill_tokens_per_s`, `decode_tokens_per_s`, time-to-first-token, and time-per-output-token as first-class runtime statistics.
- transfer: Expose throughput and latency as API-level metrics so downstream apps can tune UX and model choices empirically.

## Skill 20: Resolve ABI Variants Instead of Hardcoding One Kernel Contract
- evidence: `src/llm_chat.ts`
- pattern: Detect whether the runtime should use `prefill` and `decode` or `batch_prefill` and `batch_decode`, then bind the matching function pair dynamically.
- transfer: When model runtimes span multiple compiled backends, negotiate ABI availability at startup rather than freezing one assumption into the engine.

## Skill 21: Enforce Chunk-Size Preconditions Around Prefill
- evidence: `src/llm_chat.ts`
- pattern: Track `prefillChunkSize`, reject oversized inputs early, and route token and embedding operations through that limit.
- transfer: Turn internal chunking constraints into explicit runtime guards so large prompts fail predictably instead of corrupting GPU execution.

## Skill 22: Hide Startup Overhead Behind Prefill-Adjacent Work
- evidence: `src/llm_chat.ts`
- pattern: Overlap grammar-matcher initialization and related setup work with prompt prefilling to reduce visible startup latency.
- transfer: Co-locate auxiliary initialization with the first heavy inference stage when you want to minimize perceived cold-start cost.

## Skill 23: Treat Service Worker Integration as a Dedicated Engine Layer
- evidence: `src/service_worker.ts`
- pattern: Model service-worker execution with specialized handler and engine classes instead of reusing the plain in-page worker path unchanged.
- transfer: When the browser runtime container changes, elevate the lifecycle and messaging differences into a dedicated abstraction.

## Skill 24: Keep Service Worker Sessions Alive Deliberately
- evidence: `src/service_worker.ts`
- pattern: Send explicit keep-alive messages from the service-worker engine so long-lived inference sessions survive browser lifecycle pressure.
- transfer: Background browser AI needs proactive lifecycle management, not just message passing.

## Skill 25: Encode Abort, Cache, Multi-Model, and Worker Control in Focused Examples
- evidence: `examples/abort-reload`, `examples/cache-usage`, `examples/get-started-web-worker`, `examples/logit-processor`, `examples/multi-models`, `examples/service-worker`
- pattern: Use small examples to pin down runtime control flows such as abort and reload, persistent cache usage, worker orchestration, pluggable decoding logic, and multi-model switching.
- transfer: Treat example programs as executable interface contracts for operational behavior, not as secondary documentation.
# web-llm Skills 11-15

## Skill 11: Expose Model-Load Progress as a UX Primitive
- evidence: `src/config.ts`
- pattern: Provide an initialization progress callback during engine creation so applications can surface loading states while models initialize in-browser.
- transfer: For heavy client-side AI startup paths, progress telemetry should be part of the public API, not an afterthought.

## Skill 12: Push Inference Off the Main Thread
- evidence: `README.md`, `examples/get-started-web-worker/README.md`
- pattern: Provide a web-worker path for inference so UI rendering stays responsive during model load and token generation.
- transfer: Treat thread isolation as a default integration pattern whenever browser AI competes with user interaction.

## Skill 13: Support Service Worker Lifecycles for Persistent Browser Features
- evidence: `README.md`, `examples/service-worker/README.md`
- pattern: Extend inference integration to service workers when the application needs background lifecycle control or browser-managed persistence.
- transfer: Match the runtime container to the application lifecycle instead of forcing all AI work into a visible page context.

## Skill 14: Treat Browser Extensions as a First-Class Deployment Target
- evidence: `README.md`, `examples/chrome-extension/README.md`, `examples/chrome-extension-webgpu-service-worker/README.md`
- pattern: Maintain explicit extension examples, including WebGPU service-worker variants, so browser-native AI can ship beyond ordinary web pages.
- transfer: If the runtime is browser-centric, document extension packaging early rather than retrofitting it later.

## Skill 15: Use Narrow Examples to Encode Operational Capabilities
- evidence: `examples/cache-usage/README.md`, `examples/abort-reload/README.md`, `examples/get-started-latency-breakdown/README.md`, `examples/seed-to-reproduce/README.md`, `examples/multi-models/README.md`
- pattern: Capture operational concerns such as cache reuse, abort/reload behavior, latency breakdown, reproducibility, and multi-model switching in focused examples instead of one oversized sample app.
- transfer: Encode each operational guarantee in a dedicated example so adopters can copy only the capability they need.
# Browser-AI and WebGPU Runtime Family

## Scope

This family groups repository and paper bundles that share a browser-native AI runtime surface, especially when WebGPU, workers, service workers, local-model execution, or browser-hosted acceleration are central to the design.

It is not a claim that all members solve the same product problem. The family exists so the archivist can connect adjacent browser-runtime assets without collapsing their first-level skills into one persona.

## Membership Rules

- Include repositories whose primary technical surface is browser-hosted AI or GPU runtime behavior.
- Include assets where WebGPU, worker orchestration, browser lifecycle management, or local-model execution materially shape the implementation.
- Exclude assets that only happen to mention browsers but are fundamentally about unrelated application logic.

## Current Members

### Repositories

- `web-llm`: browser-native LLM inference runtime with WebGPU acceleration, OpenAI-compatible APIs, and worker/service-worker integration paths
- `visionary`: browser-native WebGPU rendering and ONNX inference platform for Gaussian-splatting and mesh workflows

### Papers

- `websplatter-arxiv-2602-03207`: browser WebGPU systems paper about efficient Gaussian splatting across devices

## Family-Level Reuse Rules

- Reuse browser lifecycle, worker-isolation, and GPU-runtime patterns across members when the execution model matches.
- Keep domain-specific first-level skills with their dedicated personas: LLM runtime skills stay with `web-llm-runtime-architect`, rendering-system skills stay with their rendering personas, and paper-method skills stay with their paper personas.
- Prefer family-specific indexes over direct comparisons when members are adjacent in runtime technology but not in application domain.

## Why web-llm Belongs Here

- It is browser-native by design.
- WebGPU materially determines performance posture.
- Worker and service-worker execution are explicit parts of the public integration model.
- The repository is reusable as infrastructure for other browser-local AI systems.
# wan-2-2 Skills 16-20

## Skill 16: Keep The Text Stack Self-Contained And Numerically Defensive
- evidence: `wan/modules/t5.py`
- method: Package tokenization, relative-position bias, gated feed-forward blocks, and fp16 clamp protection inside a local T5 implementation instead of treating text encoding as an opaque external dependency.
- transfer: Multimodal video systems stay easier to adapt when the text encoder exposes stable internal contracts and guards against half-precision overflow.

## Skill 17: Specialize Animate Cross-Attention By Splitting Image Tokens From Text Tokens
- evidence: `wan/modules/animate/model_animate.py`
- method: Route the first image-embedding slice through dedicated `k_img` and `v_img` projections while preserving a separate text-conditioned cross-attention path.
- transfer: Character-animation systems benefit when image identity cues and text semantics are fused through distinct cross-attention channels instead of one undifferentiated context stream.

## Skill 18: Inject Pose And Face Motion After Patch Embedding Rather Than Rewriting The Whole Backbone
- evidence: `wan/modules/animate/model_animate.py`, `wan/modules/animate/motion_encoder.py`
- method: Add pose latents directly into the patchified video tokens, derive compact face-motion vectors through a dedicated motion encoder, and adapt them with face-specific adapter blocks.
- transfer: Task-specialized control often lands better as post-embedding adapters than as a fork of the entire video transformer.

## Skill 19: Make Speech-to-Video Modulation Segment-Aware Before Audio Injection
- evidence: `wan/modules/s2v/model_s2v.py`
- method: Split token ranges by segment index, apply separate modulation weights to each segment inside the attention block, then inject audio-conditioned features through dedicated S2V modules.
- transfer: Audio-driven video models stay more controllable when temporal segments are explicit modulation units instead of one uniform token stream.

## Skill 20: Align Audio Features To Video Through Interpolation And Bucketization
- evidence: `wan/modules/s2v/audio_encoder.py`
- method: Extract wav2vec features, interpolate them from audio FPS to video FPS, then bucket local temporal neighborhoods into frame-aligned audio descriptors for batched generation.
- transfer: Cross-modal conditioning gets more reusable when audio-to-video alignment is a first-class preprocessing contract rather than an implicit assumption inside the model.
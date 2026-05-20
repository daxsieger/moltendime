# Wan2.2 Task-Specialized Subfamilies

## Purpose

This note separates Wan2.2's reusable core backbone from the task-specialized branches that sit on top of it.

Use it when deciding whether a downstream import needs generic Wan video priors or one of the specialized control stacks.

## Core Backbone

- `wan/modules/attention.py`
- `wan/modules/model.py`
- `wan/modules/vae2_2.py`

These files define the reusable substrate: attention fallback policy, 3-axis RoPE, timestep-modulated transformer blocks, patchified video processing, and the causal 3D VAE.

## Text Stack

- `wan/modules/t5.py`

This is the text-conditioning subfamily.

It matters because Wan keeps the text encoder local and modifiable rather than outsourcing the entire text stack to an opaque library wrapper.

## Animate Branch

- `wan/modules/animate/model_animate.py`
- `wan/modules/animate/motion_encoder.py`

This branch specializes the core backbone for character animation and replacement.

Its main additions are:

- image-embedding-aware cross-attention
- pose-latent injection after patch embedding
- face-motion extraction and adapter routing

## Speech-to-Video Branch

- `wan/modules/s2v/model_s2v.py`
- `wan/modules/s2v/audio_encoder.py`

This branch specializes the core backbone for audio-driven video generation.

Its main additions are:

- segment-aware modulation inside attention blocks
- audio encoders and injectors
- explicit audio-to-video temporal alignment and bucketing

## Routing Rule

- Reuse the core backbone pack when the destination project needs generic Wan-style video generation structure.
- Reuse the text stack notes when the destination project needs controllable or replaceable text encoding.
- Reuse the animate branch when the destination project needs identity, pose, or face-motion conditioning.
- Reuse the S2V branch when the destination project needs synchronized audio-driven motion or speech-conditioned temporal structure.
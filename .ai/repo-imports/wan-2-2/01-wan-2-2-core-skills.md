# wan-2-2 Skills 01-05

## Skill 01: Use Mixture-of-Experts Across Timesteps to Raise Capacity Without Raising Cost Linearly
- evidence: `README.md`
- method: Split denoising work across specialized expert models through a timestep-aware MoE design.
- transfer: Video backbones that must scale quality without exploding cost can move specialization into timestep structure.

## Skill 02: Treat Multimodal Video Tasks as One Family, Not Separate Products
- evidence: `README.md`
- method: Ship text-to-video, image-to-video, text-image-to-video, speech-to-video, and animation variants inside one repository lineage.
- transfer: Shared video backbones become more reusable when task variants are documented as one coherent system.

## Skill 03: Offer Both Single-GPU and Distributed Inference as First-Class Paths
- evidence: `README.md`
- method: Document single-GPU runs alongside FSDP plus DeepSpeed Ulysses multi-GPU runs rather than leaving scale-up as an exercise to the user.
- transfer: Large video backbones need a deployment story that spans workstation and cluster operation.

## Skill 04: Make Prompt Extension an Optional but Recommended Quality Stage
- evidence: `README.md`
- method: Support prompt extension through Dashscope or local Qwen models before main video generation.
- transfer: Prompt enrichment can be productized as a normal inference stage rather than a separate research trick.

## Skill 05: Publish Memory-Aware Operating Modes for the Smallest Public Variant
- evidence: `README.md`
- method: Position TI2V-5B as a 24GB-capable high-compression path while larger tasks target heavier hardware.
- transfer: Family repos become more adoptable when one strong consumer-grade operating point is documented clearly.
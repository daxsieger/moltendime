# Wan-Move Technical Notes

## Summary

Wan-Move is a motion-control method for image-to-video generation that avoids auxiliary motion modules by rewriting the existing first-frame condition features in latent space. Its main technical narrative is the combination of latent trajectory guidance, scalable fine-tuning on a strong I2V backbone, and a benchmark contribution tailored to motion control.

## Architecture Summary

### Latent Guidance Path

- Encode the first input frame plus zero-padded future frames with the VAE to obtain the condition tensor.
- Map point trajectories from pixel space into latent coordinates, accounting for temporal and spatial compression.
- Replicate first-frame latent features along each latent trajectory to make the conditioning tensor motion-aware.

### Backbone Integration

- Keep the existing Wan-I2V-14B backbone intact.
- Inject the edited condition tensor via the same conditioning pathway the base I2V model already uses.
- Use direct concatenation and classifier-free guidance instead of adding separate motion-processing branches.

### Data and Scaling Strategy

- Curate a 2M-video high-quality training set through quality and motion-consistency filtering.
- Use CoTracker to extract dense trajectories, but sample a practical subset of tracks during training.
- Scale long-video fine-tuning through FSDP, bfloat16, and sequence parallelism.

## Evaluation Takeaways

- Wan-Move improves both fidelity and motion adherence on MoveBench and DAVIS.
- Multi-object control remains a meaningful stress case, and the method retains strong margins there.
- Latent feature replication is better than pixel replication and random track embedding.
- Direct concatenation delivers similar quality to ControlNet with much lower latency and less architectural burden.
- Training and inference are sensitive to trajectory counts, but the method generalizes beyond the maximum count seen during training.

## Benchmark Takeaways

- MoveBench is a reusable benchmark-design pattern, not just a dataset release.
- It combines quality curation, semantic clustering, interactive human+SAM labeling, and generation-oriented captions.
- The benchmark is designed to evaluate both point-based and mask-based control approaches.

## Research-to-Persona Lessons

- This paper yields skills in three distinct families: method design, scalable training, and benchmark design.
- Supplementary implementation details materially affect the extracted engineering lessons and should not be skipped.
- Failure analysis is part of the persona knowledge, not just an appendix detail.

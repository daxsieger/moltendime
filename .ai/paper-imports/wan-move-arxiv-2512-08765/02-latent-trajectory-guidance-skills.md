# Wan-Move Paper Skills 11-20

## Skill 11: Map Motion Trajectories from Pixel Space into Latent Coordinates
- evidence: Section 3.2
- method: Convert point tracks to latent coordinates through deterministic spatial and temporal mapping.
- transfer: Translate guidance into the representation space where the generator already operates.

## Skill 12: Reuse the VAE's Translation Equivariance Assumption
- evidence: Section 3.2
- method: Motivate latent feature replication by assuming corresponding latent positions should preserve similar content under motion.
- transfer: Build control mechanisms around invariances the base representation already approximately exhibits.

## Skill 13: Encode the First Frame with Zero-Padded Future Frames
- evidence: Equation 1, Section 3.2
- method: Build the condition feature from the first frame plus zero-padded later frames before motion injection.
- transfer: Use sparse temporal initialization when only the first frame is given but future slots must be addressed explicitly.

## Skill 14: Average Temporal Coordinates Across Latent Compression Windows
- evidence: Equation 2, Section 3.2
- method: For subsequent latent frames, average pixel-space points over each temporal compression block.
- transfer: Respect temporal compression structure when projecting controls into latent video space.

## Skill 15: Replicate First-Frame Features Along Each Latent Trajectory
- evidence: Equation 3, Section 3.2
- method: Copy the feature at the first-frame trajectory start to subsequent latent positions along the track.
- transfer: Turn motion guidance into feature transport rather than into a separately learned embedding.

## Skill 16: Update the Existing Condition Tensor In-Place
- evidence: Section 3.2
- method: Inject motion by writing directly into `z_image` instead of generating a separate `z_motion` branch.
- transfer: Simplify guidance fusion by editing the conditioning tensor the backbone already consumes.

## Skill 17: Resolve Trajectory Collisions by Random Single-Track Selection
- evidence: Section 3.2, Section 9.1, Table 11
- method: Randomly choose one trajectory's feature when multiple visible tracks hit the same spatiotemporal location.
- transfer: Prefer collision-resolution rules that avoid feature averaging blur when overlapping controls occur.

## Skill 18: Prefer Latent Feature Replication over Pixel Replication
- evidence: Section 5.3, Table 4
- method: Use latent feature replication because pixel replication lacks semantic and texture context.
- transfer: Move replication after encoding when raw pixels are too local and brittle to serve as robust guidance.

## Skill 19: Prefer Latent Feature Replication over Random Track Embeddings
- evidence: Section 5.3, Table 4
- method: Use appearance-bearing latent features instead of random embeddings to improve both motion fidelity and image quality.
- transfer: Enrich control tokens with local context when bare coordinate embeddings prove too weak.

## Skill 20: Treat Guidance Quality as Both Motion Accuracy and Visual Fidelity
- evidence: Table 4, Section 5.3
- method: Compare guidance strategies on EPE, FID, FVD, PSNR, and SSIM together.
- transfer: Avoid evaluating control mechanisms only on adherence if they also affect image quality.

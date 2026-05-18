# Wan-Move Paper Skills 21-30

## Skill 21: Build a Two-Stage Quality Filter for Training Data
- evidence: Section 3.3
- method: Filter data first by visual quality and then by motion consistency.
- transfer: Separate static-quality screening from temporal-consistency screening in video-data curation.

## Skill 22: Train a Small Expert Scoring Model from Manual Quality Labels
- evidence: Section 3.3
- method: Label 1,000 examples manually and fit a scoring model for large-scale quality filtering.
- transfer: Bootstrap scalable data curation from a compact, high-quality human-labeled subset.

## Skill 23: Use Feature Similarity as a Motion-Stability Filter
- evidence: Section 3.3
- method: Compute cosine similarity between first-frame SigLIP features and the mean features of later frames to reject unstable videos.
- transfer: Turn temporal semantic drift into a measurable filter before training expensive video models.

## Skill 24: Curate Large-Scale Video Data Only After Motion-Coherence Filtering
- evidence: Section 3.3
- method: Produce a final training set of 2 million high-quality 720p videos only after both filters pass.
- transfer: Preserve final scale, but only after the data has been filtered on the failure modes that matter for control.

## Skill 25: Track a Dense 32x32 Grid, Then Sample Sparse Subsets per Step
- evidence: Section 3.3
- method: Extract dense CoTracker trajectories but sample only `k` tracks for each training iteration.
- transfer: Generate rich trajectory supervision offline while keeping per-step training inputs manageable.

## Skill 26: Mix No-Control and Controlled Training Cases Deliberately
- evidence: Section 3.3, Table 7
- method: Use a 5% probability of dropping motion conditions to preserve the original I2V capability.
- transfer: Retain base-model behavior by training on a small but intentional fraction of unconditioned examples.

## Skill 27: Sample the Number of Tracks from a Practical Range
- evidence: Section 3.3
- method: With 95% probability, sample between 1 and 200 trajectories uniformly.
- transfer: Align training-time control density with the range you expect to use operationally, rather than always maximizing it.

## Skill 28: Replicate Features Only Along Visible Trajectories
- evidence: Section 3.3
- method: Respect CoTracker visibility flags and skip occluded segments during replication.
- transfer: Distinguish visible from occluded guidance states when transporting conditioning features.

## Skill 29: Fine-Tune the Backbone with Flow Matching Instead of Replacing the Objective
- evidence: Equation 4, Section 3.3
- method: Initialize from the base I2V model and optimize the vector field under a flow-matching loss.
- transfer: Add controllability while staying aligned with the foundation model's native training regime.

## Skill 30: Scale Long-Sequence Training with Sequence Parallelism
- evidence: Section 8.3
- method: Use Ulysses sequence parallelism with FSDP and bfloat16 across 64 A100 GPUs for 30,000 steps.
- transfer: Treat distributed training strategy as part of the method's reproducibility surface when long clips are involved.

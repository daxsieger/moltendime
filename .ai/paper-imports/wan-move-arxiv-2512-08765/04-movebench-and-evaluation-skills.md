# Wan-Move Paper Skills 31-40

## Skill 31: Create a Benchmark that Matches the Control Task, Not Just the Modality
- evidence: Section 4
- method: Build MoveBench specifically for motion-controllable video generation rather than reusing generic segmentation or short-clip datasets.
- transfer: Design benchmarks around the paper's exact control problem so evaluation pressure matches the method.

## Skill 32: Use Free-License Source Data for Reusable Research Assets
- evidence: Section 4
- method: Source evaluation videos from Pexels to keep benchmark release practical.
- transfer: Make licensing part of benchmark design when you expect the asset to be public and reusable.

## Skill 33: Balance Quality and Diversity with a Multi-Stage Curation Pipeline
- evidence: Section 4, Figure 3
- method: Filter, crop, resample, cluster, and manually select representative examples.
- transfer: Combine algorithmic pruning and final human selection to avoid either pure automation or pure manual curation.

## Skill 34: Cluster Content into Explicit Categories for Coverage Control
- evidence: Section 4, Section 8.2
- method: Cluster videos into 54 content categories and then select 15-25 representatives per class.
- transfer: Make scenario coverage auditable by using explicit semantic buckets instead of ad hoc sample lists.

## Skill 35: Provide Both Point and Mask Annotations
- evidence: Section 4
- method: Include both trajectory points and segmentation masks so multiple motion-guidance paradigms can be compared.
- transfer: Broaden benchmark usefulness by supporting adjacent control interfaces, not only the one your method uses.

## Skill 36: Pair Interactive Annotation with SAM Assistance
- evidence: Section 4, Section 8.2, Figure 11
- method: Let annotators place positive and negative points while SAM proposes masks for refinement.
- transfer: Use human-in-the-loop segmentation to scale annotation quality without collapsing into fully automatic noise.

## Skill 37: Add Dense Captions Tailored for Generation Tasks
- evidence: Section 4
- method: Use Gemini-generated captions covering objects, actions, and camera dynamics.
- transfer: Treat prompt-ready textual descriptions as part of benchmark usability for generative systems.

## Skill 38: Measure Motion Accuracy with End-Point Error on Estimated Tracks
- evidence: Section 5.1
- method: Compare ground-truth trajectories to tracks estimated from generated videos using EPE.
- transfer: Evaluate controllable video models with explicit motion metrics rather than only perceptual quality scores.

## Skill 39: Preserve Both Fidelity and Motion Metrics in the Main Table
- evidence: Table 1, Table 2
- method: Report FID, FVD, PSNR, SSIM, and EPE together on MoveBench and DAVIS.
- transfer: Keep quality and control adherence in the same evaluation frame when extracting research skills.

## Skill 40: Benchmark Against Both Academic and Commercial Systems
- evidence: Table 3, Section 5.2
- method: Compare against Tora, LeviTor, MagicMotion, and Kling 1.5 Pro through both metrics and human studies.
- transfer: Use commercial baselines to contextualize practical progress when open models aim to close a product gap.

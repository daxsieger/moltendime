# Wan-Move Paper Skills 41-50

## Skill 41: Use Human Preference Studies to Validate Practical Motion Quality
- evidence: Table 3, Section 5.2
- method: Run 2AFC studies over motion accuracy, motion quality, and visual quality.
- transfer: Add user-facing evaluation when numeric control metrics cannot fully capture practical usefulness.

## Skill 42: Prefer Direct Concatenation When It Matches Control Quality with Lower Latency
- evidence: Table 5, Section 5.3
- method: Choose direct condition concatenation because it matches ControlNet-level results with much lower latency.
- transfer: Favor the simpler fusion strategy when extra modules do not buy meaningful quality gains.

## Skill 43: Quantify Integration Simplicity in Latency Terms
- evidence: Table 5, Section 5.3
- method: Report that ControlNet adds roughly 225 seconds over the original I2V model while the proposed method adds only about 3 seconds.
- transfer: Convert architectural complexity into runtime numbers when motivating simpler control integration.

## Skill 44: Tune Training Track Count for the Evaluation Regime You Care About
- evidence: Table 6, Section 5.3
- method: Find that training with up to 200 tracks is optimal, while denser track counts hurt due to train-test mismatch.
- transfer: Match training control density to likely deployment density instead of assuming more supervision is always better.

## Skill 45: Test Inference with More Tracks Than Seen in Training
- evidence: Table 7, Section 5.3
- method: Show generalization from training at up to 200 tracks to inference with much denser conditions.
- transfer: Probe extrapolation in control granularity rather than evaluating only within the training envelope.

## Skill 46: Preserve Naive I2V Quality While Adding Control
- evidence: Table 7, Figure 9
- method: Verify that zero-track inference keeps strong PSNR and SSIM, indicating retention of base generation quality.
- transfer: Always test whether the control extension degrades the underlying unconditional or lightly conditioned mode.

## Skill 47: Evaluate Large-Motion and OOD Motion as Separate Stress Tests
- evidence: Table 9, Section 5.3
- method: Build subsets for large-amplitude and out-of-distribution motion scenarios and measure them independently.
- transfer: Stress-test controllable generation on the motion regimes where brittle guidance usually fails first.

## Skill 48: Expose Applications Beyond the Main Benchmark Loop
- evidence: Section 5.4, Figures 15-18
- method: Demonstrate object control, camera control, motion transfer, 3D rotation, and editing workflows.
- transfer: Turn paper applications into reusable persona capabilities, not just qualitative illustrations.

## Skill 49: Document Failure Modes Explicitly
- evidence: Section 6, Section 9.4, Figure 13
- method: Call out persistent trajectory disappearance, crowded interactions, and physically implausible motion paths as primary failures.
- transfer: Preserve failure taxonomy as skill-pack context so downstream users know where the method stops being reliable.

## Skill 50: Turn Method, Benchmark, and Failure Analysis into One Paper Persona
- evidence: overall paper structure, bundle ownership model
- method: Package the motion-guidance method, MoveBench benchmark, ablation lessons, and failure cases into one dedicated paper persona while the archivist only catalogs it.
- transfer: Reuse this structure for future university papers where the method and benchmark are equally important knowledge assets.

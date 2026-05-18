# WebSplatter Paper Skills 21-30

## Skill 21: Treat Prefix Scan as the Core Sort Bottleneck
- evidence: Section 3.3.1
- method: Identify prefix-sum efficiency as the dominant pressure point in parallel radix sort.
- transfer: Optimize the scan primitive first when porting GPU sort pipelines to constrained runtimes.

## Skill 22: Ban Inter-Workgroup Spin Waiting on WebGPU
- evidence: Section 3.3.1
- method: Reject algorithms that poll global atomic flags in `while(true)` loops across workgroups.
- transfer: Remove scheduler-order assumptions when targeting browser GPU APIs.

## Skill 23: Use a Wait-Free Hierarchical Blelloch Scan
- evidence: Section 3.3.2
- method: Base the sort on a wait-free hierarchical Blelloch scan instead of cross-workgroup waiting.
- transfer: Prefer recursive scan structures that require only intra-workgroup barriers.

## Skill 24: Define Stable Scatter Position as `base_d + rank_i`
- evidence: Section 3.3.2
- method: Express each pass's output position with a digit base offset plus a stable rank.
- transfer: Preserve stable ordering explicitly when teaching radix sort as a reusable skill.

## Skill 25: Decompose Rank into Inter- and Intra-Workgroup Components
- evidence: Section 3.3.2
- method: Compute `rank_i` from a workgroup prefix plus a local rank within the workgroup.
- transfer: Split ordering logic along synchronization boundaries to keep parallel algorithms portable.

## Skill 26: Sort 32-Bit Depth via Four Stable 8-Bit Passes
- evidence: Section 3.3.2
- method: Perform four consecutive 8-bit radix passes with radix size 256.
- transfer: Use fixed, regular digit passes when simplicity and determinism matter more than exotic radix tuning.

## Skill 27: Structure Each Sort Pass as Histogram, Prefix, Scatter
- evidence: Section 3.3.2
- method: Use a three-step compute pipeline for every radix pass.
- transfer: Teach browser GPU sort pipelines as explicit stage sequences that can be measured independently.

## Skill 28: Run Hierarchical Scan as Independent Dispatches per Level
- evidence: Section 3.3.2
- method: Execute each recursion level as its own dispatch consuming the previous level's buffers.
- transfer: Replace implicit global synchronization with explicit dispatch boundaries in browser-safe GPU algorithms.

## Skill 29: Preserve Linear Work and Modest Auxiliary Storage
- evidence: Section 3.3.2
- method: Keep the algorithm at $O(N)$ work and $O(N/wg)$ auxiliary storage.
- transfer: Capture complexity targets as reusable design constraints for future WebGPU algorithms.

## Skill 30: Treat Deterministic Cross-Device Execution as an Algorithmic Deliverable
- evidence: Abstract, Section 1, Section 4.2
- method: Present wait-free scheduling behavior as both a robustness and performance win across vendors.
- transfer: When extracting research skills, retain determinism claims as first-class engineering tactics.

# Verification

This directory contains the checks of the results: an axiom audit of the Lean formalization, the Comparator check of the Challenge statements, and exact computations that test every statement of the paper. The PARI/GP computations were written separately from the Lean files and from the program that generated the certificate files, and use neither.

| Check | Files | Result |
|---|---|---|
| Axiom audit of the formal proof | [`AxiomAudit.lean`](AxiomAudit.lean), [`check_axioms.py`](check_axioms.py), [`ScanControl.lean`](ScanControl.lean), [`scan_sources.py`](scan_sources.py) | 94 of 94 listed theorems, and all 8,035 declarations of the library and the Solution, use only the standard axioms; no escape hatch in the sources |
| Challenge statements against their proofs | [`../lean/comparator/`](../lean/comparator/), [`../lean/scripts/verify-comparator.sh`](../lean/scripts/verify-comparator.sh) | The configuration is accepted by the Lean, NanoDa and con-ron kernels |
| Exact computations | [`independent_checks.gp`](independent_checks.gp) | 72 of 72 checks pass |

The outputs are in [`results/`](results/).

## Axiom audit

The Lean project in [`../lean/`](../lean/) was built from source with Lean 4.35.0 and Mathlib v4.35.0, commit `56a005855ea17e0b0958f73ec801ae140b0a1679` ([`results/lean_build.log`](results/lean_build.log)). [`AxiomAudit.lean`](AxiomAudit.lean) runs `#print axioms` on the 10 theorems in [`../lean/Solutions/`](../lean/Solutions/) that are compared with the Challenge statements and on 84 theorems of the library, which include every theorem the paper cites. It then scans all 8,035 declarations of the modules `Circulant5.*` and `Solutions.*`, including the auxiliary and generated ones, with Lean's `collectAxioms`. Under Lean's module system an importing file sees imported theorems without their proofs, so the scan relies on the axiom lists that Lean records for each declaration when its module is compiled; [`ScanControl.lean`](ScanControl.lean) runs the same scan on the Challenge module and finds that all 10 of its declarations depend on `sorryAx` ([`results/scan_control.txt`](results/scan_control.txt)), which shows that the scan sees through imports. [`check_axioms.py`](check_axioms.py) confirms that every listed theorem is reported, that it depends only on `propext`, `Classical.choice` and `Quot.sound`, and that the scan finds no other axiom; an unfinished proof would appear as `sorryAx`, and a proof by `native_decide` as `Lean.ofReduceBool`. The output is in [`results/axiom_audit.txt`](results/axiom_audit.txt) and the verdict in [`results/axiom_audit_check.txt`](results/axiom_audit_check.txt). A text search of all Lean sources, with comments and strings removed ([`scan_sources.py`](scan_sources.py), output in [`results/source_scan.txt`](results/source_scan.txt)), finds no `sorry` outside the Challenge file, and no `axiom`, `admit`, `native_decide`, `implemented_by` or `extern`.

A formal proof certifies the statement that Lean checks. The Lean statements were therefore also compared with Gyires's conjecture as stated by Cheon and Wanless. The Challenge uses Mathlib's permanent, transpose, doubly stochastic matrices and circulant matrices. These differ from the formulations of the paper and of Cheon and Wanless only by equivalent conventions, which are listed under `fidelity` in [`../lean/formalization.yaml`](../lean/formalization.yaml).

## Comparator

The principal theorems are stated a second time in [`../lean/Challenges/GyiresCirculant5.lean`](../lean/Challenges/GyiresCirculant5.lean), using Mathlib's definitions only, so that a reader can audit them without reading the library. [`../lean/scripts/verify-comparator.sh`](../lean/scripts/verify-comparator.sh) runs `lake comparator` on the configuration in [`../lean/comparator/`](../lean/comparator/): it checks that the Solution theorems have exactly the Challenge statements and use only the standard axioms, and replays the proofs through Lean's kernel and the independent NanoDa and con-ron kernels. The output is in [`results/comparator.log`](results/comparator.log).

## Exact computations

[`independent_checks.gp`](independent_checks.gp) works in exact integer, rational and polynomial arithmetic. It

1. computes every permanent from the definition, as a sum over all permutations, and compares it with PARI's `matpermanent` (Ryser's formula);
2. verifies symbolically the 26-term formula for the permanent of a circulant, the identities for the products of circulants (in the paper's convention and in Mathlib's), and the affine invariance of the permanent, of the autocorrelation, of the self-convolution and of the two defects;
3. checks that each of the 120 orderings of the indices is the image of exactly one of the six canonical orderings under exactly one affine map;
4. recomputes the chamber polynomials for all 120 orderings, not only the six canonical ones, and checks every claim about their 120 × 1001 = 120,120 coefficients:
   - all are nonnegative integers, 119,520 positive and 600 zero;
   - the zeros are exactly the coefficients of the monomials $`z_0^{10}`$ and $`z_0^9z_j`$;
   - the least positive coefficient is 484, and the coefficients of $`z_1^{10},\dots,z_4^{10}`$ are 233,296, 44,209, 484 and 601;
   - the coefficients remain nonnegative after the margin $`484\,(z_1^{10}+\dots+z_4^{10})`$ is subtracted;
5. tests the comparison $`2\mathrm{per}(MN^{\mathsf T})\le\mathrm{per}(MM^{\mathsf T})+\mathrm{per}(NN^{\mathsf T})`$ on 200 random rational matrices of orders 1 to 5, the occupancy identity of its proof on 24 random integer pairs, and its consequence $`P(h)\le P(g)`$ on 300 random signed weight vectors;
6. tests the strong inequality, the margin, Gyires's inequality in homogeneous and ratio form, the positivity of the denominator, and the equality cases, on 2,000 nonnegative weight vectors, many of them with zero or repeated weights;
7. checks the two-point example and the sharpness of 484, Newman's example of order four, and every remark of the Introduction and of the Discussion: the case $`n=2`$, the vanishing of the defect to second order along the constant vectors, the absence of counterexamples to the strong inequality among 1,080 random nonnegative circulants of orders 2 to 8 and among 2,500 random doubly stochastic matrices of orders 2 to 6 (also for Gyires's inequality), and the count of $`(n-2)!`$ chambers for $`n=3,5,7`$.

The script prints one line per check and exits with a nonzero status if a check fails or if fewer checks than expected have run. The output is in [`results/independent_checks.log`](results/independent_checks.log).

The chamber computation in item 4 is exact and complete; it is an independent recomputation of the certificate that Lean checks. The random tests in items 5 to 7 are evidence, not proofs; their purpose is to catch errors in definitions, conventions and statements.

## Running the checks

```sh
# from lean/, after building the project
lake env lean ../verification/AxiomAudit.lean > ../verification/results/axiom_audit.txt
python3 ../verification/check_axioms.py ../verification/results/axiom_audit.txt
lake env lean ../verification/ScanControl.lean
scripts/verify-comparator.sh               # Linux with bubblewrap

# from the repository root
python3 verification/scan_sources.py

# from verification/ (PARI/GP 2.15 or later)
gp -q independent_checks.gp < /dev/null    # about 30 seconds
```

Each command exits with a nonzero status if a check fails.

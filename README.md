# Gyires's permanent inequality for circulant matrices of order five

A proof, formalized in Lean 4, that Gyires's permanent inequality holds for every doubly stochastic circulant matrix of order five, with its equality case. The proof establishes a stronger inequality for all nonnegative circulants of order five, with a sharp quantitative margin. The repository contains a self-contained paper, the Lean formalization, and the checks of the results.

## Background

This project is an AI research effort that I directed. ChatGPT (OpenAI), using the GPT-6 model with Pro reasoning, worked autonomously from my prompts: it proposed the problem, found the proof, and wrote the Lean formalization. I chose which problems to pursue and asked for proofs, formal verification and revisions, but I did not supply proof ideas. I then used Claude Opus 5.5 with Claude Code to check the work independently and to write the paper in its present form.

I have personally reviewed the AI-generated proofs to the best of my mathematical ability. The accompanying Lean formalizations have been machine-checked, but my review should not be considered independent expert validation. I make no claims regarding the novelty of these results and welcome further scrutiny, corrections, and feedback from the mathematical community. They have NOT been peer reviewed. The searches for earlier work were limited, and I claim no priority; earlier work that bears on the result is credited in the paper. The precise attribution of each contribution is in [AUTHORSHIP.md](AUTHORSHIP.md).

— Dev D. Goyal

## Results

A real square matrix is doubly stochastic if its entries are nonnegative and its row and column sums are all 1. B. Gyires conjectured in 1978 that every doubly stochastic $`n\times n`$ matrix $`A`$ satisfies

```math
\frac{4\mathrm{per}(A)^2}{\mathrm{per}(AA^{\mathsf T})+\mathrm{per}(A^{\mathsf T}A)+2\mathrm{per}(A^2)}\ \ge\ \frac{n!}{n^n},
```

with equality only at the matrix $`J_n`$ all of whose entries are $`1/n`$. The conjecture is Conjecture 20 in the survey of Cheon and Wanless (Linear Algebra Appl. 403, 2005) of open problems on permanents. It is elementary for $`n=2`$; the inequality was proved for $`n=3`$ by D. K. Chang (1990), and the conjecture was proved for $`n=4`$ by C. Ozols in 2026 with a computer-assisted proof formalized in Lean, not peer reviewed, whose finite certificate is checked with `native_decide` ([cozuya/gyires-permanent-4x4](https://github.com/cozuya/gyires-permanent-4x4)); it is open for $`n\ge5`$.

A circulant matrix of order five has entries $`c_{ij}=w_{j-i}`$, indices modulo five, for a vector of weights $`w\in\mathbb{R}^5`$ (the first row of the matrix). The doubly stochastic circulants are the convex combinations of the five powers of the cyclic permutation matrix, a four-dimensional family that includes matrices with zero entries and reaches the boundary of the set of doubly stochastic matrices. For a circulant $`C`$ of order five with nonnegative weights, the paper proves:

- **the strong inequality** $`24\mathrm{per}(CC^{\mathsf T})\le625\mathrm{per}(C)^2`$, that is, $`\frac{5!}{5^5}\mathrm{per}(CC^{\mathsf T})\le\mathrm{per}(C)^2`$, with equality exactly when all five weights are equal;
- **a sharp margin**: if $`z_1,\dots,z_4`$ are the gaps between consecutive sorted weights, then $`625\mathrm{per}(C)^2-24\mathrm{per}(CC^{\mathsf T})\ge484\,(z_1^{10}+z_2^{10}+z_3^{10}+z_4^{10})`$, with equality for $`w=(1,1,0,0,0)`$, so that $`484`$ is the largest constant with this property;
- **Gyires's inequality** for $`C`$ in homogeneous form, $`24\bigl(\mathrm{per}(CC^{\mathsf T})+\mathrm{per}(C^{\mathsf T}C)+2\mathrm{per}(C^2)\bigr)\le2500\mathrm{per}(C)^2`$, with equality exactly when all weights are equal; in particular, for every doubly stochastic circulant of order five the denominator of the ratio above is positive, the ratio is at least $`5!/5^5=24/625`$, and equality holds exactly at $`J_5`$.

The proof uses the affine changes of indices modulo five to reduce the 120 orderings of the weights to six. For each of the six, the defect $`625\mathrm{per}(C)^2-24\mathrm{per}(CC^{\mathsf T})`$, written in the smallest weight and the gaps, is a polynomial with nonnegative integer coefficients. Gyires's inequality follows from the strong inequality because circulants are normal and $`\mathrm{per}(C^2)\le\mathrm{per}(CC^{\mathsf T})`$.

The results concern circulants of order five only; the conjecture for all doubly stochastic matrices of order five remains open. The strong inequality $`\frac{n!}{n^n}\mathrm{per}(AA^{\mathsf T})\le\mathrm{per}(A)^2`$, if it held for all doubly stochastic matrices, would imply Gyires's conjecture; it is known for $`n=2`$ and $`n=4`$, it holds for the circulants of order five by the result above, and random tests found no counterexample in orders up to six. The paper discusses this question. The result is addressed to researchers working on permanents of doubly stochastic matrices and on the open problems collected by Minc and by Cheon and Wanless.

## Navigating the repository

- The [overview](overview.pdf) summarizes the result.
- The [manuscript map](CONTENTS.md) gives the result, status and abstract of the paper.
- The [`preprints/`](preprints/) directory contains the paper: its PDF, its LaTeX source and a BibTeX citation.
- The [Lean project](lean/README.md), the [formalization metadata](lean/formalization.yaml) and the [formalization notes](lean/docs/GyiresCirculant5.md) describe the formal proof and the declarations corresponding to each statement of the paper. The principal theorems are restated in [`lean/Challenges/GyiresCirculant5.lean`](lean/Challenges/GyiresCirculant5.lean) using Mathlib's definitions only.
- The [`verification/`](verification/README.md) directory contains the axiom audit of the formal proof, the Comparator check of the Challenge statements, and the exact computations that test every statement of the paper.

## Verification

- **Formal proofs.** The Lean project builds from source with Lean 4.35.0 and Mathlib v4.35.0. The 94 theorems listed in the axiom audit, which include every theorem cited in the paper and the 10 theorems compared with the Challenge statements, depend only on Lean's standard axioms `propext`, `Classical.choice` and `Quot.sound`, and a scan of all 8,035 declarations of the library and the Solution finds no other axiom. Apart from the deliberate placeholders in the Challenge file, the sources contain no `sorry`, and no `axiom`, `admit`, `native_decide`, `implemented_by` or `extern`.
- **Challenge statements.** [Comparator](https://github.com/leanprover/comparator) confirms that the proved theorems have exactly the statements in [`lean/Challenges/GyiresCirculant5.lean`](lean/Challenges/GyiresCirculant5.lean), and the proofs are accepted by Lean's kernel and by the independent NanoDa and con-ron kernels.
- **Definitions.** The Lean statements use Mathlib's permanent, transpose, doubly stochastic matrices and circulant matrices. Where a Mathlib definition differs from the formulation of Cheon and Wanless, the difference is an equivalent convention; each such difference is listed under `fidelity` in the [formalization metadata](lean/formalization.yaml).
- **Exact computations.** A PARI/GP script, written separately from the Lean files and from the program that generated the certificate files, computes every permanent from the definition, recomputes the coefficients of the chamber polynomials for all 120 orderings of the weights, and tests every theorem and every remark of the paper. All 72 checks pass; see [`verification/`](verification/README.md).

## Citations

The [README of the paper](preprints/Gyires-inequality-for-circulants-of-order-five/README.md) contains a BibTeX entry. When citing the result, please also cite the source of the conjecture, B. Gyires, *On permanent inequalities*, Colloq. Math. Soc. János Bolyai 18, North-Holland, 1978, and the survey of G.-S. Cheon and I. M. Wanless, *An update on Minc's survey of open problems involving permanents*, Linear Algebra Appl. 403 (2005), 314–342.

This repository is licensed under the Apache License 2.0 ([`LICENSE`](LICENSE)). The file [`lean/Circulant5/PermanentGram.lean`](lean/Circulant5/PermanentGram.lean) is adapted from C. Ozols's repository [cozuya/gyires-permanent-4x4](https://github.com/cozuya/gyires-permanent-4x4), also licensed under the Apache License 2.0; it retains Ozols's copyright notice and states the changes made.

# Authorship and AI disclosure

**Author:** Dev D. Goyal.

The result in this repository was obtained in an AI research effort directed by Dev D. Goyal, in which ChatGPT worked autonomously. This page records the contribution of each participant.

## Contributions

**Dev D. Goyal** initiated and directed the project, choosing which of the proposed problems to pursue, requesting proofs, formal verification and revisions, reviewing the results and deciding what to publish, but did not supply proof strategies or intermediate mathematical arguments. Dev D. Goyal is responsible for the contents of this repository.

**ChatGPT** (OpenAI), using the GPT-6 model with Pro reasoning, worked autonomously from Dev D. Goyal's prompts. It:

- proposed the problem (the circulant case of order five of Gyires's conjecture) and searched for earlier work on it;
- found the theorems and their proofs: the reduction to the strong inequality, the affine symmetry and the six chambers, the chamber certificate with its margin `484`, and the equality cases;
- wrote the Lean 4 library [`lean/Circulant5/`](lean/Circulant5/) for Lean 4.19, except for the file [`MathlibStatements.lean`](lean/Circulant5/MathlibStatements.lean), and the programs that generated the certificate files in [`lean/Circulant5/Coefficients/`](lean/Circulant5/Coefficients/) and [`lean/Circulant5/CompactInputs/`](lean/Circulant5/CompactInputs/); these programs are not part of this repository, and Lean checks every generated identity and inequality;
- adapted C. Ozols's Lean proof of the Gram comparison in [`lean/Circulant5/PermanentGram.lean`](lean/Circulant5/PermanentGram.lean);
- wrote the first draft of the paper.

The theorems stated in Section 3 ("Results") of the paper, and their proof strategy, are ChatGPT's.

**Claude Opus 5.5**, used with Claude Code, checked the work independently and prepared the paper and the repository. It:

- ported the library from Lean 4.19 to Lean 4.35, adapting it to Lean's module system, replacing its comments by module documentation and adapting proofs where Lean or Mathlib had changed (a larger step limit for one `simp` call, renamed lemmas and imports); the mathematical arguments of the proofs are unchanged;
- rebuilt the Lean project from source and audited the axioms of every theorem stated in the paper and of every declaration of the library and of the Solution;
- compared the Lean definitions and statements with Gyires's conjecture as stated by Cheon and Wanless;
- wrote the exact computations in [`verification/`](verification/), which recompute every permanent from the definition, recompute the chamber certificate for all 120 orderings of the weights, and test every result and every remark of the paper;
- read every proof;
- wrote [`lean/Circulant5/MathlibStatements.lean`](lean/Circulant5/MathlibStatements.lean), which translates the results to Mathlib's `Matrix.circulant` and `doublyStochastic` and proves the margin `484 (z₁¹⁰ + ⋯ + z₄¹⁰)` for an arbitrary nonnegative weight vector and an arbitrary sorting permutation, with the sharpness of `484` in that form, and the uniqueness of the reduction of a permutation to a canonical ordering; the earlier formalization stated the margin and its sharpness only in the six canonical chambers;
- wrote the Challenge and Solution modules [`lean/Challenges/GyiresCirculant5.lean`](lean/Challenges/GyiresCirculant5.lean) and [`lean/Solutions/GyiresCirculant5.lean`](lean/Solutions/GyiresCirculant5.lean), which restate the principal theorems using Mathlib's definitions only and derive them from the library, and checked them with Comparator;
- wrote the paper in its present form, expanding the exposition and writing out in full the proofs of the lemmas on products of circulants, on affine symmetry and on the six chambers;
- wrote the computation for $`n=2`$ in the introduction and the Discussion section; apart from the two-point example, which is formalized, these are tested by exact computation and are not part of the Lean formalization.

## Review status

Dev D. Goyal has reviewed the AI-generated proofs; this review is not an independent expert validation. The Challenge statements and their docstrings, and the file `lean/Circulant5/MathlibStatements.lean`, were written by Claude Opus 5.5. The statements have been checked by Lean and by Comparator, and the statements and docstrings have been read by separate Claude agents; no human expert has reviewed them, and they are not covered by Dev D. Goyal's review of the proofs. No claim of novelty is made. The paper has not been peer reviewed, and it has not been submitted to a journal.

## Scope of the checks

A Lean proof certifies the statement that Lean checks; whether that statement matches Gyires's conjecture was checked by comparing the definitions, and the paper explains the correspondence. The few statements of the paper that are checked only by computation are listed under `status.scope` in [`lean/formalization.yaml`](lean/formalization.yaml), and the conventions in which the Lean statements differ from the source under `fidelity`. The random tests of the remarks cover finitely many cases; they are evidence, not proofs.

## Credits and priority

The conjecture is due to B. Gyires (1978), and its statement is taken from the survey of G.-S. Cheon and I. M. Wanless (2005, Conjecture 20). Earlier work credited in the paper:

- D. K. Chang proved the inequality for $`n=3`$ (Linear and Multilinear Algebra 26, 1990).
- C. Ozols proved the case $`n=4`$ in 2026, with a Lean formalization ([cozuya/gyires-permanent-4x4](https://github.com/cozuya/gyires-permanent-4x4)); its proof of the comparison $`2\operatorname{per}(MN^{\mathsf T})\le\operatorname{per}(MM^{\mathsf T})+\operatorname{per}(NN^{\mathsf T})`$ is adapted in `lean/Circulant5/PermanentGram.lean`, under the Apache License 2.0.
- According to Ozols's account of prior work, a catalogue of Minc's conjectures maintained by Y. Lavi announces partial results on Gyires's conjecture without proofs; that catalogue could not be consulted for this repository.

The searches for earlier work were limited, and no priority is claimed.

## Corrections

Errors in a proof, a definition or an attribution can be reported in the repository's issue tracker.

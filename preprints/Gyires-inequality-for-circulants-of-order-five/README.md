# [Gyires's permanent inequality for nonnegative circulant matrices of order five](paper.pdf)

*A proof of Conjecture 20 of Cheon and Wanless for doubly stochastic circulant matrices of order five*

Dev D. Goyal  
October 2026

Lean: [`lean/Challenges/GyiresCirculant5.lean`](../../lean/Challenges/GyiresCirculant5.lean), [`lean/Circulant5/`](../../lean/Circulant5/) · Formalization notes: [`lean/docs/GyiresCirculant5.md`](../../lean/docs/GyiresCirculant5.md) · Checks: [`verification/`](../../verification/)

## Abstract

B. Gyires conjectured in 1978 that every doubly stochastic $`n\times n`$ matrix $`A`$ satisfies $`4\operatorname{per}(A)^2\ge\frac{n!}{n^n}\bigl(\operatorname{per}(AA^{\mathsf T})+\operatorname{per}(A^{\mathsf T}A)+2\operatorname{per}(A^2)\bigr)`$, with equality only at the matrix $`J_n`$ all of whose entries are $`1/n`$; the conjecture is open for $`n\ge5`$. We prove the conjecture for every doubly stochastic circulant matrix of order five, that is, for every convex combination of the five powers of the cyclic permutation matrix, including the matrices with zero entries. The proof establishes the stronger inequality $`24\operatorname{per}(CC^{\mathsf T})\le625\operatorname{per}(C)^2`$ for every circulant $`C`$ of order five with nonnegative entries, with equality only when all entries of $`C`$ are equal, together with a quantitative form: if $`z_1,\dots,z_4`$ are the gaps between consecutive values when the entries of the first row of $`C`$ are sorted in increasing order, then $`625\operatorname{per}(C)^2-24\operatorname{per}(CC^{\mathsf T})\ge484\,(z_1^{10}+z_2^{10}+z_3^{10}+z_4^{10})`$, and the constant $`484`$ is best possible. After an affine change of indices modulo five, the entries of the first row may be assumed to increase along one of six canonical orderings, and for each of them $`625\operatorname{per}(C)^2-24\operatorname{per}(CC^{\mathsf T})`$, written in the smallest entry and the gaps, is a polynomial with nonnegative integer coefficients. The results have been checked by computer and proved formally in the Lean proof assistant.

## Source

The LaTeX source is [`source/paper.tex`](source/paper.tex). It compiles on its own with `pdflatex` (run twice).

## Citation

```bibtex
@misc{Goyal:GyiresCirculant5,
  author = {Goyal, Dev D.},
  title = {{Gyires's permanent inequality for nonnegative circulant matrices of order five}},
  howpublished = {Preprint, \url{https://github.com/dvgyl/gyires-circulant-5/blob/main/preprints/Gyires-inequality-for-circulants-of-order-five/paper.pdf}},
  year = {2026}
}
```

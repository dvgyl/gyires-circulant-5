# Contents

**One paper on Gyires's permanent inequality for circulant matrices of order five.**

[**Read the overview PDF**](overview.pdf).

## Paper

The entry gives the title, linked to the PDF, the result, its status and the abstract. The status *special case proved* means that the statements are proved for a stated family of matrices covered by an open conjecture, which remains open in general.

&emsp;**[Gyires's permanent inequality for nonnegative circulant matrices of order five](preprints/Gyires-inequality-for-circulants-of-order-five/paper.pdf)** (Conjecture 20 of Cheon and Wanless, special case proved)

&emsp;Gyires's inequality, with its equality case, for every doubly stochastic circulant of order five; the stronger inequality $`24\operatorname{per}(CC^{\mathsf T})\le625\operatorname{per}(C)^2`$ for every nonnegative circulant of order five; a margin of $`484\,(z_1^{10}+\dots+z_4^{10})`$ in the gaps between the sorted weights, with $`484`$ best possible.

> B. Gyires conjectured in 1978 that every doubly stochastic $`n\times n`$ matrix $`A`$ satisfies $`4\operatorname{per}(A)^2\ge\frac{n!}{n^n}\bigl(\operatorname{per}(AA^{\mathsf T})+\operatorname{per}(A^{\mathsf T}A)+2\operatorname{per}(A^2)\bigr)`$, with equality only at the matrix $`J_n`$ all of whose entries are $`1/n`$; the conjecture is open for $`n\ge5`$. We prove the conjecture for every doubly stochastic circulant matrix of order five, that is, for every convex combination of the five powers of the cyclic permutation matrix, including the matrices with zero entries. The proof establishes the stronger inequality $`24\operatorname{per}(CC^{\mathsf T})\le625\operatorname{per}(C)^2`$ for every circulant $`C`$ of order five with nonnegative entries, with equality only when all entries of $`C`$ are equal, together with a quantitative form: if $`z_1,\dots,z_4`$ are the gaps between consecutive values when the entries of the first row of $`C`$ are sorted in increasing order, then $`625\operatorname{per}(C)^2-24\operatorname{per}(CC^{\mathsf T})\ge484\,(z_1^{10}+z_2^{10}+z_3^{10}+z_4^{10})`$, and the constant $`484`$ is best possible. After an affine change of indices modulo five, the entries of the first row may be assumed to increase along one of six canonical orderings, and for each of them $`625\operatorname{per}(C)^2-24\operatorname{per}(CC^{\mathsf T})`$, written in the smallest entry and the gaps, is a polynomial with nonnegative integer coefficients. The results have been checked by computer and proved formally in the Lean proof assistant.

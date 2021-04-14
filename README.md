# DualNumbers
An implementation of dual numbers and polynomials in the Julia language. This includes an interactive Pluto notebook.

## What are Dual Numbers?

The Dual Numbers can be thought of as an extension of the real numbers, with an additional constant symbol `ϵ` satisfying the relation `ϵ² = 0` (akin to the complex numbers and the relation `i² = -1`). Every dual number can be written in the form `a + b ϵ`, where `a` and `b` are real numbers.

An important property of these numbers is that for any polynomial `p` defined over the reals, the expression `p(x + ϵ)` evaluated is the dual number `p(x) + p'(x) ϵ`, where `p'(x)` is the derivative of the polynomial `p` at the point `x`.

This has numerous uses, since the derivative obtained is exact, and the computation time is also very low (it is the same amount of time required to compute the value of `p` at the point `x`, when suitable optimisations are applied).

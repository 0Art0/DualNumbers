# DualNumbers
An implementation of dual numbers and polynomials in the Julia language. This includes an interactive Pluto notebook, which can be viewed at [this](https://binder.plutojl.org/v0.14.1/open?url=https%253A%252F%252Fraw.githubusercontent.com%252F0Art0%252FDualNumbers%252Fmain%252Fplutodemo.jl) link.

## What are Dual Numbers?

The Dual Numbers can be thought of as an extension of the real numbers, with an additional constant symbol `ϵ` satisfying the relation `ϵ² = 0` (akin to the complex numbers and the relation `i² = -1`). Every dual number can be written in the form `a + b ϵ`, where `a` and `b` are real numbers.

An important property of these numbers is that for any polynomial `p` defined over the reals, the expression `p(x + ϵ)` evaluated is the dual number `p(x) + p'(x) ϵ`, where `p'(x)` is the derivative of the polynomial `p` at the point `x`.

This has numerous uses, since the derivative obtained is exact, and the computation time is also very low (it is the same amount of time required to compute the value of `p` at the point `x`, when suitable optimisations are applied).

## How does the code work?

At its core, the code relies on three crucial definitions:

#### Addition of Dual Numbers

This is done in a straightforward way

`(a + b ϵ) + (c + d ϵ) = (a + c) + (b + d) ϵ`

#### Multiplication of Dual Numbers

This is done slightly indirectly

`(a + b ϵ) ⋅ (c + d ϵ) = (ac) + (ad + bc) ϵ`

The above definition of multiplication follows from the defining equation of dual numbers - `ϵ² = 0`, and is in fact equivalent to it. This definition of multiplication is preferred for reasons of speed and ease.

#### Promotion of real numbers

If `r` is a real number that is being added or multiplied to a dual number, it is first converted to a dual number

`promote(r) = (r + 0 ϵ)`

This ensures that all operations are performed in the field of dual numbers.

---

The rest follows magically!

### An example

Consider the polynomial `p(x) = x^2 + 2x + 1`.

`p(x + ϵ) = (x + ϵ)^2 + 2(x + ϵ) + 1`


The first term is `(x + ϵ)^2 = (x + ϵ) ⋅ (x + ϵ) = (x)^2 + 2x ϵ`

The second term is `2(x + ϵ) = (2 + 0 ϵ) ⋅ (x + ϵ) = 2x + 2 ϵ`

The last term is just `1`.



Put together, this gives `(x^2 + 2x ϵ) + (2x + 2 ϵ) + 1 = (x^2 + 2x + 1) + (2x + 2) ϵ`.

The coefficient of `ϵ` is precisely `p'(x)`, the derivative of `p` at `x`!

---

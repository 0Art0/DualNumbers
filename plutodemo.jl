### A Pluto.jl notebook ###
# v0.14.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 1d52556c-9d2b-11eb-1eae-1de24a17ca62
begin
	import Pkg
	Pkg.activate(mktempdir())
	
	Pkg.add([
		Pkg.PackageSpec(name="Plots", version="1"),
 		Pkg.PackageSpec(name="PlutoUI", version="0.7")
			])
	
	using Plots, PlutoUI
end

# ╔═╡ c59921e5-af59-44e8-b13d-ed20dd1f95b8
begin
	cd(mktempdir())
	run(`gh repo clone 0Art0/DualNumbers`)
	
	include("DualNumbers/derivatives.jl")
end

# ╔═╡ 6aa1ed46-859b-4507-a098-501f1529fbee
md"
## What are Dual Numbers?

The Dual Numbers can be thought of as an extension of the real numbers, with an additional constant symbol `ϵ` satisfying the relation `ϵ² = 0` (akin to the complex numbers and the relation `i² = -1`). Every dual number can be written in the form `a + b ϵ`, where `a` and `b` are real numbers.


An important property of these numbers is that for any polynomial `p` defined over the reals, the expression `p(x + ϵ)` evaluated is the dual number `p(x) + p'(x) ϵ`, where `p'(x)` is the derivative of the polynomial `p` at the point `x`.


This has numerous uses, since the derivative obtained is exact, and the computation time is also very low (it is the same amount of time required to compute the value of `p` at the point `x`, when suitable optimisations are applied).
"

# ╔═╡ c35fee7c-2dfc-4797-a3fa-19d76a597261
md"
**The crucial property**

p(x + ϵ) = p(x) + p′(x) ϵ

---
"

# ╔═╡ a1e02614-fa79-409d-bca7-2f899d6027fe


# ╔═╡ 91bdf5c0-2088-4bf0-a40d-c53bdaaea82d
md"### Enter your favourite polynomial here!"

# ╔═╡ a9df6f48-0453-4d5e-8e0f-a37ca577fa47
#modify this cell
p = 2x^2 + 9x + 5

# ╔═╡ c7742703-5f8f-4c64-9578-aee20ecb07ec
md"### Here is the derivative"

# ╔═╡ f67b48cb-584e-4f03-b416-3c21f0af0387
p(x + ϵₚ)

# ╔═╡ 2afe0755-9952-4111-8c2c-c30b662b525b
md"### Here is the derivative computed at a specific value

Notice that it is exact, with no numerical errors!"

# ╔═╡ d4525e2d-33a7-43b0-bf75-c953accbabb6
@bind a Slider(-100:0.5:100, show_value = true, default = 0)

# ╔═╡ dd5c20f6-9a0b-4e13-99da-f7f163a26b94
p(a + ϵ)

# ╔═╡ 9364c49c-df3f-446a-969e-dde1fd89d794


# ╔═╡ 9685f6d4-0363-4d35-8ea2-855cd87d7748
md"### Interacting with the polynomial"

# ╔═╡ 8670dd7b-8943-4480-b8e1-9a235b84e978
md"##### Select the point at which the derivative is to be computed

𝚡"

# ╔═╡ 1eb92713-2935-42cc-91e8-8d9c370ecac4
@bind 𝚡 Slider(-100:0.1:100, default = 0.0, show_value = true)

# ╔═╡ 8e1887f9-cf22-4863-aeab-f578cf93a4e6
md"Adjust the value of `h`, sliding it towards zero"

# ╔═╡ c978caae-28f7-4a8c-84f3-ac79b126ad81
@bind h Slider(1e-10:1e-10:10, show_value = true, default = 1)

# ╔═╡ ace1d43e-2704-4a8c-8c17-9e5c68e64d94
begin
	plot(𝚡-h:h/1000:𝚡+h, p.(𝚡-h:h/1000:𝚡+h), label = "p(x) = $p", xlabel = "x", ylabel = "y")
	plot!([𝚡], linetype = :vline, label = "𝕩 = $𝚡")
end

# ╔═╡ 027e3632-a547-4a4d-8d13-199e9bb9120d
md"Notice how the polynomial looks linear at `𝚡` for very small values of `h`."

# ╔═╡ 2ffd0c23-20c7-43c5-92ff-83c778a2c407


# ╔═╡ 7bc2e20e-e78a-4ac5-9c40-a1b247d8b00f
md"
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

"

# ╔═╡ eabee366-66cc-47b6-a23c-978aadac1b22
md"### An example

Consider the polynomial `p(x) = x^2 + 2x + 1`.

`p(x + ϵ) = (x + ϵ)^2 + 2(x + ϵ) + 1`


The first term is `(x + ϵ)^2 = (x + ϵ) ⋅ (x + ϵ) = (x)^2 + 2x ϵ`

The second term is `2(x + ϵ) = (2 + 0 ϵ) ⋅ (x + ϵ) = 2x + 2 ϵ`

The last term is just `1`.



Put together, this gives `(x^2 + 2x ϵ) + (2x + 2 ϵ) + 1 = (x^2 + 2x + 1) + (2x + 2) ϵ`.

The coefficient of `ϵ` is precisely `p'(x)`, the derivative of `p` at `x`!

---
"

# ╔═╡ Cell order:
# ╟─1d52556c-9d2b-11eb-1eae-1de24a17ca62
# ╟─c59921e5-af59-44e8-b13d-ed20dd1f95b8
# ╟─6aa1ed46-859b-4507-a098-501f1529fbee
# ╟─c35fee7c-2dfc-4797-a3fa-19d76a597261
# ╟─a1e02614-fa79-409d-bca7-2f899d6027fe
# ╟─91bdf5c0-2088-4bf0-a40d-c53bdaaea82d
# ╠═a9df6f48-0453-4d5e-8e0f-a37ca577fa47
# ╟─c7742703-5f8f-4c64-9578-aee20ecb07ec
# ╠═f67b48cb-584e-4f03-b416-3c21f0af0387
# ╟─2afe0755-9952-4111-8c2c-c30b662b525b
# ╟─d4525e2d-33a7-43b0-bf75-c953accbabb6
# ╟─dd5c20f6-9a0b-4e13-99da-f7f163a26b94
# ╟─9364c49c-df3f-446a-969e-dde1fd89d794
# ╟─9685f6d4-0363-4d35-8ea2-855cd87d7748
# ╟─8670dd7b-8943-4480-b8e1-9a235b84e978
# ╟─1eb92713-2935-42cc-91e8-8d9c370ecac4
# ╟─ace1d43e-2704-4a8c-8c17-9e5c68e64d94
# ╟─8e1887f9-cf22-4863-aeab-f578cf93a4e6
# ╟─c978caae-28f7-4a8c-84f3-ac79b126ad81
# ╟─027e3632-a547-4a4d-8d13-199e9bb9120d
# ╟─2ffd0c23-20c7-43c5-92ff-83c778a2c407
# ╟─7bc2e20e-e78a-4ac5-9c40-a1b247d8b00f
# ╟─eabee366-66cc-47b6-a23c-978aadac1b22

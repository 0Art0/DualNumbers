include("DualNumbers.jl")
include("polynomials.jl")

promote_rule(::Type{Polynomial{T}}, ::Type{D{Polynomial{S}}}) where {T, S <: Number} = D{Polynomial{typejoin(T, S)}}

ϵₚ = ε(Polynomial{Int64})

function derivative(p::Polynomial{T})::Polynomial{T} where {T <: Number}
    p(x + ϵₚ).β
end

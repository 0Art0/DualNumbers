struct D{T} <: Number
	α::T
	β::T
end

import Base: +, - , *, /, convert, promote_rule
 
+(x::D, y::D)::D = D(x.α + y.α, x.β + y.β)
-(x::D, y::D)::D = D(x.α - y.α, x.β - y.β)
*(x::D, y::D)::D = D(x.α * y.α, x.α*y.β + x.β*y.α)
/(x::D, y::D)::D = D(x.α / y.α, (y.α*x.β - x.α*y.β)/y.α^2)

import Base: sin, cos, tan, exp, log

sin(z::D)::D = D(sin(z.α), cos(z.α) * z.β)
cos(z::D)::D = D(cos(z.α), -sin(z.α) * z.β)
tan(z::D)::D = D(tan(z.α), 1/cos^2(z.α) * z.β)
exp(z::D)::D = D(exp(z.α), exp(z.α) * z.β)
log(z::D)::D = D(log(z.a), 1/z.α * z.β)

convert(::Type{D{T}}, x::Number) where {T} = D(convert(T, x), zero(T))
convert(::Type{D{T}}, z::D{S}) where {T, S <: Number} = D(convert(T, z.α), convert(T, z.β))

promote_rule(::Type{D{T}}, ::Type{S}) where {T, S <: Number} = D{promote_type(T, S)}

Base.show(io::IO, x::D) = print(io, x.α, "  +  ", x.β, " ϵ")

ϵ = D(zero(Real), one(Real))
ε(::Type{T}) where {T} = D{T}(zero(T), one(T)) #

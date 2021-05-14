function GCD(p::T, q::T; bezout = true) where {T <: Number}
    a, b = ( p >= q ? (p, q) : (q, p) ) .|> copy
    bez, out = [1, 0], [0, 1]

    while !iszero(b) 
        q, r = divrem(a, b)
        
        bez, out = out, bez - q.*out 
	a, b = b, r
    end

    bezout ? (a, bez) : a
end

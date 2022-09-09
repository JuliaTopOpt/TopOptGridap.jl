using TopOptGridap, Zygote
using Test

@testset "TopOptGridap.jl" begin

f, x = TopOptGridap.get_domain()
Zygote.gradient(f, x)

function f(E)
    a(u, v) = g(E) * ...
    ...
    ...
    return f(u)
end

Zygote.gradient(f, 1.0)

end

module CIS3223

include("types.jl")
export
    Graph

include("utils.jl")

include("chapter0.jl")
include("chapter1.jl")
include("chapter2.jl")
include("chapter3.jl")
include("chapter4.jl")
include("chapter5.jl")
include("chapter6.jl")
include("chapter7.jl")
include("chapter8.jl")
include("chapter9.jl")
include("chapter10.jl")

using .Chapter0
export
    fib1,
    fib2

using .Chapter1
export
    multiply,
    divide,
    modexp,
    euclid,
    extendedeuclid,
    primality,
    primality2

using .Chapter2
export
    karatsuba,
    karatsuba2,
    mergesort,
    iterativemergesort,
    polynomialmultiplication

using .Chapter3
export
    explore,
    dfs

using .Chapter4
export
    dijkstra

using .Chapter5
using .Chapter6
export
    lcs

using .Chapter7
using .Chapter8
using .Chapter9
using .Chapter10

end # module

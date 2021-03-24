"""
# Divide-and-conquer algorithms

- Multiplication
- Recurrence relations
    - Master theorem
    - Binary search
- Mergesort
    - An n log n lower bound for sorting
- Medians
    - A randomized divide-and-conquer algorithm for selection
    - Efficiency analysis
    - The Unix sort command
- Matrix multiplication
- The fast Fourier transform
    - Why multiply polynomials?
    - An alternative representation of polynomials
    - Evaluation by divide-and-conquer
    - Interpolation
    - A matrix reformulation
    - Interpolation resolved
    - Inversion formula
    - A closer look at the fast Fourier transform
    - The definitive FFT algorithm
    - The fast Fourier transform unraveled
    - The slow spread of a fast algorithm
"""
module Chapter2

export
    karatsuba,
    karatsuba2,
    mergesort,
    iterativemergesort,
    polynomialmultiplication

"""
    karatsuba(x, y)

Using the Karatsuba algorithm, compute the product of two integers `x` and `y`.

# Examples

```jldoctest
julia> karatsuba(2412, 3231)
7793172
```
"""
function karatsuba(x::Int, y::Int)
    if ndigits(x) == 1 || ndigits(x) == 1
        return x * y
    end

    n = max(ndigits(x), ndigits(y))
    m = n ÷ 2

    xL, xR = x ÷ 10^m, x % 10^m
    yL, yR = y ÷ 10^m, y % 10^m

    P1 = karatsuba(xL, yL)
    P2 = karatsuba(xR, yR)
    P3 = karatsuba((xL + xR), (yL + yR))

    return (P1 * 10^(2m)) + ((P3 - P1 - P2) * 10^m) + P2
end

"""
    karatsuba2(x, y)

Using the Karatsuba algorithm, compute the product of two integers `x` and `y`.

# Examples

```jldoctest
julia> karatsuba(2412, 3231)
7793172
```
"""
function karatsuba2(x::Int, y::Int)
    if ndigits(x, base=2) == 1 || ndigits(y, base=2) == 1
        return x * y
    end

    n = max(ndigits(x, base=2), ndigits(y, base=2))
    m = n ÷ 2

    xL, xR = x ÷ 2^m, x % 2^m
    yL, yR = y ÷ 2^m, y % 2^m

    P1 = karatsuba(xL, yL)
    P2 = karatsuba(xR, yR)
    P3 = karatsuba((xL + xR), (yL + yR))

    return (P1 * 2^n) + ((P3 - P1 - P2) * 2^m) + P2
end

"""
    mergesort(a)

Sort an array of numbers `a` using the merge sort algorithm.

# Examples

```jldoctest
julia> mergesort([10, 2, 5, 3, 7, 13, 1, 6])
8-element Vector{Int64}:
  1
  2
  3
  5
  6
  7
 10
 13

julia> mergesort([1, 4.54312, 3.4321, π])
4-element Vector{Float64}:
 1.0
 3.141592653589793
 3.4321
 4.54312
```
"""
function mergesort(a::AbstractVector)
    if length(a) > 1
        m = length(a) ÷ 2
        return merge(mergesort(a[1:m]), mergesort(a[(m + 1):end]))
    else
        return a
    end
end

function merge(x::AbstractVector, y::AbstractVector)
    if length(x) == 0
        return y
    end
    if length(y) == 0
        return x
    end
    if x[1] <= y[1]
        return pushfirst!(merge(x[2:end], y), x[1])
    else
        return pushfirst!(merge(x, y[2:end]), y[1])
    end
end

function iterativemergesort(a::AbstractVector)
    Q = []
    for i ∈ 1:length(a)
        push!(Q, [a[i]])
    end
    while length(Q) > 1
        push!(Q, merge(eject(Q), eject(Q)))
    end
    return eject(Q)
end

function polynomialmultiplication(A::AbstractVector{T}, B::AbstractVector{T}) where {T <: Real}
    product = zeros(length(A) + length(B))

    for i ∈ 1:length(A)
        for j ∈ 1:length(B)
            product[i + j] += A[i] * B[j]
        end
    end

    return product
end

# TODO: FFT
# function FFT(A, ω)
#
# end

end # module

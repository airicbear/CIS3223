"""
# Algorithms with numbers

- Basic arithmetic
    - Addition
    - Bases and logs
    - Multiplication and division
- Modular arithmetic
    - Substitution rule
    - Modular addition and multiplication
    - Two's complement
    - Modular exponentiation
    - Euclid's algorithm for greatest common divisor
    - Euclid's rule
    - An extension of Euclid's algorithm
    - Modular division
    - Is your social security number a prime?
- Primality testing
    - Fermat's little theorem
    - Hey, that was group theory!
    - Generating random primes
    - Lagrange's prime number theorem
    - Carmichael numbers
    - Randomized algorithms: a virtual chapter
- Cryptography
    - An application of number theory?
    - Private-key schemes: one-time pad and AES
    - RSA
- Universal Hashing
    - Hash tables
    - Families of hash functions
"""
module Chapter1

export
    multiply,
    divide,
    modexp,
    euclid,
    extendedeuclid,
    primality,
    primality2

"""
    multiply(x, y)

Compute the product of two integers `x` and `y`.

# Examples
```jldoctest
julia> multiply(7, 8)
56
```
"""
function multiply(x::Integer, y::Integer)
    if y == 0
        return 0
    end

    z = multiply(x, y ÷ 2)
    if iseven(y)
        return 2z
    else
        return x + 2z
    end
end

"""
    divide(x, y)

Compute the quotient and remainder of `x ÷ y`.

# Examples
```jldoctest
julia> divide(5, 3)
(1, 2)
```
"""
function divide(x::Integer, y::Integer)
    if x == 0
        return (q,r) = (0,0)
    end

    (q,r) = divide(x ÷ 2, y)
    q = 2q
    r = 2r
    if isodd(x)
        r = r + 1
    end
    if r >= y
        r = r - y
        q = q + 1
    end
    return (q,r)
end

"""
    modexp(x, y, N)

Compute the modular exponentation `x^y mod N`.

# Examples
```jldoctest
julia> modexp(2, 3, 5)
3
```
"""
function modexp(x::Integer, y::Integer, N::Integer)
    if y == 0
        return 1
    end

    z = modexp(x, y ÷ 2, N)
    if iseven(y)
        return mod(z^2, N)
    else
        return mod(x * z^2, N)
    end
end

"""
    euclid(a, b)

Using Euclid's algorithm, compute the greatest common divisor
between two integers `a` and `b` where `a >= b >= 0`.

# Examples
```jldoctest
julia> euclid(25, 20)
5
```
"""
function euclid(a::Integer, b::Integer)
    @assert a >= b >= 0
    if b == 0
        return a
    end

    return euclid(b, mod(a, b))
end

"""
    extendedeuclid(a, b)

A simple extension of Euclid's algorithm.

- Input: Two positive integers `a` and `b` with `a >= b >= 0`.
- Ouput: Integers `x`, `y`, `d` such that `d = gcd(a,b)` and `ax + by = d`.

# Examples
```jldoctest
julia> extendedeuclid(9, 6)
(1, -1, 3)
```
"""
function extendedeuclid(a::Integer, b::Integer)
    @assert a >= b && b >= 0
    if b == 0
        return (1, 0, a)
    end

    (x′, y′, d) = extendedeuclid(b, mod(a, b))
    return (y′, x′ - a ÷ b * y′, d)
end

"""
    isprime(N)

Determine whether an integer `N` is prime using Fermat's little theorem.

# Examples
```jldoctest
julia> primality(5)
true
```
"""
function primality(N::Integer)
    if N < 2
        return false
    end

    a = rand(1:(N - 1))
    return powermod(a, N - 1, N) == 1
end

"""
    primality2(N)

Determine whether an integer `N` is prime with low error probability.
"""
function primality2(N::Integer)
    if N < 2
        return false
    end

    a = rand(1:(N - 1), N - 1)
    if all([powermod(a[i], N - 1, N) == 1 for i ∈ 1:(N - 1)])
        return true
    else
        return false
    end
end

end # module

"""
# Prologue

- Books and algorithms
- Enter Fibonacci
    - An exponential algorithm
    - A polynomial algorithm
    - More careful analysis
- Big-O notation
"""
module Chapter0

export
    fib1,
    fib2

function fib1(n)
    if n == 0
        return 0
    end
    if n == 1
        return 1
    end
    return fib1(n - 1) + fib1(n - 2)
end

function fib2(n)
    if n == 0
        return 0
    end

    f = fill(NaN, n)
    f[0] = 0
    f[1] = 1
    for i ∈ 2:n
        f[i] = f[i - 1] + f[i - 2]
    end
    return f[n]
end

end # module

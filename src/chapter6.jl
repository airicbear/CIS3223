"""
# Dynamic programming

- Shortest paths in dags, revisited
- Longest increasing subsequences
    - Recursion? No, thanks.
    - Programming?
- Edit distance
    - A dynamic programming solution
    - The underlying dag
    - Common subproblems
    - Of mice and men
- Knapsack
    - Knapsack with repetition
    - Knapsack without repetition
    - Memoization
- Chain matrix multiplication
- Shortest paths
    - Shortest reliable paths
    - All-pairs shortest paths
    - The traveling salesman problem
- Independent sets in trees
    - On time and memory
"""
module Chapter6

export
    lcs

"""
    lcs(A, B)

Find the longest subsequence of two sequences `A` and `B`.
"""
function lcs(A, B)
    T = zeros(length(A) + 1, length(B) + 1)

    for i ∈ 1:(length(A) + 1), j ∈ 1:(length(B) + 1)
        if i == 1 || j == 1
            T[i, j] = 0
        elseif A[i - 1] == B[j - 1]
            T[i, j] = T[i - 1, j - 1] + 1
        else
            T[i, j] = max(T[i - 1, j], T[i, j - 1])
        end
    end

    return lcs(A, B, T)
end

function lcs(a, b, T)
    result = []
    i, j = size(T)
    while i > 1 && j > 1
        if a[i - 1] == b[j - 1]
            pushfirst!(result, a[i - 1])
            i -= 1
            j -= 1
        elseif T[i - 1, j] > T[i, j - 1]
            i -= 1
        else
            j -= 1
        end
    end
    return join(result)
end

end # module

"""
# Paths in graphs

- Distances
- Breadth-first search
    - Correctness and efficiency
- Lengths on edges
- Dijkstra's algorithm
    - An adaptation of breadth-first search
    - A more convenient graph
    - Alarm clocks
    - Dijkstra's algorithm
    - An alternative derivation
    - Running time
    - Which heap is best?
- Priority queue implementations
    - Array
    - Binary heap
    - d-ary heap
- Shortest paths in the presence of negative edges
    - Negative edges
    - Negative cycles
- Shortest paths in dags
"""
module Chapter4

using DataStructures

export
    dijkstra

import
    ..Graph

"""
    dijkstra(G, s)

Run Dijkstra's shortest path algorithm from node `s` for a graph using an adjacency list representation.
Return the distances in the first column and previous nodes in the second column where each row represents the corresponding node.

# Examples

```jldoctest
julia> G = Dict(
           :A=>[(:B,6), (:D,1)],
           :B=>[(:A,6), (:C,5), (:D,2), (:E,2)],
           :C=>[(:B,5), (:E,5)],
           :D=>[(:A,1), (:B,2), (:E,1)],
           :E=>[(:B,2), (:C,5), (:D,1)]
           )
Dict{Symbol, Vector{Tuple{Symbol, Int64}}} with 5 entries:
  :A => [(:B, 6), (:D, 1)]
  :D => [(:A, 1), (:B, 2), (:E, 1)]
  :B => [(:A, 6), (:C, 5), (:D, 2), (:E, 2)]
  :E => [(:B, 2), (:C, 5), (:D, 1)]
  :C => [(:B, 5), (:E, 5)]

julia> dijkstra(G, :A)[:dist]
Dict{Symbol, Float64} with 5 entries:
  :A => 0.0
  :D => 1.0
  :B => 3.0
  :E => 2.0
  :C => 7.0

julia> dijkstra(G, :A)[:prev]
Dict{Symbol, Symbol} with 5 entries:
  :A => :nil
  :D => :A
  :B => :D
  :E => :D
  :C => :E
```
"""
dijkstra(G::Graph{T,U}, s::T) where {T<:Symbol, U<:Real} = dijkstra(G, s, :nil::Union{T,Nothing})
dijkstra(G::Graph{T,U}, s::T) where {T<:Real, U<:Real} = dijkstra(G, s, 0::Union{T,Nothing})
dijkstra(G::Graph{T,U}, s::T) where {T<:String, U<:Real} = dijkstra(G, s, ""::Union{T,Nothing})

function dijkstra(G::Graph{T,U}, s::T, nil::Union{T,Nothing}) where{T, U<:Real}
    dist = Dict(collect(keys(G)) .=> Inf)
    prev = Dict(collect(keys(G)) .=> nil)
    dist[s] = 0

    H = PriorityQueue([(s, dist[s])])
    while !isempty(H)
        (u, du) = dequeue_pair!(H)
        for (v, length) ∈ G[u]
            alt = dist[u] + length
            if dist[v] > alt
                dist[v] = alt
                prev[v] = u
                if !haskey(H, v)
                    enqueue!(H, v => alt)
                end
            end
        end
    end

    return (dist=dist, prev=prev)
end

end # module

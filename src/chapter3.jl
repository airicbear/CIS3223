"""
# Decomposition of graphs

- Why graphs?
    - How is a graph represented?
- Depth-first search in undirected graphs
    - Exploring mazes
    - Depth-first search
    - Connectivity in undirected graphs
    - Previsit and postvisit orderings
- Depth-first search in directed graphs
    - Types of edges
    - Directed acyclic graphs
- Strongly connected components
    - Defining connectivity for directed graphs
    - An efficient algorithm
"""
module Chapter3

export
    explore,
    dfs

import
    ..Graph

mutable struct Clock
    value::Int
end

function previsit!(v, pre::Dict, clock::Clock)
    pre[v] = clock.value
    clock.value += 1
end

function postvisit!(v, post::Dict, clock::Clock)
    post[v] = clock.value
    clock.value += 1
end

"""
    explore(G, v)

Find all nodes reachable from a particular node.
"""
function explore(G::Graph{T}, v::T,
                 visited::Dict=Dict(collect(keys(G)) .=> false),
                 pre::Dict=Dict(collect(keys(G)) .=> 0),
                 post::Dict=Dict(collect(keys(G)) .=> 0),
                 clock::Clock=Clock(0)) where {T}
    visited[v] = true
    previsit!(v, pre, clock)
    for edge ∈ G[v]
        (u, w) = edge
        if !visited[u]
            explore(G, u, visited, pre, post, clock)
        end
    end
    postvisit!(v, post, clock)
    return (pre=pre, post=post)
end

"""
    dfs(G, v)

Depth-first search algorithm.
"""
function dfs(G::Graph{T}, v::T, visited::Dict=Dict(collect(keys(G)) .=> false)) where {T}
    explored = []
    for (v, e) ∈ G
        if !visited[v]
            push!(explored, (v, explore(G, v, visited)))
        end
    end
    return explored
end

end # module

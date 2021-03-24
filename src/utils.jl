function eject(Q::AbstractVector)
    if isempty(Q)
        return Q
    end

    pop = Q[1]
    deleteat!(Q, 1)
    return [pop]
end

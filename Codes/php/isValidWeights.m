function isValidWeights(W)
    if sum(W < 0) ~= 0
        error('Poids n�gatifs !');
    end
end
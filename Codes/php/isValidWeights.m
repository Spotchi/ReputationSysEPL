function isValidWeights(W)
    if sum(W < 0) ~= 0
        error('Poids négatifs !');
    end
end
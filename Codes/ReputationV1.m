function [r, t, iter] = ReputationV1(E, A, c)

    % # of items
    [n, m] = size(E);
    
    % # of items evalueated by i
    mi = sum(A, 2);
    
    % Trust matrix of evaluations
    T = ones(n, m);
    
    % Variable to stop the loop
    r = zeros(m, 1);  
    rOld = r;    
    first = true;
    eps = 10^-6;
    iter = 0;
    
    while first||sum(abs(rOld-r) < eps) < m

        rOld = r;
        iter = iter + 1;
        first = false;
        
        W = getWeights(T, A)
        r = getReputationVector(W, E)
        d = getPenalizedRow(E, r, mi)
        T = getTrustMatrix(c, d, n, m)
        
        t = max(d) - d;
    end
    
    function W = getWeights(T, A)
        W = bsxfun(@rdivide, T, sum(A.*T));       
    end

    function r = getReputationVector(W, E)
        r = sum(W.*E)';
    end

    function d = getPenalizedRow(E, r, mi)
        d = sum(bsxfun(@minus, E, r').^2, 2)./mi;
    end

    function T = getTrustMatrix(c, d, n, m)
        T = bsxfun(@minus, c, d')';
        T = T(1:n, 1:m);
        
        % Replace row of [0 0 ... 0] by row of [1 1 ... 1]
        p = any(T == 0, 2);
        T(p, :) = repmat(ones(1, m), [sum(p) 1]);
    end
    
end


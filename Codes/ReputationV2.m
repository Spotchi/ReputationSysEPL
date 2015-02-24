function [r, w, iter] = ReputationV2(X, A)

    % # of items
    [n, m] = size(X);
    
    % # of items evalueated by i
    mi = sum(A, 1);
    
    % Weight vectors of the raters
    w = ones(m, 1);
    
    % Reputation vector of the items
    r = (X*w)/sum(w);
    
    rOld = r; 
    first = true;
    eps = 10^-3;
    iter = 0;   

    while first||sum(abs(rOld-r) < eps) < n

        rOld = r;
        iter = iter + 1;
        first = false;
        
        d = getPenalizedRow(X, A, r, mi);
        w = getWeights(d);
        r = getReputationVector(w, X, A);
    end
    
    
    function w = getWeights(d)
        w = exp(-d);     
        %w = 1-1/5.*d;
        %w = 1-1/3.*d;
        %w = d.^-1;
        %w = d.^(-1/2);
    end

    function r = getReputationVector(w, X, A)
        r = X*w./(A*w);
    end

    function d = getPenalizedRow(X, A, r, mi)
        d = (sum(bsxfun(@minus, X, bsxfun(@times, A, r)).^2)./mi)';
    end
    
end


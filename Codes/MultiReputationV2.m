%
% X_{n . m . k} where n = # of judges
%                     m = # of objects
%                     k = # of characteristics
%
% A_{n . m . k} = 1 if X_{n . m . k} is voted
%               = 0  otherwise
%
function [w R d T] = MultiReputationV2(X, A)

    if ndims(X) ~= 3
        error('The vector X must have 3 dimensions');
    end

    if ndims(A) ~= 3
        error('The vector A must have 3 dimensions');
    end

    % # of items and juges
    [n, m, k] = size(X);

    % # of items on characteristics k evalueated by judge i
    % mi_{n, k}
    mi = permute(sum(A, 2), [1 3 2]);
    
    % Trust matrix of evaluations
    T = ones(n, m, k);
    
    % Reputation matrix
    R = zeros(m, k);
    
    % Weights tensor
    w = ones(n, 1);
    
    for i=1:100
        
        R = getReputationVector(w, X);
        d = getPenalizedRow(X, R);
        
        w = getTrustMatrix(d, n, m, k);
        
    end
    
    function w = getWeights(T, A)
        w = bsxfun(@rdivide, T, sum(A.*T));      
    end

    function r = getReputationVector(w, X)
        % 1 x m x k --> m x k
        r = sum(bsxfun(@times, X, w))./sum(w);
        %r = permute(r, [2 3 1]);
    end

    function d = getPenalizedRow(X, R)
    
        dij = bsxfun(@minus, X, R);
        
        %dij = permute(dij, [1 3 2]);
        
        d = sum(sum(dij.^2, 2), 3);
    end

    function w = getTrustMatrix(d, n, m, K)
        
        
        k = 1/(log(2*pi));
        
        w = 1 - k*1/(m*K)*d;
        
        %w = 1-1/5.*d;
        
    end
    
end


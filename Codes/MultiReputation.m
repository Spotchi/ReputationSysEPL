%
% X_{n . m . k} where n = # of judges
%                     m = # of objects
%                     k = # of characteristics
%
% A_{n . m . k} = 1 if X_{n . m . k} is voted
%               = 0  otherwise
%
function [W R d T] = MultiReputation(X, A)

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
    W = zeros(n, m, k);
    
    for i=1:10
    
        W = getWeights(T, A);
        R = getReputationVector(W, X);
        d = getPenalizedRow(X, R, mi);
        T = getTrustMatrix(eye(k, k), d, n, m, k);
        
    end
    
    function W = getWeights(T, A)
        W = bsxfun(@rdivide, T, sum(A.*T));      
    end

    function r = getReputationVector(W, X)
        % 1 x m x k --> m x k
        r = sum(W.*X);
        r = permute(r, [2 3 1]);
    end

    function d = getPenalizedRow(X, R, mi)

        X = permute(X, [3, 1, 2]);
        R = permute(R, [1 3 2]);
        v = bsxfun(@minus, X, R);
        
        mi = permute(mi, [3 1 2]);
        
        d = sum(sum(v.^2).*mi)
    end

    function T = getTrustMatrix(C, d, n, m, k)

        T = 1 - 2/(-log((2*pi)^k)*det(C))*d;
        T = bsxfun(@minus, ones(m, n), permute(d, [3 2 1]))';

        for i = 1:k-1
            T = cat(3, T, T);
        end

    end
    
end


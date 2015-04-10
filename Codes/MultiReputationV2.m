%
% X_{n . m . k} where n = # of judges
%                     m = # of objects
%                     k = # of characteristics
%
% A_{n . m . k} = 1 if X_{n . m . k} is voted
%               = 0  otherwise
%
function [w R d] = MultiReputationV2(X, A)

    if ndims(X) ~= 3
        error('The vector X must have 3 dimensions');
    end

    if ndims(A) ~= 3
        error('The vector A must have 3 dimensions');
    end

    % # of items and juges
    [n, m, k] = size(X);
    
    % Reputation matrix
    R = zeros(m, k);
    
    % Weights tensor
    w = ones(n, 1);
    
    for i=1:200
        %display("Avant\n");
        %R
        R = getReputationVector(w, X);
        %display("Apres\n");
        %R
        d = getPenalizedRow(X, R);
        w = getTrustMatrix(d, n, m, k);
        
    end
R
    function R = getReputationVector(w, X)
        % 1 x m x k --> m x k
        
        R = sum(bsxfun(@times, X, w))./sum(w);
        %r = permute(r, [2 3 1]);
    end

    function d = getPenalizedRow(X, R)
    
        dij = bsxfun(@minus, X, R);
        
        %dij = permute(dij, [1 3 2]);
        
        d = sum(sum(dij.^2, 2), 3);
    end

    function w = getTrustMatrix(d, ~, M, K)
        
        k = 1/(log(2*pi));
        
        %w = 1 - k*(1/(M*K))*d;
        
        w = 1 - 1/10*(1/(M*K))*d;
        
        %w = exp(-d);
        
    end
    
end


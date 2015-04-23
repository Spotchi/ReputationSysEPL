%
% X_{n . m . k} where n = # of judges
%                     m = # of objects
%                     k = # of characteristics
%
% A_{n . m . k} = 1 if X_{n . m . k} is voted
%               = 0  otherwise
%
function [w, R, d] = MultiReputationV2(X, A)

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
    
    % # votes by judges
    mi = sum(sum(A, 2), 3);

    for i=1:100
        R = getReputationVector(w, X, A);
        d = getPenalizedRow(X, R, A)./mi;
        w = getTrustMatrix(d);
    end
    
    % Format R to m x k
    R = permute(R, [2 3 1]);

    function R = getReputationVector(w, X, A)
        R = sum(bsxfun(@times, X, w))./sum(bsxfun(@times, A, w));
        % Remove division by 0
        R(isnan(R)) = 0 ;
    end

    function d = getPenalizedRow(X, R, A)
        dij = bsxfun(@minus, X, bsxfun(@times, A, R));
        d = sum(sum(dij.^2, 2), 3);
    end

    function w = getTrustMatrix(d)
        ki = 1/(log(2*pi));
        w = 1 - ki*d;
    end

end



%
% X_{n . m . k} where n = # of judges
%                     m = # of objects
%                     k = # of characteristics
%
% A_{n . m . k} = 1 if X_{n . m . k} is voted
%               = 0  otherwise
%
function [w, R, d, coeff] = MultiReputationMaxK(X, A, B)
    
    if ndims(X) ~= 3
        error('The vector X must have 3 dimensions');
    end

    if ndims(A) ~= 3
        error('The vector A must have 3 dimensions');
    end
    
    if nargin < 4
        B = A;
    end
    % # of items and juges
    [n, m, k] = size(X);

    % Reputation matrix
    R = zeros(m, k);

    % Weights tensor
    w = ones(n, 1);
    
    % # votes by judges
    mi = sum(sum(A, 2), 3);

    for i=1:5
        R = getReputationVector(w, X, A);
        d = getPenalizedRow(X, R, A, B)./mi;
        coeff = getMaxK(d);
        w = getTrustMatrix(d,coeff);
    end
    
    % Format R to m x k
    R = permute(R, [2 3 1]);

    function R = getReputationVector(w, X, A)
        R = sum(bsxfun(@times, X, w))./sum(bsxfun(@times, A, w));
        % Remove division by 0
        R(isnan(R)) = 0 ;
    end

    function d = getPenalizedRow(X, R, A, B)
        dij = B.*bsxfun(@minus, X, bsxfun(@times, A, R));
        d = sum(sum(dij.^2, 2), 3);
    end
    function daK = getMaxK(d)
        daK = 1/max(d);
    end
    function w = getTrustMatrix(d,coeff)
        w = 1 - coeff*d;
    end

end

% MULTIREPUTATION Calculate multi-variate version of the reputation system.
%
%   [w, R, d] = MultiReputation(X, A, coeff, B) Calculate multi-variate
%   version the the reputation system.
%
%   The tensor X and A must have the same 3D size. The tensor X contains the
%   rates of objects and the tensor A is the adjacency matrix.
%   The param coeff determine how we penalized the raters. The higher the
%   coefficient, the higher we penalize the judge. If it is not filled or
%   equal to NaN, each iteration we take the max possible k.
%
%   X_{nxmxk} where n = # of judges
%                   m = # of objects
%                   k = # of characteristics
%
%   A_{nxmxk} = 1 if X_{nxmxk} is voted
%             = 0 otherwise
%
%   The algorithm is an iterative algorithm. On each iteration it
%   calculates the reputation for each characteristics, the belief
%   divergence for each rater and the trust vector w for each raters.
%
%       R ------> d^{ij}     
%       ^        /           R_{ij} = (?X_{ijk}w_i)/(?A_{ijk}w_i)
%       | Iter /            d^{ij} = X_{ijk} - A_{ijk}*r_{jk}
%       |    /               div_i  = 1/mi*?((d_{ij})'*(d_{ij})
%       |  /                 w_{ij} = 1 - k*div_i
%       w 
%
%   The belief divergence d^{ij} is used to penalize those raters that have
%   an high belief divergence.
%
%   The function return a matrix R of iterate reputation. A colomn vector
%   of weights W and a column vector of divergences d.
%
%   Exemple:
%       X1 = [4.2 4.5 2.8; 3.4 3.3 4.9];
%       X2 = [4.3 4.4 2.8; 3.3 3.4 4.8];
%
%       X = permute(cat(3, X1, X2), [2 3 1]);
%       A = ones(size(X));
%
%      [W R d] = MultiReputation(X, A, 0.35);
%
%       W = [0.9744 0.9518 0.4853]';
%       R = [4.0311 3.6679; 4.0321 3.6465];
%       d = [0.0730 0.1378 1.4705]';
%
%   See also REPUTATION
function [w, R, d, coeff, iter] = MultiReputation(X, A, coeff, B)

    if ndims(X) ~= 3
        error('The vector X must have 3 dimensions');
    end

    if ndims(A) ~= 3
        error('The vector A must have 3 dimensions');
    end
    
    if nargin < 3
        useMaxCoeff = true;
    else
        useMaxCoeff = false;
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
    
    % Tolerance of algorithm
    tol = 10^-3;
    iter = 0;
    previousNorm = 0;
    actualNorm = 0;

    %% Iteration
    while abs(previousNorm - actualNorm) > tol || iter == 0
        R = getReputationVector(w, X, A);
        d = getPenalizedRow(X, R, A, B)./mi;
        
        % MaxK
        if useMaxCoeff
            coeff = getMaxK(d);
        end
        
        w = getTrustMatrix(d, coeff);
        
        previousNorm = actualNorm;
        actualNorm = norm(permute(R, [2 3 1]), 'fro');
        
        iter = iter + 1;
    end
    
    % Format output R to m x k
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

    function w = getTrustMatrix(d, coeff)
        w = 1 - coeff*d;
    end

end

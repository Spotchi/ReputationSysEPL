% Reputation Calculates the reputation of raters and objects
%
%   [r, t, W, d] = REPUTATION(E, A, c, f) calculates the uni-variate
%   reputation of raters and objects.
%
%   The matrix E and A must have the same size. The matrix E contains the
%   rates of objects and the matrice A is the adjacency matrix. The param c
%   is a vector of the default weight of judges (by default a vector of ones).
%   The param f is an anonymous function that represent the energy function.
%
%   E_{nxm} where n = # of items and m = # juges.
%   A_{nxm} where A_{ij} = 1 if E_{ij} is voted, 0 otherwise.
%   c_{nx1}
%
%   The algorithm is an iterative algorithm. On each iteration it
%   calculates the matrix of weights, the reputation for each item, the
%   belief divergence for each rater and the trust matrix T for each
%   rating.
%
%       T ------> W         W_{ij} = T_{ij}/?T_{kj}
%       ^         |            r_j = ? W_{ij}E_{ij}
%       |   Iter  |            d_i = 1/mi*?(E_{ij} - r_j)^2
%       |         |         T_{ij} = c_j - di;
%       d <------ r            t_i = d_{max} - di
%
%   The belief divergence is used to penalize those raters that have an
%   high belief divergence.
%
%   The function return a column vector r of iterate reputation. A column
%   vector of raters t, a matrix of weights W and a column vector of
%   divergences d.
%
%   Exemple:
%       X = [4.2 4.5 2.8; 3.4 3.3 4.9];
%       A = ones(size(X));
%       c = ones(size(X, 1), 1);
%       f = inline('1 - exp(-d)')
%       [r, t, W, d] = Reputation(X, A, c, f);
%
%       r = [4.2589 3.4394]';
%
function [r, t, W, d, iter] = Reputation(E, A, c, f)

    % # of items and juges
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
    
    %% Iteration
    while first||sum(abs(rOld-r) < eps) < m
        rOld = r;
        iter = iter + 1;
        first = false;
        
        W = getWeights(T, A);
        r = getReputationVector(W, E);
        d = getPenalizedRow(E, r, mi);
        T = getTrustMatrix(c, d, n, m);
    end
        
    t = max(d) - d;
    
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
        
        T = bsxfun(@minus, c, f(d)')';
        T = T(1:n, 1:m);
        
        % Replace row of [0 0 ... 0] by row of [1 1 ... 1]
        p = any(T == 0, 2);
        T(p, :) = repmat(ones(1, m), [sum(p) 1]);
    end
    
end


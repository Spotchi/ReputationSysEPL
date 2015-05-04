function d = getInitialVariance(X, A)

    n = size(X, 1);

    Rmean = sum(bsxfun(@times, X, ones(n, 1)))./sum(bsxfun(@times, A, ones(n, 1)));
    Rmean(isnan(Rmean)) = 0 ;
    
    dij = bsxfun(@minus, X, bsxfun(@times, A, Rmean));
    mi  = sum(sum(A, 2), 3);
    
    d = sum(sum(dij.^2, 2), 3)./mi;
    
end
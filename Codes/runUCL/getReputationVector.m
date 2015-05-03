function R = getReputationVector(w, X, A)
        R = sum(bsxfun(@times, X, w))./sum(bsxfun(@times, A, w));
        % Remove division by 0
        R(isnan(R)) = 0 ;
end
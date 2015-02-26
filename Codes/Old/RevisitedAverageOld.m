function r = RevisitedAverageOld(E)

    [~, n] = size(E);
    
    % Remove max values
    for i=1:n      
        E(E(:, i) == max(E(:, i)), i) = NaN;
    end
        
    % Remove min values
    for i=1:n      
        E(E(:, i) == min(E(:, i)), i) = NaN;
    end
    
    % Mean of the rest
    r = nanmean(E, 1);
    
    if sum(isnan(r)) ~= 0
        error('We have remove all values at least one vector! We must implement an alternative...');
    end

end


function [r, X] = Outlier(X)

    % Remove max values
    [~, i] = max(X);
    j = sub2ind(size(X), i, 1:size(X, 2));
    X(j) = NaN;

    % Remove min values
    [~, i] = min(X);
    j = sub2ind(size(X), i, 1:size(X, 2));
    X(j) = NaN;

    % Mean of the rest
    r = nanmean(X, 1);
end


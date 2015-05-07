% Outlier  Calculates the trimmed mean of the values in X
%
%   M = OUTLIER(X) calculates the trimmed mean of the values in X.
%   For a vector input, M is the mean of X, excluding the highest and
%   lowest K data values. For a matrix input, M is a row vector
%   containing the trimmed mean of each column of X.
%
%   Exemple: X =  [3 3 1; ...
%                  1 2 2; ...
%                  3 3 3];
%
%            M = Outlier(X);
%
%            M = [3 3 2];
%
% See also MEAN, NANMEAN, TRIMMEAN
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


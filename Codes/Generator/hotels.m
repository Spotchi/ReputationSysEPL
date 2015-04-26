clear all;
close all;
clc;

% total # of judges
n = 10;

% total # of hotels
m = 5;

% # of characteristics
k = 3;

%% Create matrix
A = randi([0 1], n, m, k);
X = randi([0 5], n, m, k).*A;

for i=1:k
    if X(:, :, 1) == zeros(n, m)
        error('no one voted for the characteristics %d', i);
    end
end

%% Calculate basic mean
mean = sum(X)./sum(A);
mean(isnan(mean)) = 0;
mean = permute(mean, [2 3 1]);

%% Run Reputation
[W, R, d] = MultiReputationV2(X, A);

%% Compare
meanDiff = mean - R;
lessThanZero = sum(sum(meanDiff < 0));
greatherThanZero = sum(sum(meanDiff > 0));
equalToZero = sum(sum(meanDiff == 0));


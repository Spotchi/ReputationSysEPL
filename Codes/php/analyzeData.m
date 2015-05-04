parseData;

%% Run Reputation
tic;
[W, R, d] = MultiReputationMaxK(X, A);
toc;

%% Compare
meanDiff = normalMean - R;
lessThanZero = sum(sum(meanDiff < 0));
greatherThanZero = sum(sum(meanDiff > 0));
equalToZero = sum(sum(meanDiff == 0));

%% Initial value of variance
createFigure('Histogram of weights after iterations');
histogram(W, 0:0.1:1);

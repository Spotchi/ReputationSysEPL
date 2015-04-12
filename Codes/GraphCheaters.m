clear all;
close all;
clc;

addpath('Old');

scores = [4.2 2.8 3.4 2.2];
interval = [0 5];
x = interval(1):0.1:interval(2);
n = size(x);

rOutlier = zeros(n);
rIter = zeros(n);
rNormal = zeros(n);

for i = 1:length(x)
    newScores = [scores x(i)];
    rOutlier(i) = mean(Outlier(newScores'));
    rNormal(i) = mean(newScores);
    [r, w] = ReputationV2([newScores; [4 3.8 2.5 3.6 5]], ones(2, length(scores) + 1));
    means = mean(r);
    rIter(i) = means(1);
end

f = createFigure('How to cheat ?', 'Score', 'Mean');
createPlot(f, x, rOutlier);
createPlot(f, x, rIter);
createPlot(f, x, rNormal);

legend('Outliers', 'Iteration (Team 2 significantly advantaged)', 'Basic mean');

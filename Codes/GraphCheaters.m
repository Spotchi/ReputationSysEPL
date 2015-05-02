clear all;
close all;
clc;

addpath('Old');

scores1 = [4.2 2.8 3.4 2.2 2.4 3 3 3.4 3.5 3.2];
scores2 = [4   3.8 2.5 3.6 2.7 2.7 3   3.8 3.8 4];
interval = [0 5];
x = interval(1):0.1:interval(2);
n = size(x);

rOutlier = zeros(n);
rIter = zeros(n);
rNormal = zeros(n);

for i = 1:length(x)
    newScores = [scores1 x(i)];
    rOutlier(i) = mean(Outlier(newScores'));
    rNormal(i) = mean(newScores);
    [r, w] = ReputationV2([newScores; [scores2 0]], ones(2, length(scores1) + 1));
    means = mean(r);
    rIter(i) = means(1);
    
    if (sum(w < 0) == 1)
        error('Poids négatifs !');
    end
end

f = createFigure('How to cheat ?', 'Score', 'Mean');
createPlot(f, x, rOutlier);
createPlot(f, x, rIter);
createPlot(f, x, rNormal);

legend('Outliers', 'Iteration (Team 2 significantly advantaged)', 'Basic mean');

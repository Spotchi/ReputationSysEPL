clear;
close all;
clc;

addpath('Old');

%% 1
scores1 = [4.2 2.8 3.4 2.2 2.4 3 3 3.4 3.5 3.2 2 2 3.5 3.9 5 5 5 5 5 5 5 5 5];
scores2 = [4   3.8 2.5 3.6 2.7 2.7 3   3.8 3.8 4 2.5 2.3 4 4 0 5 4 4 4 3 3 3 3];
interval = [0 10];

%% 2
scores1 = 3*[4   3.8 2.5 3.6 2.7 2.7 3   3.8 3.8 3 flip([4   3.8 2.5 3.6 2.7 2.7 3   3.8 3.8 3]) 4   3.8 2.5 3.6 2.7 2.7 3   3.8 3.8 3];
scores2 = 4*[4.2 4.4 3.4 4.2 3.4 3 4 3.4 3.5 3.8 4.2 4.4 3.4 4.2 3.4 3 4 3.4 3.5 3.8 flip([4.2 4.4 3.4 4.2 3.4 3 4 3.4 3.5 3.8])];
interval = [0 20];

%% 3
%scores1 = [3.3 3.4 4.9 3.5 3.3 3.8];
%scores2 = [4.2 4.5 2.8 4.3 4.3 3.8];
%interval = [0 5];


x = interval(1):0.1:interval(2);
n = size(x);

rOutlier = zeros(n);
rIter = zeros(n);
rIter2 = zeros(n);
rNormal = zeros(n);
poids = zeros(n);

for i = 1:length(x)
    newScores = [scores1 x(i)];
    
    % Normal mean
    rNormal(i) = mean(newScores);
    
    % Outliers
    rOutlier(i) = mean(Outlier(newScores'));
    
    % Iteration
    [r, w] = ReputationV2([newScores; [scores2 0]], ones(2, length(scores1) + 1));
    
    rIter(i) = r(1);
    poids(i) = w(end);
    
    if (sum(w < 0) ~= 0)
        error('Poids négatifs !');
    end
end

f = createFigure('How to cheat ?', 'Score', 'Mean');
createPlot(f, x, rOutlier);
createPlot(f, x, rIter);
createPlot(f, x, rNormal);

[~, minIter] = min(rIter);
[~, maxIter] = max(rIter);

color = [1 0.400000005960464 0.600000023841858];

plot(x(minIter), rIter(minIter), '.', 'Color', color, 'MarkerSize', 32);
plot(x(maxIter), rIter(maxIter), '.', 'Color', color, 'MarkerSize', 32);

legend('Outliers', 'Score Team Advantaged', 'Basic mean', 'Min & Max');

g = createFigure('Evolution of weight of cheater', 'Score', 'Weigth');
createPlot(g, x, poids);
[~, minPoids] = min(poids);
[~, maxPoids] = max(poids);
plot(x(minPoids), poids(minPoids), '.', 'Color', color, 'MarkerSize', 32);
plot(x(maxPoids), poids(maxPoids), '.', 'Color', color, 'MarkerSize', 32);
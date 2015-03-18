clear all;
close all;
clc;
addpath('Old');

X1 = [4.2 4.5 2.8; 3.4 3.3 4.9];
X2 = [4.3 4.4 2.8; 3.3 3.4 4.8];

%% Ancienne version

A  = ones(size(X1));
[r1, w1] = ReputationV2(X1, A);
[r2, w2] = ReputationV2(X2, A);

%% Nouvelle version
X = cat(3, X1, X2);
A = ones(size(X));
[W R d T] = MultiReputationV2(permute(X, [2 3 1]), A);


%% Moyenne
meanX = round(mean(X, 2)*100)/100;
newMean = round(permute(permute(R, [2 3 1])', [1 3 2])*100)/100;
oldMean = round(cat(3, r1, r2)*100)/100;

[n, m, k] = size(meanX);
[o, p] = size(newMean);

fprintf('------------- Basic Mean ------ New Mean ----- Old Mean \n\n');

for i = 1:n
    fprintf('Note %d ------------------------------------------------\n\n', i);
    for j = 1:m
        for l = 1:k
            fprintf('Team %d: \t %g \t\t  %g \t\t %g\n', l, meanX(l, j, i), newMean(l, j, i), oldMean(l, j, i));
        end
        %fprintf('Mean of Mean: %g \t\t%g', mean());
        fprintf('\n');
    end
end

means = [mean(meanX, 3); mean(newMean, 3); mean(oldMean, 3)];

fprintf('Gagnants ------------------------------------------------\n\n');
fprintf('Team 1: \t %g \t\t %g \t\t %g\n',  means(1), means(3), means(5));
fprintf('Team 2: \t %g \t\t %g \t\t %g\n',  means(2), means(4), means(6));




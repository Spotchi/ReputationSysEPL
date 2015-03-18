clear all;
close all;
clc;

X1 = [4.2 4.5 2.8; 3.4 3.3 4.9];
X2 = [4.3 4.4 2.8; 3.3 3.4 4.8];

%X1 = [2 4 1; 4 1 2];
%X2 = [1 1 5; 4 2 5];

X = cat(3, X1, X2);
meanX = round(mean(X, 2)*100)/100;

A = ones(size(X));

[W R d T] = MultiReputationV2(permute(X, [2 3 1]), A);




[n, m, k] = size(meanX);
newMean = permute(R, [2 3 1]);
newMean = round(permute(newMean', [1 3 2])*100)/100;
[o, p] = size(newMean);

fprintf('-------------- Basic Mean ------------ New Mean ------\n\n');

for i = 1:n
    fprintf('Note %d ----------------------------------------------\n\n', i);
    for j = 1:m
        for l = 1:k
            fprintf('Team %d: \t%g \t\t %g\n', l, meanX(l, j, i), newMean(l, j, i));
        end
        %fprintf('Mean of Mean: %g \t\t%g', mean());
        fprintf('\n');
    end
end


fprintf('----- New Mean -----\n\n');
for i = 1:o
    fprintf('------- Note %d -------\n\n', i)
    for j = 1:p
        fprintf('Team %d: %f\n', j, newMean(i, j));
    end
    fprintf('\n');
end

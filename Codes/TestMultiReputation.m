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

[W R d] = MultiReputationV2(permute(X, [2 3 1]), permute(A, [2 3 1]))

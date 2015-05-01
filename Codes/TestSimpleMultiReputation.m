clear all;
close all;
clc;

% Generate data
X1 = [4 0; 3 0];
A1 = X1 > 0;

X2 = [0 3; 0 3];
A2 = X2 > 0;

X = cat(3, X1, X2)
A = cat(3, A1, A2)

X = sparse(X);
A = sparse(A);

[W R d] = MultiReputationV2(X, A);

permute(R, [2 3 1])
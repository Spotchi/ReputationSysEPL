clear all;
close all;
clc;

% Données dans la thèse.
X = [3.3 4.2; 3.4 4.5; 4.9 2.8]';

% Initialization
[n, m] =  size(X);
A = ones(n, m);

%[r, w, iter] = ReputationV2(X, A)

[r, t, iter] = ReputationV1(X', A', [1 1 1]');

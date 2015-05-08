clear;
close all;
clc;

addpath('../');

%% Load File
M = dlmread('data/hotels.txt', '/');

%% Create Matrix
M(:,1:3) = M(:,1:3) + 1;
X = zeros(max(M(:,1)), max(M(:,2)), max(M(:,3)));
A = X;
idx = sub2ind(size(X), M(:,1), M(:,2), M(:,3));

X(idx) = M(:,4);
X(X < 0) = 0;
A(idx) = 1;

%% Dimensions
[n, m, k] = size(X);

%% Calculate basic mean
normalMean = sum(X)./sum(A);
normalMean(isnan(normalMean)) = 0;
normalMean = permute(normalMean, [2 3 1]);
totalNormalMean = mean(normalMean, 2);

%% Run Reputation
tic;
[W, R, d, coeff, iter] = MultiReputation(X, A);
toc;
clear;
close all;
clc;

%% Generate data
addpath('../Generator');
addpath('../');
hotels;

%% Calculate basic mean
mean = sum(X)./sum(A);
mean(isnan(mean)) = 0;
mean = permute(mean, [2 3 1]);

%% Run Reputation
[W, R, d] = MultiReputation(X, A);
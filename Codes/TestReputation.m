clear all;
close all;
clc;

% Generate data
addpath('Generator');
students;

f = inline('1 - exp(-d)');
[r, t, W, d, iter] = Reputation(X', A', ones(size(X, 1), 1), f);
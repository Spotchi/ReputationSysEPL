clear all;
close all;
clc;

% Generate data
addpath('Generator');
students;

X = [4.2 4.5 2.8; 3.4 3.3 4.9];
A = ones(2, 3);

f = inline('1 - exp(-d)');
[r, t, W, d, iter] = Reputation(X', A', ones(size(X, 1), 1), f);
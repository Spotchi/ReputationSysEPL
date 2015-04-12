clear all;
close all;
clc;

X = zeros(3, 3);
X = [5 0 4; 0 4 3; 0 3 3];
A = X > 0;
[m, k] = size(X);
clear all;
close all;
clc;

% Datas
E = [4.2 3.4; 4.5 3.3; 2.8 4.9];

% Initialization
[n, m] =  size(E);
A = ones(n, m);
T = ones(n, m);
c = 5*ones(m, 1);

[r, t, iter] = Reputation(E, A, c)

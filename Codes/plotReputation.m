clear all;
close all;

[X, Y] = meshgrid(-1:0.01:1, -1:0.01:1);
K = size(X, 1);
k = 1/(log((2*pi)^K));

Z = X.^2 + Y.^2;

%mesh(X, Y, 1 - k*Z)
contourf(X, Y, 1 - k*Z)
axis square;


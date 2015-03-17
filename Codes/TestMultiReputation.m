clear all;
close all;
clc;

X1 = [4.2 4.5 2.8; 3.4 3.3 4.9];
X2 = [4.4 4.4 2.9; 3.3 3.3 4.8];

round(mean(X1')*100)/100;
round(mean(X2')*100)/100;

%X1 = [2 4 1; 4 1 2];
%X2 = [1 1 5; 4 2 5];

X = cat(3, X1, X2);
X = permute(X, [2 3 1]);

[W R d T] = MultiReputation(X, ones(size(X)));
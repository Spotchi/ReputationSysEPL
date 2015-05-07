%
% Generate nxmxk matrix where n, m and k are respectively the numbers of
% judges, hotels and characteristics.
%
clear;
close all;
clc;

% total # of judges
n = 10;

% total # of hotels
m = 5;

% # of characteristics
k = 3;

% Min and max score
scoreRange = [0 5];

%% Create matrix
A = randi([0 1], n, m, k);
X = randi(scoreRange, n, m, k).*A;

for i=1:k
    if X(:, :, 1) == zeros(n, m)
        error('no one voted for the characteristics %d', i);
    end
end

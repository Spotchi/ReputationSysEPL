clear;
close all;
clc;

addpath('../');

%% Load File
M = dlmread('data/data_exclude_1_and_2_and_3.txt', '/');

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

%% Run Reputation
tic;
[W, R, d] = MultiReputationV2(X, A, 1/(log(2*pi))/9);
toc;

%% Compare
meanDiff = normalMean - R;
lessThanZero = sum(sum(meanDiff < 0));
greatherThanZero = sum(sum(meanDiff > 0));
equalToZero = sum(sum(meanDiff == 0));

%% Initial value of variance
Rmean = sum(bsxfun(@times, X, ones(n, 1)))./sum(bsxfun(@times, A, ones(n,1)));
Rmean(isnan(Rmean))= 0 ;
dij = bsxfun(@minus, X, bsxfun(@times, A, Rmean));
mi = sum(sum(A, 2), 3);
initiald = sum(sum(dij.^2, 2), 3)./mi;
fig = createFigure('Values of d at initial stage');
hist(initiald);
%print(strcat(images_dir,'dInitial.eps'),'-depsc');
%close(fig);

%% Distributions of least and most reliable judges
unreliableUser = find(W == min(W));


for l=1:k
    ind1 = find(A(unreliableUser, :, l) == 1);
    title = sprintf('Distribution of ratings for least reliable user (user %d) for characteristic %d with k = %f',unreliableUser, l, 1/(log(2*pi))/9);
    fig = createFigure(title);
    hist(X(unreliableUser, ind1, l));
    filename = sprintf('distribLeastRelK%fc1.eps',1/(log(2*pi))/9);
    %print(strcat(images_dir,filename),'-depsc');
    %close( fig);
    pause;
end

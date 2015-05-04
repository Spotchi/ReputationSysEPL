parseData;

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
initiald = getInitialVariance(X, A);
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

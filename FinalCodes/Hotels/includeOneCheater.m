parseHotelsData;

WInitial = W;
RInitial = R;
dInitial = d;

%% Include cheater
cheater = zeros(m, k);
cheater(1, :) = 5;

X(n + 1, :, :) = cheater;
A(n + 1, :, :) = ones(m, k);

%% Run Reputation
tic;
[W, R, d] = MultiReputationMaxK(X, A);
toc;

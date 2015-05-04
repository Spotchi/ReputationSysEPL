parseData;

%% Include cheater
cheater = zeros(m, k);
cheater(1, :) = 5;

X(n + 1, :, :) = cheater;
A(n + 1, :, :) = ones(m, k);

%% Run Reputation
tic;
[W, R, d] = MultiReputationV2(X, A, 1/(log(2*pi))/10);
toc;

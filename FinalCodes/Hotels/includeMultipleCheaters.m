parseHotelsData;

WInitial = W;
RInitial = R;
dInitial = d;

%# of cheaters
l = 200;

%% Include cheater
cheaters = zeros(l, m, k);

%% Select random hotel for cheaters
randomHotels = randperm(m, l);

for i=1:l
    cheaters(i, randomHotels(i), :) = 5;
end

X = [X; cheaters];
A = [A; ones(l, m, k)];

%% Calculate basic mean
normalMeanWithCheaters = sum(X)./sum(A);
normalMeanWithCheaters(isnan(normalMeanWithCheaters)) = 0;
normalMeanWithCheaters = permute(normalMeanWithCheaters, [2 3 1]);
totalNormalMeanWithCheaters = mean(normalMeanWithCheaters, 2);

%% Run Reputation
tic;
[W, R, d] = MultiReputation(X, A);
toc;
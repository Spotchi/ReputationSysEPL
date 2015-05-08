parseHotelsData;

WInitial = W;
RInitial = R;
dInitial = d;
coeffInitial = coeff;
iterInitial = iter;

% # of cheaters
l = m;

% # of defavorized hotels
r = 10;

%% Include cheater
cheaters = zeros(l, m, k);
hotels   = zeros(l, m, k);

%% Select random hotel favorized by cheaters
randomHotel = randperm(m, l);
randomSpamHotels = zeros(l, r);

for i=1:l
    
    cheaters(i, randomHotel(i), :) = 5;
    hotels(i, randomHotel(i), :) = 1;

    % Select random hotels
    randomHotels = randperm(m, r);
    ids = randomHotels ~= randomHotel(i);
    
    % On ne prend pas l'hotel déjà choisit (facultatif)
    while sum(ids) ~= length(ids)
        randomHotels = randperm(m, r);
        ids = randomHotels ~= randomHotel(i);
    end
    
    randomSpamHotels(i, :) = randomHotels;
    hotels(i, randomHotels, :) = 1;
end

X = [X; cheaters];
A = [A; hotels];

%% Calculate basic mean
normalMeanWithCheaters = sum(X)./sum(A);
normalMeanWithCheaters(isnan(normalMeanWithCheaters)) = 0;
normalMeanWithCheaters = permute(normalMeanWithCheaters, [2 3 1]);
totalNormalMeanWithCheaters = mean(normalMeanWithCheaters, 2);

%% Run Reputation
tic;
[W, R, d, coeff, iter] = MultiReputation(X, A);
toc;
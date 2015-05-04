parseData;


%% Before
tic;
ki = 1/(log(2*pi))/10;
[WBefore, RBefore, dBefore] = MultiReputationMaxK(X, A);
toc;


% # of cheaters
l = 100;

%% Include cheater
cheaters = zeros(l, m, k);
hotels   = zeros(l, m, k);
defavorized = 0:l;
ids = cumsum(defavorized);
id = ids(end);

%% Select random hotel favorized by cheaters
randomHotel = randperm(m, l);

for i=1:l
    cheaters(i, randomHotel(i), :) = 5;
    hotels(i, randomHotel(i), :) = 1;
    
    randomHotels = randperm(m, i);
    ids = randomHotels ~= randomHotel(i);
    
    while sum(ids) ~= length(ids)
        randomHotels = randperm(m, i);
        ids = randomHotels ~= randomHotel(i);
    end
    
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
[W, R, d] = MultiReputationMaxK(X, A);
toc;

%% Poids négatifs ?
isValidWeights(W);

%% Interpretation
initiald = getInitialVariance(X, A);
unreliableJudges = getMostUnreliableJudges(W);
reliableJudges = getMostReliableJudges(W);

%% Histogram
h = createFigure('Histogram of the weight of users who have voted');
set(findall(gcf,'type','text'),'FontSize',30,'fontWeight','bold', 'FontName', 'Times New Roman');
minBar = 0.8;
hCheaters = histogram(W(W < minBar), 0:0.1:minBar);
hold on;
hBefore = histogram(WBefore(WBefore < minBar), 0:0.1:minBar);
legend({'With spammers', 'After iterations'});

combined = cell(length(hCheaters.Values), 1);

for j=1:length(hCheaters.Values)
    combined(j) = {strcat(num2str(hCheaters.Values(j)), char(' -  '), ' ', [' ', num2str(hBefore.Values(j))])};
end

text(hCheaters.BinEdges(1:end-1) + 0.05, hCheaters.Values/2, num2cell(combined), 'horizontalalignment','center');

diffHist = hCheaters.Values - hBefore.Values;
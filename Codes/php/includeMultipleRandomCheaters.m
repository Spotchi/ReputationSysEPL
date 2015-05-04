parseData;

%% Before
tic;
ki = 1/(log(2*pi))/10;
[WBefore, RBefore, dBefore] = MultiReputationMaxK(X, A);
toc;

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

    % On choisit aléatoirement l autre hotel
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
[W, R, d] = MultiReputationMaxK(X, A);
toc;

%% Poids négatifs ?
isValidWeights(W);

%% Interpretation
initiald = getInitialVariance(X, A);
unreliableJudges = getMostUnreliableJudges(W);
reliableJudges = getMostReliableJudges(W);

%% Histogram
h = createFigure('Histogram of the weight of users who have voted with one spammer for each hotel');
set(findall(gcf,'type','text'),'FontSize',30,'fontWeight','bold', 'FontName', 'Times New Roman');
minBar = 0.9;
hCheaters = histogram(W(W < minBar), 0:0.1:minBar);
hold on;
hBefore = histogram(WBefore(WBefore < minBar), 0:0.1:minBar);
legend({'With cheaters', 'Without cheaters'});

combined = cell(length(hCheaters.Values), 1);

for j=1:length(hCheaters.Values)
    combined(j) = {strcat(num2str(hCheaters.Values(j)), char(' -  '), ' ', [' ', num2str(hBefore.Values(j))])};
end

text(hCheaters.BinEdges(1:end-1) + 0.05, hCheaters.Values/2, num2cell(combined), 'horizontalalignment','center');

diffHist = hCheaters.Values - hBefore.Values;

g = createFigure('Score of hotels', 'Sorted hotels', 'Score');
[sortedNormalMeanWithCheaters, iSorted] = sort(totalNormalMeanWithCheaters);
h1 = createPlot(g, 1:size(iSorted, 1), sortedNormalMeanWithCheaters);
h3 = plot(randomHotel, 5*ones(size(randomHotel)), '*', 'Color', 'blue');

plot(randomSpamHotels(:), zeros(size(randomSpamHotels(:), 1), 1), '*', 'Color', 'blue');

meanHotelAfterIter = mean(R, 2);
[sortedMeanWithCheatersAfterIter, iSortedAfterIter] = sort(meanHotelAfterIter);
h2 = createPlot(g, 1:size(iSorted, 1), sortedMeanWithCheatersAfterIter);
legend([h1 h2 h3], {'With spammer', 'After iteration', 'Spam'});
parseData;

%% Before
tic;
ki = 1/(log(2*pi))/10;
[WBefore, RBefore, dBefore] = MultiReputationMaxK(X, A);
toc;

% # of cheaters
l = 1000;

% # of defavorized hotels
r = 4;

%% Include cheater
cheaters = zeros(l, m, k);
hotels   = zeros(l, m, k);
randomSpamHotels = zeros(m, l);

%% Select random hotel favorized by cheaters
for i=1:l
    randomHotels = randperm(m, r);
    
    a = 0;
    b = 5;
    
    randomCaract = randperm(k, randi([1 k]));
    cheaters(i, randomHotels, randomCaract) = ((b-a).*rand(1, r, size(randomCaract, 1)) + a);
    
    hotels(i, randomHotels, randomCaract) = 1;
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
minBar = 1;
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

%% Spammermean
spammerMean = sum(cheaters)./sum(hotels);
spammerMean(isnan(spammerMean)) = 0;
spammerMean = permute(spammerMean, [2 3 1]);
totalSpammerMean = mean(spammerMean, 2);
idss = find(totalSpammerMean > 0);

g = createFigure('Score of hotels', 'Sorted hotels', 'Score');
[sortedNormalMeanWithCheaters, iSorted] = sort(totalNormalMeanWithCheaters);
h1 = createPlot(g, 1:size(iSorted, 1), sortedNormalMeanWithCheaters);
%h3 = plot(1:size(totalSpammerMean(idss)), sort(totalSpammerMean(idss)), '*', 'Color', 'blue');

reorderCheaters = cheaters(:, iSorted, :);
reorderHotels = hotels(:, iSorted, :);
for i = 1:l
    for j = 1:m
        hotelMean = sum(reorderCheaters(i, j, :))./sum(reorderHotels(i, j, :));
        
        if hotelMean ~= 0
            h3 = plot(j, hotelMean, 'x', 'Color', 'blue');
        end
    end
end

meanHotelAfterIter = mean(R, 2);
[sortedMeanWithCheatersAfterIter, iSortedAfterIter] = sort(meanHotelAfterIter);
h2 = createPlot(g, 1:size(iSorted, 1), sortedMeanWithCheatersAfterIter);
legend([h1 h2 h3], {'With spammer', 'After iteration', 'Spam'});
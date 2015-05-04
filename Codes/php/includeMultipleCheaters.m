parseData;

%% Before
tic;
ki = 1/(log(2*pi))/10;
[WBefore, RBefore, dBefore] = MultiReputationMaxK(X, A);
toc;

% 0.1% of cheaters
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
legend({'With spammers', 'Without spammers'});

combined = cell(length(hCheaters.Values), 1);

for j=1:length(hCheaters.Values)
    combined(j) = {strcat(num2str(hCheaters.Values(j)), char(' -  '), ' ', [' ', num2str(hBefore.Values(j))])};
end

text(hCheaters.BinEdges(1:end-1) + 0.05, hCheaters.Values/2, num2cell(combined), 'horizontalalignment','center');

diffHist = hCheaters.Values - hBefore.Values;

g = createFigure('Score of hotels', 'Sorted hotels', 'Score');
[sortedNormalMeanWithCheaters, iSorted] = sort(totalNormalMeanWithCheaters);
h1 = createPlot(g, 1:size(iSorted, 1), sortedNormalMeanWithCheaters);
h3 = plot(randomHotels, 5*ones(size(randomHotels)), '*', 'Color', 'blue');
spammerId = repmat([1:m]', l);
plot(spammerId(:), zeros(l*size(spammerId, 1), 1), '*', 'Color', 'blue');

meanHotelAfterIter = mean(R, 2);
[sortedMeanWithCheatersAfterIter, iSortedAfterIter] = sort(meanHotelAfterIter);
h2 = createPlot(g, 1:size(iSorted, 1), sortedMeanWithCheatersAfterIter);
legend([h1 h2 h3], {'With spammer', 'After iterations', 'Spam'});
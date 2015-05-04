parseData;

%% Before
tic;
ki = 1/(log(2*pi))/10;
[WBefore, RBefore, dBefore] = MultiReputationMaxK(X, A);
toc;


% # of cheaters for the same hotel
l = 10;

%% Include cheater
cheaters = zeros(l, m, k);
hotels = zeros(l, m, k);

%% Select random hotel for cheaters
randomHotel = randperm(m, 1);
cheaters(:, randomHotel, :) = 5;
hotels(:, randomHotel, : ) = 1;

X = [X; cheaters];
A = [A; hotels];


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
minBar = 1;
hCheaters = histogram(W(W < minBar), 0:0.1:minBar);
hold on;
hBefore = histogram(WBefore(WBefore < minBar), 0:0.1:minBar);
legend({'With spammers', 'After iterations'});
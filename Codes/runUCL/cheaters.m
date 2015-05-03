 close all;

images_dir = '../../rapport/images/cheaters/ch';
[mat,A,B,~,~,~] = createTensor('nopreprocess');
[nJudges,nStud,nCarac] = size(mat);

[pmat,App,Bpp,teachers,students,caracs] = createTensor('meanSelect');
Rmean = getReputationVector(ones(nJudges,1),mat,A);
Rmean = reshape(Rmean,nStud,nCarac);
[wold,~,~,kold] = MultiReputationMaxK(pmat,App,B);
Rold = getReputationVector(wold,mat,A);
Rold = reshape(Rold,nStud,nCarac);
%
%% First try : 2 stupid cheaters
%
nCheaters = 3;
nSmartCheaters = 0;
[matcheat, pmatcheat, Appcheat, Acheat, Bcheat] = cheatMatrix( nCheaters, nSmartCheaters );

[w,~,~,k] = MultiReputationMaxK(pmatcheat,Appcheat,Bcheat);
R = getReputationVector(w,matcheat,Acheat);
R = reshape(R,nStud,nCarac);
normalMean = getReputationVector(ones(nJudges+nCheaters+nSmartCheaters,1),matcheat,Acheat);
normalMean = reshape(normalMean,nStud,nCarac);


%% Weights of judges
filename = 'weightsStupid.eps';
title = sprintf('Weights of judges with k = %f',k);
fig = createFigure(title);
bar(w);
print(strcat(images_dir,filename),'-depsc');
close(fig);

 %% Compare reputations computed with normal mean

fig = createFigure(['Compare new reputation with former : characteristic 1, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],1)),(R([FavoredStud,DisfavoredStud],1)),(normalMean([FavoredStud,DisfavoredStud],1))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepStupidc1.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);

fig = createFigure(['Compare new reputation with former : characteristic 2, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],2)),(R([FavoredStud,DisfavoredStud],2)),...
    (normalMean([FavoredStud,DisfavoredStud],2))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepStupidc2.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);

%
%% Second try : two subtle cheaters
%
nCheaters = 0;
nSmartCheaters = 3;
[matcheat, pmatcheat, Appcheat, Acheat, Bcheat] = cheatMatrix( nCheaters, nSmartCheaters );

[w,~,~,k] = MultiReputationMaxK(pmatcheat,Appcheat,Bcheat);
R = getReputationVector(w,matcheat,Acheat);
R = reshape(R,nStud,nCarac);
normalMean = getReputationVector(ones(nJudges+nCheaters+nSmartCheaters,1),matcheat,Acheat);
normalMean = reshape(normalMean,nStud,nCarac);


%% Weights of judges
filename = 'weightsSmart.eps';
title = sprintf('Weights of judges with k = %f',k);
fig = createFigure(title);
bar(w);
print(strcat(images_dir,filename),'-depsc');
close(fig);

 %% Compare reputations computed with normal mean

fig = createFigure(['Compare new reputation with former : characteristic 1, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],1)),(R([FavoredStud,DisfavoredStud],1)),(normalMean([FavoredStud,DisfavoredStud],1))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepSmartc1.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);

fig = createFigure(['Compare new reputation with former : characteristic 2, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],2)),(R([FavoredStud,DisfavoredStud],2)),...
    (normalMean([FavoredStud,DisfavoredStud],2))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepSmartc2.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);

%
%% Third try : a mix of the 2
%
nCheaters = 1;
nSmartCheaters = 2;
[matcheat, pmatcheat, Appcheat, Acheat, Bcheat] = cheatMatrix( nCheaters, nSmartCheaters );

[w,~,d,k] = MultiReputationMaxK(pmatcheat,Appcheat,Bcheat);
R = getReputationVector(w,matcheat,Acheat);
R = reshape(R,nStud,nCarac);
normalMean = getReputationVector(ones(nJudges+nCheaters+nSmartCheaters,1),matcheat,Acheat);
normalMean = reshape(normalMean,nStud,nCarac);


%% Weights of judges
filename = 'weightsMix.eps';
title = sprintf('Weights of judges with k = %f',k);
fig = createFigure(title);
bar(w);
print(strcat(images_dir,filename),'-depsc');
close(fig);

 %% Compare reputations computed with normal mean

fig = createFigure(['Compare new reputation with former : characteristic 1, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],1)),(R([FavoredStud,DisfavoredStud],1)),(normalMean([FavoredStud,DisfavoredStud],1))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepMixc1.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);

fig = createFigure(['Compare new reputation with former : characteristic 2, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],2)),(R([FavoredStud,DisfavoredStud],2)),...
    (normalMean([FavoredStud,DisfavoredStud],2))]);
set(barplot(2),'FaceColor','g');
filename = 'compareRepMixc2.eps';
print(strcat(images_dir,filename),'-depsc');
close(fig);




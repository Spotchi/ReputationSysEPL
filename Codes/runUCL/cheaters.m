 close all;

images_dir = '../../rapport/images/cheaters/ch';
[mat,A,B,teachers,students,caracs] = createTensor('nopreprocess');
[nJudges,nStud,nCarac] = size(mat);

[pmat,App,B,teachers,students,caracs] = createTensor('meanVarianceSelect');
Rmean = getReputationVector(ones(nJudges,1),mat,A);
Rmean = reshape(Rmean,nStud,nCarac);
[wold,Rold,~,kold] = MultiReputationMaxK(pmat,App,B);
Rold = getReputationVector(wold,mat,A);
Rold = reshape(Rold,nStud,nCarac);

% 
% [w,R,d,k] = MultiReputationMaxK(pmat,App,B);
% R = getReputationVector(w,mat,A);
% R = reshape(R,nStud,nCarac);
% 
% %% Weights of judges
% filename = sprintf('weightsk%d.eps',10000*k);
% title = sprintf('Weights of judges with k = %f',k);
% fig = createFigure(title);
% bar(w);
% % print(strcat(images_dir,filename),'-depsc');
% close(fig);
% 
%  %% Compare reputations computed with normal mean
% normalMean = getReputationVector(ones(nJudges,1),mat,A);
% normalMean = reshape(normalMean,nStud,nCarac);
% 
% fig = createFigure(['Compare reputation with means : characteristic 1, k = ',num2str(k)]);
% barplot = bar([(normalMean(:,1)),(R(:,1))]);
% set(barplot(2),'FaceColor','g');
% filename = sprintf('compareRepc1K%d.eps',10000*k);
% % print(strcat(images_dir,filename),'-depsc');
% close(fig);
%     
% fig = createFigure(['Compare reputation with means : characteristic 2, k = ',num2str(k)]);
% barplot = bar([(normalMean(:,2)),(R(:,2))]);
% set(barplot(2),'FaceColor','g');
% filename = sprintf('compareRepc2K%d.eps',10000*k);
% % print(strcat(images_dir,filename),'-depsc');
% close(fig);

%% Add some cheaters
nCheaters = 0;
nSmartCheaters = 0;
matcheat = zeros(nJudges + nCheaters + nSmartCheaters,nStud,nCarac);
pmatcheat = matcheat;
Appcheat = matcheat;
Acheat = matcheat;
Bcheat = matcheat;
for i=1:nJudges
    for j = 1:nStud
        for k = 1:nCarac
            matcheat(i,j,k) = mat(i,j,k);
            pmatcheat(i,j,k) = pmat(i,j,k);
            Appcheat(i,j,k) = App(i,j,k);
            Acheat(i,j,k) = A(i,j,k);
            Bcheat(i,j,k) = B(i,j,k);
        end
    end
end

nCarac = 1;
DisfavoredStud = [1 2 3 9 11 13 14 15 17 19 21 22 24 25 30];
FavoredStud = [4 10];
Other = [];%[31 32 34 35 36 37 38 39 40];


for i = nJudges+1 : nJudges + nCheaters
    mean = zeros(nCarac,1);
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            matcheat(i,FavoredStud(j),k) = 20;
            Acheat(i,FavoredStud(j),k) = 1;
            Appcheat(i,FavoredStud(j),k) = 1;   
            Bcheat(i,FavoredStud(j),k) = 1;
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            matcheat(i,DisfavoredStud(j),k) = 8;
            Acheat(i,DisfavoredStud(j),k) = 1;
            Appcheat(i,DisfavoredStud(j),k) = 1;
            Bcheat(i,DisfavoredStud(j),k) = 1;
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            matcheat(i,Other(j),k) = Rmean(Other(j),k);
            Acheat(i,Other(j),k) = 1;
            Appcheat(i,Other(j),k) = 1;            
            Bcheat(i,Other(j),k) = 1;
            mean(k) = mean(k) + Rmean(Other(j),k);
        end
    end
    mean = mean + length(FavoredStud)*20 + length(DisfavoredStud) * 8;
    mean = mean/(length(FavoredStud)+length(DisfavoredStud)+length(Other));
    
    var = zeros(nCarac,1);
    for j = 1:nStud
        for k = 1:nCarac
            var(k) = var(k) + Acheat(i,j,k)*(mean(k)-matcheat(i,j,k))^2;
        end
    end
    var = var/(length(FavoredStud)+length(DisfavoredStud)+length(Other));
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            pmatcheat(i,FavoredStud(j),k) = (20-mean(k))/var(k);
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            pmatcheat(i,DisfavoredStud(j),k) = (8-mean(k))/var(k);
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            pmatcheat(i,Other(j),k) = (Rmean(Other(j),k)-mean(k))/var(k);
        end
    end
end
for i = nJudges+nCheaters+1 : nJudges + nCheaters + nSmartCheaters
    mean = zeros(nCarac,1);
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            matcheat(i,FavoredStud(j),k) = 17;
            Acheat(i,FavoredStud(j),k) = 1;
            Appcheat(i,FavoredStud(j),k) = 1;           
            Bcheat(i,FavoredStud(j),k) = 1;
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            matcheat(i,DisfavoredStud(j),k) = 12;
            Acheat(i,DisfavoredStud(j),k) = 1;
            Appcheat(i,DisfavoredStud(j),k) = 1;
            Bcheat(i,DisfavoredStud(j),k) = 1;
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            matcheat(i,Other(j),k) = Rmean(Other(j),k);
            Acheat(i,Other(j),k) = 1;
            Appcheat(i,Other(j),k) = 1;            
            Bcheat(i,Other(j),k) = 1;
            mean(k) = mean(k) + Rmean(Other(j),k);
        end
    end
    mean = mean + length(FavoredStud)*17 + length(DisfavoredStud) * 12;
    mean = mean/(length(FavoredStud)+length(DisfavoredStud)+length(Other));
    
    var = zeros(nCarac,1);
    for j = 1:nStud
        for k = 1:nCarac
            var(k) = var(k) + Acheat(i,j,k)*(mean(k)-matcheat(i,j,k))^2;
        end
    end
    var = var/(length(FavoredStud)+length(DisfavoredStud)+length(Other));
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            pmatcheat(i,FavoredStud(j),k) = (17-mean(k))/var(k);
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            pmatcheat(i,DisfavoredStud(j),k) = (12-mean(k))/var(k);
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            pmatcheat(i,Other(j),k) = (Rmean(Other(j),k)-mean(k))/var(k);
        end
    end
end
nCarac = 2;

[w,~,d,k] = MultiReputationMaxK(pmatcheat,Appcheat,Bcheat);
R = getReputationVector(w,matcheat,Acheat);
R = reshape(R,nStud,nCarac);
RnewMean = getReputationVector(ones(nJudges+nCheaters+nSmartCheaters,1),matcheat,Acheat);
RnewMean = reshape(RnewMean,nStud,nCarac);


%% Weights of judges
filename = sprintf('weightsk%d.eps',10000*k);
title = sprintf('Weights of judges with k = %f',k);
fig = createFigure(title);
bar(w);
print(strcat(images_dir,filename),'-depsc');
% close(fig);

 %% Compare reputations computed with normal mean
normalMean = getReputationVector(ones(nJudges+nCheaters+nSmartCheaters,1),matcheat,Acheat);
normalMean = reshape(normalMean,nStud,nCarac);

fig = createFigure(['Compare new reputation with former : characteristic 1, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],1)),(R([FavoredStud,DisfavoredStud],1)),(RnewMean([FavoredStud,DisfavoredStud],1))]);
set(barplot(2),'FaceColor','g');
filename = sprintf('compareRepc1K%d.eps',10000*k);
print(strcat(images_dir,filename),'-depsc');
% close(fig);

fig = createFigure(['Compare new reputation with former : characteristic 2, k = ',num2str(k)]);
barplot = bar([(Rold([FavoredStud,DisfavoredStud],2)),(R([FavoredStud,DisfavoredStud],2)),...
    (RnewMean([FavoredStud,DisfavoredStud],2))]);
set(barplot(2),'FaceColor','g');
filename = sprintf('compareRepc2K%d.eps',10000*k);
print(strcat(images_dir,filename),'-depsc');
% close(fig);



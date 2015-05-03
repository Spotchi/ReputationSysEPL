function [matcheat, pmatcheat, Appcheat, Acheat, Bcheat] = cheatMatrix( nCheaters, nSmartCheaters )
%CHEATMATRIX 
[mat,A,B,~,~,~] = createTensor('nopreprocess');
[nJudges,nStud,nCarac] = size(mat);

[pmat,App,Bpp,~,~,~] = createTensor('meanSelect');
%% Add some cheaters
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
FavoredStud = [4 10 31 32 34];
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
    
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            pmatcheat(i,FavoredStud(j),k) = (20-mean(k));
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            pmatcheat(i,DisfavoredStud(j),k) = (8-mean(k));
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            pmatcheat(i,Other(j),k) = (Rmean(Other(j),k)-mean(k));
        end
    end
end
for i = nJudges+nCheaters+1 : nJudges + nCheaters + nSmartCheaters
    mean = zeros(nCarac,1);
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            matcheat(i,FavoredStud(j),k) = 19;
            Acheat(i,FavoredStud(j),k) = 1;
            Appcheat(i,FavoredStud(j),k) = 1;           
            Bcheat(i,FavoredStud(j),k) = 1;
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            matcheat(i,DisfavoredStud(j),k) = 9;
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
    mean = mean + length(FavoredStud)*19 + length(DisfavoredStud) * 9;
    mean = mean/(length(FavoredStud)+length(DisfavoredStud)+length(Other));
    
    for j = 1:length(FavoredStud)
        for k = 1:nCarac
            pmatcheat(i,FavoredStud(j),k) = (19-mean(k));
        end
    end
    for j = 1:length(DisfavoredStud)
        for k = 1:nCarac
            pmatcheat(i,DisfavoredStud(j),k) = (9-mean(k));
        end
    end
    for j = 1:length(Other)
        for k = 1:nCarac
            pmatcheat(i,Other(j),k) = (Rmean(Other(j),k)-mean(k));
        end
    end
end

end


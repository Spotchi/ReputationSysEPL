close all;
% clear all;
clc;
    
images_dir = '../../rapport/images/noPreprocess/';
%% Retrieve ratings tensor
[mat,A,teachers,students,caracs] = createTensor('nopreprocess');
[nJudges,nStud,nCarac] = size(mat);

%% Mean ratings for the teachers
meanTeachers = zeros(nJudges,nCarac);
nVotes = zeros(nJudges,nCarac); % The corresponding number of votes for i and k
for i = 1:nJudges
    for k = 1 : nCarac
        for j = 1 : nStud
            meanTeachers(i,k) = meanTeachers(i,k) + A(i,j,k)*mat(i,j,k);
            nVotes(i,k) = nVotes(i,k)+A(i,j,k);
        end
        meanTeachers(i,k) = meanTeachers(i,k)/nVotes(i,k);
    end
end
meanTeachers(nVotes == 0) = 0;
fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,1)),meanTeachers(:,1)');
print(strcat(images_dir,'meanTeachersC1.eps'),'-depsc');
close(fig);
fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,2)),meanTeachers(:,2)');
print(strcat(images_dir,'meanTeachersC2.eps'),'-depsc');
close(fig);

%% Initial values of variance
Rmean = sum(bsxfun(@times, mat, ones(nJudges,1)))./sum(bsxfun(@times, A, ones(nJudges,1)));
Rmean(isnan(Rmean))= 0 ;
dij = bsxfun(@minus, mat, bsxfun(@times, A, Rmean));
mi = sum(sum(A, 2), 3);
initiald = sum(sum(dij.^2, 2), 3)./mi;
fig = createFigure('Values of d at initial stage');
hist(initiald);
print(strcat(images_dir,'dInitial.eps'),'-depsc');
close(fig);

%% Results for different values of k
k = [0.066 0.02 0.001];
for i = 1 : length(k)
    [w,R,d] = MultiReputationV2(mat,A,k(i));
    %% Weights of judges
    filename = sprintf('weightsk%d.eps',10000*k(i));
    title = sprintf('Weights of judges with k = %f',k(i));
    fig = createFigure(title);
    bar(w);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Distributions of least and most reliable judges
    unreliableTeacher = find(w == min(w));
    ind1 = find(A(unreliableTeacher,:,1)==1);
    ind2 = find(A(unreliableTeacher,:,2)==1);
    
    title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 1 with k = %f',unreliableTeacher,k(i));
    fig = createFigure(title);
    hist(mat(unreliableTeacher,ind1,1));
    filename = sprintf('distribLeastRelK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close( fig);
    
    title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 2 with k = %f',unreliableTeacher,k(i));
    fig = createFigure(title);
    hist(mat(unreliableTeacher,ind2,2));
    filename = sprintf('distribLeastRelK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    
    mostReliableTeacher = find(w == max(w));
    ind1 = find(A(mostReliableTeacher,:,1)==1);
    ind2 = find(A(mostReliableTeacher,:,2)==1);
    
    title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 1 with k = %f',mostReliableTeacher,k(i));
    fig = createFigure(title);
    hist(mat(mostReliableTeacher,ind1,1));
    filename = sprintf('distribMostRelK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 2 with k = %f',mostReliableTeacher,k(i));
    fig = createFigure(title);
    hist(mat(mostReliableTeacher,ind2,2));
    filename = sprintf('distribMostRelK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    %% Histograms of notes and reputations
    fig = createFigure('Histogram of initial ratings for characteristic 1');
    ratings1 = mat(A(:,:,1)==1);
    hist(ratings1(:)');
    filename = sprintf('ratingsHistK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of initial ratings for characteristic 2');
    ind = find(A(:,:,2)==1);
    ratings2 = mat(:,:,2);
    ratings2 = ratings2(:)';
    hist(ratings2(ind));
    filename = sprintf('ratingsHistK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of reputations for characteristic 1');
    hist(R(:,1));
    filename = sprintf('reputationHistK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of reputations for characteristic 2');
    hist(R(:,1));
    filename = sprintf('reputationHistK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of d after iteration');
    hist(d);
    filename = sprintf('dHistK%d.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Influence of number of ratings on weights
    totalRatings = nVotes(:,1)+nVotes(:,2);
    title = sprintf('Influence of number of ratings on weight,k = %f',k(i));
    fig = createFigure(title);
    plot(totalRatings,w,'*');
    filename = sprintf('numRatvsWK%d.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
end

images_dir = '../../rapport/images/preprocess/pp';
[pmat,A,teachers,students,caracs] = createTensor('meanVariance');

%% Initial values of variance
Rmean = sum(bsxfun(@times, pmat, ones(nJudges,1)))./sum(bsxfun(@times, A, ones(nJudges,1)));
Rmean(isnan(Rmean))= 0 ;
dij = bsxfun(@minus, mat, bsxfun(@times, A, Rmean));
mi = sum(sum(A, 2), 3);
initiald = sum(sum(dij.^2, 2), 3)./mi;
fig = createFigure('Values of d at initial stage');
hist(initiald);
print(strcat(images_dir,'dInitial.eps'),'-depsc');
close(fig);


%% Mean ratings for the teachers
meanTeachers = zeros(nJudges,nCarac);
nVotes = zeros(nJudges,nCarac); % The corresponding number of votes for i and k
for i = 1:nJudges
    for k = 1 : nCarac
        for j = 1 : nStud
            meanTeachers(i,k) = meanTeachers(i,k) + A(i,j,k)*pmat(i,j,k);
            nVotes(i,k) = nVotes(i,k)+A(i,j,k);
        end
        meanTeachers(i,k) = meanTeachers(i,k)/nVotes(i,k);
    end
end
meanTeachers(nVotes == 0) = 0;
fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,1)),meanTeachers(:,1)');
print(strcat(images_dir,'meanTeachersC1.eps'),'-depsc');
close(fig);
fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,2)),meanTeachers(:,2)');
print(strcat(images_dir,'meanTeachersC2.eps'),'-depsc');
close(fig);

%% Results for different values of k
k = [0.2 0.1 0.066];
for i = 1 : length(k)
    [w,R,d] = MultiReputationV2(pmat,A,k(i));
    %% Weights of judges
    filename = sprintf('weightsk%d.eps',10000*k(i));
    title = sprintf('Weights of judges with k = %f',k(i));
    fig = createFigure(title);
    bar(w);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Distributions of least and most reliable judges
    unreliableTeacher = find(w == min(w));
    ind1 = find(A(unreliableTeacher,:,1)==1);
    ind2 = find(A(unreliableTeacher,:,2)==1);
    
    title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 1 with k = %f',unreliableTeacher,k(i));
    fig = createFigure(title);
    hist(pmat(unreliableTeacher,ind1,1));
    filename = sprintf('distribLeastRelK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close( fig);
    
    title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 2 with k = %f',unreliableTeacher,k(i));
    fig = createFigure(title);
    hist(pmat(unreliableTeacher,ind2,2));
    filename = sprintf('distribLeastRelK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    
    mostReliableTeacher = find(w == max(w));
    ind1 = find(A(mostReliableTeacher,:,1)==1);
    ind2 = find(A(mostReliableTeacher,:,2)==1);
    
    title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 1 with k = %f',mostReliableTeacher,k(i));
    fig = createFigure(title);
    hist(pmat(mostReliableTeacher,ind1,1));
    filename = sprintf('distribMostRelK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 2 with k = %f',mostReliableTeacher,k(i));
    fig = createFigure(title);
    hist(pmat(mostReliableTeacher,ind2,2));
    filename = sprintf('distribMostRelK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    %% Histograms of notes and reputations
    fig = createFigure('Histogram of initial ratings for characteristic 1');
    ratings1 = pmat(A(:,:,1)==1);
    hist(ratings1(:)');
    filename = sprintf('ratingsHistK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of initial ratings for characteristic 2');
    ind = find(A(:,:,2)==1);
    ratings2 = pmat(:,:,2);
    ratings2 = ratings2(:)';
    hist(ratings2(ind));
    filename = sprintf('ratingsHistK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of reputations for characteristic 1');
    hist(R(:,1));
    filename = sprintf('reputationHistK%dc1.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of reputations for characteristic 2');
    hist(R(:,1));
    filename = sprintf('reputationHistK%dc2.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of d after iteration');
    hist(d);
    filename = sprintf('dHistK%d.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Influence of number of ratings on weights
    totalRatings = nVotes(:,1)+nVotes(:,2);
    title = sprintf('Influence of number of ratings on weight,k = %f',k(i));
    fig = createFigure(title);
    plot(totalRatings,w,'*');
    filename = sprintf('numRatvsWK%d.eps',10000*k(i));
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
end
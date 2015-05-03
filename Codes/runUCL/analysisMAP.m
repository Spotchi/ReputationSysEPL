close all;
% clear all;
clc;
    
images_dir = '../../rapport/images/noPreprocess/';
%% Retrieve ratings tensor
[mat,A,B,teachers,students,caracs] = createTensor('nopreprocess');
[nJudges,nStud,nCarac] = size(mat);
% 
% %% Mean ratings for the teachers
% meanTeachers = zeros(nJudges,nCarac);
% varTeachers = zeros(nJudges,nCarac);
% nVotes = zeros(nJudges,nCarac); % The corresponding number of votes for i and k
% for i = 1:nJudges
%     for k = 1 : nCarac
%         for j = 1 : nStud
%             meanTeachers(i,k) = meanTeachers(i,k) + A(i,j,k)*mat(i,j,k);
%             nVotes(i,k) = nVotes(i,k)+A(i,j,k);
%         end
%         meanTeachers(i,k) = meanTeachers(i,k)/nVotes(i,k);
%         for j = 1 : nStud
%             varTeachers(i,k) = varTeachers(i,k) + A(i,j,k)*(mat(i,j,k)-meanTeachers(i,k))^2;
%         end
%         varTeachers(i,k) = varTeachers(i,k)/nVotes(i,k);
%     end
% end
% meanTeachers(nVotes == 0) = 0;
% varTeachers(nVotes == 0) = 0;
% fig = createFigure('Mean ranking values for characteristic 1','Teachers');
% bar(meanTeachers(:,1));
% print(strcat(images_dir,'meanTeachersC1.eps'),'-depsc');
% close(fig);
% fig = createFigure('Mean ranking values for characteristic 1','Teachers');
% bar(meanTeachers(:,2));
% print(strcat(images_dir,'meanTeachersC2.eps'),'-depsc');
% close(fig);
% 
% fig = createFigure('Variance of ratings values for characteristic 1','Teachers');
% bar(varTeachers(:,1));
% print(strcat(images_dir,'varTeachersC1.eps'),'-depsc');
% close(fig);
% 
% fig = createFigure('Variance of ratings values for characteristic 2','Teachers');
% bar(varTeachers(:,2));
% print(strcat(images_dir,'varTeachersC2.eps'),'-depsc');
% close(fig);
% 
% %% Initial values of variance
% Rmean = sum(bsxfun(@times, mat, ones(nJudges,1)))./sum(bsxfun(@times, A, ones(nJudges,1)));
% Rmean(isnan(Rmean))= 0 ;
% dij = bsxfun(@minus, mat, bsxfun(@times, A, Rmean));
% mi = sum(sum(A, 2), 3);
% initiald = sum(sum(dij.^2, 2), 3)./mi;
% fig = createFigure('Values of d at initial stage');
% hist(initiald);
% print(strcat(images_dir,'dInitial.eps'),'-depsc');
% close(fig);
% 
% %% Results for different values of k
% k = [0.066 0.02 0.001];
% for i = 1 : length(k)
%     [w,R,d] = MultiReputationV2(mat,A,k(i));
%     %% Weights of judges
%     filename = sprintf('weightsk%d.eps',10000*k(i));
%     title = sprintf('Weights of judges with k = %f',k(i));
%     fig = createFigure(title);
%     bar(w);
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     %% Distributions of least and most reliable judges
%     unreliableTeacher = find(w == min(w));
%     ind1 = find(A(unreliableTeacher,:,1)==1);
%     ind2 = find(A(unreliableTeacher,:,2)==1);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 1 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(mat(unreliableTeacher,ind1,1));
%     filename = sprintf('distribLeastRelK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close( fig);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 2 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(mat(unreliableTeacher,ind2,2));
%     filename = sprintf('distribLeastRelK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     
%     mostReliableTeacher = find(w == max(w));
%     ind1 = find(A(mostReliableTeacher,:,1)==1);
%     ind2 = find(A(mostReliableTeacher,:,2)==1);
%     
%     title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 1 with k = %f',mostReliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(mat(mostReliableTeacher,ind1,1));
%     filename = sprintf('distribMostRelK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 2 with k = %f',mostReliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(mat(mostReliableTeacher,ind2,2));
%     filename = sprintf('distribMostRelK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     %% Histograms of notes and reputations
%     fig = createFigure('Histogram of initial ratings for characteristic 1');
%     ratings1 = mat(A(:,:,1)==1);
%     hist(ratings1(:)');
%     filename = sprintf('ratingsHistK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of initial ratings for characteristic 2');
%     ind = find(A(:,:,2)==1);
%     ratings2 = mat(:,:,2);
%     ratings2 = ratings2(:)';
%     hist(ratings2(ind));
%     filename = sprintf('ratingsHistK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of reputations for characteristic 1');
%     hist(R(:,1));
%     filename = sprintf('reputationHistK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of reputations for characteristic 2');
%     hist(R(:,1));
%     filename = sprintf('reputationHistK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of d after iteration');
%     hist(d);
%     filename = sprintf('dHistK%d.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     %% Influence of number of ratings on weights
%     totalRatings = nVotes(:,1)+nVotes(:,2);
%     title = sprintf('Influence of number of ratings on weight,k = %f',k(i));
%     fig = createFigure(title);
%     plot(totalRatings,w,'*');
%     filename = sprintf('numRatvsWK%d.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
% end

images_dir = '../../rapport/images/preprocess/pp';
[pmat,A,B,teachers,students,caracs] = createTensor('mean'); 

%% Initial values of variance
Rmean = sum(bsxfun(@times, mat, ones(nJudges,1)))./sum(bsxfun(@times, A, ones(nJudges,1)));
Rmean(isnan(Rmean))= 0 ;
dij = bsxfun(@minus, pmat, bsxfun(@times, A, Rmean));
mi = sum(sum(A, 2), 3);
initiald = sum(sum(dij.^2, 2), 3)./mi;
fig = createFigure('Values of d at initial stage');
hist(initiald);
print(strcat(images_dir,'dInitial.eps'),'-depsc');
close(fig);


%% Mean and variance of ratings for the teachers
meanTeachers = zeros(nJudges,nCarac);
varTeachers = zeros(nJudges,nCarac);
nVotes = zeros(nJudges,nCarac); % The corresponding number of votes for i and k
for i = 1:nJudges
    for k = 1 : nCarac
        for j = 1 : nStud
            meanTeachers(i,k) = meanTeachers(i,k) + A(i,j,k)*pmat(i,j,k);
            nVotes(i,k) = nVotes(i,k)+A(i,j,k);
        end
        meanTeachers(i,k) = meanTeachers(i,k)/nVotes(i,k);
        for j = 1 : nStud
            varTeachers(i,k) = varTeachers(i,k) + A(i,j,k)*(pmat(i,j,k)-meanTeachers(i,k))^2;
        end
        varTeachers(i,k) = varTeachers(i,k)/nVotes(i,k);
    end
end
meanTeachers(nVotes == 0) = 0;
varTeachers(nVotes == 0) = 0;

fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,1)),meanTeachers(:,1)');
print(strcat(images_dir,'meanTeachersC1.eps'),'-depsc');
close(fig);
fig = createFigure('Mean ranking values for characteristic 1','Teachers');
stem(1:length(meanTeachers(:,2)),meanTeachers(:,2)');
print(strcat(images_dir,'meanTeachersC2.eps'),'-depsc');
close(fig);

fig = createFigure('Variance of ratings values for characteristic 1','Teachers');
bar(varTeachers(:,1));
print(strcat(images_dir,'varTeachersC1.eps'),'-depsc');
close(fig);

fig = createFigure('Variance of ratings values for characteristic 2','Teachers');
bar(varTeachers(:,2));
print(strcat(images_dir,'varTeachersC2.eps'),'-depsc');
close(fig);

% Results for max value of k
    [w,~,d,k] = MultiReputationMaxK(pmat,A);
    R = getReputationVector(w,mat,A);
    R = reshape(R,nStud,nCarac);
    
    %% Weights of judges
    filename = sprintf('weightsk%bx.eps',k);
    title = sprintf('Weights of judges with k = %f',k);
    fig = createFigure(title);
    bar(w);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Distributions of least and most reliable judges
    unreliableTeacher = find(w == min(w));
    ind1 = find(A(unreliableTeacher,:,1)==1);
    ind2 = find(A(unreliableTeacher,:,2)==1);
    
    title = {sprintf('Histogram of ratings for judge %d',unreliableTeacher);
             sprintf('for characteristic 1 with k = %f',k)};
    fig = createFigure(title);
    hist(pmat(unreliableTeacher,ind1,1));
    filename = sprintf('distribLeastRelK%bxc1.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close( fig);
    
    title = {sprintf('Histogram of ratings for judge %d',unreliableTeacher);
             sprintf('for characteristic 2 with k = %f',k)};
    fig = createFigure(title);
    hist(pmat(unreliableTeacher,ind2,2));
    filename = sprintf('distribLeastRelK%bxc2.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    
    mostReliableTeacher = find(w == max(w));
    ind1 = find(A(mostReliableTeacher,:,1)==1);
    ind2 = find(A(mostReliableTeacher,:,2)==1);
    
    title = {sprintf('Histogram of ratings for judge %d',mostReliableTeacher);
    sprintf('for characteristic 1 with k = %f',k)};    
    fig = createFigure(title);
    hist(pmat(mostReliableTeacher,ind1,1));
    filename = sprintf('distribMostRelK%bxc1.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    title = {sprintf('Histogram of ratings for judge %d',mostReliableTeacher);
             sprintf('for characteristic 2 with k = %f',k)};
    fig = createFigure(title);
    hist(pmat(mostReliableTeacher,ind2,2));
    filename = sprintf('distribMostRelK%bxc2.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    %% Histograms of notes and reputations
    fig = createFigure({'Histogram of initial ratings';'for characteristic 1'});
    ratings1 = pmat(A(:,:,1)==1);
    hist(ratings1(:)');
    filename = sprintf('ratingsHistK%bxc1.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure({'Histogram of initial ratings';'for characteristic 2'});
    ind = find(A(:,:,2)==1);
    ratings2 = pmat(:,:,2);
    ratings2 = ratings2(:)';
    hist(ratings2(ind));
    filename = sprintf('ratingsHistK%bxc2.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure({'Histogram of reputations';'for characteristic 1'});
    hist(R(:,1));
    filename = sprintf('reputationHistK%bxc1.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure({'Histogram of reputations';'for characteristic 2'});
    hist(R(:,1));
    filename = sprintf('reputationHistK%bxc2.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure('Histogram of d after iteration');
    hist(d);
    filename = sprintf('dHistK%bx.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Influence of number of ratings on weights
    totalRatings = nVotes(:,1)+nVotes(:,2);
    title = {'Influence of number of ratings';sprintf('on weight,k = %f',k)};
    fig = createFigure(title);
    plot(totalRatings,w,'*');
    filename = sprintf('numRatvsWK%bx.eps',10000*k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);


images_dir = '../../rapport/images/preprocessSelect/pps';
[pmat,App,B,teachers,students,caracs] = createTensor('meanSelect');


    [w,ppR,d,k] = MultiReputationMaxK(pmat,App);
    R = getReputationVector(w,mat,A);
    R = reshape(R,nStud,nCarac);
    
    %% Weights of judges
    filename = sprintf('weightsk%bx.eps',k);
    title = sprintf('Weights of judges with k = %f',k);
    fig = createFigure(title);
    bar(w);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
%     %% Distributions of least and most reliable judges
%     unreliableTeacher = find(w == min(w));
%     ind1 = find(A(unreliableTeacher,:,1)==1);
%     ind2 = find(A(unreliableTeacher,:,2)==1);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 1 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(unreliableTeacher,ind1,1));
%     filename = sprintf('distribLeastRelK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close( fig);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 2 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(unreliableTeacher,ind2,2));
%     filename = sprintf('distribLeastRelK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     
%     mostReliableTeacher = find(w == max(w));
%     ind1 = find(A(mostReliableTeacher,:,1)==1);
%     ind2 = find(A(mostReliableTeacher,:,2)==1);
%     
%     title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 1 with k = %f',mostReliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(mostReliableTeacher,ind1,1));
%     filename = sprintf('distribMostRelK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsrc');
%     close(fig);
%     
%     title = sprintf('Distribution of ratings for most reliable judge (judge %d) for characteristic 2 with k = %f',mostReliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(mostReliableTeacher,ind2,2));
%     filename = sprintf('distribMostRelK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     %% Histograms of notes and reputations
%     fig = createFigure('Histogram of initial ratings for characteristic 1');
%     ratings1 = pmat(A(:,:,1)==1);
%     hist(ratings1(:)');
%     filename = sprintf('ratingsHistK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
 
%     fig = createFigure('Histogram of reputations for characteristic 1');
%     hist(R(:,1));
%     filename = sprintf('reputationHistK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of reputations for characteristic 2');
%     hist(R(:,1));
%     filename = sprintf('reputationHistK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
%     fig = createFigure('Histogram of d after iteration');
%     hist(d);
%     filename = sprintf('dHistK%d.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
%     
    %% Influence of number of ratings on weights
    totalRatings = nVotes(:,1)+nVotes(:,2);
    title = {'Influence of number of ratings';sprintf( 'on weight,k = %f',k)};
    fig = createFigure(title);
    plot(totalRatings,w,'*');
    filename = sprintf('numRatvsWK%bx.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    %% Compare reputations computed with normal mean
    normalMean = getReputationVector(ones(nJudges,1),mat,A);
    normalMean = reshape(normalMean,nStud,nCarac);
    
    fig = createFigure({'Compare reputation with means :';[' characteristic 1, k = ',num2str(k)]});
    barplot = bar([(normalMean(20:40,1)),(R(20:40,1))]);
    set(barplot(2),'FaceColor','g');
    filename = sprintf('compareRepc1K%bx.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    fig = createFigure({'Compare reputation with means : ';['characteristic 2, k = ',num2str(k)]});
    barplot = bar([(normalMean(20:40,2)),(R(20:40,2))]);
    set(barplot(2),'FaceColor','g');
    filename = sprintf('compareRepc2K%bx.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
%     unreliableTeacher = find(w == min(w));
%     ind1 = find(A(unreliableTeacher,:,1)==1);
%     ind2 = find(A(unreliableTeacher,:,2)==1);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 1 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(unreliableTeacher,ind1,1),-4:4);
%     filename = sprintf('distribLeastRelK%dc1.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close( fig);
%     
%     title = sprintf('Distribution of ratings for least reliable judge (judge %d) for characteristic 2 with k = %f',unreliableTeacher,k(i));
%     fig = createFigure(title);
%     hist(pmat(unreliableTeacher,ind2,2),-4:4);
%     filename = sprintf('distribLeastRelK%dc2.eps',10000*k(i));
%     print(strcat(images_dir,filename),'-depsc');
%     close(fig);
% 

    ratUnr = reshape(pmat(unreliableTeacher,ind1,1),length(ind1),1);
    diff = ratUnr -ppR(ind1,1);
    
    title = {sprintf('Ratings-Reputations for judge %d',unreliableTeacher);sprintf(' for characteristic 1 with k = %f',k)};
    fig = createFigure(title);
    bar(diff);
    filename = sprintf('diffRaReLeastK%bxc1.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    ratUnr = reshape(pmat(unreliableTeacher,ind2,2),length(ind2),1);
    diff = ratUnr -ppR(ind2,2);
    
    title = {sprintf('Ratings-Reputations for judge %d',unreliableTeacher);sprintf(' for characteristic 2 with k = %f',k)};
    fig = createFigure(title);
    bar(diff);
    filename = sprintf('diffRaReLeastK%bxc2.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    mostReliableTeacher = find(w == max(w));
    ind1 = find(A(mostReliableTeacher,:,1)==1);
    ind2 = find(A(mostReliableTeacher,:,2)==1);
    
    ratUnr = reshape(pmat(mostReliableTeacher,ind1,1),length(ind1),1);
    diff = ratUnr -ppR(ind1,1);
    
    title = {sprintf('Ratings-Reputations for judge %d',mostReliableTeacher);sprintf(' for characteristic 1 with k = %f',k)};
    fig = createFigure(title);
    bar(diff);
    filename = sprintf('diffRaReMostK%bxc1.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    
    ratUnr = reshape(pmat(mostReliableTeacher,ind2,2),length(ind2),1);
    diff = ratUnr -ppR(ind2,2);
    
    title = {sprintf('Ratings-Reputations for judge %d',mostReliableTeacher);sprintf(' for characteristic 2 with k = %f',k)};
    fig = createFigure(title);
    bar(diff);
    filename = sprintf('diffRaReMostK%bxc2.eps',k);
    print(strcat(images_dir,filename),'-depsc');
    close(fig);
    








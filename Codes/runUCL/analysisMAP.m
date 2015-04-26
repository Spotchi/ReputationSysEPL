[mat,A] = createTensor();
[nJudges,nStud,nCarac] = size(mat);
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
% stem(1:length(meanTeachers(:,1)),meanTeachers(:,1)');hold on;
% stem(1:length(meanTeachers(:,2)),meanTeachers(:,2)');

[w,R,d] = MultiReputationV2(mat,A,0.01);

bar(d);
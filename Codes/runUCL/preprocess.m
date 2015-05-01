
function pmat = preprocess(mat,A)

[nJudges,nStud,nCarac] = size(mat);

%% Mean ratings for the teachers
meanTeachers = zeros(nJudges,nCarac);
varTeachers = zeros(nJudges,nCarac);
nVotes = zeros(nJudges,nCarac); % The corresponding number of votes for i and k
for i = 1:nJudges
    for k = 1 : nCarac
        for j = 1 : nStud
            meanTeachers(i,k) = meanTeachers(i,k) + A(i,j,k)*mat(i,j,k);
            nVotes(i,k) = nVotes(i,k)+A(i,j,k);
        end
        meanTeachers(i,k) = meanTeachers(i,k)/nVotes(i,k);
        for j = 1 : nStud
            varTeachers(i,k) = varTeachers(i,k) + A(i,j,k)*(mat(i,j,k)-meanTeachers(i,k))^2;
        end
        varTeachers(i,k) = varTeachers(i,k)/nVotes(i,k);
    end
end
meanTeachers(nVotes == 0) = 0;
varTeachers(nVotes ==0) = 0;

pmat = mat;
for i = 1 : nJudges
    for j = 1 : nStud
        for k = 1: nCarac
            if A(i,j,k)
                pmat(i,j,k) = (pmat(i,j,k)-meanTeachers(i,k))/sqrt(varTeachers(i,k));
            end
        end
    end
end
end
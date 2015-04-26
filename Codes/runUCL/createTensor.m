function [mat,A,teachers,NOMAList,carac] = createTensor()
[a,NOMAList] = runUCL;
[nT,nStud] = size(a);
nCarac = 2;
mat = zeros(nT,nStud-1,nCarac);
for i = 1 : nT
    for j = 2 : nStud
        nc1 = 0;
        nc2 = 0;
        sum1 = 0;
        sum2 = 0;
        [~,nEntries] = size(a{i,j});
        for l = 1 : nEntries
            if ~isempty(strfind(a{i,j}{1,l}{1,1},'P'))
                sum2 = sum2 + a{i,j}{1,l}{1,2};
                nc2 = nc2 + 1 ;
            else
                sum1 = sum1 + a{i,j}{1,l}{1,2};
                nc1 = nc1 + 1;
            end
        end
        if nc1 > 0
            mat(i,j-1,1) = sum1/nc1;
        end
        if nc2 > 0
            mat(i,j-1,2) = sum2/nc2;
        end
    end
end
mat(isnan(mat)) = 0;
A = ones(size(mat));
A(mat==0) = 0;
teachers = a(:,1)';
carac = {1,2};
end
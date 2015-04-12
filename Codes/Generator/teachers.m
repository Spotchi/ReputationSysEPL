simpleTest;
%students;

% # of course per teacher
p = [1 2 3];
coursesPerTeacher = [];

while (sum(coursesPerTeacher) < k)
    
    % Select random in p
    msize = numel(p);
    idx = randperm(msize);
    pi = p(idx(1:1));
    
    if (sum([coursesPerTeacher pi]) > k) 
        continue;
    end
    
    coursesPerTeacher = [coursesPerTeacher pi];
    
end


n = size(coursesPerTeacher, 2);
bigX = zeros(n, m, k);
bigA = zeros(n, m, k);

j = 1;
for l = 1:n
    
    i = coursesPerTeacher(l);
    
    x = X(:, j:j + i - 1);
    a = A(:, j:j + i - 1);
    
    left = repmat(zeros(m, 1), 1, j - 1);
    right = repmat(zeros(m, 1), 1, k - size(x, 2) - j + 1);
    
    x = [left x right];
    a = [left a right];
    
    
    bigX(l, :, :) = x;
    bigA(l, :, :) = a;
    
    j = i + j;
end


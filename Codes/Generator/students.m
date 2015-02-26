% total # of students
n = 200;

% total # of courses
m = 20;

% # of courses per student
k = 6;

X = zeros(n, m);
A = zeros(n, m);

for i = 1:n
    average  = randi([7, 17], 1, 1);
    variance = 3;
    
    % Plus one or min one course
    kv = randi([-1 1]);
    
    % Random courses
    a = [zeros(1, m - k - kv) ones(1, k + kv)];
    a = a(randperm(m));
    A(i, :) = a;
    
    % Random mean and points around mean
    y = variance.*randn(1, m) + average;
    X(i, :) = y.*a;
end

averages = sum(X, 2) ./ sum(A, 2);
average = mean(averages);

success   = sum(averages >= 10);
unsuccess = sum(averages < 10);

histfit(averages)


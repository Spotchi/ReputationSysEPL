clear all;
close all;
clc;

% total # of students
m = 10;

% total # of courses
k = 5;

% # of courses per student
l = 3;

X = zeros(m, k);
A = zeros(m, k);

for i = 1:m
    average  = randi([7, 17], 1, 1);
    variance = 3;
    
    % Plus one or min one course
    lv = randi([-1 1]);
    
    % Random courses
    a = [zeros(1, k - l - lv) ones(1, l + lv)];
    a = a(randperm(k));
    A(i, :) = a;
    
    % Random mean and points around mean
    y = variance.*randn(1, k) + average;
    X(i, :) = y.*a;
end

% Cleans values
X(X < 0)  = 0;
X(X > 20) = 20;

averages = sum(X, 2) ./ sum(A, 2);
average = mean(averages);

success   = sum(averages >= 10);
unsuccess = sum(averages < 10);

%histfit(averages)


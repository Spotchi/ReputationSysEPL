% Generate data
addpath('Generator');
teachers;

[W R d] = MultiReputationV2(bigX, bigA);

permute(R, [2 3 1])
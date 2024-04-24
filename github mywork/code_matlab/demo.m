% Clear workspace, close all figures, and clear command window
clear; clc; close all;

% Add necessary paths
if isempty(strfind(path, './funs'))
    addpath('./funs');
end
if isempty(strfind(path, '../code/MLdatasets/'))
    addpath('../code/MLdatasets/');
end

% Load data
load("iris_uni.mat");
c = length(unique(Y));  % Determine the number of unique classes

% Set parameter
lambda = 0.1;

% Construct and symmetrize the adjacency matrix
A0 = constructW_PKN(X', 6);
A = (A0 + A0') / 2;  % Ensure A is symmetric

% Preallocate result arrays for performance improvement
re_sum = zeros(30, 1);

% Perform clustering operations
for jj = 1:30
    [label_out, obj, F_original, labelY_comparison] = work(A, c, 30, lambda);
    result(jj, :) = ClusteringMeasure_new(Y, label_out);
    re_sum(jj) = result(jj, :).ACC;  % Store the accuracy
end

% Calculate and display the mean of accuracies
meanACC = mean(re_sum);
fprintf('Mean ACC: %.2f%%\n', meanACC * 100);

clear;
close all;
clc;

% Add necessary paths
% addpath('../code/MLdatasets/');
addpath('funs');

% Load dataset and set parameters
datasetFile = 'iris_uni';
load(datasetFile);
% Y =gnd;
% X=fea;
% Y = double(int16(labels)+1);
% X = im2double(data);
numClasses = max(Y);
[num,dim] = size(X);
X = zscore(X);  % Standardize the features

% Parameters for adjacency matrix construction
t = 100;
A0 = constructW_PKN(X', t);
A = (A0 + A0') / 2;  % Ensure symmetry
numIter = 30;
lambda = logspace(-6, 6, 13);  % Vector of lambda values
numRepeats = 30;

% Choose the algorithm: 1 for work (N-DSC), 2 for work_Ratio (R-CDC)
algorithmChoice = 1;  % Set to 1 or 2 as needed

% Prepare file for output
outputFilename = sprintf('%s_largexp_mywork.txt', datasetFile);
% If choose the R-CDC
% outputFilename = sprintf('%s_largexp_myworkR.txt', datasetFile);
fid = fopen(outputFilename, 'a');
fprintf(fid, 'Run on %s\n', datasetFile);

% Main computation loop
results = zeros(numRepeats, 7, length(lambda));
time_lsc = zeros(numRepeats, 1);
entropyNorm = zeros(numRepeats, 1);
SDCS = zeros(numRepeats, 1);

for l = 1:length(lambda)
    for k = 1:numRepeats
        startTime = clock;

        % Select function based on the choice
        if algorithmChoice == 1
            [labels, ~, ~] = work(A, numClasses, numIter, lambda(l));
        else
            [labels, ~, ~] = work_Ratio(A, numClasses, numIter, lambda(l));
        end

        endTime = clock;
        time_lsc(k) = etime(endTime, startTime);
        result(k,1:7) = ClusteringMeasure1(Y, labels);
        tbl = tabulate(labels);
        clus = tbl(:,1);
        num_clus = tbl(:,2);
        nk = num_clus/num;
        counts = num_clus;
        ct = counts-(num/numClasses);
        ct2 = sum(ct.*ct);
        SDCS(k) = sqrt(ct2/(numClasses-1));
    end
    lsctim = mean(time_lsc);
    mer=mean(result);
    sttd = std(result);
    mer=mer.*100;
    sttd=sttd.*100;
    mSD = mean(SDCS);
    stdSD = std(SDCS);
    fprintf(fid, 'lambda = %0.6f ', lambda(l));
    fprintf(fid, 'time = %0.6f ACC = %0.2f(%0.2f) NMI = %0.2f(%0.2f) Purity = %0.2f(%0.2f) P = %0.2f(%0.2f) R = %0.2f(%0.2f) F = %0.2f(%0.2f) RI = %0.2f(%0.2f)  SDCS = %0.2f(%0.2f)\r\n',lsctim,mer(1),sttd(1),mer(2),sttd(2),mer(3),sttd(3),mer(4),sttd(4),mer(5),sttd(5),mer(6),sttd(6),mer(7),sttd(7),mSD,stdSD);

end

fclose(fid);

% % Save accuracy data to a CSV file
% folderPath = './mywork';
% if ~exist(folderPath, 'dir')
%     mkdir(folderPath);
% end
% filename = sprintf('%s/%s_lambda_acc.csv', folderPath, datasetFile);
% accMeans = squeeze(mean(results(:,1,:), 1)) * 100;
% T = table(lambda', accMeans, 'VariableNames', {'Lambda', 'Accuracy'});
% writetable(T, filename);

% clear matlab
clc;
clear all;
close all;

% load train/test image structure
load('data\train\output\train_resize.mat');
load('data\test\output\test_resize.mat');

% extract all features
addpath('src\');
[houghTrain, houghTest] = houghFeature();

% combine all features
trainFeatures = houghTrain;
testFeatures = houghTest;

% using svm to classify
addpath('libsvm\matlab\');
train_labels = zeros(1,trainData.count);
for i = 1 : trainData.count
    train_labels(i) = str2double(trainData.label{i});
end
test_labels = ones(1, testData.count) * (-1);

% Simplify
% train_labels = train_labels(1:100);
% test_labels = test_labels(1:100);
% trainFeatures = trainFeatures(1:100,:);
% testFeatures = testFeatures(1:100,:);
%

modelName = 'hough_v1';
if(exist(['src\cache\model_' modelName '.mat'], 'file'))
    load(['src\cache\model_' modelName '.mat']);
else
    model = svmtrain(train_labels',  trainFeatures, '-t 0 -c 0.01');
    save(['src\cache\model_' modelName '.mat'],'model');
end

[predicted_test_label, accuracy, decision_values] = svmpredict(test_labels', testFeatures, model);
fid = fopen('result.dat', 'w');
fprintf(fid, '%d \n', predicted_test_label);
fclose(fid);

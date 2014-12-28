function [ trainFeatures, testFeatures ] = houghFeature( )

if(exist('src\cache\hough.mat','file'))
    load('src\cache\hough.mat');
    return;
end

if(~exist('trainData','var'))
    load('data\train\output\train_resize.mat');
end
if(~exist('testData','var'))
    load('data\test\output\test_resize.mat');
end
Ncut = 10;
NumOfStrokes = 25;

numOfPic = trainData.count;
trainFeatures = zeros(numOfPic, Ncut*Ncut);
for i = 1:numOfPic
    disp([num2str(i) '/' num2str(numOfPic)]);
    H = hough(trainData.image{i});
    peaks = houghpeaks(H, NumOfStrokes, 'Threshold', 15, 'NHoodSize', [5 5]);
    highH = size(H, 1);
    widH = size(H, 2);
    for j = 1 : size(peaks, 1)
        B_x = floor((peaks(j, 1)-1)/ceil(highH/Ncut))+1;
        B_y = floor((peaks(j, 2)-1)/ceil(widH/Ncut))+1;
        trainFeatures(i, B_y + (B_x-1)*Ncut) = trainFeatures(i, B_y + (B_x-1)*Ncut) + 1;
    end
end

numOfPic = testData.count;
testFeatures = zeros(numOfPic, Ncut*Ncut);
for i = 1:numOfPic
    disp([num2str(i) '/' num2str(numOfPic)]);
    H = hough(testData.image{i});
    peaks = houghpeaks(H, NumOfStrokes, 'Threshold', 15, 'NHoodSize', [5 5]);
    highH = size(H, 1);
    widH = size(H, 2);
    for j = 1 : size(peaks, 1)
        B_x = floor((peaks(j, 1)-1)/ceil(highH/Ncut))+1;
        B_y = floor((peaks(j, 2)-1)/ceil(widH/Ncut))+1;
        testFeatures(i, B_y + (B_x-1)*Ncut) = testFeatures(i, B_y + (B_x-1)*Ncut) + 1;
    end
end
save('src\cache\hough.mat','trainFeatures','testFeatures');

end


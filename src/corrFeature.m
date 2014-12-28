function [ trainFeatures, testFeatures ] = corrFeature( )

if(exist('src\cache\corr.mat','file'))
    load('src\cache\corr.mat');
    return;
end

if(~exist('trainData','var'))
    load('data\train\output\train_resize.mat');
end
if(~exist('testData','var'))
    load('data\test\output\test_resize.mat');
end

[refinedWord, trans, scale, rot] = wordRefine();
eigenWord = cell(1,32);
for i = 1 : 32
    eigenWord{i} = zeros(122,105);
end
cnt = zeros(1,32);

for i = 1 : trainData.count
    disp([num2str(i) '/' num2str(trainData.count)]);
    label = str2double(trainData.label{i})+1;
    eigenWord{label} = eigenWord{label}+double(refinedWord{i});
    cnt(label) = cnt(label)+1;
end
for i = 1 : 32
    eigenWord{i} = eigenWord{i}/cnt(i);
%     eigenWord{i} = eigenWord{i}/norm(eigenWord{i},2);
end

image(eigenWord{31})

% trainFeatures = zeros(trainData.count,32);
% testFeatures = zeros(testData.count,32);
% shiftNum = 4;
% for i = 1 : trainData.count
%     disp([num2str(i) '/' num2str(trainData.count)]);
%     corr = -inf;
%     corrIdx = 0;
%     for j = 1 : 32
%         for k = 1 : shiftNum
%             for m = 1 : shiftNum
%                 transImg = imtranslate(trainData.image{i}, [(k-1)*(105/(shiftNum+1)), (m-1)*(122/(shiftNum+1))]);
%                 tcorr = sum(sum(double(transImg) .* eigenWord{j}));
%                 if(tcorr > corr)
%                     corr = tcorr;
%                     corrIdx = str2double(trainData.label{j});
%                 end
%             end
%         end
%     end
%     trainFeatures(i,corrIdx) = 1;
% end

end


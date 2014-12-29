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

% transNum = 1;
% transAway = 15;
% scaleNum = 2;
% rotNum = 2;
% n = testData.count;
% testImg = testData.image;
% disp('begin test');
% for i = 1 : n
%     disp([num2str(i) '/' num2str(testData.count)]);
%     alignedWord = centerAlign(testImg{i}, eigenWord{str2double(testLabel{i})+1});
%     coor = -inf;
%     tmpWord = alignedWord;
%     tmpTrans = 0;
%     tmpScale = 1;
%     tmpRot = 0;
%     for trow = -transNum : transNum
%         for tcol = -transNum : transNum
%             for scai = 1:scaleNum+1
%                 sca = 0.5 + (scai-1)/scaleNum;
%                 for roti = 1 : rotNum+1
% %                     disp(['trow=' num2str(trow) ' tcol=' num2str(tcol) ' scai=' num2str(scai) ' roti=' num2str(roti)]);
%                     ro = -45 + 90*(roti-1)/rotNum;
%                     twisted = twist(alignedWord,[tcol*size(alignedWord,2)/transAway trow*size(alignedWord,1)/transAway],sca,ro);
%                     tcoor = randCorr(twisted,mean_words{str2double(testLabel{i})+1},250);
%                     if(tcoor > coor)
%                         coor = tcoor;
%                         tmpWord = twisted;
%                         tmpTrans = [tcol*size(alignedWord,2)/transAway trow*size(alignedWord,1)/transAway];
%                         tmpScale = sca;
%                         tmpRot = ro;
%                     end
%                 end
%             end
%         end
%     end
%     words(i) = {tmpWord};
%     trans(i,:) = tmpTrans;
%     scale(i) = tmpScale;
%     rot(i) = tmpRot;
% end

test_lable = zeros(7372,1);
for i = 1 : testData.count
    i
    coor = -inf;
    for j = 1 : 32
        tcoor = randCorr(testData.image{i}, eigenWord{j}, 1000);
        if(tcoor > coor)
            coor = tcoor;
            test_lable(i,1) = j-1;
        end
    end
end
fid = fopen('coorRes.dat', 'w');
fprintf(fid, '%d \n', test_lable);
fclose(fid);

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


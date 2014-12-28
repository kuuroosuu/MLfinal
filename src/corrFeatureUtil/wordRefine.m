function [ words, trans, scale, rot ] = wordRefine( )

if(exist('src\cache\wordRefine.mat','file'))
    load('src\cache\wordRefine.mat');
    return;
end

if(~exist('trainData','var'))
    load('data\train\output\train_resize.mat');
end
if(~exist('testData','var'))
    load('data\test\output\test_resize.mat');
end

if(exist('src\cache\mean_words.mat', 'file'))
    load('src\cache\mean_words.mat');
else
    mean_words = cell(1,32);
    for i = 1 : 32
        mean_words{i} = zeros(122,105);
    end
    cnt = zeros(1,32);
    for i = 1 : trainData.count
        disp([num2str(i) '/' num2str(trainData.count)]);
        label = str2double(trainData.label{i})+1;
        mean_words{label} = mean_words{label}+double(trainData.image{i});
        cnt(label) = cnt(label)+1;
    end
    for i = 1 : 32
        mean_words{i} = mean_words{i}/cnt(i);
    end
    save('src\cache\mean_words.mat','mean_words');
end

% words = cell(1,trainData.count);
% trans = zeros(trainData.count,2);
% scale = zeros(1,trainData.count);
% rot = zeros(1,trainData.count);

transNum = 2;
transAway = 15;
scaleNum = 4;
rotNum = 4;
n = trainData.count;
trainImg = trainData.image;
trainLabel = trainData.label;
disp('begin refine');
parfor i = 1 : n
%     disp([num2str(i) '/' num2str(trainData.count)]);
    alignedWord = centerAlign(trainImg{i}, mean_words{str2double(trainLabel{i})+1});
    coor = -inf;
    tmpWord = alignedWord;
    tmpTrans = 0;
    tmpScale = 1;
    tmpRot = 0;
    for trow = -transNum : transNum
        for tcol = -transNum : transNum
            for scai = 1:scaleNum+1
                sca = 0.5 + (scai-1)/scaleNum;
                for roti = 1 : rotNum+1
%                     disp(['trow=' num2str(trow) ' tcol=' num2str(tcol) ' scai=' num2str(scai) ' roti=' num2str(roti)]);
                    ro = -45 + 90*(roti-1)/rotNum;
                    twisted = twist(alignedWord,[tcol*size(alignedWord,2)/transAway trow*size(alignedWord,1)/transAway],sca,ro);
                    tcoor = randCorr(twisted,mean_words{str2double(trainLabel{i})+1},1000);
                    if(tcoor > coor)
                        coor = tcoor;
                        tmpWord = twisted;
                        tmpTrans = [tcol*size(alignedWord,2)/transAway trow*size(alignedWord,1)/transAway];
                        tmpScale = sca;
                        tmpRot = ro;
                    end
                end
            end
        end
    end
    words(i) = {tmpWord};
    trans(i,:) = tmpTrans;
    scale(i) = tmpScale;
    rot(i) = tmpRot;
end
save('src\cache\wordRefine.mat','words','trans','scale','rot');

end


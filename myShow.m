function myShow( num, type)

if(type == 0)
    if(~exist('trainData','var'))
        load('data\train\output\train_resize.mat');
    end
    image(trainData.image{num});
else
    if(~exist('testData','var'))
        load('data\test\output\test_resize.mat');
    end
    image(testData.image{num});
end

end


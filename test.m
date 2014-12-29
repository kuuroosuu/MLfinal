close all;
eigenWord = zeros(122,105);
oriWord = zeros(122,105);
count = 0;
for i = 1 : 14744
    if(str2double(trainData.label{i}) == 22)
        eigenWord = eigenWord + double(words{i});
        oriWord = oriWord + double(trainData.image{i});
        count = count+1;
    end
end
image(eigenWord/count);
figure();
image(oriWord/count);
function [ corr ] = randCorr( mat1, mat2, sampleNum )

% make two matrices to be same size
wid = max(size(mat1,2), size(mat2,2));
high = max(size(mat1,1), size(mat2,1));
mat1 = [zeros(size(mat1,1),floor((wid-size(mat1,2))/2)) mat1 zeros(size(mat1,1),ceil((wid-size(mat1,2))/2))];
mat1 = [zeros(floor((high-size(mat1,1))/2),size(mat1,2)); mat1; zeros(ceil((high-size(mat1,1))/2),size(mat1,2))];
mat2 = [zeros(size(mat2,1),floor((wid-size(mat2,2))/2)) mat2 zeros(size(mat2,1),ceil((wid-size(mat2,2))/2))];
mat2 = [zeros(floor((high-size(mat2,1))/2),size(mat2,2)); mat2; zeros(ceil((high-size(mat2,1))/2),size(mat2,2))];

% normalize
mat1 = double(mat1);
mat2 = double(mat2);
mat1 = mat1/norm(mat1,2);
mat2 = mat2/norm(mat2,2);

% check if 'sampleNum' exist
if(~exist('sampleNum','var'))
    sampleNum = wid*high/10;
end

% generate sampleNum's points
samp = [randi(high,[sampleNum 1]) randi(wid,[sampleNum 1])];

% calculate correlation
corr = 0;
for i = 1 : sampleNum
    corr = corr + mat1(samp(i,1),samp(i,2))*mat2(samp(i,1),samp(i,2));
end

end


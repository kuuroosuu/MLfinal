function [ img1 ] = centerAlign( img1, img2 )

limg1 = logical(img1);
limg2 = logical(img2);

cnt1 = 0;
rowSum1 = 0;
colSum1 = 0;
cnt2 = 0;
rowSum2 = 0;
colSum2 = 0;
for i = 1 : size(img1,1)
    for j = 1 : size(img1,2)
        if(limg1(i,j))
            cnt1 = cnt1+1;
            rowSum1 = rowSum1+i;
            colSum1 = colSum1+j;
        end
        if(limg2(i,j))
            cnt2 = cnt2+1;
            rowSum2 = rowSum2+i;
            colSum2 = colSum2+j;
        end
    end
end
img1Cen = [rowSum1/(cnt1+1) colSum1/(cnt1+1)];
img2Cen = [rowSum2/(cnt2+1) colSum2/(cnt2+1)];
diff = img2Cen-img1Cen;
img1 = imtranslate(img1,[diff(2) diff(1)]);

end


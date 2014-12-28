function [ img3 ] = myResize( img )
%WORKONIMAGE Summary of this function goes here
%   Detailed explanation goes here

if (max(max(img))==0);  % 如果進來的圖是全黑的, 直接全黑傳回去
    img3=img;
    return ;
end


top=sum(img);% 橫的
side=sum(img, 2);% 直的

[row, col] = find( top ~= 0 );
leftBound=col(1);
rightBound=col(length(col));

[row, col] = find( side ~= 0 );
upBound=row(1);
downBound=row(length(row));



cutted=img(upBound:downBound, leftBound:rightBound);

[X Y]=size(cutted);
if (X/122>Y/105)    % 高度比寬度長 
    img2=imresize(cutted, 'OutputSize', [122 NaN]);
    [newX newY]=size(img2);
    leftBlackBarWidth=floor((105-newY)/2);
    img3=[zeros(122, leftBlackBarWidth) img2 zeros(122, 105-(newY+leftBlackBarWidth))];
else        % 寬度比高度長
    img2=imresize(cutted, 'OutputSize', [NaN 105]);
    [newX newY]=size(img2);
    topBlackBarHight=floor((122-newX)/2);
    img3=[zeros(topBlackBarHight, 105) ;
          img2 ;
          zeros(122-(newX+topBlackBarHight), 105)];
    
end

%figure;
%imshow(img3);
end


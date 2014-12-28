function [ img ] = twist( img, trans, scale, rot )

imgSize = size(img);
img = imtranslate(img,trans);
img = imresize(img,scale);
img = imrotate(img, rot);

if(size(img,1)>imgSize(1))
    img = img(ceil(size(img,1)/2)-floor(imgSize(1)/2):ceil(size(img,1)/2)+floor(imgSize(1)/2),:);
else if(size(img,1)<imgSize(1))
        img = [zeros(floor((imgSize(1)-size(img,1))/2),size(img,2)); img; zeros(ceil((imgSize(1)-size(img,1))/2),size(img,2))];
    end
end
if(size(img,2)>imgSize(2))
    img = img(:,ceil(size(img,2)/2)-floor(imgSize(2)/2):ceil(size(img,2)/2)+floor(imgSize(2)/2));
else if(size(img,2)<imgSize(2))
        img = [zeros(size(img,1),floor((imgSize(2)-size(img,2))/2)) img zeros(size(img,1),ceil((imgSize(2)-size(img,2))/2))];
    end
end
img = imresize(img, imgSize);

end


function [ img ] = turnToPic( data )

img = zeros(105, 122);

if(isempty(data))
    img = img';
    return;
end

dat = textscan(data,'%d:%f');
index = cell2mat(dat(1));
shade = cell2mat(dat(2));

img(index) = shade;       
img = uint8(img*255).';   % 注意最後要加一個轉置, 否則字是倒的

end


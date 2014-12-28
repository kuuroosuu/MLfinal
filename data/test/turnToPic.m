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
img = uint8(img*255).';   % �`�N�̫�n�[�@����m, �_�h�r�O�˪�

end


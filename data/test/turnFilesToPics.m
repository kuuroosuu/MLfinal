function [ imgs ] = turnFilesToPics( ~ )

imgs.image = {};
fid = fopen('test.dat');
i = 1;
while 1
    i
    line = fgetl(fid);  % �C��Ū�i�@�� (�@�Ӧr)
    if ~ischar(line), break, end    % if�w�gŪ������ɮ�, ���X�j��
    cat = sscanf(line, '%s', 1);  % Ū�i�C��}�Y����������
    imgs.image = [imgs.image myResize(turnToPic(line(length(cat)+1:length(line))))];    % ��������ҥH�~��data��ifunction�ন��
    i = i+1;
end
imgs.count = i-1;
fclose(fid);

end


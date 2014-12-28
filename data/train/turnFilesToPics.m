function [ imgs ] = turnFilesToPics( ~ )

imgs.label = {};
imgs.image = {};
fid = fopen('train.dat');
i = 1;
while 1
    i
    line = fgetl(fid);  % 每次讀進一行 (一個字)
    if ~ischar(line), break, end    % if已經讀完整個檔案, 跳出迴圈
    cat = sscanf(line, '%s', 1);  % 讀進每行開頭的分類標籤
    imgs.label = [imgs.label cat];
    imgs.image = [imgs.image myResize(turnToPic(line(length(cat)+1:length(line))))];    % 把分類標籤以外的data丟進function轉成圖
    i = i+1;
end
imgs.count = i-1;
fclose(fid);

end


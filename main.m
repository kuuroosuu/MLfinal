clc;
clear all;
addpath('feature-extraction\features\color\');
addpath('feature-extraction\features\sift\');
addpath('feature-extraction\util\');

if(exist('cache.mat', 'file'))
    load('cache');
else
    imgs = turnFilesToPics;
    save('cache', 'imgs');
end

for i = 1 : 1
    [feat, x, y, wid, hgt] = llc_color(imgs(i).image, conf());
end
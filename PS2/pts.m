inputIm = imread('soldier.jpg');
refIm = imread('weed.jpg');

[pt1, pt2] = Q1_1('soldier.jpg','weed.jpg', 4)
H = computeH(pt1, pt2);

% inputIm = imread('crop1.jpg');
% refIm = imread('crop2.jpg');
% 
% H = computeH(cc1,cc2)
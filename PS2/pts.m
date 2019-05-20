inputIm = imread('crop1.jpg');
refIm = imread('crop2.jpg');

% inputIm = imread('wdc1.jpg');
% refIm = imread('wdc2.jpg');

% [pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);
pt1 = cc1(:,1:4)
pt2 = cc2(:,1:4)
% pt1 = cc1(:,1);
% pt1 = [pt1, cc1(:,4)];
% pt1 = [pt1, cc1(:,8)];
% pt1 = [pt1, cc1(:,12)];
% pt2 = cc2(:,1);
% pt2 = [pt2, cc1(:,4)];
% pt2 = [pt2, cc1(:,8)];
% pt2 = [pt2, cc1(:,12)];

H = computeH(cc1, cc2);
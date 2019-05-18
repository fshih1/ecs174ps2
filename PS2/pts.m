inputIm = imread('crop1.jpg');
refIm = imread('crop2.jpg');

[pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);

H = computeH(pt1, pt2);
% create an interface, to match the images. create pairs, that match in the
% two images. 8-10 pairs
function [t1,t2] = Q1_1(image1,image2)
img1 = imread(image1);
img2 = imread(image2);
imshow(img1)
[x1,y1] = ginput(10)
imshow(img2)
[x2,y2] = ginput(10)
t1 = [x1 y1]'
t2 = [x2 y2]'
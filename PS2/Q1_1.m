% create an interface, to match the images. create pairs, that match in the
% two images. 8-10 pairs
function [t1,t2] = Q1_1(image1,image2)
img1 = imread(image1);
img2 = imread(image2);
imshow(img1)
[col1,row1] = ginput(8)
imshow(img2)
[col2,row2] = ginput(8)
t1 = [col1 row1]'
t2 = [col2 row2]'
% create an interface, to match the images. create pairs, that match in the
% two images. n pairs
function [t1,t2] = Q1_1(image1,image2, n)
    img1 = imread(image1);
    img2 = imread(image2);
    imshow(img1);
    [x1,y1] = ginput(n);
    imshow(img2);
    [x2,y2] = ginput(n);
    t1 = [x1 y1]';
    t2 = [x2 y2]';
end
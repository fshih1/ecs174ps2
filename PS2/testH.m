
img1 = imread('crop1.jpg');
img2 = imread('crop2.jpg');

[pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);

H = computeH(pt1, pt2)

H = reshape(H,[3,3])'

transImg = [];

[nRow, nCol] = size(img1);
for i = nRow
    for j = nCol
        coord = H * [i, j, 1]'
        disp(coord)
% %         [x_prime_w; y_prime_w; w] 
        x_prime = coord(1,1) / coord(1,3)
        y_prime = coord(1,2) / coord(1,3)
        disp(x_prime)
        disp(y_prime)
    end
end

% imshow(img1);
% hold on;
% plot(pt1');
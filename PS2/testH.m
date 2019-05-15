
img1 = imread('crop1.jpg');
img2 = imread('crop2.jpg');

[pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);

H = computeH(pt1, pt2)

H = reshape(H,[3,3])'

transImg = [];

[nRow, nCol, ~] = size(img2);
for i = 1:nRow
    for j = 1:nCol        
        coord = inv(H) * [i, j, 1]';
        x_prime = coord(1,1) / coord(3,1);
        y_prime = coord(2,1) / coord(3,1);
        transImg(i, j, 1) = interp2(img2(:,:,1), x_prime, y_prime); 
        transImg(i, j, 2) = interp2(img2(:,:,2), x_prime, y_prime);
        transImg(i, j, 3) = interp2(img2(:,:,3), x_prime, y_prime);
    end
end

% imshow(transImg)

% imshow(img1);
% hold on;
% plot(pt1');
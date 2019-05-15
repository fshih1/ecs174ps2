
img1 = imread('crop1.jpg');
img2 = imread('crop2.jpg');

[pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);

H = computeH(pt1, pt2)
[m, ~] = max([t1, t2], [], 2);
[~, numPoints] = size(pt1);

transPts = []
for col = 1:numPoints
%     x = (pt1(1,col) / m(1)) * 2;
%     y = (pt1(2,col) / m(2)) * 2;
    
    transPt = H * [x, y, 1]';
    x_p = transPt(1,1);
    y_p = transPt(2,1);
    w = transPt(3,1);
    x_p = x_p / w;
    y_p = y_p / w;
    
%     x_p = (x_p / 2) * m(1);
%     y_p = (y_p / 2) * m(2);
    transPts = horzcat(transPts, [x_p, y_p]');
end

transPts

% for i = 1:nRow
%     for j = 1:nCol        
%         coord = H * [i, j, 1]';
%         x_prime = coord(1,1) / coord(3,1);
%         y_prime = coord(2,1) / coord(3,1);
        
%         transImg(x_prime+1, y_prime+1, 1)
%         transImg(i, j, 1) = interp2(img2(:,:,1), x_prime, y_prime); 
%         transImg(i, j, 2) = interp2(img2(:,:,2), x_prime, y_prime);
%         transImg(i, j, 3) = interp2(img2(:,:,3), x_prime, y_prime);
%     end
% end

% imshow(transImg)

% imshow(img1);
% hold on;
% plot(pt1');
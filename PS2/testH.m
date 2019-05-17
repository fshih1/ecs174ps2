
img1 = imread('crop1.jpg');
img2 = imread('crop2.jpg');

[pt1, pt2] = Q1_1('crop1.jpg', 'crop2.jpg', 4);

H = computeH(pt1, pt2)
[m, ~] = max([pt1, pt2], [], 2);
[~, numPoints] = size(pt1);

transPts = [];
for col = 1:numPoints
%     x = (pt1(1,col) / m(1)) * 2;
%     y = (pt1(2,col) / m(2)) * 2;
    x = pt1(1,col)
    y = pt1(2,col)
    
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

[~, numPoints2] = size(pt2);
originPts = [];
for col = 1:numPoints2
%     x = (pt2(1,col) / m(1)) * 2;
%     y = (pt2(2,col) / m(2)) * 2;
    x = pt2(1,col);
    y = pt2(2,col);
    
    originPt = inv(H) * [x, y, 1]';
    x_p = originPt(1,1);
    y_p = originPt(2,1);
    w = originPt(3,1);
    x_p = x_p / w;
    y_p = y_p / w;
    
%     x_p = (x_p / 2) * m(1);
%     y_p = (y_p / 2) * m(2);
    originPts = horzcat(originPts, [x_p, y_p]');
end
originPts
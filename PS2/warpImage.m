function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];
    
    [nrow,ncol,~] = size(refIm);
    [maxRow, maxCol, ~] = size(inputIm);
    
% warp 4 corners of input image
% results are 1x2 matrices, 1st row = x, 2nd row = y
    warpCorner1 = H * [1, 1, 1]';
    warpCorner1 = [warpCorner1(1)/warpCorner1(3), warpCorner1(2)/warpCorner1(3)]';
    warpCorner2 = H * [1, maxCol, 1]';
    warpCorner2 = [warpCorner2(1)/warpCorner2(3), warpCorner2(2)/warpCorner2(3)]';
    warpCorner3 = H * [maxRow, 1, 1]';
    warpCorner3 = [warpCorner3(1)/warpCorner3(3), warpCorner3(2)/warpCorner3(3)]';
    warpCorner4 = H * [maxRow, maxCol, 1]';
    warpCorner4 = [warpCorner4(1)/warpCorner4(3), warpCorner4(2)/warpCorner4(3)]';

% get 4 corners of ref image
    refCorner1 = [1, 1]';
    refCorner2 = [1, ncol]';
    refCorner3 = [nrow, 1]';
    refCorner4 = [nrow, ncol]';

% preprocessing for bounding box compute
    all_x = [warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)];
    all_x = [all_x, refCorner1(1), refCorner2(1), refCorner3(1), refCorner4(1)];
    all_y = [warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)];
    all_y = [all_y, refCorner1(2), refCorner2(2), refCorner3(2), refCorner4(2)];
    
    min_x = min(all_x);
    max_x = max(all_x);
    min_y = min(all_y);
    max_y = max(all_y);

% get 4 sides of bounding box
    boxL = floor(min_y);
    boxR = ceil(max_y);
    boxT = floor(min_x);
    boxB = ceil(max_x);
    
% allocate bounding box
    warpIm = zeros([boxB - boxT + 1], [boxR - boxL + 1]);

% compute position of reference image in bounding box
    x_translate = 0;
    y_translate = 0;
    x_min = min([warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)]);
    if -x_min < 1
        x_translate = x_min;
    end
    y_min = min([warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)]);
    if -y_min < 1
        y_trasnlate = y_min;
    end
    x_translate = -x_min
    y_translate = -y_min
    for row = 1:nrow
        for col = 1:ncol
%             refIm(row,col,:)
            warpImg(row + floor(x_translate), col + floor(y_translate), :) = refIm(row, col, :);
        end
    end
    
% iterate through bounding box and compute inverse   
    for row = boxT:boxB
        for col = boxL:boxR
%             disp([row, col]);
            temp = inv(H) * [row, col, 1]';
            invX = temp(1) / temp(3);
            invY = temp(2) / temp(3);
            
            if invX < 1 || invX > maxRow
                if warpIm(row - boxT + 1, col - boxL + 1, :) ~= 0
                    warpIm(row - boxT + 1, col - boxL + 1, :) = 0;
                end
%                 warpIm(y - boxT + 1, x - boxL + 1, :) = 0;
                continue
            end
            if invY < 1 || invY > maxCol
%                 disp(col);
%                 disp(col-boxL+1);
                if warpIm(row - boxT + 1, col - boxL + 1, :) ~= 0
                    warpIm(row - boxT + 1, col - boxL + 1, :) = 0;
                end
%                 warpIm(y - boxT + 1, x - boxL + 1, :) = 0;
                continue
            end
            
            i = floor(invX);
            j = floor(invY);
            a = invX - i;
            b = invY - j;
            warpIm(row - boxT + 1, col - boxL + 1, 1) = (1-a)*(1-b)*double(inputIm(i,j,1))+a*(1-b)*double(inputIm(i+1,j,1))+a*b*double(inputIm(i+1,j+1,1))+(1-a)*b*double(inputIm(i,j+1,1));
            warpIm(row - boxT + 1, col - boxL + 1, 2) = (1-a)*(1-b)*double(inputIm(i,j,2))+a*(1-b)*double(inputIm(i+1,j,2))+a*b*double(inputIm(i+1,j+1,2))+(1-a)*b*double(inputIm(i,j+1,1));
            warpIm(row - boxT + 1, col - boxL + 1, 3) = (1-a)*(1-b)*double(inputIm(i,j,3))+a*(1-b)*double(inputIm(i+1,j,3))+a*b*double(inputIm(i+1,j+1,3))+(1-a)*b*double(inputIm(i,j+1,3));
%             warpIm(row - boxT + 1, col - boxL + 1, 2) = (1-a)*(1-b)*double(inputIm(i,j,2))+a*(1-b)*double(inputIm(i+1,j,2))+a*b*double(inputIm(i+1,j+1,2))+(1-a)*b*double(inputIm(i,j+1,2));
%             warpIm(row - boxT + 1, row - boxL + 1, 1) = (1-a)*(1-b)*double(inputIm(i,j,2))+a*(1-b)*double(inputIm(i+1,j,2))+a*b*double(inputIm(i+1,j+1,2))+(1-a)*b*double(inputIm(i,j+1,2));
%             warpIm(x - boxT + 1, y - boxL + 1, 3) = (1-a)*(1-b)*double(inputIm(i,j,3))+a*(1-b)*double(inputIm(i+1,j,3))+a*b*double(inputIm(i+1,j+1,3))+(1-a)*b*double(inputIm(i,j+1,3));
        end
    end
    
%     warpIm = uint8(permute(warpIm, [2 1 3]));
    warpIm = uint8(warpIm);
    
    
%     imshow(warpIm);
%     hold on;
%     imshow(transRefIm);
    hold off;
end

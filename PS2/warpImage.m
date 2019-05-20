function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];
    
    [nrow,ncol,~] = size(refIm);
    [maxRow, maxCol, ~] = size(inputIm);
    
% warp 4 corners of input image
% results are 1x2 matrices, 1st row = x, 2nd row = y
    warpCorner1 = H * [1, 1, 1]';
    warpCorner1 = [warpCorner1(2)/warpCorner1(3), warpCorner1(1)/warpCorner1(3)]';
    warpCorner2 = H * [maxCol, 1, 1]';
    warpCorner2 = [warpCorner2(2)/warpCorner2(3), warpCorner2(1)/warpCorner2(3)]';
    warpCorner3 = H * [1,maxRow, 1]';
    warpCorner3 = [warpCorner3(2)/warpCorner3(3), warpCorner3(1)/warpCorner3(3)]';
    warpCorner4 = H * [maxCol, maxRow, 1]';
    warpCorner4 = [warpCorner4(2)/warpCorner4(3), warpCorner4(1)/warpCorner4(3)]';

% get 4 corners of ref image
    refCorner1 = [1, 1]';
    refCorner2 = [1, ncol]';
    refCorner3 = [nrow, 1]';
    refCorner4 = [nrow, ncol]';
    
% warpIm compute
    all_x = [warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)];
    all_y = [warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)];
    
    boxL = floor(min(all_y));
    boxR = ceil(max(all_y));
    boxT = floor(min(all_x));
    boxB = ceil(max(all_x));

    for row = 1:maxRow
        for col = 1:maxCol
            temp = H * [col, row, 1]';
            invX = temp(2) / temp(3);
            invY = temp(1) / temp(3);  
            warpIm(floor(invX) - boxT + 1, floor(invY) - boxL + 1, :) = inputIm(row, col, :);
        end
    end
    warpIm = uint8(warpIm);


% mosaic bounding box compute
    all_x = [all_x, refCorner1(1), refCorner2(1), refCorner3(1), refCorner4(1)];
    all_y = [all_y, refCorner1(2), refCorner2(2), refCorner3(2), refCorner4(2)];

% get 4 sides of bounding box for merged mosaic
    boxL = floor(min(all_y));
    boxR = ceil(max(all_y));
    boxT = floor(min(all_x));
    boxB = ceil(max(all_x));
    
    mergeIm = zeros([boxB - boxT + 1], [boxR - boxL + 1]);

% iterate through bounding box and compute inverse   
    A = [];
    B = [];
    a = [];
    b = [];
    [A, B] = meshgrid(1:maxCol, 1:maxRow);
    
    for row = boxT:boxB
        tempx = [];
        tempy = [];
        for col = boxL:boxR           
            temp = inv(H) * [col, row, 1]';
            invX = temp(2) / temp(3);
            invY = temp(1) / temp(3);
            tempy = [tempy , invY];
            tempx = [tempx , invX];
        end
        a =[ a ; tempy];
        b =[ b ; tempx];
    end
    
    mergeIm = interp2(A, B, double(inputIm(:,:,1)), a, b);
    mergeIm(:,:,2) = interp2(A, B, double(inputIm(:,:,2)), a, b);
    mergeIm(:,:,3) = interp2(A, B, double(inputIm(:,:,3)), a, b);
    mergeIm = uint8(mergeIm);
    
    % compute position of reference image in bounding box
    x_translate = 0;
    y_translate = 0;
    x_shift = min([warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)])-1;
    y_shift = min([warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)])-1;
    x_translate = -x_shift
    y_translate = -y_shift
    for row = 1:nrow
        for col = 1:ncol
            mergeIm(row + floor(x_translate), col + floor(y_translate), 1) = refIm(row, col, 1);
            mergeIm(row + floor(x_translate), col + floor(y_translate), 2) = refIm(row, col, 2);
            mergeIm(row + floor(x_translate), col + floor(y_translate), 3) = refIm(row, col, 3);

        end
    end

end

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
    
    warpIm = zeros([boxB-boxT, boxR-boxL, 3]);

    for row = 1:maxRow
        for col = 1:maxCol
            temp = H * [col, row, 1]';
            X = temp(2) / temp(3);
            Y = temp(1) / temp(3);
            warpX = round(X) - boxT + 1;
            warpY = round(Y) - boxL + 1;
     
            if warpX < 1
                warpX = 1;
            elseif warpX > boxB-boxT
                warpX = boxB-boxT;
            end
            if warpY < 1
                warpY = 1;
            elseif warpY > boxR-boxL
                warpY = boxR-boxL;
            end
            
            warpIm(warpX, warpY, 1) = inputIm(row, col, 1);
            warpIm(warpX, warpY, 2) = inputIm(row, col, 2);
            warpIm(warpX, warpY, 3) = inputIm(row, col, 3);
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
    
    mergeIm = zeros([boxB - boxT + 1, boxR - boxL + 1]);

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
    x_shift = min([refCorner1(1),refCorner2(1),refCorner3(1),refCorner4(1),warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)])-1;
    y_shift = min([refCorner1(2),refCorner2(2),refCorner3(2),refCorner4(2),warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)])-1;
    
    if -x_shift < 1
        x_translate = x_shift;
    else
        x_translate = -x_shift;
    end
 
    if -y_shift < 1
        y_trasnlate = y_shift;
    else
        y_translate = -y_shift;
    end

    x_translate
    y_translate
    for row = 1:nrow
        for col = 1:ncol
            mergeX = row + floor(x_translate);
            mergeY = col + floor(y_translate);
            if mergeX < 1
                mergeX = 1;
            elseif mergeX > boxB-boxT
                mergeX = boxB-boxT;
            end
            if mergeY < 1
                mergeY = 1;
            elseif mergeY > boxR-boxL
                mergeY = boxR-boxL;
            end
            
            if mergeIm(mergeX, mergeY, 1) == 0
                mergeIm(mergeX, mergeY, 1) = refIm(row, col, 1);
                mergeIm(mergeX, mergeY, 2) = refIm(row, col, 2);
                mergeIm(mergeX, mergeY, 3) = refIm(row, col, 3);
            end
        end
    end
    
end

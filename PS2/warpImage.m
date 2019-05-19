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
    
    A = [];
    B = [];
    a = [];
    b = [];

    [A, B] = meshgrid(1:maxCol, 1:maxRow);
   
% iterate through bounding box and compute inverse   
    for row = boxT:boxB
        tempx = [];
        tempy = [];
        for col = boxL:boxR
%             disp([row, col]);
            
            temp = inv(H) * [col, row, 1]';
            invX = temp(2) / temp(3);
            invY = temp(1) / temp(3);
            tempy = [tempy , invY];
            tempx = [tempx , invX];
        end
        a =[ a ; tempy];
        b =[ b ; tempx];
    end
    
    warpIm = interp2(A, B, double(inputIm(:,:,1)), a, b);
    warpIm(:,:,2) = interp2(A, B, double(inputIm(:,:,2)), a, b);
    warpIm(:,:,3) = interp2(A, B, double(inputIm(:,:,3)), a, b);
    warpIm = uint8(warpIm);
    
    % compute position of reference image in bounding box
    x_translate = 0;
    y_translate = 0;
    x_shift = min([warpCorner1(1), warpCorner2(1), warpCorner3(1), warpCorner4(1)])-1;
%     if -x_shift < 1
%         x_translate = x_shift;
%     end
    y_shift = min([warpCorner1(2), warpCorner2(2), warpCorner3(2), warpCorner4(2)])-1;
%     if -y_shift < 1
%         y_trasnlate = y_shift;
%     end
    x_translate = -x_shift
    y_translate = -y_shift
    for row = 1:nrow
        for col = 1:ncol
%             refIm(row,col,:)
            warpIm(row + floor(x_translate), col + floor(y_translate), 1) = refIm(row, col, 1);
            warpIm(row + floor(x_translate), col + floor(y_translate), 2) = refIm(row, col, 2);
            warpIm(row + floor(x_translate), col + floor(y_translate), 3) = refIm(row, col, 3);

        end
    end
    
%     imshow(warpIm);
%     hold on;
%     imshow(transRefIm);
    hold off;
end

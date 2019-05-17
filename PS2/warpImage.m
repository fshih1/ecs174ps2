function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];
    
    [nrow,ncol,~] = size(refIm);
    [maxRow, maxCol, ~] = size(inputIm);
    
    for row = 1:nrow
        for col = 1:ncol
            temp = inv(H) * [row,col,1]';
            x_prime = temp(1) / temp(3);
            y_prime = temp(2) / temp(3);
            
            x_max = ceil(x_prime);
            x_min = floor(x_prime);
            y_max = ceil(y_prime);
            y_min = floor(y_prime);
            
            if col == 1 & col == 1
                disp(x_min);
                disp(y_min);
            end
            
            a = x_prime - x_min;
            b = y_prime - y_min;
            
            if x_min < 1 || y_min < 1
                warpIm(row, col) = 0;
                continue
            end
            if x_max > maxRow || y_max > maxCol
                warpIm(row, col) = 0;
                continue
            end
            warpIm(row, col, 1) = (1-a)*(1-b)*inputIm(x_min, y_min, 1) + a*(1-b)*inputIm(x_max, y_min, 1) + a*b*inputIm(x_max, y_max, 1) + (1-a)*b*inputIm(x_min, y_max, 1);
            warpIm(row, col, 2) = (1-a)*(1-b)*inputIm(x_min, y_min, 2) + a*(1-b)*inputIm(x_max, y_min, 2) + a*b*inputIm(x_max, y_max, 2) + (1-a)*b*inputIm(x_min, y_max, 2);
            warpIm(row, col, 3) = (1-a)*(1-b)*inputIm(x_min, y_min, 3) + a*(1-b)*inputIm(x_max, y_min, 3) + a*b*inputIm(x_max, y_max, 3) + (1-a)*b*inputIm(x_min, y_max, 3);
        end
    end
 
    
end

function [warpIm, mergeIm] = warpImage3(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];
    
    [nrow,ncol,~] = size(refIm);
    [nrow_i, ncol_i ,~] = size(inputIm);
    
    for row = 1:nrow_i
        for col = 1:ncol_i
            temp = H * [row, col, 1]';
            x_prime = temp(1) / temp(3);
            y_prime = temp(2) / temp(3);
            
            inputIm(row, col) 
            
        end
    end
    
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
            
            warpIm(row, col) = (1-a)*(1-b)*inputIm(x_min, y_min) + a*(1-b)*inputIm(x_max, y_min) + a*b*inputIm(x_max, y_max) + (1-a)*b*inputIm(x_min, y_max);
        end
    end
 
    
end

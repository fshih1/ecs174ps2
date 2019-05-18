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
            
            warpIm(round(x_prime), round(y_prime), :) = inputIm(row, col, :);
        end
    end
    warpIm = uint8(warpIm);

end

function [warpIm, mergeIm] = warpImage_legend26(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];
    [nrow_ref,ncol_ref,~] = size(refIm);
    [nrow_inp,ncol_inp,~] = size(inputIm);

    A = [];
    B = [];
    a = [];
    b = [];
    
    % iterate through original
    for row = 1:nrow_inp
        for col = 1:ncol_inp
%             A(row, col) = row;
%             B(row, col) = col;
        
            temp = H * [row, col, 1]';
            x_prime = temp(1) / temp(3);
            y_prime = temp(2) / temp(3);
            x_max = ceil(x_prime);
            x_min = floor(x_prime);
            y_max = ceil(y_prime);
            y_min = floor(y_prime);
           
            if row == x_min 
                x(row, col) = x_min
            else
                x(row, col) = x_max
            end
            A(row, col) = 
        end
    end
    
    for row = 1:nrow_ref
        for col = 1:ncol_ref
            temp = inv(H) * [row,col,1]';
            x_prime = temp(1) / temp(3);  
            y_prime = temp(2) / temp(3);
            a[row, col] = x_prime
            b[row, col] = y_prime
        end
    end
    
    
    
    



end
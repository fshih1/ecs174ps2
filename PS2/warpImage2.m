function [warpIm, mergeIm] = warpImage2(inputIm, refIm, H)
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
            A(row, col) = row;
            B(row, col) = col;
        
%             temp = H * [row, col, 1]';
%             x_prime = temp(1) / temp(3);
%             y_prime = temp(2) / temp(3);
            
        end
    end
    
    for row = 1:nrow_ref
        for col = 1:ncol_ref
            temp = inv(H) * [row,col,1]';
            x_prime = temp(1) / temp(3);  
            y_prime = temp(2) / temp(3);
            a(row, col) = x_prime
            b(row, col) = y_prime
        end
    end
    
    wrapIm = interp2(A, B, inputIm(:,:,1), a, b);
    wrapIm(:,:,2) = interp2(A, B, inputIm(:,:,2), a, b);
    wrapIm(:,:,3) = interp2(A, B, inputIm(:,:,3), a, b);
    

end
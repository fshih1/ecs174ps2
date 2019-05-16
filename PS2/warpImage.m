function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
    warpIm = [];
    mergeIm = [];

    a = [];
    b = [];
    
    [nrow,ncol,~] = size(refIm);
    for row = 1:nrow
        for col = 1:ncol
            temp = inv(H) * [row,col,1]';
            x_prime = temp(1) / temp(3);
            y_prime = temp(2) / temp(3);

            a(row, col) = x_prime;
            b(row, col) = y_prime;
        end
    end
   
    warpIm(:,:, 1) = interp2(double(inputIm(:,:,1)), x_prime, y_prime);
    warpIm(:,:, 2) = interp2(double(inputIm(:,:,2)), x_prime, y_prime);
    warpIm(:,:, 3) = interp2(double(inputIm(:,:,3)), x_prime, y_prime);
end

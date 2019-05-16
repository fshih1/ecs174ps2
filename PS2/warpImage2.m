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
%     for row = 1:nrow_inp
%         for col = 1:ncol_inp
%             A(row, col) = col;
%             B(row, col) = row;
%         
% %             temp = H * [row, col, 1]';
% %             x_prime = temp(1) / temp(3);
% %             y_prime = temp(2) / temp(3);
%             
%         end
%     end
    [A, B] = meshgrid(1:ncol_inp, 1:nrow_inp)
    
    for row = 1:nrow_ref
        for col = 1:ncol_ref
%             A(row, col) = col;
%             B(row, col) = row;
            
            temp = inv(H) * [row,col,1]';
            x_prime = temp(1) / temp(3);
            y_prime = temp(2) / temp(3);
            a(row, col) = y_prime;
            b(row, col) = x_prime;
        end
    end
    
    if size(A) ~= size(B)
        error('A & B size mismatch')
    end
    if size(A) ~= size(inputIm(:,:,1))
        error ('Input size mismatch')
    end
     
    wrapIm = interp2(A, B, double(inputIm(:,:,1)), a, b)
%     wrapIm(:,:,2) = interp2(A, B, double(inputIm(:,:,2)), a, b);
%     wrapIm(:,:,3) = interp2(A, B, double(inputIm(:,:,3)), a, b);
    

end
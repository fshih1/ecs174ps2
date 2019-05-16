function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)

% refIm = 'crop2.jpg'

warpImg = []

[nrow,ncol] = size(refIm)
for row = 1:nrow
   for col = 1:ncol
       temp = H * [row,col,1]';
       x_prime = temp(1) / temp(3);  %we might need to scale it back?
       y_prime = temp(2) / temp(3);
       
       if floor(x_prime) ~= ceil(x_prime) % we need to do interpolation
            transImg(i, j, 1) = interp2(img2(:,:,1), x_prime, y_prime); 
            transImg(i, j, 2) = interp2(img2(:,:,2), x_prime, y_prime);
            transImg(i, j, 3) = interp2(img2(:,:,3), x_prime, y_prime);
            
       
       else % we chilling
           warpImg(x_prime,y_prime,1) = refIm(row,col,1);
           warpImg(x_prime,y_prime,2) = refIm(row,col,2);
           warpImg(x_prime,y_prime,3) = refIm(row,col,3);
       end
   end
end
[warpedImg, mergedImg] = warpImage(inputIm, refIm, H);

% warpedImg = resultImgs(1, 1);
% mergedImg = resultImgs(2, 1);
imshow(warpedImg);
% hold on;
% line([0, 1], [50, 50], 'Color', 'red', 'Linewidth', 20);
% line([355, 355], [1, 2], 'Color', 'red', 'Linewidth', 2000);


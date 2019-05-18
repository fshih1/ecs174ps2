% USAGE:
% Use pts.m to get H and save H as global in workspace so that you can use this script without
% having to click points every time you run it

[warpedImg, mergedImg] = warpImage(inputIm, refIm, H);

imshow(warpedImg);


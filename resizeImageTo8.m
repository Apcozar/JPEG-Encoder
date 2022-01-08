function imgResized = resizeImageTo8(img)
% RESIZEIMAGETO8 adjusts the dimensions of the image to be integer multiple 
% of 8.
% 
% imgResized = RESIZEIMAGETO8(img) uses the Matlab's function imresize() to
% ensure that both horizontal and vertical dimensions of the image are
% integer multiple of 8.
%

% José A. García Naya, 11 NOV 2021
%

    imgHeight = size(img, 1);
    imgWidth = size(img, 2);
    imgResized = imresize(img, [8*ceil(imgHeight/8) 8*ceil(imgWidth/8)]);
end
function imgRGB = convertYCbCrToRGB(imgYCbCr)
% CONVERTYCBCRTORGB converts YCbCr color values to RGB.
%
% imgRGB = CONVERTRGBTOYCBCR(imgYCbCr) converts the YCbCr values in the
% image imgYCbCr to RGB and stores them in imgRGB.
%
% imgYCbCr can be uint8 or double. 
% imgRGB is always double.
%
% See ALSO CONVERTRGBTOYCBCR.
% 

% José A. García-Naya, 11 NOV 2021

if isinteger(imgYCbCr)
    imgYCbCr = double(imgYCbCr);
end

mYCbCr2RGB = inv([0.299 0.587 0.114; -0.1687 -0.3313 0.5; 0.5 -0.4187 -0.0813]);
[M, N, nColors] = size(imgYCbCr);

if (nColors ~= 3)
    error('Image must be YCbCr');
end

imgYCbCr = permute(imgYCbCr, [3, 1, 2]);
imgRGB = zeros(size(imgYCbCr));
for m = 1:M
    for n = 1:N
        imgRGB(:, m, n) = mYCbCr2RGB * (imgYCbCr(:, m, n) - [0 128 128].');
    end
end
imgRGB = permute(imgRGB, [2, 3, 1]);
end
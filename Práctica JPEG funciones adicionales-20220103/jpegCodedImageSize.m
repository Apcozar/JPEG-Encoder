function [bpp] = jpegCodedImageSize(bitStr, imgDimensions)
% JPEGCODEDIMAGESIZE computes the size of a JPEG-coded image expressed in
% bits/pixel.
%
% bpp = JPEGCODEDIMAGESIZE(bitStr, imgDimensions) computes the size of the
% bitStr stream obtained with JPEGENCODER corresponding to an image with
% dimensions imgDimensions. bpp contains the result expressed in
% bits/pixel.
%
% See also JPEGENCODER.

% José A. García Naya, 11 NOV 2021.
%

numBits = 0;
for ii = 1:numel(bitStr)
    block = bitStr{ii};
    for jj = 1:numel(block)
        numBits = numBits + numel(block{jj});
    end
end

% bits required by the Huffman Tables
% AC table has 160 codes and we need 2 bytes per code
% Luminance and chrominance tables are different
numBits = numBits + 2 * 8 * 160 * (1 + (imgDimensions(3) == 3));

% DC table has 12 entries and we need also 2 bytes per entry
% Luminance and chrominance tables are different
numBits = numBits + 2 * 8 * 12 * (1 + (imgDimensions(3) == 3));

% Quantification matrices have 64 elements and require 1 byte per entry
numBits = numBits + 8 * 64 * (1 + (imgDimensions(3) == 3));

% bits/pixel are obtained dividing by the total number of pixels of the
% image.
bpp = numBits / (imgDimensions(1) * imgDimensions(2));
end
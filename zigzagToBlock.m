function [Y] = zigzagToBlock(x)
% ZIGZAGTOBLOCK converts a 64-element vector to an 8x8 matrix representing 
% a JPEG block of pixels.
%
% Y = ZIGZAGTOBLOCK(x) converts the 64-element vector x to an 8x8 matrix Y 
% accorging to the zig-zag order defined by JPEG.
%
% See also BLOCKTOZIGZAG.
%

% José A. García-Naya, 11 NOV 2021

if (numel(x) ~= 64)
    error('Only vectors with 64 elements are supported.');
end
            
% The following code produces izigzagIndices.   
% % %     m = reshape(1:64, [8 8])';
% % %     mzigzag = block2zigzag(m);
% % %     izigzagindices = zeros(1, 64);
% % %     for ii = 1:64
% % %         izigzagindices(ii) = find(mzigzag == ii);       
% % %     end
    
izigzagindices = [1, 2, 6, 7, 15, 16, 28, 29, 3, 5, 8, 14, 17, 27, 30, ...
    43, 4, 9, 13, 18, 26, 31, 42, 44, 10, 12, 19, 25, 32, 41, 45, 54, ...
    11, 20, 24, 33, 40, 46, 53, 55, 21, 23, 34, 39, 47, 52, 56, 61, ...
    22, 35, 38, 48, 51, 57, 60, 62, 36, 37, 49, 50, 58, 59, 63, 64];

x = x(:);
Y = reshape(x(izigzagindices),[8 8]).';
end
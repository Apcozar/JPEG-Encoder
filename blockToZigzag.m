function [y] = blockToZigzag(X)
% BLOCKTOZIGZAG converts an 8x8 matrix to a 64-element vector.
% 
% Y = BLOCKTOZIGZAG(X) converts the 8x8 matrix X to a 64-element vector y 
% following the zig-zag order defined by JPEG.
%
% See also ZIGZAGTOBLOCK.
%

% José A. García-Naya, 11 NOV 2021

if ~(sum(size(X) == [8, 8]) == 2)
    error('Only 8x8 matrices are supported.');
end
    
% The following code produces zigzagIndices.
% 
% % %     zigzag = [...
% % %          1  2  6  7 15 16 28 29;
% % %          3  5  8 14 17 27 30 43;
% % %          4  9 13 18 26 31 42 44;
% % %         10 12 19 25 32 41 45 54;
% % %         11 20 24 33 40 46 53 55;
% % %         21 23 34 39 47 52 56 61;
% % %         22 35 38 48 51 57 60 62;
% % %         36 37 49 50 58 59 63 64];
% % %     zigzagIndices = zeros(1, 64);    
% % %     for ii = 1:64
% % %         zigzagIndices(ii) = find(zigzag == ii);
% % %     end
    
zigzagIndices = [1, 9, 2, 3, 10, 17, 25, 18, 11, 4, 5, 12, 19, 26, 33, 41, ...
    34, 27, 20, 13, 6, 7, 14, 21, 28, 35, 42, 49, 57, 50, 43, 36, 29, ...
    22, 15, 8, 16, 23, 30, 37, 44, 51, 58, 59, 52, 45, 38, 31, 24, 32, ...
    39, 46, 53, 60, 61, 54, 47, 40, 48, 55, 62, 63, 56, 64];
y = X(zigzagIndices);
end
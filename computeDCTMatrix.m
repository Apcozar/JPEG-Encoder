function dctMatrix = computeDCTMatrix()
% COMPUTEDCTMATRIX() computes the 8x8 matrix of the DCT.
%
% dctMatrix = COMPUTEDCTMATRIX() returns the 8x8 matrix of the DCT.
%
% The DCT output DCTOUT of an 8x8 matrix IN can be obtained as follows:
%
% DCTOUT = dctMatrix * IN * dctMatrix.';
%
% and its inverse:
%
% IN = dctMatrix.' * DCTOUT * dctMatrix;
%

% José A. García-Naya, 11 NOV 2021

dctMatrix = zeros(8, 8);
colIncrement = 2;
dctMatrix(1, :) = sqrt(2)/4;
for rowIndex = 2:8
    factor = rowIndex - 1;
    for colIndex = 1:8
        dctMatrix(rowIndex, colIndex) = 0.5 .* cos(factor*pi/16);
        factor = factor + colIncrement;
    end
    colIncrement = colIncrement + 2;
end
end
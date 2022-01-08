function b = huffmanDecimalToBinary(d)
% HUFFMANDEFIMALTOBINARY converts decimal numbers to its binary
% representation according to JPEG Huffma code.
%
% binStr = HUFFMANDECIMALTOBINARY(dec) converts dec to its binary
% representation as a char array of 1's and 0's following the one's
% complement format with the minimum number of bits required by JPEG
% Huffman coding.
%
% See also HUFFMANBINARYTODECIMAL.

% José A. García-Naya, 11 NOV 2021

if (d >= 0)
    b = dec2bin(d);
else
    b = dec2bin(abs(d));
    % 1's complement
    b = char(int32(not(b - '0')) + int32('0'));
    % Minimum number of required bits for 1's complement
    minNumBits = floor(log2(abs(d))) + 1;
    % Take only the minimum necessary bits
    b = b(end - minNumBits + 1 : end);
end
end
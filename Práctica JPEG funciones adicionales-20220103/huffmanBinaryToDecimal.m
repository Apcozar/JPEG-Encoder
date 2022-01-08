function dec = huffmanBinaryToDecimal(binStr, varargin)
% HUFFMANBINARYTODECIMAL converts a binary representation of a number (as a
% char array of 1's and 0's) back to its decimal format.
% dec = HUFFMANBINARYTODECIMAL(binStr) converts the char array of 0's and 1's 
% in binStr to its decimal representation in dec.
%
% dec = HUFFMANBINARYTODECIMAL(binStr, true) changes the output when
% binStr = '0':
%   dec = HUFFMANBINARYTODECIMAL('0', true) produces a 0, whereas
%   dec = HUFFMANBINARYTODECIMAL('0') produces a -1.
% For the rest of the values of binStr the second parameter does not
% make any difference.
% This is useful when decoding DC coefficients, since the Huffman table for
% DC values considers size = 0, whose output must be also 0, whereas for
% the rest of DC size values, and also for all the AC cases, binStr = '0'
% must be converted to dec = -1.
%
% See also HUFFMANDECIMALTOBINARY.
%

% José A. García-Naya, 11 NOV 2021

if isempty(varargin)
    zerosize = false;
else
    zerosize = varargin{1};
end
if (strcmp(binStr,'0'))
    if (zerosize)
        dec = 0;
    else
        dec = -1;
    end
else
    if (binStr(1) == '1')
        dec = bin2dec(binStr);
    else
        dec = -1 * bin2dec(char(not(int32(binStr) - int32('0')) + '0'));
    end
end
end
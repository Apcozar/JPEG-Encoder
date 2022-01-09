function [block] = jpegHuffmanDecodeBlock(bitStr, type)
% JPEGHUFFMANDECODEBLOCK decodes a bit stream of an 8x8 block encoded with 
% Huffman according to the Huffman tables defined in the annex of the JPEG 
% standard.
%
% BLOCK = JPEGHUFFMANDECODEBLOCK(BITSTR, 'L') decodes the luminance bit 
% stream representation in BITSTR, which is an array of chars of 1's and 
% 0's, according to the Huffman tables defined in the annex of the JPEG 
% standard.
%
% BITSTR is a cell array of arrays of chars. Each Huffman codeword is
% encoded as two elements of the cell array, one for the Huffman code and
% another one for the value. The first two elements in BITSTR correspond to
% the DC coefficient. BITSTR must correspond to an 8x8 block and finish 
% with the EOB code.
%
% BLOCK is an 8x8 array of coefficients after Huffman decoding.
% 
% BLOCK = JPEGHUFFMANDECODEBLOCK(BITSTR, 'C') decodes the bit stream
% representation of chrominace symbols.
% 
% See also JPEGHUFFMANENCODEBLOCK.
%

% José A. García-Naya, 11 NOV 2021.
%

block = jpegHuffmanDecodeBlock__(bitStr, type);

end
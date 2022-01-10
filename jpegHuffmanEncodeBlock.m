function [bitStr] = jpegHuffmanEncodeBlock(block, type)
% JPEGHUFFMANENCODEBLOCK encodes an 8x8 block (after DCT transform,
% quantization, and zig-zag conversion) according to the Huffman tables
% defined in the annex of the JPEG standard.
%
% BITSTR = JPEGHUFFMANENCODEBLOCK(BLOCK, 'L') encodes the 8x8 BLOCK and 
% outputs the bit stream in BITSTR as an array of chars of 1's and 0's.
%
% SYMBOLS is an array of 64 coefficients: the DC plus 63 AC coefficients.
% 
% BITSTR is a cell array of arrays of chars. Each huffman codeword is
% encoded as two elements of the cell array, one for the Huffman code and
% another one for the value. The first two elements in BITSTR correspond to
% the DC coefficient.
%
% BITSTR = JPEGHUFFMANENCODEBLOCK(SYMBOLS, 'C') encodes the array of 
% chromince symbols. 
% 
% See also JPEGHUFFMANDECODEBLOCK.
%

% José A. García-Naya, 11 NOV 2021.
%

[huff_ldc, huff_lac, huff_cdc, huff_cac] = huffman_codes();

count = 1;

value = huffmanDecimalToBinary(block(1));
bitStr = {};

size = length(value);

lastNonZero = 0;

if (size ~= 0)
    size = size + 1;
end 

if (type == 'L')
    bitStr(1) = strcat(huff_ldc(1,size),value);
    EOB = {'1010'};
    ZRL = {'11111111001'};
elseif (type == 'C')
    bitStr(1) = strcat(huff_cdc(1,size),value);
    EOB = {'00'};
    ZRL = {'1111111010'};
end

for i = 1:length(block)
    if (block(i) ~= 0)
        lastNonZero = i;
    end
end

for i = 2:lastNonZero
    
     if (block(i) == 0)
        count = count + 1;
        if (count == 16 && lastNonZero > i) 
            bitStr(end+1) = ZRL;
            count = 1;
        end
        continue;
    end
     
    value = huffmanDecimalToBinary(block(i));
    run = count;
    size = length(value);

    count = 1;

    if (type == 'L')
        bitStr(end+1) = strcat(huff_lac(run, size), value);
    elseif (type == 'C')
        bitStr(end+1) = strcat(huff_cac(run, size), value);
    end

end

bitStr(end+1) = EOB;

end
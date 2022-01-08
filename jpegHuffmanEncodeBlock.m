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

count = 0;

value = huffmanDecimalToBinary(block(1));

not0 = 0;

for i = 1:64
    if (block(i) ~= 0)
        not0 = not0 + 1;
    end
end

if (type == 'L')
    size = length(value);
    bitStr(1,1) = size; bitStr(1,2) = value;
    
    for i = 2:64
        if (block(i) == 0)
            count = count + 1;
            continue;
        end
        
        value = huffmanDecimalToBinary(block(i));
        run = count;
        size = length(value);
        
        count = 0;
        bitStr(1,end+1) = strcat(huff_lac(run+1, size), value);
    end

elseif (type == 'C')
    size = find(huff_cdc == length(value));
    bitStr(1,1) = size; bitStr(1,2) = value;

    for i = 2:64
        if (block(i) == 0)
            count = count + 1;
            continue;
        end
        
        value = huffmanDecimalToBinary(block(i));
        run = count;
        size = length(value);
        
        count = 0;
        bitStr(:,end+1) = strcat(huff_cac(run+1, size), value);
    end
end

end
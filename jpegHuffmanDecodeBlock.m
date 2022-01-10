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

block = zeros(1,64);
[huff_ldc, huff_lac, huff_cdc, huff_cac] = huffman_codes();

if (type == 'L')
    ZRL = '11111111001';
    huff_dc = huff_ldc;
    huff_ac = huff_lac;
elseif (type == 'C')
    ZRL = '1111111010';
    huff_dc = huff_cdc;
    huff_ac = huff_cac;
end

cBits = bitStr{1,1};

if (strcmp(cBits(1:2),'00'))
    value = 0;
else
    for j = 2:length(cBits)
        bitSize = cBits(1:j);
        sizeValue = find(strcmp(huff_dc,bitSize)) - 1;
               
        if (sizeValue == length(cBits(j+1:end)))
            break;
        end
    end
    
    value = huffmanBinaryToDecimal(cBits(j+1:end));
end

DC = value;

block(1) = DC;
pos = 2;

for i = 2:length(bitStr)-1
    
    cBits = bitStr{1,i};
   
    if (strcmp(cBits, ZRL))
        pos = pos + 16;
        continue;
    end 

    for j = 2:length(cBits)
        bitRunSize = cBits(1:j);
        
        runSizeValue = find(strcmp(huff_ac,bitRunSize))-1;
        
        sizeValue = floor(runSizeValue / 16) + 1;
        
        if (sizeValue == length(cBits(j+1:end)))
            run = mod(runSizeValue,16);
            break;
        end
    end

    if (run ~= 0)
        pos = pos + run;
    end

    block(pos) = huffmanBinaryToDecimal(cBits(j+1:end));
    
    pos = pos + 1;
end
end
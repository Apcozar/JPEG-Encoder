function  [Q50L, Q50C] = jpegQuantizationMatrices()
% JPEGQUANTIZATIONMATRICES returns the default cuantization matrices for a
% quality factor of 50 corresponding to the luminance and chrominance
% color components.
%
% [Q50L, Q50C] = JPEGQUANTIZATIONMATRICES() returns the 8x8 quantization matrix
% Q50L for the luminance and the 8x8 quantization matrix Q50C for the
% chrominancies.
%

% José A. García-Naya, 11 NOV 2021

Q50L = [16 11 10 16  24  40  51  61;
        12 12 14 19  26  58  60  55;
        14 13 16 24  40  57  69  56;
        14 17 22 29  51  87  80  62;
        18 22 37 56  68 109 103  77;
        24 35 55 64  81 104 113  92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103  99];


Q50C = [17 18 24 47 99 99 99 99
	    18 21 26 66 99 99 99 99
	    24 26 56 99 99 99 99 99
	    47 66 99 99 99 99 99 99
	    99 99 99 99 99 99 99 99
	    99 99 99 99 99 99 99 99
	    99 99 99 99 99 99 99 99
	    99 99 99 99 99 99 99 99];   
end
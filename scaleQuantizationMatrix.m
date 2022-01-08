function Qs = scaleQuantizationMatrix(Q, quality)
% SCALEQUANTIZATIONMATRIX scales the JPEG quantization matrix according to
% the quality factor.
%
% Qs = SCALEQUANTIZATIONMATRIX(Q, QUALITY) scales the JPEG 8x8 quantization
% matrix Q with the quality factor QUALITY and returns the result in QS.
%
% QUALITY must be between 1 and 100. QUALITY = 100 means that no
% quantization is carried out (QS elements are 1).
%
% See also JPEGQUANTIZATIONMATRICES.
%

%
% José A. García Naya, 11 NOV 2021.
%

if ((quality < 1) || (quality > 100))
    error('quality must be between 1 and 100.');
end

if (quality <= 50)
    scaleFactor = 50/quality;
else
    scaleFactor = 2 - quality/50;
end

Qs = max(round(Q .* scaleFactor), 1);
end
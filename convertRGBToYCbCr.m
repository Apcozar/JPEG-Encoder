function imgYCbCr = convertRGBToYCbCr(imgRGB)
% CONVERTRGBTOYCBCR converts RGB color values to YCbCr.
% imgYCbCr = CONVERTRGBTOYCBCR(imgRGB) converts the RGB values in the
% image imgRGB to YCbCr and stores them in imgYCbCr.
%
% imgRGB can be uint8 or double. 
% imgYCbCr is always double. The reason for that is that during JPEG 
% encoding the values converted to YCbCr will undergo DCT transform, 
% hence avoiding precission errors.
%
% See also CONVERTYCBCRTORGB.
% 

% José A. García-Naya, 11 NOV 2021
%{
matrix = [0.299 0.587 0.114;
          -0.1687 -0.3313 0.5;
          0.5 -0.4187 -0.0813];
%}

R = imgRGB(:,:,1);
G = imgRGB(:,:,2);
B = imgRGB(:,:,3);

imgYCbCr(:,:,1) = 0 + 0.299*R + 0.587*G + 0.114*B; 
imgYCbCr(:,:,2) = 128 - 0.1687*R - 0.3313*G + 0.5*B;
imgYCbCr(:,:,3) = 128 + 0.5*R - 0.4187*G - 0.0813*B;

%{
imgYCbCr = zeros(size(imgRGB));
for i = 1:size(imgRGB,1)
    for j = 1:size(imgYCbCr,2)
        for p = 1:size(imgYCbCr,3)
            imgYCbCr(i,j,:) = matrix(:,p) * double(imgRGB(i,j,p));
        end
    end
end

imgYCbCr(:,1) = imgYCbCr(:,1) + 0;
imgYCbCr(:,2) = imgYCbCr(:,2) + 128;
imgYCbCr(:,3) = imgYCbCr(:,3) + 128;
%}

end

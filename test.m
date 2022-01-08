img = imread("img/mars_panorama_orig.jpg");

% % EJER 1
% figure(1);
% r = img(:,:,1);
% g = img(:,:,2);
% b = img(:,:,3);
% subplot(3,1,1)
% histogram(r,256);
% title("Red channel")
% subplot(3,1,2)
% histogram(g,256);
% title("Green channel")
% subplot(3,1,3)
% histogram(b,256);
% title("Blue channel")
% 
% % EJER 2
% figure(2);
% myycrcb = convertRGBToYCbCr(img);
% back = convertYCbCrToRGB(myycrcb);
% mlycrcb = rgb2ycbcr(img);
% 
% subplot(3,1,1);
% imshow(myycrcb/255);
% subplot(3,1,2);
% imshow(back/255);
% subplot(3,1,3);
% imshow(img);
% 
% % EJER 3.1
% figure(3);
% ssmin_vals = [];
% for i = 0:5:100
%     imwrite(img, "temp", "jpeg","Quality",i);
%     compressed = imread("temp", "jpeg");
%     tmp = ssim(compressed, img);
%     ssmin_vals = [ssmin_vals, tmp];
% end
% 
% plot(ssmin_vals,".-", "LineWidth", 1.5, "MarkerSize", 30);
% ylabel("SSIM Value");
% xlabel("Quality");
% 
% % Ejer 3.2
% figure(4);
% compresionRates = [];
% for i = 0:5:100
%     imwrite(img, "temp", "jpeg","Quality",i);
%     currentRate = imfinfo("temp").FileSize / numel(img);
%     compresionRates = [compresionRates, currentRate];
% end
% 
% plot(compresionRates,".-", "LineWidth", 1.5, "MarkerSize", 30);
% ylabel("Bits/pixel");
% xlabel("Quality");
% 
% 
% % Ejer 4
% figure(5);
% ssimVals = [];
% noise = [];
% 
% for k = 0.01:0.01:0.1
%     noisyImg = imnoise(img, "gaussian", k);
%     val = ssim(noisyImg, img);
%     ssimVals = [ssimVals, val];
%     noise = [noise, k];
% end
% 
% plot(noise, ssimVals, ".-", "LineWidth", 1.5, "MarkerSize", 30);
% ylabel("SSIM Value");
% xlabel("Noise");

% Ejer 5
ssimVals = [];
ssimValsNoisy = [];
qualityFactor = [];

compresionRates = [];
compresionRatesNoisy = [];

noisyImg = imnoise(img, "gaussian", 0.02);

for i = 10:10:100
    imwrite(img, "temp", "jpeg","Quality",i);
    imwrite(noisyImg, "tempNoisy", "jpeg","Quality",i);

    compressed = imread("temp", "jpeg");
    compressedNoisy = imread("tempNoisy", "jpeg");
    ssimVal = ssim(compressed, img);
    ssimValNoisy = ssim(compressedNoisy, img);

    currentRate = imfinfo("temp").FileSize / numel(img);
    currentRateNoisy = imfinfo("tempNoisy").FileSize / numel(img);

    ssimVals = [ssimVals, ssimVal];
    ssimValsNoisy = [ssimValsNoisy, ssimValNoisy];
    compresionRates = [compresionRates, currentRate];
    compresionRatesNoisy = [compresionRatesNoisy, currentRateNoisy];
    qualityFactor = [qualityFactor, i];
end

figure(6); 
hold on
plot(qualityFactor, ssimVals, ".-", "LineWidth", 1.5, "MarkerSize", 30);
plot(qualityFactor, ssimValsNoisy, ".-", "LineWidth", 1.5, "MarkerSize", 30);
hold off
ylabel("SSIM Value");
xlabel("Quality factor");

figure(7)
hold on
plot(qualityFactor, compresionRates, ".-", "LineWidth", 1.5, "MarkerSize", 30);
plot(qualityFactor, compresionRatesNoisy, ".-", "LineWidth", 1.5, "MarkerSize", 30);
hold off
ylabel("Bits/pixel");
xlabel("Quality factor");

figure(8)
hold on
plot(compresionRates, ssimVals, ".-", "LineWidth", 1.5, "MarkerSize", 30);
plot(compresionRatesNoisy, ssimValsNoisy, ".-", "LineWidth", 1.5, "MarkerSize", 30);
hold off
xlabel("Bits/pixel");
ylabel("SSIM Value");


function [outputImages] = thresholdImages(inputImages, threshold)
% Extract edges using Canny edge extraction
outputImages = [];
wb = waitbar(0, "Thresholding images...");
for x = 1:height(inputImages)
    waitbar(x/height(inputImages), wb, "Thresholding images...");
    imageVector = inputImages(x,:);
    img = reshape(imageVector, 160, 96);
    img = mat2gray(img);
    img = imbinarize(img);
    vector = reshape(img,1, size(img, 1) * size(img, 2));
    vector = double(vector); % / 255;
    outputImages(x,:) = vector;
end
close(wb);
end
function [outputImages] = histogramEqualisation(inputImages)
% Pre-process images using histogram equalisation (HEQ)
wb = waitbar(0, "Applying HEQ to images...");
outputImages = [];
for x = 1:height(inputImages)
    waitbar(x/height(inputImages), wb, "Applying HEQ to images...");
    try
        imageVector = inputImages(x,:);
        img = reshape(imageVector, 160, 96);
        img = mat2gray(img);
        img = histeq(img);
        vector = reshape(img,1, size(img, 1) * size(img, 2));
        vector = double(vector); % / 255;
        outputImages(x,:) = vector;
    catch EX
        fprintf(1, "Unable to apply HEQ to image: %s\n %s", string(x), string(EX.message));
    end
end
close(wb);
end
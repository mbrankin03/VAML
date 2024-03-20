function [outputImages] = contrastLimitedAdaptiveHistogramEqualisation(inputImages)
% Pre-process images using adaptive histogram equalisation (CLAHE)
outputImages = [];
if height(inputImages) > 1
    wb = waitbar(0, "Applying CLAHE to images...");
end
for x = 1:height(inputImages)
    if height(inputImages) > 1
        waitbar(x/height(inputImages), wb, "Applying CLAHE to images...");
    end
    try 
        imageVector = inputImages(x,:);
        img =  reshape(imageVector, 640, 480);
        img = mat2gray(img);
        img = adapthisteq(img);
        vector = reshape(img,1, size(img, 1) * size(img, 2));
        vector = double(vector); % / 255;
        outputImages(x,:) = vector;
    catch EX
        fprintf(1, "Unable to apply CLAHE (adaptive HEQ) to image: %s\n %s", string(x), string(EX.message));
    end
end
if height(inputImages) > 1
    close(wb);
end
end
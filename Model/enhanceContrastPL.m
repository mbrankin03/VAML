function outputImages = enhanceContrastPL(inputImages,gamma)
% Apply power law contrast enhancement to input images
outputImages = [];
Lut = contrast_PL_LUT(gamma);
wb = waitbar(0, "Applying Power Law to images...");
for x=1:height(inputImages)
    waitbar(x/height(inputImages), wb, "Applying Power Law to images...");
    imageVector = inputImages(x,:);
    img = reshape(imageVector, 160, 96);
    img = mat2gray(img);
    img = intlut(uint8(img),Lut);
    vector = reshape(img,1, size(img, 1) * size(img, 2));
    vector = double(vector); % / 255;
    outputImages(x,:) = vector;
end
close(wb)
end


function [outputImages] = hogImages(inputImages)
% Convert reshaped image matrix into array
outputImages = [];
if height(inputImages) > 1
    wb = waitbar(0, "Applying HOG to images...");
end
for x=1:height(inputImages)
    if height(inputImages) > 1
        waitbar(x/height(inputImages), wb, "Applying HOG to images...");
    end
    imageVector = inputImages(x,:);
    img = reshape(imageVector, 160, 96);
    img = mat2gray(img);
    img = hog_feature_vector(img);
    outputImages(x,:) = img;
end
if height(inputImages) > 1
    close(wb);
end
end


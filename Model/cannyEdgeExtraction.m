function [outputImages] = cannyEdgeExtraction(inputImages, threshold)
% Extract edges using Canny edge extraction
outputImages = [];
wb = waitbar(0, "Extracting edges using Canny...");
for x = 1:height(inputImages)
    waitbar(x/height(inputImages), wb, "Extracting edges using Canny...");
    imageVector = inputImages(x,:);
    img = reshape(imageVector, 160, 96);
    img = mat2gray(img);
    if nargin<2
        img = edge(img, "Canny");
    else
        img = edge(img, "Canny", threshold);
    end
    vector = reshape(img,1, size(img, 1) * size(img, 2));
    vector = double(vector); % / 255;
    outputImages(x,:) = vector;
end
close(wb);
end
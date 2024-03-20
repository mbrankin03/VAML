function [outputImages, outputLabels] = createAugmentedImages(images, labels, label, xhundreds)
% Extract edges using Canny edge extraction
% wb = waitbar(0, "Reshaping images...");
% for x = 1:height(inputImages)
%     waitbar(x/height(inputImages), wb, "Reshaping images...");
%     imageVector = inputImages(x,:);
%     img = reshape(imageVector, 160, 96);
%     img = mat2gray(img);
%     outputImages{x} = img;
% end
imgds = imageDatastore("images/" + label + "/", "FileExtensions",[".jpg"]);
augmenter = imageDataAugmenter('RandRotation', [0,35], "RandScale", [0.5, 1.3], "RandXReflection", 1);
augmentedTrainingImages = augmentedImageDatastore([160,96],imgds, 'DataAugmentation', augmenter, 'ColorPreprocessing','rgb2gray');
augmentedTrainingImages.MiniBatchSize = 100;
augmentedTrainingImages.NumObservations
outputImages = images;
outputLabels = labels;
wb = waitbar(0, "Creating augmented images...");
for i=1:xhundreds
    imgs = read(augmentedTrainingImages);
    waitbar(i/xhundreds, wb, "Creating augmented images...");
    for x=1:height(imgs)
        img = imgs{x,1}{1,1};
        img = im2gray(img);
        vector = reshape(img,1, size(img, 1) * size(img, 2));
        vector = double(vector); % / 255;
        outputImages = [outputImages; vector];
        if label == "pos"
            outputLabels = [outputLabels; 1];
        else
            outputLabels = [outputLabels; -1];
        end
    end
end
close(wb);
end
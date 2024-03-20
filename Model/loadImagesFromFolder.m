function [images] = loadImagesFromFolder(filepath)

%Load image set from file
image_dir = dir(filepath + "/*.jpg");
images = [];

wb = waitbar(0, "Loading frames from folder...");

for x = 1:length(image_dir)
    waitbar(x/length(image_dir), wb, "Loading frames from folder...");
    img = imread(image_dir(x).folder + "\" + image_dir(x).name);
    img = im2gray(img);
    vector = reshape(img,1, size(img, 1) * size(img, 2));
    vector = double(vector); % / 255;
    images(x,:) = vector;
end
close(wb);
fprintf(1,"Loaded %s images\n", string(height(images)));

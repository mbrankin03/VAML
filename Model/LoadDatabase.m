function [images, labels] = LoadDatabase(filename, sampling)

if nargin<2
    sampling =1;
end


fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);


line1=fgetl(fp);
line2=fgetl(fp);

numberOfImages = fscanf(fp,'%d',1);

images=[];
labels =[];
wb = waitbar(0, "Loading images from database...");
for im=1:sampling:numberOfImages
    waitbar(im/numberOfImages, wb, "Loading images from database...");
    label = fscanf(fp,'%d',1);
    
    imfile = fscanf(fp,'%s',1);
    I=imread(imfile);
    if size(I,3) < 3
        continue
    end
    if size(I,3)>1
        I=rgb2gray(I);
    end
    vector = reshape(I,1, size(I, 1) * size(I, 2));
    vector = double(vector); % / 255;
    labels= [labels; label];
    images= [images; vector];
    
end
close(wb);
fclose(fp);

end
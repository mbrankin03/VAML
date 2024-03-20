function [] = readVideo(videoFrames, model)
%This function assumes the VideoFrames are already Pre-Processed

totalFrames= size(videoFrames,1);


videoWrite = VideoWriter('pedestrianVideo');
open(videoWrite);

for(i = 1:totalFrames)

    currentImage = videoFrames(i,:);
    reshapedImage = reshape(currentImage,[480,640]);

    outputFrame = slidingWindow(reshapedImage,"horizontal",model)

    writeVideo(videoWrite, outputFrame)

    pause(0.2)
end

close(videoWrite);


end


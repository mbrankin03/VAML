function [videoFrame] = slidingWindow(image,type,model)
   %This function assumes image is already pre-processed
   % Returns frame to be used in the video

   


    if(type == "horizontal")
    
      getPredictedBoxes(image,model,"horizontal")

    end
    if(type == "vertical")
        image = imrotate(image,90)
        imshow(image)

        imageIterate(image,[160,96],model,"vertical") 

        fig = gcf
        frame = getframe(fig)

        % frame from earlier
        img = frame2im(frame)

        % rotate image back to original orientation
        figure
        imshow(imrotate(img,-90))

    end

    %Gets outputted figure
    currentFigure = gcf
    foundFrame = getframe(currentFigure)

    %Turns into frame and writes to video
    videoFrame= frame2im(foundFrame)
 


end
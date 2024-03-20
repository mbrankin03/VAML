function [predictedBoxes] = getPredictedBoxes(image, model,type)
%This function assumes the image has already been pre processed and feature
%extracted

addpath("PedestrianProcessing")

image = mat2gray(image);

if(type == "horizontal")
    % Uncomment this to see what image looks like after sliding window
    figure
    imshow(image)

    %Gets models predicted guesses from sliding window
    guesses = imageIterate(image,[96,160],model,'horizontal');
end

if(type == "vertical")
    %vertical sliding accomplished by rotating image
    image = imrotate(image,90)

    figure
    imshow(image)


    %Gets models predicted guesses from sliding window
    guesses = imageIterate(image,[160,96],model,'vertical')
end

%==============Extra knn calculations========================
% Calculates each bounding boxes intersections with every other bounding
% box
%allIntersections = getIntersections(guesses,[96,160]);

% Filters boxes with that are below an intersection threshold
%thresholdedGuesses = intersectThreshold([96,160],allIntersections,0.45);

% Gets the box with the most intersections
%rankedIntersections = rankIntersections(thresholdedGuesses);

%predictedBoxes = rankedIntersections
%===========================================================

verdicts = guesses(:,5);

selectedBbox = selectStrongestBbox(guesses(:,1:4),verdicts);

% Plots output boxes (optional)

if(type == "horizontal")
    plotBoxes(image,selectedBbox,[96,160]); 
else
    plotBoxes(image,selectedBbox,[160,96]'); % for vertical
end

predictedBoxes = selectedBbox;

end


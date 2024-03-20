function [outputArg1] = getIntersections(boxes,boxSize)

canvasWidth = boxSize(1)
canvasHeight = boxSize(2)

totalEntries = size(boxes,1)

%Store coordinates and intersections of each box
intersections = []

for(index = 1:totalEntries)
    currentBox = boxes(index,:)

    for(otherBoxIndex = 1: totalEntries)
        otherBox = boxes(otherBoxIndex,:)
          
        % check that boxes are not equal, the difference between box height
        % and other box height is less than canvasHeight and that box width
        % and other box width is less than canvasWidth
       if(all(currentBox ~= otherBox) && abs(currentBox(1) - otherBox(1)) < canvasHeight ...
               && abs(currentBox(2) - otherBox(2)) < canvasWidth)
           
           
           currentBoxRect = [currentBox(1),currentBox(2),canvasWidth,canvasHeight]
           otherBoxRect = [otherBox(1),otherBox(2),canvasWidth,canvasHeight]
                
           calc = rectint(currentBoxRect,otherBoxRect)

           row = [currentBox,otherBox,calc]
           intersections = [intersections;row]

       end
    end
end




outputArg1 = intersections


end
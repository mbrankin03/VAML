function [] = plotBoxes(image,rectangles)
%This function is for plotting the actual boxes we get from the test
%dataset

figure
imshow(image)

for(rows = 1:size(rectangles,1))
    currentRectangle = rectangles(rows,:)

    rectangle('Position', [ currentRectangle(1),currentRectangle(2), ...
        currentRectangle(3),currentRectangle(4)], 'EdgeColor', 'r', 'LineWidth', 2); 
end
   
end


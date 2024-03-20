function [] = plotBoxes(image,rectangles,canvasSize)

figure
imshow(image)

for(rows = 1:size(rectangles,1))
    currentRectangle = rectangles(rows,:)

    rectangle('Position', [ currentRectangle(2),currentRectangle(1), canvasSize(1),canvasSize(2)], 'EdgeColor', 'g', 'LineWidth', 2); 
end
   
end


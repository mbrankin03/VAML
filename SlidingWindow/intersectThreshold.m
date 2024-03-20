function [outputArg1] = intersectThreshold(canvasSize,entries,fraction)

canvasWidth = canvasSize(1)
canvasHeight = canvasSize(2)

maximumIntersection = canvasWidth * canvasHeight
percentageIntersection = maximumIntersection * fraction

thresholdedIntersections = []
totalEntries = size(entries,1)

for(valueIndex = 1:totalEntries)
    row = entries(valueIndex,:)
    intersection = row(1,5)

    calculation = intersection / maximumIntersection 

    if(calculation > fraction )

        thresholdedIntersections = [thresholdedIntersections;row]
    end
end

outputArg1 = thresholdedIntersections;

end


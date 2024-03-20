function [outputArg1] = rankIntersections(thresh)

columnValues = unique(thresh(:,1))

%actual values of thresh
columns = thresh(:,1);
rowValues = thresh(:,2);

ranked = []

for(threshIndex = 1:size(columnValues,1))

    currentValue = columnValues(threshIndex);
    
    specificColumn = columns == currentValue;
    
    foundRows = thresh(specificColumn,:)
    rowValues = foundRows(:,2)

    mostCommonRow = median(rowValues);
 
    %hardcoding size for now
    ranked= [ranked;currentValue,mostCommonRow,96,160]

end




outputArg1 = ranked

end


function [pos] = imageIterate(matrix,canvasSize, model,type)

%size of canvas
canvasX = canvasSize(1)
canvasY = canvasSize(2)

%Size of matrix
matrixRowSize = size(matrix,1)
matrixColSize = size(matrix,2)

%Offsets,
%how many pixel intervals till another frame is taken
columnInterval = 20
rowInterval = 20

%Recording positions x and y coordinates of the top left corner of a square
pos = []

% Prevent row threshold going out of bounds
 for(currRowIndex = 1:rowInterval: matrixRowSize - canvasY)
     rowThreshold = currRowIndex+canvasY;



    % prevent column index going out of bounds
      for (currColIndex = 1:columnInterval: matrixColSize - canvasX)
                columnThreshold = currColIndex+canvasX;
  

        fract = double(matrix(currRowIndex:rowThreshold-1,currColIndex:columnThreshold-1));

        image = mat2gray(fract);
   
        hoggy = hog_feature_vector(image);

        %verdict = KNNTesting(hoggy,model,7);
        verdict = SVMTestingWindow(hoggy,model);

        if(verdict(2) > 0.8)%% vertical threshold is 0.4 horizontal is 0.8
            rectangle('Position', [currColIndex, currRowIndex, canvasX, canvasY], 'EdgeColor', 'g', 'LineWidth', 2);  
            
            if(type == "vertical")
               %for svm
               pos = [pos;currColIndex,currRowIndex ,canvasX, canvasY,verdict(2)];


               % for knn
               %pos = [pos;currColIndex,currRowIndex];
                continue
            end
            
            %for svm
            pos = [pos;currRowIndex,currColIndex, canvasX, canvasY,verdict(2)];
            
            % for knn
            %pos = [pos;currRowIndex,currColIndex];
        end
      end    
 end

end


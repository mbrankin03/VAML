function [rates,confusionMatrix] = confusionMatrix(labels, predictions, showmat)

numImages = length(predictions);
pedestrainsPredicted = sum(predictions ==1);
compare = (labels == predictions);

%Accuracy
accuracy = sum(compare) / numImages;
fprintf('Prediction- Pedestrian =  %d , Non-pedestrian = %d ', pedestrainsPredicted, numImages - pedestrainsPredicted);

%Confusion Matrix
%       -1   1
%  -1   TN   FP
%   1   FN   TP

confusionMatrix = confusionmat(labels, predictions);
TN = confusionMatrix(1,1);
FP = confusionMatrix(1,2);
FN = confusionMatrix(2,1);
TP = confusionMatrix(2,2);

rates.precision = TP / (TP+FP);
rates.recall = TP / (TP+FN);
rates.f1 = 2*TP / (2*TP + FN + FP);
rates.specificity = TN / (TN+FP);
rates.falseAlarm = FP / (FP + TN);
rates.accuracy = 100 * accuracy;

fprintf('Precision Rate : %.2f\n', rates.precision);
fprintf('Recall Rate : %.2f\n', rates.recall);
fprintf('F1 Rate : %.2f\n', rates.f1);
fprintf('Specificity Rate : %.2f\n', rates.specificity);
fprintf('Accuracy : %.2f%%\n', rates.accuracy);
fprintf('False Alarm Rate : %.2f\n', rates.falseAlarm);

if showmat
    confusionchart(labels,  predictions);
end

end
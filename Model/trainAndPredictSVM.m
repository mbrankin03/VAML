function [testPredictions, model] = trainAndPredictSVM(trainingImages, trainingLabels, testingImages, kernel)
%Train SVM model using training data and gather predictions from test set
model = SVMtraining(trainingImages, trainingLabels, kernel);
testPredictions = [];
wb = waitbar(0, "Gathering SVM predictions....");
for x=1:size(testingImages,1)
    waitbar(x/size(testingImages,1), wb, "Gathering SVM predictions....");
    testPredictions = [testPredictions; SVMTesting(testingImages(x,:), model)];
end
close(wb)
end


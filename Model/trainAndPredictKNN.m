function [testPredictions, model] = trainAndPredictKNN(trainingImages, trainingLabels, testingImages, K)
%Train SVM model using training data and gather predictions from test set
model = KNNtraining(trainingImages, trainingLabels);
testPredictions = [];
wb = waitbar(0, "Gathering K-NN predictions....");
for x=1:height(testingImages)
    waitbar(x/height(testingImages), wb, "Gathering K-NN predictions....");
    testPredictions = [testPredictions; KNNTesting(testingImages(x,:), model, K)];
end
close(wb)
end

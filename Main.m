%clear all
%close all
addpath ./SVM-KM/

%% Load in images %%
[trainingImages, trainingLabels] = LoadDatabase('pedestrianTrainingImages.cdataset');
%[testingImages, testingLabels] = LoadDatabase('pedestrianTestingImages.cdataset');

%% Augment images %%
[trainingImages, trainingLabels] = augmentImages(trainingImages, trainingLabels, "pos", 5);
[testingImages, testingLabels] = augmentImages(testingImages, testingLabels, "neg", 5);

%% Preprocessing %%

% Histogram equalisation
trainingImages = histogramEqualisation(trainingImages);
%testingImages = histogramEqualisation(testingImages);

% Contrast limited adaptive histogram equalisation(CLAHE)
%trainingImages = contrastLimitedAdaptiveHistogramEqualisation(trainingImages);
%testingImages = contrastLimitedAdaptiveHistogramEqualisation(testingImages);

% Power law contrast enhancement
%gamma = 2;
%trainingImages = enhanceContrastPL(trainingImages, gamma);
%testingImages = enhanceContrastPL(testingImages, gamma);

%% feature extraction %%
% Histogram of gradients
trainingImages = hogImages(trainingImages);
%testingImages = hogImages(testingImages);

% Canny Edge
%trainingImages = cannyEdgeExtraction(trainingImages);
%testingImages = cannyEdgeExtraction(testingImages);

% Thresholding
%trainingImages = thresholdImages(trainingImages);
%testingImages = thresholdImages(testingImages);

%% classification and training %%

% K-NN - HOLDOUT
testResults = trainAndPredictKNN(trainingImages, trainingLabels, testingImages, 5);

% SVM - HOLDOUT ('gaussian', 'rbf', or 'linear')
%[testResults, model] = trainAndPredictSVM(trainingImages, trainingLabels, testingImages, 'linear');

%% Validation %%
% Train/Test Knn using K-Fold cross validation
%kFoldCrossValidation(trainingImages, trainingLabels, testingImages, testingLabels, 2, @trainAndPredictKNN, 5);

% Train/Test SVM using K-Fold cross validation ('gaussian', 'rbf', or 'linear')
%kFoldCrossValidation(trainingImages, trainingLabels, testingImages, testingLabels, 10, @trainAndPredictSVM, 'linear');

% Create confusion matrix
confusionMatrix(testResults, testingLabels, true);

%% Sliding Window Detection

addpath("PedestrianProcessing")
addpath("SlidingWindow")

%knnModel = KNNtraining(trainingImages,trainingLabels)
model = SVMtraining(trainingImages,trainingLabels,'gaussian')
%%
vidImages = loadImagesFromFolder("pedestrian");

%Pre processing
vidImages = histogramEqualisationPed(vidImages);
%vidImages  = contrastLimitedAdaptiveHistogramEqualisationPed(vidImages);

%Features
%vidImages = thresholdImagesPed(vidImagesEQ);
%vidImages = cannyEdgeExtractionPed(vidImagesThresh);

%%
addpath("TestWindow")

%Test detections
%Use svm or knn model to test
testDetection(vidImages,model,'horizontal')
%testDetection(vidImages,model,'vertical')

%Create output video
%readVideo(vidImagesEQ,model)

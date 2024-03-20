function [model] = kFoldCrossValidation(trainingImages,trainingLabels, testingImages, testingLabels, folds, trainAndPredictFun, funArg)
imageSet = [trainingImages; testingImages];
labelSet = [trainingLabels; testingLabels];
partitions = cvpartition(height(imageSet), "KFold", folds);
wb = waitbar(0, "Training/Testing using K-Fold...");
accuracies = [];
f1s = [];
precisions = [];
recalls = [];
specificities = [];
falseAlarms = [];
for fold = 1:partitions.NumTestSets
    waitbar(fold/folds, wb, "Training/Testing using K-Fold...");
    trainingPartition = partitions.training(fold);
    testingPartition = partitions.test(fold);
    trainingImageSet = [];
    trainingLabelSet = [];
    testingImageSet = [];
    testingLabelSet = [];
    for trainIndex=1:height(trainingPartition)
        if trainingPartition(trainIndex) == 1;
            trainingImageSet = [trainingImageSet; imageSet(trainIndex, :)];
            trainingLabelSet = [trainingLabelSet; labelSet(trainIndex, :)];
        end
    end
    for testIndex=1:height(testingPartition)
        if testingPartition(testIndex) == 1;
            testingImageSet = [testingImageSet; imageSet(testIndex, :)];
            testingLabelSet = [testingLabelSet; labelSet(testIndex, :)];
        end
    end
    [predictions, model] = trainAndPredictFun(trainingImageSet, trainingLabelSet, testingImageSet, funArg);
    [results, confusionmat] = confusionMatrix(testingLabelSet, predictions, false);
    precisions = [precisions; results.precision];
    recalls = [recalls; results.recall];
    f1s = [f1s; results.f1];
    specificities = [specificities; results.specificity];
    falseAlarms = [falseAlarms; results.falseAlarm];
    accuracies = [accuracies; results.accuracy];

    clf();
    hold on
    plot(precisions, "-og");
    plot(recalls, "-oc");
    plot(f1s, "-ob");
    plot(specificities, "-om");
    plot(falseAlarms, "-ok");
    plot(accuracies/100, "-or");
    set(gca, 'xtick',1:folds);
    set(gca,'xlim',[1,folds]);
    set(gca, 'ylim',0:1)
    hold off
    lgd = legend("Precision Rate", "Recall Rate", "F1 Rate", "Specificity Rate", "False Alarm Rate", "Accuracy");
    lgd.Location = 'southwest';
    lgd.Orientation = 'vertical';
    lgd.FontSize = 5;
    xlabel('Fold')
    ylabel('Rate')
end
hold off
close(wb);
fprintf('Precision rate over all folds: %.2f\n', mean2(precisions));
fprintf('Recall rate over all folds: %.2f\n', mean2(recalls));
fprintf('F1 Rate over all folds: %.2f\n', mean2(f1s));
fprintf('Specificity Rate over all folds: %.2f\n', mean2(specificities));
fprintf('False Alarm Rate over all folds: %.2f\n', mean2(falseAlarms));
fprintf('Accuracy over all folds: %.2f\n', mean2(accuracies));
disp(mean2(f1s));
disp(mean2(specificities));
disp(mean2(accuracies));
disp(mean2(falseAlarms));
disp(mean2(precisions));
disp(mean2(recalls));
end
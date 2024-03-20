function prediction = KNNTesting(testImage, modelNN, K)
distances = zeros(height(modelNN.neighbours),1);
for x = 1:height(modelNN.neighbours)
    distances(x) = EuclideanDistance(testImage, modelNN.neighbours(x,:));
end

sorted = sort(distances);
for i = 1:K
   sample = find(distances==sorted(i));
   closest(i) = sample(1);
end
prediction = mode(modelNN.labels(closest));

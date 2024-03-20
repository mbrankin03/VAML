function dEuc=EuclideanDistance(sample1, sample2)
total = 0;
for y = 1:length(sample1)
    total = total + (sample1(y) - sample2(y)) .^ 2;
end
dEuc = sqrt(total);
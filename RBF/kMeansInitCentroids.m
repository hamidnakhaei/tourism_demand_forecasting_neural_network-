function centroids = kMeansInitCentroids(X, k)

centroids = zeros(k, size(X, 2));

randidx = randperm(size(X, 1));

centroids = X(randidx(1:k), :);

end


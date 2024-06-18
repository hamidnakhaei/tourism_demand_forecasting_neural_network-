function [centroids, memberships] = kMeans(X, initial_centroids, max_iters)

k = size(initial_centroids, 1);
centroids = initial_centroids;
prevCentroids = centroids;
% Run K-Means
for (i = 1 : max_iters)
    
    % Output progress
    fprintf('K-Means iteration %d / %d...\n', i, max_iters);
   
    % For each example in X, assign it to the closest centroid
    memberships = findClosestCentroids(X, centroids);
        
    % Given the memberships, compute new centroids
    centroids = computeCentroids(X, centroids, memberships, k);
    if (prevCentroids == centroids)
        fprintf('Stopping after %d iterations.\n', i);
        break;
    end

    prevCentroids = centroids;
end

end


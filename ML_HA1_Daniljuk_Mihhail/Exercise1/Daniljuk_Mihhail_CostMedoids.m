% Function that reassigns the labels of every point to the closest medoid
% Also computes the total cost and returns labels and cost when terminates
function [labels,value] = Daniljuk_Mihhail_CostMedoids(data, medoids, idxs)

[rows, cols] = size(data);
[K,~] = size(medoids);
cost = 0;

for i=1:rows
    if ismember(i, idxs)
        minIdx(i,:) = 0;
    else
        % If point is not a medoid we compute distances to every medoid and
        % find it's closest medoid, also compute the cost, as sum of these
        % minimum distances
        for j=1:K
            distances(j) = Daniljuk_Mihhail_Distance_Euclidean(data(i,:), medoids(j,:));
        end
        [minDistrow,minDistCol] = find(min(distances) == distances);
        minIdx(i,:) = minDistCol(1,1);
        cost = cost + min(distances);
    end
end
value = cost;
labels = minIdx;
end
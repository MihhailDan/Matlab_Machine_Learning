function [lb, data, med] = Daniljuk_Mihhail_KMedoids(DS, K, distFun)

rng(1);
[rows, cols] = size(DS);
labels = DS(:,cols);
DS = DS(:,1:cols-1);

[medoids, medoid_IDX] = Daniljuk_Mihhail_Medoids_Generation(DS,K);

[labels, cost] = Daniljuk_Mihhail_CostMedoids(DS, medoids, medoid_IDX);
newCost = inf;


"Computing"
count = 1;
% Swap the medoids with other points till the change in cost is below the
% threshold
while abs(newCost - cost) > 0.000001 
    Daniljuk_Mihhail_Plot_Result(DS, labels, K, count, "Iteration " + string(count));
    newCost = cost;
    for i=1:rows
        if ismember(i, medoid_IDX)
        else
            % saving datarow and labels before swap
            temp = DS(i,:);
            tempLabels = labels;
            for j=1:K
                % Perfofming swap wiith curreent medoid
                tempIDX = medoid_IDX(j);
                DS(i,:) = medoids(j,:);
                medoids(j,:) = temp;
                medoid_IDX(1,j) = i;
                
                % Recomputing cost and labels
                [labels,swapCost] = Daniljuk_Mihhail_CostMedoids(DS, medoids, medoid_IDX);

                % Undo the swap if new cost is higher
                if swapCost >= cost
                    medoid_IDX(1,j) = tempIDX;
                    medoids(j,:) = DS(i,:);
                    DS(i,:) = temp;
                    labels = tempLabels;
                else
                    cost = swapCost;
                end
            end
        end
    end
    count = count + 1;
end

Medoids_After_Clustering = medoids

lb = labels;
data = DS;
med = medoids;
end
function [value, IDX] = Daniljuk_Mihhail_Medoids_Generation(DS, K)

[rows, cols] = size(DS);

medoid_IDX = randi([1,rows],1,K);
for i=1:K
    medoid(i,:) = DS(medoid_IDX(i), :);
end

value = medoid;
IDX = medoid_IDX;
end

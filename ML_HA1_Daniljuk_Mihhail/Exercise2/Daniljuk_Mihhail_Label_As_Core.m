% Function marks point as core point if it satisfies conditions of DBSCAN
function value = Daniljuk_Mihhail_Label_As_Core(point, DataSet, eps, min_elem)

[rows,cols] = size(DataSet);
countElem = 0;
for i=1:rows
    if Daniljuk_Mihhail_Distance_Euclidean(point, DataSet(i,:)) <= eps
        countElem = countElem + 1;
        if countElem >= min_elem + 1
            value = 1;
            break;
        end
    end
    value = 0;
end


end
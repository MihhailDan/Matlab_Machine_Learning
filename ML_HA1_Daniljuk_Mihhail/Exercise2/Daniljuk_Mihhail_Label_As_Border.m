% Function marks points as border points 
function value = Daniljuk_Mihhail_Label_As_Border(point, corePoints, eps)

[rows,cols] = size(corePoints);
for i=1:rows
    if Daniljuk_Mihhail_Distance_Euclidean(point, corePoints(i,:)) <= eps
        value = 2;
        break;
    end
    value = 3;
end

end
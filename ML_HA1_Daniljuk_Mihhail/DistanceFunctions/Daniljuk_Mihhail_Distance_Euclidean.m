function value=Daniljuk_Mihhail_Distance_Euclidean(p1,p2)

dimensionality = length(p1);

vSum = 0;
for i=1:dimensionality
    vSum = vSum + (p1(i) - p2(i))^2;
end

value = sqrt(vSum);
end
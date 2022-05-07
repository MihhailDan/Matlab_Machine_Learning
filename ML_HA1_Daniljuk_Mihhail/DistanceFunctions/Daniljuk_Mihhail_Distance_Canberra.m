function value = Daniljuk_Mihhail_Distance_Canberra(p1,p2)

dim = length(p1);
vSum = 0;

for i=1:dim
    vSum = vSum + (abs(p1(i) - p2(i))) / (abs(p1(i)) + abs(p2(i)));
end

value = vSum;
end
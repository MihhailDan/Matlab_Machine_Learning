function value = Daniljuk_Mihhail_Distance_Minkowsky(p1,p2,p)

dim = length(p1);
vSum = 0;

for i=1:dim
    vSum = vSum + abs(p1(i) - p2(i))^p;
end

value = vSum ^ (1/p);
end
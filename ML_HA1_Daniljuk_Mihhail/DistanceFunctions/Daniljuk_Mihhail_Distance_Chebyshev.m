function value = Daniljuk_Mihhail_Distance_Chebyshev(p1, p2)

dim = length(p1);
value = max((p1 - p2));
for i=1:dim
    dists(i) = abs(p1(i) - p2(i));
end

value = max(dists);
function cost = Daniljuk_Mihhail_CostFunc(outs, labels)
    errors = (outs-labels).^2;
    cost = sqrt(sum(errors));
end
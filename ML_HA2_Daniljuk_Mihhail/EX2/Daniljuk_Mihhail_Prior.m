function prior = Daniljuk_Mihhail_Prior(data, label)

    rows_total = size(data,1);
    
    for i=1:length(unique(label))
        rows_class = length(find(label(:,end) == i));
        prior(i) = rows_class / rows_total;
    end
end
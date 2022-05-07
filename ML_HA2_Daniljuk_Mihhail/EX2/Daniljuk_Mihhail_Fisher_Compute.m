function value = Daniljuk_Mihhail_Fisher_Compute(DS)

    [rows, cols] = size(DS);
    unique_labels = unique(DS(:,cols));
    
    
    for i=1:cols-1
        feature_mean = mean(DS(:,i));
        numerator = 0;
        denominator = 0;
        for j=unique_labels'
            filtered_data = DS(find(DS(:,cols) == j), i);
            MuJ = mean(filtered_data);
            pJ = size(find(DS(:,cols) == j), 1);
    
            stdj = std(filtered_data)^2;
            numerator = numerator + pJ * (MuJ - feature_mean)^2;
            denominator = denominator + pJ*stdj;
        end
    
        fisher_Scores(i) = numerator / denominator;
    end

    value = fisher_Scores;
end
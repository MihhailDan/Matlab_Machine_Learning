function D = Daniljuk_Mihhail_Filtering_Data(fishers, DS, threshold)

    D = [];
    for i =1:length(fishers)
        if fishers(i) > threshold
            D = [D, DS(:,i)];
        end
    end

end
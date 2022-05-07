function neuronGridFlat = Daniljuk_Mihhail_Initialize_Net(size_of_grid, cols)
    
    for i = 1:size_of_grid
        for j = 1:size_of_grid
            neuronGridFlat(size_of_grid * (i-1) + j ,:) = rand(1, cols) * 2-1;
        end
    end
    
end
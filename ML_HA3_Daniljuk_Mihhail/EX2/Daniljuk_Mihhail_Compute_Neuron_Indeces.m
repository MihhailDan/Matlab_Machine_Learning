function indeces = Daniljuk_Mihhail_Compute_Neuron_Indeces(size_of_grid)

    % Generating table of indecies for grid
    for k = 0: size_of_grid*size_of_grid
        k = int32(k);
        indeces(k+1,1) = idivide(k, size_of_grid) + 1;
        indeces(k+1,2) = mod(k,size_of_grid)+1;
    end
    indeces = indeces(1:size_of_grid*size_of_grid,:);
end
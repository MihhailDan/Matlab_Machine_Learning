function layer_coefs = Daniljuk_Mihhail_Model_Init(structure, num_of_layers)
    for i = 1:num_of_layers-1
        layer_coefs(i).weights = rand(structure(i), structure(i+1)) * 2-1;
        layer_coefs(i).bias = rand(1, structure(i+1))*2-1;
    end

end
function layer_coefs = Daniljuk_Mihhail_BackProp(layer_coefs, output, num_of_layers, XOR_data, labels)
    partial_prod = Daniljuk_Mihhail_CostFunc_Partial_Deriv(output,labels);
    for i = (num_of_layers - 1):-1:1
        partial_prod = partial_prod .* layer_coefs(i).deriv;
        layer_coefs(i).weights_deriv = (partial_prod' * Daniljuk_Mihhail_Weights_Partial_Deriv(layer_coefs, i, XOR_data))';
        layer_coefs(i).bias_deriv = sum(partial_prod,1);
        if i ~= 1
            % partial_prod = sum(partial_prod' .* Daniljuk_Mihhail_Prev_Activation_Partial_Deriv(layer_coefs,i),2);
            partial_prod = partial_prod * Daniljuk_Mihhail_Prev_Activation_Partial_Deriv(layer_coefs,i)';
        end
    end
end
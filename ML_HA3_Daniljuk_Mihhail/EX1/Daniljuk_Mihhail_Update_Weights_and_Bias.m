function layer_coefs = Daniljuk_Mihhail_Update_Weights_and_Bias(layer_coefs, learning_rate, num_of_layers)
    for i =1:num_of_layers-1
        layer_coefs(i).weights = layer_coefs(i).weights - learning_rate .* layer_coefs(i).weights_deriv;
        layer_coefs(i).bias = layer_coefs(i).bias - learning_rate .* layer_coefs(i).bias_deriv;
    end
end
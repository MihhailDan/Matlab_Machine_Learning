function [output, layer_coefs] = Daniljuk_Mihhail_ForwardProp(input, layer_coefs, num_of_layers)
    a = input;
    for i = 1:num_of_layers-1
        z = a * layer_coefs(i).weights + layer_coefs(i).bias;
        a = Daniljuk_Mihhail_Sigmoid(z);
        layer_coefs(i).activations = a;
        layer_coefs(i).deriv = Daniljuk_Mihhail_Sigmoid_Partial_Deriv(a);
    end
    output = a;
end
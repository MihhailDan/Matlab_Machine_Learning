function deriv = Daniljuk_Mihhail_Weights_Deriv(layer_coefs, L, input)
    if L == 1
        deriv = input;
    else
        deriv = layer_coefs(L-1).activations;
    end
end
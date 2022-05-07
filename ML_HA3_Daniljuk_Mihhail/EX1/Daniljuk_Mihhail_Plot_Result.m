function Daniljuk_Mihhail_Plot_Result(layer_coefs, num_of_layers, XOR_data, labels)

    % Plotting the heatmap, function provided by Gabor Visky
    fh(1) = figure(1);
    clf(fh(1));
    span = -1:.005:1;
    [P1,P2] = meshgrid(span,span);
    pp = [P1(:) P2(:)];
    
    output = Daniljuk_Mihhail_ForwardProp(pp, layer_coefs,num_of_layers);
    mesh(P1,P2,reshape(output, length(span), length(span)));
    hold on ;
    title("NN 10 and 5 neurons 2 hidden layers respectively");
    
    % Plotting datapoints
    Daniljuk_Mihhail_Plot_Data(XOR_data, labels);

end
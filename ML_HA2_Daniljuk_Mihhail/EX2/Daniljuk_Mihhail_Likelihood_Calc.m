function like = Daniljuk_Mihhail_Likelihood_Calc(data, feat, feat_val, Y, label)
    
    data = data(find(Y(:,end) == label),:);
    length(find(Y(:,end) == label));
    mean_d = mean(data(:,feat));
    std_d = std(data(:,feat));

    % Calculating probability for gaussian distribution
    prob_x_given_y = (1 / (sqrt(2*pi)*std_d)) * exp((-1/2) * ((feat_val - mean_d)^2 / (std_d)^2));
    like = prob_x_given_y;
end
function labels_predicted = Daniljuk_Mihhail_Naive_Bayes(train, test_data, labels)

    [rows,cols] = size(test_data);

    % Calculating prior probabilities
    prior = Daniljuk_Mihhail_Prior(train,labels);
    lbls = unique(labels(:,end));
    
    % Calculating likelihoods and posterior probability, then choose label
    % with maximum probability value
    for i=1:rows
        for j = 1:length(lbls)
            likelihood_x(j,1) = 1;
            for k=1:cols
                likelihood_x(j,1) = likelihood_x(j,1) * Daniljuk_Mihhail_Likelihood_Calc(train, k, test_data(i,k), labels, lbls(j));
            end
        end
    
        % Calc
        for j = 1:length(lbls)
            post_prob(j,1) = prior(j) * likelihood_x(j,1);
        end
        
        max_prob= max(post_prob);
        labels_predicted(i,1) = find(post_prob == max_prob);
    end
end
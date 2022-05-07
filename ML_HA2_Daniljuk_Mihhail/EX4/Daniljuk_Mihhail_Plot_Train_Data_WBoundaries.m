function Daniljuk_Mihhail_Plot_Train_Data_WBoundaries(DS_train,train_labels, dec_tree,count)
    
    uni = unique(train_labels);
    
    fh(count) = figure(count);
    clf(fh(count));
    
    % Plotting data points
    for j=1:length(uni)
        switch j
            case 0
                cl = 'green';
            case 1
                cl = 'red';
            case 2 
                cl = 'magenta';
            case 3
                cl = "blue";
            case 4
                cl = "yellow";
        end
    
        cluster = find(train_labels==j);
        scatter(DS_train(cluster,1), DS_train(cluster,2), cl)
        axis equal;
        grid on
        hold on
        title("Train data " + string(count));
    end
    
    % Plotting boundaries
    if ismember(2, dec_tree(:,1))
        yline(dec_tree(1,2));
    else
        xline(dec_tree(1,2));
    end

end
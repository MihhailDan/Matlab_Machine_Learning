% Function plots the test data with boundaries and predicted labels
function Daniljuk_Mihhail_Plot_Test_Results(DS_test, dec_tree, count, k)
    
    fh(count+k) = figure(count+k);
    clf(fh(count+k))

    % Plotting data points
    for j =1 :length(unique(DS_test(:,5)))
        switch j
            case 1
                cl = "red";
            case 2
                cl = "blue";
        end
    
        cluster = find(DS_test(:,5) == j);
        scatter(DS_test(cluster,1), DS_test(cluster,2));
        hold on;
        grid on;
        axis equal;
        title("Test data " + string(count));
    end
    
    % Plotting boundaries
    if ismember(2, dec_tree(:,1))
        yline(dec_tree(1,2));
    else
        xline(dec_tree(1,2));
    end

end
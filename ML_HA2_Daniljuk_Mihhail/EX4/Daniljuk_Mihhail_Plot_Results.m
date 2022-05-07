% Function plots the resulting data with boundaries and predicted labels

function Daniljuk_Mihhail_Plot_Results(DS_test, model, count, k, tree_num)
    
    fh(count+k) = figure(count+k);
    clf(fh(count+k))

    % Plotting data points
    for j =1 :length(unique(DS_test(:,3)))
        switch j
            case 1
                cl = "red";
            case 2
                cl = "blue";
        end
    
        cluster = find(DS_test(:,3) == j);
        scatter(DS_test(cluster,1), DS_test(cluster,2));
        hold on;
        grid on;
        axis equal;
        title(strcat("Resulting ", num2str(tree_num)," trees"));
    end
    
    % Plotting boundaries
    for i =1:size(model,1)
        if ismember(2, model(i,1))
            yline(model(i,2));
        else
            xline(model(i,2));
        end
    end
    
    saveas(fh(count+k),"AdaBoostLess.png");
end
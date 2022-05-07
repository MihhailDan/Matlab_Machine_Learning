function Daniljuk_Mihhail_Plot_Result(predicted_labels, labels_valid, D_valid, count)
    fh(count) = figure(count);
    clf(fh(count));
    
    % For each point determine edge color and face color
    for i=1:length(labels_valid)
        if predicted_labels(i,1) == 1
            cl = "yellow";
        else
            cl = "blue";
        end
    
        if labels_valid(i,1) == 1
            cl2 = "yellow";
        else
            cl2 = "blue";
        end
    
        scatter(D_valid(i,1), D_valid(i,2), "o", "MarkerFaceColor",cl,"MarkerEdgeColor",cl2);
        grid on
        hold on
        title("Naive Bayes classifier results");
    end

    saveas(fh(count), "Bayes_result.png");
end
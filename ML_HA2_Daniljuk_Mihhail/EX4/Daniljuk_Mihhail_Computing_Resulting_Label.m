% Function computes resulting label according to weights and predictions of
% each model
function labels = Daniljuk_Mihhail_Computing_Resulting_Label(lbls, model)

    for l=1:size(lbls,2)
        lbls(find(lbls(:,l) == 2), l) = -1;
    end


    for l=1:size(lbls, 1)
        num = lbls(l,:) * model(:,5);
        if num < 0
            labels(l,1) = 2;
        else
            labels(l,1) = 1;
        end
    end
end
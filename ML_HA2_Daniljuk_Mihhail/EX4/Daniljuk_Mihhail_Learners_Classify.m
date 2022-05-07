% Function predicts labels using decision tree for data set provided as arguments.

function lbls = Daniljuk_Mihhail_Learners_Classify(DS_test, dec_tree)

    [rows_test, ~] = size(DS_test);
    
    for i=1:rows_test
        count = 1;
        ith_DS = DS_test;
        for j = dec_tree(:,1)'
            if ith_DS(i,j) > dec_tree(count,2)
                if dec_tree(count,3) ~= 0
                    DS_test(i,5) = dec_tree(count,3);
                    break
                end
            else
                if dec_tree(count,4) ~= 0
                    DS_test(i,5) = dec_tree(count,4);
                    break
                end
            end
            if length(unique(dec_tree(:,1))) > 1 || ~ismember(2,dec_tree(:,1))
                ith_DS = [ith_DS(:,1:j-1),ith_DS(:,j+1:end)];
            end
            count = count + 1;
        end
    end
    
    lbls = DS_test(:,5);
end
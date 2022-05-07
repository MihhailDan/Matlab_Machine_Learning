% Function to grow the stump, that is the tree with one split only
function value = Daniljuk_Mihhail_GrowStump(DS_train)

    % Initializing variables
    train_labels = DS_train(:,3);
    partitionNum = 100;
    count = 1;
    results = zeros(1,5);
    
    % Computing the entropy of the whole DS
    for i=unique(train_labels)'
        class_costs(i) = length(find(DS_train(:,3) == i)) / length(DS_train);
    end
    vSumTotal = 0;
    for j=class_costs
        vSumTotal = vSumTotal + j * log2(j);
    end
    vSumTotal = -1 * vSumTotal;
    

    % Running loop 1 time, so I get a stump, not a tree
    vSum = vSumTotal;
    while count <= 1
        vSum = vSumTotal;
        flag = true;
        for i=1:2   % featureNumber-count
            featureCol = DS_train(:,i);
            labeledFeature = [featureCol, train_labels];
            sortedFeature = sortrows(labeledFeature,1);
            intervals = linspace(min(sortedFeature(:,1)), max(sortedFeature(:,1)), partitionNum+1);
    
            % Splitting feature into subsets
            for j=intervals(2:partitionNum)
                ss1 = sortedFeature(find(sortedFeature(:,1) > j),:);
                ss2 = sortedFeature(find(sortedFeature(:,1) < j),:);
                splitEntropy = Daniljuk_Mihhail_Entropy_Calculation(ss1,ss2);
    
                if splitEntropy < vSum
                    prevSS1 = ss1;
                    prevSS2 = ss2;
                    vSum = splitEntropy;
                    fatureToAsk = i;
                    linePos = j;
                    [trueBranch, falseBranch] =Daniljuk_Mihhail_Defining_True_False(ss1,ss2,count,1);
                    flag = false;
                end
            end
        end
        if flag
            [trueBranch, falseBranch] = Daniljuk_Mihhail_Defining_True_False(prevSS1,prevSS2,count,1);
        end
        % Saving the results for the node of dec tree
        results(count,1) = fatureToAsk;
        results(count,2) = linePos;
        results(count,3) = trueBranch;
        results(count,4) = falseBranch;
        count = count + 1;
        DS_train = [ DS_train(:,1:fatureToAsk - 1),DS_train(:,fatureToAsk+1:end)];
    end
    value = results;
end
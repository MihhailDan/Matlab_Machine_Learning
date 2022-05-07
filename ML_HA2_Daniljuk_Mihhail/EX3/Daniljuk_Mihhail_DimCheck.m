% This function was created to check the best dimensionality for my DS,
% So it gives some intuition about function
function dim_n =  Daniljuk_Mihhail_DimCheck(DS)
    
    [rows, cols] = size(DS);
    data = DS(:,1:2);
    labels = DS(:,end);
    [D_1, labels_1, D_2, lables_2] = DataSplitter(data, labels, 0.7);
    

    prev_result = 0
    for i=1:5
        SVMModel = fitcsvm(D_1,labels_1, 'KernelFunction', 'polynomial','PolynomialOrder',i);
        predicted_labels = SVMModel.predict(D_2);
        result = length(find(predicted_labels == lables_2));
        if result > prev_result
            needed_poly = i;
        end
    
        if result == length(predicted_labels)
            break
        end
        prev_result = result;
    end
    dim_n = needed_poly;
end
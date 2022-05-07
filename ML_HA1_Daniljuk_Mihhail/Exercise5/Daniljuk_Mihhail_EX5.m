% Decision tree algorithm
clear
clc


load("DS.mat","DS")
k_fold = 5;
[rows, cols] = size(DS);

feature_num = cols-1;
labels = DS(:,cols);
intervals = floor(linspace(0, rows, k_fold+1));

% Plotting iniitial clusters
Daniljuk_Mihhail_Plot_Initial_Data(DS);

% Variable for crossvalidation result
totalResult = 0;
for i=1:k_fold
    
    % Splitting data into training and testing set
    low_bound = intervals(i);
    upper_bound = intervals(i+1);

    test_data = DS(low_bound+1:upper_bound,:);
    train_data = [DS(1:low_bound-1,:); DS(upper_bound+1:end,:)];

    test_labels = test_data(:,3);
    train_labels = train_data(:,3);


    % Plotting train data with decision tree boundaries
    dec_tree = Daniljuk_Mihhail_GrowTree(train_data);
    Daniljuk_Mihhail_Plot_Train_Data_WBoundaries(train_data, train_labels, dec_tree, i);
    
    % Classifying test dataset and plotting result
    [result, DS_test, labels] = Daniljuk_Mihhail_classify(test_data,test_labels, dec_tree);
    Daniljuk_Mihhail_Plot_Test_Results(DS_test,dec_tree,i,k_fold);
    
    % Computing totalresult within cross-validation
    totalResult = totalResult + result;
end

% Printing result of rightly classified labels in percents
CrossValidatedResult  = (totalResult / k_fold) / (upper_bound-low_bound) * 100

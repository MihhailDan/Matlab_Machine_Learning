% Exercise 2: Bayes classifier
% This video helped me a lot to get a better understanding of how the algorithm works
% https://www.youtube.com/watch?v=3I8oX3OUL6I&t=638s&ab_channel=NormalizedNerd

clc
clear
% rng(1);


% Loading the data and initialising 
load ('DS.mat',"DS");
threshold = 0.05;
labels = DS(:,end);
num_of_classes = length(unique(labels));

% Computing fisher's scores for each feature
fishers = Daniljuk_Mihhail_Fisher_Compute(DS);

% Filtering data accordiing to fishers
D = Daniljuk_Mihhail_Filtering_Data(fishers,DS,threshold);

% Split the data for testing and validation
[D_train,labels_train,D_valid,labels_valid] = DataSplitter(D,labels,0.7);

% Defining variables
k_fold = 5;
fold_size = size(D_train,1) / k_fold;
upper_bound = fold_size;
lower_bound = 1;
total_acc = 0;

% Iterating through the folds
for l=1:k_fold
 
    % Splitting the data according to folds
    train_fold = [D_train(1:lower_bound-1, :); D_train(upper_bound+1:end,:)];
    labels_train_fold = [labels_train(1:lower_bound-1, :); labels_train(upper_bound+1:end,:)];
    test_fold = D_train(lower_bound:upper_bound,:);
    labels_test_fold = labels_train(lower_bound:upper_bound,:);
    lower_bound = lower_bound + fold_size;
    upper_bound = upper_bound + fold_size;
    
    % Predicting labels for test_fold according to train_fold dataset
    predicted_labels = Daniljuk_Mihhail_Naive_Bayes(train_fold, test_fold, labels_train_fold);

    % Plotting the confusion matrix for every fold
    % Daniljuk_Mihhail_Plot_confusion(predicted_labels, labels_test_fold, l);

    % Computing correctly classified points
    correct = length(find(predicted_labels == labels_test_fold));
    total_acc = total_acc + correct;
end

% Computing total accuracy of folds
total_acc_folds = total_acc / (length(test_fold) * k_fold) * 100

% Validating model on validation set, plotting confusion matrix, and data
% with new labels
predicted_labels = Daniljuk_Mihhail_Naive_Bayes(D_train, D_valid, labels_train);
Daniljuk_Mihhail_Plot_confusion(predicted_labels, labels_valid, k_fold+1);
Daniljuk_Mihhail_Plot_Result(predicted_labels, labels_valid, D_valid, k_fold+2);

% Computing correctly predicted labels in percents
correct = length(find(predicted_labels == labels_valid));
total_acc = correct / length(predicted_labels) * 100


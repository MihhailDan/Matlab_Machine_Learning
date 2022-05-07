% Exercise 4: Adaboost algorithm
% Thanks to this youtube video for clear explanation of the algorithm
% https://www.youtube.com/watch?v=LsK-xG1cLYA&ab_channel=StatQuestwithJoshStarmer


% rng(1);
clear;
clc;

% Loading data, splitting labels from data
load("DS.mat", "DS");
data = DS(:,1:2);
labels = DS(:,end);

% Creating sets for train and validation
[DS_train, labels_train, DS_test, labels_test] = DataSplitter(data, labels, 0.7);

% Initialising variables for creating stumps with weigths
learnersNum = 20;
DS_train = [DS_train, labels_train];
DS_test = [DS_test, labels_test];
[rows_training, ~] = size(DS_train);
[rows_testing, ~] = size(DS_test);
weights = [ones(rows_training,1) * 1/rows_training];

% Adding weights to model and one more column for new classified labels
DS_train = [DS_train, weights, labels_train];
new_set2 = DS_train;

% Running loop for "learnersNum" times
for k = 1:learnersNum;
    
    % Growing first stump, plotting training data set
    dec_tree = Daniljuk_Mihhail_GrowStump(new_set2);
    model(k,:) = dec_tree(1,:);
    %Daniljuk_Mihhail_Plot_Train_Data_WBoundaries(new_set2, new_set2(:,3), dec_tree, k);
    

    % Classifying same training set to comupte total error of the stump and
    % plotting the classification result
    [result, DS_train_classified, labels] = Daniljuk_Mihhail_classify(new_set2, dec_tree);
    %Daniljuk_Mihhail_Plot_Test_Results(DS_train_classified,dec_tree,k,5);
    

    % Creating set with misscclassified data and coorrectly classified data
    missClass = DS_train_classified(find(DS_train_classified(:,3) ~= DS_train_classified(:,5)),:);
    corr_classified = DS_train_classified(find(DS_train_classified(:,3) == DS_train_classified(:,5)), :);
    
    % Computing the total error of the model in terms of weights, then
    % computing amount of say for this learner
    [error, amount_of_say] = Daniljuk_Mihhail_Model_Error_AoS(missClass);
    model(k,end) = amount_of_say;

    % Reassembling dataset with recomputed and normalised weights
    new_set = Daniljuk_Mihhail_Recompute_weights(missClass,corr_classified,amount_of_say);

    % Generating new dataset taking updated weights into account
    new_set2 = Daniljuk_Mihhail_New_Set(new_set);
    
    % Setting wweights back to equal for each sample
    new_set2(:,4) = weights;
end

% Computing the labels from each learner on the same validation data set
for l=1:size(model,1)
    lbls_learners(:,l) = Daniljuk_Mihhail_Learners_Classify(DS_test,model(l,1:4));
end

% Computing the resulting labels taking into acount amount of say for each
% model
actual_labels = Daniljuk_Mihhail_Computing_Resulting_Label(lbls_learners, model);

% Plotting the classified data set and computing accuracy in %
DS_test_classified2 = [DS_test(:,1:2), actual_labels];
Daniljuk_Mihhail_Plot_Results(DS_test_classified2, model,150,0, learnersNum);
accuracy = length(find(DS_test_classified2(:,3) == labels_test)) / rows_testing * 100
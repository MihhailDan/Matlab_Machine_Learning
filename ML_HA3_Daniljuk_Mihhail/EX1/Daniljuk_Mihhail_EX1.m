% First exercise of third Home Assignment - XOR problem using NN
clear
clc
rng(123);

% Loading the data
load("DS.mat","XOR_data");
load("labels.mat","labels");

% Defining learning rate, number of epochs and structure of NN
learning_rate = 0.05;
epochs = 5000;
hidden_layer = [10 5];

% Computing needed variable
[sample_size, feature] = size(XOR_data);
[~, target_features] = size(labels);
structure = [feature, hidden_layer, target_features];
num_of_layers = size(structure,2);

% Initializing neural net with random weights and biases
layer_coefs = Daniljuk_Mihhail_Model_Init(structure, num_of_layers);

% Training
for epoch = 1:epochs
    % Performing forward propagation step, returning output of last layer
    % and adding Sigmoid derivatives to layer_coefs structure, so that I
    % can use them later in backpropagation step
    [outs, layer_coefs] = Daniljuk_Mihhail_ForwardProp(XOR_data, layer_coefs, num_of_layers);

    % Computing the error, which is square root of RSS
    error(epoch,1) = Daniljuk_Mihhail_CostFunc(outs, labels);
    
    % Performing a backpropagation step, adding all needed derivatives into
    % layer_coefs structure
    layer_coefs = Daniljuk_Mihhail_BackProp(layer_coefs,outs,num_of_layers, XOR_data, labels);

    % Updating model weights and biases according to derivatives
    layer_coefs = Daniljuk_Mihhail_Update_Weights_and_Bias(layer_coefs, learning_rate, num_of_layers);
end

% Plotting the results
Daniljuk_Mihhail_Plot_Result(layer_coefs,num_of_layers,XOR_data,labels);


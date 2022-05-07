% Exercise 2. Sphere generation and plotting iis takens from 

clear
clc
rng(123);

% Defining  the hyperparameters
tau1 = 550;
tau2 = 550;
learning_rate_initial = 2;
neighborhood_size_initial = 3;
T = 1500;
size_of_grid = 10;

% Generating dataset for sphere with 1000 points
n=1000;
theta = 2*pi*rand(1,n);
phi = asin(2*rand(1,n)-1);
[x,y,z]=sph2cart(theta,phi,ones(1,n));

% Gathering all the coordinates into 1 dataset and get it's size
DS = [x',y',z'];
[rows,cols] = size(DS);

% Declaring size of square grid of neurons, and initializing random weights
% to each neuron in grid. Also get the flattened version of grid, which is
% (size_of_grid * size_of_grid) by 1 vector
neuronGridFlat = Daniljuk_Mihhail_Initialize_Net(size_of_grid,cols);

% Generating table of indecies for grid
indecies = Daniljuk_Mihhail_Compute_Neuron_Indeces(size_of_grid);

vv=1;
% Main cycle
for t = 1:T

    % Getting random input point
    i = randi(size(DS,1));
    input = DS(i,:);
    
    % Computing distances and winning nei
    distances = sqrt(sum((DS(i,:) - neuronGridFlat(:,:)).^2, 2));
    [min_elem, index_min] = min(distances);

    % Computing learning rate and neighborhood size for current epoch
    learning_rate_current = Daniljuk_Mihhail_Learning_Rate_Decay(learning_rate_initial, t, tau1);
    neighborhood_size_current = Daniljuk_Mihhail_Neighborhood_Decay(neighborhood_size_initial,t,tau2);

    % computing needed values for updating weights
    win = indecies(index_min,:);
    dists = Daniljuk_Mihhail_Manhat_Dist(indecies, win, neighborhood_size_current);
    dists_from_input = DS(i,:) - neuronGridFlat;

    % Updating weights
    neuronGridFlat = neuronGridFlat + learning_rate_current .* dists .* dists_from_input;

    % Drawing the state
    Daniljuk_Mihhail_Draw_State(neuronGridFlat,size_of_grid,DS,vv,t);
    vv = vv+1;
end
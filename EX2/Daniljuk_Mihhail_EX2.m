% Exercise 2 

clear
clc
rng(123);

tau1 = 100;
tau2 = 100;
learning_rate_initial = 1;
neighborhood_size_initial = 15;

T = 5000;
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
size_of_grid = 20;
for i = 1:size_of_grid
    for j = 1:size_of_grid
        neuronGrid(i,j).weights = rand(1, cols) * 2-1;
        neuronGridFlat(size_of_grid * (i-1) + j ,:) = neuronGrid(i,j).weights;
    end
end

% Main cycle
for t = 1:T
    i = randi(size(DS,1));
    
    input = DS(i,:);
    
    distances = sqrt(sum((DS(i,:) - neuronGridFlat(:,:)).^2, 2));
    [min_elem, index_min] = min(distances);

    index_min = int32(index_min);
    neuronGrid_row = idivide(index_min, size_of_grid) + 1;
    neuronGrid_col = mod(index_min,size_of_grid);

    dist_check = sqrt(sum((DS(i,:) - neuronGrid(neuronGrid_row,neuronGrid_col).weights).^2, 2))
    learning_rate_current = Daniljuk_Mihhail_Learning_Rate_Decay(learning_rate_initial, t, tau1)
    neighborhood_size_current = Daniljuk_Mihhail_Neighborhood_Decay(neighborhood_size_initial,t,tau2);
    % weights(index_min,:) = weights(index_min,:) + learning_rate_current * min_elem;
end


%plot3(weights(:,1), weights(:,2), weights(:,3), "o", "Color", "red");

% Plotting the sphere
fh(1) = figure(1);
clf(fh(1));
plot3(DS(:,1), DS(:,2), DS(:,3), "o","Color","blue");
hold on
grid on
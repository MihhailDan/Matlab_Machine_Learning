% Exercise 3: Kernel Trick
clear
clc


% Loading data  
load("DS.mat", "DS");
[rows, cols] = size(DS);
data = DS(:,1:2);
labels = DS(:,end);

% Defining transformation function
x_1 = -8:0.1:8;
y_1 = @(x) -8*sin(0.8*x);

% Checking the needed dimensionality for my dataset, so it is clearly
% separable
dim_n = Daniljuk_Mihhail_DimCheck(DS);

% Defining function for the third dimension of data
myfunc = @(z1,z2) y_1(z1) + 0.2*y_1(z2);
DS2 = DS(:,1:2);
DS2(:,3) = myfunc(DS(:,1), DS(:,2));
colorway = 'byrg';

% With all the mentioned above transformation function would look like
phi = @(x_1, x_2) [x_1, x_2, myfunc(x_1,x_2)];

% Defining Kernel as a dot product
kernel = @(x,y) x(:,1)*y(:,1) + x(:,2)*y(:,2) + ((-8*sin(0.8*x(:,1))) + 0.2 * (-8*sin(0.8*x(:,2)))) * ((-8*sin(0.8*y(:,1))) + 0.2 * (-8*sin(0.8*y(:,2))));

% Plotting the transformed data
Daniljuk_Mihhail_Plot_Transformed(DS2,labels, colorway);

% Plotting initial data with separation function
Daniljuk_Mihhail_Plot_Halfmoon_Sep(x_1, y_1, DS2, labels,colorway);
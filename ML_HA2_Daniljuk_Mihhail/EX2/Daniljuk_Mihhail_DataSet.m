clear
clc

rng(1);
n = 500;
mean1 =  [-5, 0];
mean2 = [-10, -8];

R1 = [8, 0; 0, 1];
R2 = [5, 0; 0, 1];


theta1 = 45;
Q1 = [cosd(theta1), -sind(theta1); sind(theta1), cosd(theta1)];

theta2 = 125;
Q2 = [cosd(theta2), -sind(theta2); sind(theta2), cosd(theta2)];


C1 = Q1 * R1 * inv(Q1);
C2 = Q2 * R2 * inv(Q2);

data_set1 = mvnrnd(mean1, C1, n);
data_set2 = mvnrnd(mean2, C2, n);

oneCol = ones(n, 1);
twoCol = oneCol + 1;

fh(1) = figure(1);
clf(fh(1));
scatter(data_set1(:,1), data_set1(:,2));

grid
hold on
scatter(data_set2(:,1), data_set2(:,2));

labels_1 = oneCol;
labels_2 = twoCol;


data_set = [data_set1; data_set2];



noise_1 = unifrnd(0,100,[1000, 3]);
labels = [labels_1;labels_2];
data_set = [data_set, noise_1, labels];

% CC = cov(data_set)
% [V,D] = eig(CC)

DS = data_set(randperm(size(data_set, 1)), :);
save("DS.mat", "DS");
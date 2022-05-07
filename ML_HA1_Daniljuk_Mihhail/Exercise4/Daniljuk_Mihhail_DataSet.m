clear
clc

rng(123);
n = 500;
mean1 =  [-5, 0];
mean2 = [10, 5];
mean3 = [-40, -5];

R1 = [8, 0; 0, 1];
R2 = [5, 0; 0, 1];
R3 = [2, 0; 0, 6];

theta1 = 90;
Q1 = [cosd(theta1), -sind(theta1); sind(theta1), cosd(theta1)];

theta2 = 90;
Q2 = [cosd(theta2), -sind(theta2); sind(theta2), cosd(theta2)];

theta3 = 90;
Q3 = [cosd(theta3), -sind(theta3); sind(theta3), cosd(theta3)];

C1 = Q1 * R1 * inv(Q1);
C2 = Q2 * R2 * inv(Q2);
C3 = Q3 * R3 * inv(Q3);

data_set1 = mvnrnd(mean1, C1, n);
data_set2 = mvnrnd(mean2, C2, n);
data_set3 = mvnrnd(mean3, C3, n);

oneCol = ones(n, 1);
twoCol = oneCol + 1;
threeCol = twoCol + 1;

fh(1) = figure(1);
clf(fh(1));
scatter(data_set1(:,1), data_set1(:,2));

grid
hold on
scatter(data_set2(:,1), data_set2(:,2));
scatter(data_set3(:,1), data_set3(:,2));

data_set1 = [data_set1, oneCol];
data_set2 = [data_set2, twoCol];
data_set3 = [data_set3, threeCol];

data_set = [data_set1; data_set2; data_set3];
% CC = cov(data_set)
% [V,D] = eig(CC)

DS = data_set(randperm(size(data_set, 1)), :);
save("DS.mat", "DS");

clear
clc

rng(123);
n = 500;
mean1 =  [-5, 0];
mean2 = [7, 10];
mean3 = [-2, 14];
mean4 = [6, 16];

R1 = [8, 0; 0, 1];
R2 = [5, 0; 0, 1];
R3 = [2, 0; 0, 6];
R4 = [6, 0; 0, 2];

theta1 = -45;
Q1 = [cosd(theta1), -sind(theta1); sind(theta1), cosd(theta1)];

theta2 = 60;
Q2 = [cosd(theta2), -sind(theta2); sind(theta2), cosd(theta2)];

theta3 = 0;
Q3 = [cosd(theta3), -sind(theta3); sind(theta3), cosd(theta3)];

theta4 = 0;
Q4 = [cosd(theta4), -sind(theta4); sind(theta4), cosd(theta4)];

C1 = Q1 * R1 * inv(Q1);
C2 = Q2 * R2 * inv(Q2);
C3 = Q3 * R3 * inv(Q3);
C4 = Q4 * R4 * inv(Q4);

data_set1 = mvnrnd(mean1, C1, n);
data_set2 = mvnrnd(mean2, C2, n);
data_set3 = mvnrnd(mean3, C3, n);
data_set4 = mvnrnd(mean4, C4, n);

oneCol = ones(n, 1);
twoCol = oneCol + 1;
threeCol = twoCol + 1;
fourCol = threeCol + 1;

fh(1) = figure(1);
clf(fh(1));
scatter(data_set1(:,1), data_set1(:,2));
grid
hold on
scatter(data_set2(:,1), data_set2(:,2));
scatter(data_set3(:,1), data_set3(:,2));
scatter(data_set4(:,1), data_set4(:,2));

data_set1 = [data_set1, oneCol];
data_set2 = [data_set2, twoCol];
data_set3 = [data_set3, threeCol];
data_set4 = [data_set4, fourCol];

data_set = [data_set1; data_set2; data_set3; data_set4];
% CC = cov(data_set)
% [V,D] = eig(CC)

DS = data_set(randperm(size(data_set, 1)), :);
save("DS2.mat", "DS");
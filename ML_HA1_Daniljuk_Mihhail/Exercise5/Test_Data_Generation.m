clear
clc

n = 50;
mean1 =  [-10, 0];
mean2 = [5, 0];
mean3 = [-15, 14];
mean4 = [0, 14];
rng(1)

R1 = [8, 0; 0, 1];
R2 = [5, 0; 0, 1];
R3 = [2, 0; 0, 6];
R4 = [4, 0; 0, 2];

theta1 = 90;
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

data_set1 = [data_set1, oneCol];
data_set2 = [data_set2, oneCol];
data_set3 = [data_set3, twoCol];
data_set4 = [data_set4, twoCol];


DS_test = [data_set1; data_set2; data_set3; data_set4];
% CC = cov(data_set)
% [V,D] = eig(CC)

fh(1) = figure(1);
clf(fh(1));
scatter(DS_test(:,1), DS_test(:,2));
grid on

DS_test = DS_test(randperm(size(DS_test, 1)), :);
save("DS_test.mat", "DS_test");
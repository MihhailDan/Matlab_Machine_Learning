% DBSCAN Algorithm
% By default Euclidean distance function is in use, to change the metric,
% it has to be done manually in all functions that use distance function:
% Label_As_Core
% Label_As_Border
% Clustering

clear
clc

load("DS2.mat","DS");

eps = 0.75;
theta = 4;

[labels, data] = Daniljuk_Mihhail_DBSCAN(DS, eps, theta);
clusters_num = length(unique(labels));

Daniljuk_Mihhail_Plot_Result(data,labels, clusters_num, 10, "DBSCAN");
clear
clc

load("DS2.mat","DS")

eps = 0.75;
theta = 4;
K = 4;

[labels_KMed, DS_KMedoids, medoids] = Daniljuk_Mihhail_KMedoids(DS,K);
[labels_DBSCAN, DS_DBSCAN] = Daniljuk_Mihhail_DBSCAN(DS, eps, theta);

clusters_num = length(unique(labels_DBSCAN));
Daniljuk_Mihhail_Plot_Result(DS_DBSCAN, labels_DBSCAN, clusters_num, 100, "DBSCAN");
Daniljuk_Mihhail_Plot_Result(DS_KMedoids, labels_KMed, K, 101, "K-Medoids");
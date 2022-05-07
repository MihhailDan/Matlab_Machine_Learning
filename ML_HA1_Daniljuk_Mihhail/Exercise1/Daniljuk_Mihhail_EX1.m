% By default Euclidean distance function is used, If there is need to use
% other function, then it should be changed manually in
% Daniljuk_Mihhail_CostMedoids function

% My implementation is very naive and slow because of nested for loops, so
% it needs time about 1-2 min. I know, it's very slow, and it should be
% improved 

clear
clc

load("DS2.mat", "DS");
K = 4;

[labels, DS, medoids] = Daniljuk_Mihhail_KMedoids(DS, K);

Daniljuk_Mihhail_Plot_Result(DS,labels,K,100,"K-Medoids");
medoids
% Exeercisse 4. Implementing Fisher score
clear
clc

load ('DS.mat',"DS");


fh(1) = figure(1);
clf(fh(1));
scatter(DS(:,1),DS(:,2),'o', "blue")
grid on


fishers = Daniljuk_Mihhail_Fisher_Compute(DS)
% Main function where all the steps aree done
function [lb, data] = Daniljuk_Mihhail_DBSCAN(DS, eps, theta)

% Defining variables
[rows,cols] = size(DS);
labels = DS(:,cols);
DS = DS(:,1:cols-1);


% Defining core points
for i=1:rows
    DS(i,cols) = Daniljuk_Mihhail_Label_As_Core(DS(i,:), DS, eps, theta);
end

corePointsIDX = find(DS(:,cols) == 1);
nonCore_PointsIDX = find(DS(:,cols) == 0);


% Defining border points and outliers
for i=nonCore_PointsIDX'
    DS(i,cols) = Daniljuk_Mihhail_Label_As_Border(DS(i,1:cols-1), DS(corePointsIDX, 1:cols-1), eps);
end


% Plotting all the core, border, and noise points
Daniljuk_Mihhail_Plot_Core_Border_Noise(DS);
hold on


% Addingg columns with labels for DS
labels_for_DS = zeros(rows,1);
DS_Labeled = [DS, labels_for_DS];
labels_col = cols + 1;


% Finding indecies for core and border points
core_border_pointsIDX = find(DS(:,cols) ~= 3);
DS_Labeled_Core_Border = DS_Labeled(core_border_pointsIDX,:);


% Plotting all the core and border points
Daniljuk_Mihhail_Plot_Core_Border(DS_Labeled_Core_Border);
hold on


% Creating one more column for boolean value for expanding clusters
checked = zeros(size(core_border_pointsIDX));
DS_Labeled_Core_Border = [DS_Labeled_Core_Border, checked];


% Function finds near points and unites them into clusters
data = Daniljuk_Mihhail_Clustering(DS_Labeled_Core_Border, eps);
lb = data(:,labels_col);

end
clear
clc
rng(1)

load("DS.mat", "DS");

[rows,cols] = size(DS);
feature_num = cols - 1;

train_ratio = 0.7;
train_data = DS(1:floor(rows*train_ratio),:);
test_data = DS(floor(rows*train_ratio)+1:end, :);

train_labels = train_data(:,end);
train_data = train_data(:,1:end-1);

test_labels = test_data(:,end);
test_data = test_data(:,1:end-1);


for i=1:feature_num
    for j=1:10
        mdl = fitcknn(train_data(:,1:i), train_labels,"Distance","euclidean","NumNeighbors",j);
        prediction = predict(mdl,test_data(:,1:i));
        result(i,j) = length(find(test_labels(:,1) == prediction(:,1))) / length(test_labels) * 100;
    end
end


col = {"k=1", "k=2","k=3", "k=4","k=5", "k=6","k=7", "k=8","k=9", "k=10"};
row = {"dim=1","dim=2","dim=3","dim=4","dim=5","dim=6","dim=7","dim=8"};

fh(1) = figure(1);
clf(fh(1));
set(gcf,"position",[20,20,900,220]);


uit = uitable("ColumnName",col,"RowName",row,"Data",result, "Position",[20,20,820,170]);
txt_title = uicontrol('Style', 'text', 'Position', [350 200 200 20], 'String', 'Rightly predicted labels percentage');

saveas(uit, "table.png");
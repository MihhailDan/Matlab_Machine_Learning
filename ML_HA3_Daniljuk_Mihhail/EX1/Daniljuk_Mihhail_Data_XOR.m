clear
clc

rng(123)

a = 0;
b_n = -1;
b_p = 1;

rows = 40;


XOR_pos_1 = [b_n.*rand(rows,1), b_n.*rand(rows,1)];
XOR_pos_2 = [b_p.*rand(rows,1), b_p.*rand(rows,1)];
XOR_neg_1 = [b_n.*rand(rows,1), b_p.*rand(rows,1)];
XOR_neg_2 = [b_p.*rand(rows,1), b_n.*rand(rows,1)];

XOR_pos = [XOR_pos_1; XOR_pos_2];
XOR_neg = [XOR_neg_1; XOR_neg_2];

XOR_pos = [XOR_pos, zeros(rows*2,1)];
XOR_neg = [XOR_neg, ones(rows*2,1)];

XOR_data = [XOR_pos; XOR_neg];

fh(1) = figure(1);
clf(fh(1));

XOR_data = XOR_data(randperm(size(XOR_data, 1)), :);


for i = 1:size(XOR_data,1)
    if XOR_data(i,3) == 1
        cl = "red";
    else
        cl = "blue";
    end

    scatter(XOR_data(i,1), XOR_data(i,2), cl);
    hold on
    grid on
end

labels = XOR_data(:,3);
XOR_data = XOR_data(:,1:2);
save("DS", "XOR_data");
save("labels","labels");
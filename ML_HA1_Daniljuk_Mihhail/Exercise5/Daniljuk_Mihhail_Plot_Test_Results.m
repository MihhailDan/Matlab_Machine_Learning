% Function plots the test data wiith boundaries and predicted labels
function Daniljuk_Mihhail_Plot_Test_Results(DS_test, dec_tree, count, k)
fh(count+k) = figure(count+k);
clf(fh(count+k))
for j =1 :length(unique(DS_test(:,4)))
    switch j
        case 1
            cl = "red";
        case 2
            cl = "blue";
    end

    cluster = find(DS_test(:,4) == j);
    scatter(DS_test(cluster,1), DS_test(cluster,2));
    hold on;
    grid on;
    axis equal;
    title("Test data " + string(count));
end

if ismember(2, dec_tree(:,1)) && ismember(1, dec_tree(:,1))
    yline(dec_tree(1,2));
    % xline(dec_tree(2,2));
elseif ismember(2, dec_tree(:,1))
    yline(dec_tree(1,2));
    % yline(dec_tree(2,2));
else
    xline(dec_tree(1,2));
    % yline(dec_tree(2,2));
end
end
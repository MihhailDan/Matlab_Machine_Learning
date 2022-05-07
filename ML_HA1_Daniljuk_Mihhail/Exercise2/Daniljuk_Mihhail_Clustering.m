% Function unites core and border points into clusters and plots them
% separately
function value = Daniljuk_Mihhail_Clustering(DS, eps)

[rows, cols] = size(DS);
label_col = 4;

added = false;
moreToExpand = true;
count = 1;
DS(1, label_col) = count;

while moreToExpand
    added = false;
    for i = 1:rows
        if DS(i,label_col) == count && DS(i,5) == 0
            DS(i,5) = 1;
            for j = 1:rows
                if Daniljuk_Mihhail_Distance_Euclidean(DS(i,1:2), DS(j,1:2)) <= eps
                    DS(j,label_col) = DS(i,label_col);
                    added = true;
                end
            end
        else
            continue
        end
    end
    if added == true
        ;
    else
        not_labeled = find(DS(:,4) == 0);
        fh(count+3) = figure(count + 3);
        clf(fh(count+3));

        
        cluster = find(DS(:,4)== count);
        scatter(DS(cluster,1),  DS(cluster,2), "red");
        hold on
        axis equal;
        xlim([-20,20]);
        ylim([-10,25]);
        grid on
        title("Cluster" + count);
        count = count + 1;
        if size(not_labeled) == [0,1]
            moreToExpand = false;
        else
            DS(not_labeled(1,1),4) = count;
        end
    end
end

value = DS;


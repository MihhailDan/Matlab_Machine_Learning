% Function plots initial clusters
function Daniljuk_Mihhail_Plot_Initial_Data(DS)
fh(100) = figure(100);
clf(fh(100))
for j =1 :length(unique(DS(:,3)))
    switch j
        case 1
            cl = "red";
        case 2
            cl = "blue";
    end

    cluster = find(DS(:,3) == j);
    scatter(DS(cluster,1), DS(cluster,2));
    grid on;
    hold on;
    axis equal;
    title("Initial data");
end
end
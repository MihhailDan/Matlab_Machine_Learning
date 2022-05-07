% Function plots final cluster
function Daniljuk_Mihhail_Plot_Result(DS, labels, K, counter, name)

[rows, cols] = size(DS);
fh(counter) = figure(counter);
clf(fh(counter));

for j=0:K
    switch j
        case 0
            cl = 'green';
        case 1
            cl = 'red';
        case 2 
            cl = 'magenta';
        case 3
            cl = "blue";
        case 4
            cl = "yellow";
        otherwise
            cl = "black";
    end
    cluster = find(labels==j);
    scatter(DS(cluster,1),  DS(cluster,2), cl)
    axis equal;
    grid on
    title(name);
    hold on
end
end
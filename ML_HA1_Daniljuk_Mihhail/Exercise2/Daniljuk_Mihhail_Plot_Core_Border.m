% Function plots core and border points
function Daniljuk_Mihhail_Plot_Core_Border(DS)
fh(2) = figure(2);
clf(fh(2));

for j = 1:3
    switch j
        case 1
            cl = 'green';
        case 2
            cl = 'red';
    end
    
    title("Core and Border points");
    cluster = find(DS(:,3)==j);
    scatter(DS(cluster,1),  DS(cluster,2), cl);
    hold on
    axis equal;
    xlim([-20,20]);
    ylim([-10,25]);
    grid on
end
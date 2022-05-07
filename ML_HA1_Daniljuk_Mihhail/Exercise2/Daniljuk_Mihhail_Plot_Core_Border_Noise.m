% Function plots all data points labeled as core, border or noise point
function Daniljuk_Mihhail_Plot_Core_Border_Noise(DS)
fh(1) = figure(1);
clf(fh(1));

for j = 1:3
    switch j
        case 1
            cl = 'green';
        case 2
            cl = 'red';
        case 3
            cl = 'blue';
    end
    
    title("Core, Border, Noise points");
    cluster = find(DS(:,3)==j);
    scatter(DS(cluster,1),  DS(cluster,2), cl);
    hold on
    axis equal;
    xlim([-20,20]);
    ylim([-10,25]);
    grid on
end
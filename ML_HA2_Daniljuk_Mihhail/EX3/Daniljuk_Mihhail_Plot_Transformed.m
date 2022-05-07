function Daniljuk_Mihhail_Plot_Transformed(DS2, labels, colorway)
    
    fh(1)=figure(1);
    clf(fh(1))
    
    for i = transpose(unique(labels(:,1)))
        points = DS2(labels(:,1) == i, 1:3);
        plot3(points(:,1), points(:,2), points(:,3), "o", "Color", colorway(i));
        grid on
        hold on
        title("Transformed halfmoons");
    end
end
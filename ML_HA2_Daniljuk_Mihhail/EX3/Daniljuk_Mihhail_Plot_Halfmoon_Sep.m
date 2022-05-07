function Daniljuk_Mihhail_Plot_Halfmoon_Sep(x_1, y_1, DS2, labels, colorway)
    
    fh(2)=figure(2);
    clf(fh(2))
    
    for i = transpose(unique(labels(:,1)))
        points = DS2(labels(:,1) == i, 1:3);
        plot(points(:,1), points(:,2), "o", "Color", colorway(i));
        grid on
        hold on
        title("2D separation");
    end
    plot(x_1, y_1(x_1), 'Color','black');
    saveas(fh(2),"Separated_Moons.png");
end
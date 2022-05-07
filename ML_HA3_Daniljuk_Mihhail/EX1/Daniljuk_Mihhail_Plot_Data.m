function Daniljuk_Mihhail_Plot_Data(XOR_data, labels)

    for i = 1:size(XOR_data,1)
        if labels(i,1) == 1
            cl = "red";
        else
            cl = "blue";
        end
    
        scatter(XOR_data(i,1), XOR_data(i,2), cl);
        hold on
        grid on
    end

end